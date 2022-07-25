#' @export
#' @name uniform_noise
#' @title Create uniform noise
#' @description `uniform_noise()` returns a dataset of size n*p from a
#' uniform distribution
#' @param n The number of samples
#' @param p The number of features (e.g. genes)
#' @param noise_func_args Takes the function arguments
#' @return A matrix of size n*p
#' @examples
#' \dontrun{uniform_noise(10,10,list(min=1,max=10))}
#' @details
#' n and p define the dimension of the matrix to return.
#' noise_func_args defines the argument for generating distribution
#' (in this case uniform). We can define minimum and maximum
#' of the function as noise_func_args$min=1 and noise_func_args$max=10
uniform_noise <- function(n, p, noise_func_args) {
  return(stats::runif(n * p, noise_func_args$min, noise_func_args$max))
}
