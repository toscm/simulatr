#' @export
#' @name uniform_noise
#' @title Create binomial noise
#' @description `binomial_noise()` returns a dataset of size n*p from a
#' binomial or Bernoulli distribution
#' @param n The number of samples
#' @param p The number of features (e.g. genes)
#' @param noise_func_args Takes the function arguments
#' @return A matrix of size n*p
#' @examples
#' \dontrun{binomial_noise(10,10,list(size=50,prob=0.5))}
#' @details
#' n and p define the dimension of the matrix to return.
#' noise_func_args defines the argument for generating distribution
#' (in this case uniform). We can define number of trials as
#' noise_func_args$size=10 and probability of each trial as
#' noise_func_args$prob=0.5
binomial_noise <- function(n, p, noise_func_args) {
  return(rbinom(n * p, noise_func_args$size, noise_func_args$prob))
}