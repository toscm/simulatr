#' @export
#' @name constant_batch_effect
#' @title Add constant batch effect to the
#' simulated data.
#' @description `constant_batch_effect()` returns a dataset of
#' size n*p with b number of batches, p number of affected features affected by
#' given value s.
#' @param n The number of samples
#' @param p The number of features (e.g. genes)
#' @param bias_func_args The arguments given by the user
#' for the batch effect function
#' @return A matrix of size n*p
#' @examples
#' \dontrun{constant_batch_effect(n=10,p=10,bias_func_args(
#' list(b=c(1,1,1,2,2,2,3,3,4,4),f=4,s=c(0,1,1,2))))}
#' \dontrun{constant_batch_effect
#' (n=5,p=5,bias_func_args=list(b=2,f=4,s=c(0,1)))}
#' \dontrun{constant_batch_effect(n=5,p=5,bias_func_args=list(b=2,f=4,s=1))}
#' @details
#' n and p define the dimension of the matrix to return.
#' b defines the batches the samples belong to. f defines the number of
#' features will be affected. s defines how much each batch is effected.

constant_batch_effect <- function(n, p, bias_func_args) {
    bias_mat <- matrix(0, n, p)
    if (length(bias_func_args$s) == 1) {
        bias_func_args$s <- rep(bias_func_args$s, bias_func_args$b)
    }
    if (length(bias_func_args$b) == 1) {
        bias_func_args$b <- sample.int(bias_func_args$b, n, replace = TRUE)
    }
    r <- sample.int(p, bias_func_args$f, replace = FALSE)
    for (i in 1:n) {
        bias_mat[i, r] <- bias_mat[i, r] + bias_func_args$s[bias_func_args$b[i]]
    }
    return(bias_mat)
}
