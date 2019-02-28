
#' Create a "slice plot" of two roc curves with area between them (the ABROCA region) shaded.
#' @param majority_roc list with attributes "x" and "y" defining points of roc curve
#' @param minority_roc list with attributes "x" and "y" defining points of roc curve
#' @param majority_group_name optional label for majority group (character)
#' @param minority_group_name optional label for minority group (character)
#' @param fout path to output file
#' @return No return value; file is saved to disk.
#' @references
#' Josh Gardner, Christopher Brooks, and Ryan Baker. (2019). Evaluating the Fairness
#' of Predictive Student Models Through Slicing Analysis.
#' *Proceedings of the 9th International Conference on Learning Analytics and Knowledge (LAK19)*.
#' @export
slice_plot <- function(majority_roc, minority_roc, majority_group_name = NULL, minority_group_name = NULL, fout = NULL) {
    # check that number of points are the same
    stopifnot(length(majority_roc$x) == length(majority_roc$y),
              length(majority_roc$x) == length(minority_roc$x),
              length(majority_roc$x) == length(minority_roc$y))
    if (!is.null(fout)){
        png(fout, width = 720, height = 720)
    }
    # set some graph parameters
    majority_color = "red"
    minority_color = "blue"
    majority_group_label = "Majority Group"
    minority_group_label = "Minority Group"
    plot_title = "ROC Slice Plot"
    if (!is.null(majority_group_name)){
        majority_group_label = glue::glue("{majority_group_label} ({majority_group_name})")
    }
    if (!is.null(minority_group_name)){
        minority_group_label = glue::glue("{minority_group_label} ({minority_group_name})")
    }
    # add labels, if given
    plot(majority_roc$x,
         majority_roc$y,
         col = majority_color,
         type = "l",
         lwd = 1.5,
         main = plot_title,
         xlab = "False Positive Rate",
         ylab = "True Positive Rate")
    polygon(x = c(majority_roc$x, rev(minority_roc$x)), # reverse ordering used to close polygon by ending near start point
            y = c(majority_roc$y, rev(minority_roc$y)),
            col = "grey",
            border = NA
    )
    lines(majority_roc$x, majority_roc$y, col = majority_color, type = "l", lwd = 1.5)
    #segments(majority_roc$x, majority_roc$y, minority_roc$x, minority_roc$y)
    lines(minority_roc$x, minority_roc$y, col = minority_color, type = "l", lwd = 1.5)
    legend("bottomright", legend = c(majority_group_label, minority_group_label), col = c(majority_color, minority_color), lty = 1)
    if (!is.null(fout)){
        dev.off()
    }
}
