
#' compute the Receiver Operating Characteristic (ROC) curve for a set of predicted probabilities and the true class labels.
#' @param preds vector of predicted probability of being in the positive class P(X == 1) (numeric)
#' @param labs vector of true labels (numeric)
#' @return ROCR::performance object
#' @seealso \code{\link[ROCR]{performance}}
#' @export
compute_roc <- function(preds, labs){
    # create prediction object
    pred <- ROCR::prediction(preds, labs)
    perf <- ROCR::performance(pred,"tpr","fpr")
    return(perf)
}

#' Compute Area Under the Receiver Operating Characteristic Curve (AUC)
#' @param preds vector of predicted probabilities (numeric)
#' @param labs vector of true class labels (numeric)
#' @return value of Area Under the Receiver Operating Characteristic Curve (AUC) (numeric)
#' @seealso \code{\link[ROCR]{performance}}
#' @export
compute_auc <- function(preds, labs){
    predobj <- ROCR::prediction(preds, labs)
    aucobj <- ROCR::performance(predobj, measure = "auc")
    auc <- aucobj@y.values[[1]]
    return(auc)
}

#' Use interpolation to make approximate the Receiver Operating Characteristic (ROC) curve along n_grid equally-spaced values.
#' @param perf_in ROCR::performance object computed via \code{\link{compute_roc}}
#' @param n_grid number of approximation points to use (default value of 10000 more than adequate for most applications) (numeric)
#' @return returns a list with components x and y, containing n coordinates which
#'   interpolate the given data points according to the method (and rule) desired.
#' @seealso \code{\link[stats]{approx}}
#' @export
interpolate_roc_fun <- function(perf_in, n_grid = 10000){
    x_vals = unlist(perf_in@x.values)
    y_vals = unlist(perf_in@y.values)
    stopifnot(length(x_vals) == length(y_vals))
    roc_approx = stats::approx(x_vals, y_vals, n = n_grid)
    return(roc_approx)
}
