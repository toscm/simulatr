#' @export
#' @name poisson_noise
#' @title Create poisson noise
#' @description `poisson_noise()` returns a dataset of size n*p from a
#' Poisson distribution
#' @param n The number of samples
#' @param p The number of features (e.g. genes)
#' @param noise_func_args Takes the function arguments
#' @return A matrix of size n*p
#' @examples
#' \dontrun{
#' poisson_noise(10, 10, list(lambda = 1))
#' }
#' @details
#' n and p define the dimension of the matrix to return.
#' noise_func_args defines the argument for generating distribution
#' (in this case uniform). We can define vector of non-negative means
#' as noise_func_args$lambda=2.
poisson_noise <- function(n, p, noise_func_args) {
  return(stats::rpois(n * p, noise_func_args$lambda))
}
