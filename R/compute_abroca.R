## df: dataframe containing colnames matching pred_col, label_col, and protected_attr_col
## pred_col: name of column containing predicted probabilities
## label_col: name of column containing true labels (should be 0,1 only)
## protected_attr_col: name of column containing protected attr
## majority_protected_attr_val: name of "majority" group wrt protected attribute
## n_grid: number of grid points to use in approximation
## plot_slices: if true, ROC slice plots are generated and saved
## img_dir: directory to save images to
## course: course name, used for filenames if plot_slices is set to TRUE
## returns: value of slice statistic, absolute value of area between ROC curves for protected_attr_col
compute_slice_statistic <- function(df, pred_col, label_col, protected_attr_col, majority_protected_attr_val, n_grid = 10000, plot_slices = TRUE, image_dir = NULL, course = NULL){
    # todo: input checking
    # pred_col should be in interval [0,1]
    # label_col should be strictly 0 or 1
    # majority_protected_attr_col should be in protected_attr_col values
    # protected_attr_col must be factor, otherwise convert and warn
    # initialize data structures
    ss = 0
    protected_attr_vals = unique(df[,protected_attr_col])
    roc_list = list()
    # compute roc within each group of protected_attr_vals
    for (protected_attr_val in protected_attr_vals){
        protected_attr_df = df[df[,protected_attr_col] == protected_attr_val,]
        roc_list[[protected_attr_val]] = compute_roc(protected_attr_df[,pred_col], protected_attr_df[,label_col])
    }
    # compare each non-majority class to majority class; accumulate absolute difference between ROC curves to slicing statistic
    majority_roc_fun = interpolate_roc_fun(roc_list[[majority_protected_attr_val]])
    for (protected_attr_val in protected_attr_vals[protected_attr_vals != majority_protected_attr_val]){
        minority_roc_fun = interpolate_roc_fun(roc_list[[protected_attr_val]])
        # use function approximation to compute slice statistic, cf. https://stat.ethz.ch/pipermail/r-help/2010-September/251756.html
        stopifnot(identical(majority_roc_fun$x, minority_roc_fun$x))
        f1 <- approxfun(majority_roc_fun$x, majority_roc_fun$y - minority_roc_fun$y)     # piecewise linear function
        f2 <- function(x) abs(f1(x))                 # take the positive value
        slice = integrate(f2, 0, 1, subdivisions = 10000L)$value # increased subdivisions from default 100L because non-convergence was occasionally reached when evaluating some integrals
        ss <- ss + slice
        # todo: plot these or write to file
        if (plot_slices == TRUE) {
            output_filename = file.path(image_dir, glue('slice_plot_{course}_{majority_protected_attr_val}_{protected_attr_val}.pdf'))
            slice_plot(majority_roc_fun, minority_roc_fun, majority_protected_attr_val, protected_attr_val, fout = output_filename)
        }
    }
    return(ss)
}

