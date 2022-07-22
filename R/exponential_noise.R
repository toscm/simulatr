#' @export
#' @name exponential_noise
#' @title Create exponential noise
#' @description `exponential_noise()` returns a dataset of size n*p from a
#' exponential distribution
#' @param n The number of samples
#' @param p The number of features (e.g. genes)
#' @param noise_func_args Takes the function arguments
#' @return A matrix of size n*p
#' @examples
#' \dontrun{exponential_noise(10,10,list(rate=1))}
#' @details
#' n and p define the dimension of the matrix to return.
#' noise_func_args defines the argument for generating distribution
#' (in this case uniform). We can define vector of rates as
#' noise_func_args$rate=1.
exponential_noise <- function(n, p, noise_func_args) {
  return(rexp(n * p, noise_func_args$rate))
}
