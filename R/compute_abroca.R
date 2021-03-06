#' Compute the value of the abroca statistic.
#' @param df dataframe containing colnames matching pred_col, label_col, and
#' protected_attr_col
#' @param pred_col name of column containing predicted probabilities (string)
#' @param label_col name of column containing true labels
#' (should be 0,1 only) (string)
#' @param protected_attr_col name of column containing protected
#' attribute (string)
#' @param majority_protected_attr_val name of 'majority' group with
#' respect to protected attribute (string)
#' @param n_grid number of grid points to use in approximation (numeric)
#' (default of 10000 is more than adequate for most cases)
#' @param plot_slices if TRUE, ROC slice plots are generated and saved to
#' img_dir (boolean)
#' @param image_dir directory to save images to (string)
#' @param identifier identifier name, used for filenames if plot_slices is
#' set to TRUE (boolean)
#' @return Value of slice statistic, the absolute value of area between ROC
#' curves for protected_attr_col
#' #' @references
#' Josh Gardner, Christopher Brooks, and Ryan Baker. (2019). Evaluating the
#' Fairness  of Predictive Student Models Through Slicing Analysis.
#' *Proceedings of the 9th International Conference on Learning Analytics
#' and Knowledge (LAK19)*.
#' @export
#' @examples
#' # The compute_abroca function uses a dataframe of predictions to generate
#' # the abroca statistic. This is the main utility of the abroca package.
#' 
#' # First, we load data, train a model, and generate predictions to evaluate.
#' data("recidivism")
#' recidivism$returned = as.factor(recidivism$Return.Status != "Not Returned")
#' in_train = caret::createDataPartition(recidivism$returned, 
#'     p = 0.75, list = FALSE)
#' traindata = recidivism[in_train,c("Release.Year", "County.of.Indictment", 
#'     "Gender", "Age.at.Release", "returned")]
#' testdata = recidivism[-in_train,c("Release.Year", "County.of.Indictment", 
#'     "Gender", "Age.at.Release", "returned")]
#' lr = glm(returned ~ ., data=traindata, family="binomial")
#' testdata$pred = predict(lr, testdata, type = "response")
#' 
#' # The predictions are used as the primary input to compute_abroca():
#' abroca <- compute_abroca(testdata, pred_col = "pred", label_col = "returned", 
#'     protected_attr_col = "Gender", majority_protected_attr_val = "MALE", 
#'     plot_slices = FALSE, identifier="recidivism") 
compute_abroca <- function(df, pred_col, label_col, protected_attr_col,
                           majority_protected_attr_val, n_grid = 10000,
                           plot_slices = TRUE, image_dir = NULL,
                           identifier = NULL) {
    # input checking pred_col should be in interval [0,1]
    if (!all(df[, pred_col] <= 1 & df[, pred_col] >= 0)) stop(
        "predictions must be in range[0, 1]")
    if (!length(unique(df[, label_col]) == 2)) stop(
        "only binary classification tasks supported")
    if (!is.factor(df[, protected_attr_col])){
        message(glue::glue(
            "[WARNING] coercing column {protected_attr_col} to factor"))
        df[, protected_attr_col] <- as.factor(df[, protected_attr_col])
    }
    # initialize data structures
    ss <- 0
    p_a_values <- unique(df[, protected_attr_col])
    roc_list <- list()
    # compute roc within each group of p_a_values
    for (p_a_value in p_a_values) {
        protected_attr_df <- df[df[, protected_attr_col] ==
                                   p_a_value, ]
        roc_list[[p_a_value]] <- compute_roc(
            protected_attr_df[, pred_col],
            protected_attr_df[, label_col]
            )
    }
    # compare each non-majority class to majority class; accumulate absolute
    # difference between ROC curves to slicing statistic
    majority_roc_fun <- interpolate_roc_fun(
        roc_list[[majority_protected_attr_val]]
        )
    for (p_a_value in p_a_values[p_a_values != majority_protected_attr_val]) {
        minority_roc_fun <- interpolate_roc_fun(roc_list[[p_a_value]])
        # use function approximation to compute slice statistic
        # via piecewise linear function
        stopifnot(identical(majority_roc_fun$x, minority_roc_fun$x))
        f1 <- stats::approxfun(majority_roc_fun$x,
                               majority_roc_fun$y - minority_roc_fun$y)
        f2 <- function(x) abs(f1(x))  # take the positive value
        slice <- stats::integrate(f2, 0, 1, subdivisions = 10000L)$value
        ss <- ss + slice
        # plot these or write to file
        if (plot_slices == TRUE) {
            output_filename <- file.path(
                image_dir,
                paste0(glue::glue("slice_plot_{identifier}_"),
                       glue::glue("{majority_protected_attr_val}"),
                       glue::glue("_{p_a_value}.png")
                       )
                )
            slice_plot(majority_roc_fun, minority_roc_fun,
                       majority_protected_attr_val,
                       p_a_value, fout = output_filename)
        }
    }
    return(ss)
}
