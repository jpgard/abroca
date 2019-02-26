
## preds: vector of predicted probability
## labs: vector of labels
compute_roc <- function(preds, labs){
    # create prediction object
    pred <- ROCR::prediction(preds, labs)
    perf <- ROCR::performance(pred,"tpr","fpr")
    return(perf)
}

## preds: vector of predicted probabilities
## labs: vector of labels
compute_auc <- function(preds, labs){
    predobj <- ROCR::prediction(preds, labs)
    aucobj <- ROCR::performance(predobj, measure = "auc")
    auc <- aucobj@y.values[[1]]
    return(auc)
}

## use interpolation to make approximate curve along n_grid equally-spaced values
interpolate_roc_fun <- function(perf_in, n_grid = 10000){
    x_vals = unlist(perf_in@x.values)
    y_vals = unlist(perf_in@y.values)
    stopifnot(length(x_vals) == length(y_vals))
    roc_approx = approx(x_vals, y_vals, n = n_grid)
    return(roc_approx)
}
