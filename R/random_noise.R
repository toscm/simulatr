#' @export
#' @name random_noise
#' @title Create random noise
#' @description `random_noise()` returns a dataset of size n*p from a
#' gaussian distribution
#' @param n The number of samples
#' @param p The number of features (e.g. genes)
#' @param noise_func_args Takes the function arguments
#' @return A matrix of size n*p
#' @examples
#' \dontrun{random_noise(10,10,list(sd=1))}
#' @details
#' n and p define the dimension of the matrix to return.
#' noise_func_args defines the argument for generating distribution
#' (in this case gaussian/normal). We can define standard deviation
#' of the function as noise_func_args$sd=0.5
random_noise <- function(n, p, noise_func_args) {
  return(stats::rnorm(n * p, noise_func_args$sd))
}