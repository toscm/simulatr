#' @export
#' @name simulate_dataset
#' @title Simulate a data set
#' @description
#' `simulate_dataset()` returns a simulated dataset.
#' @param n The number of samples.
#' @param p The number of features.
#' @param beta The model coefficients.
#' @param y The results generated from thebaseset and model coefficients.
#' @param base The base dataset to use as basis for the simulated data.
#' @param family The type of model to use when generating the outcome variable.
#' Either `gaussian`,`binomial` or `cox`.
#' @param cor Correlation strength within thebase
#' @param cortype Method to use for generating the correlation within
#' thebaseset.
#' @param noise_func A function taking the name of the noise function
#' (e.g. random_noise, uniform_noise)
#' @param noise_func_args Additional arguments to be passed to `noise_func`
#' @param bias_func A function taking the name of the bias function
#' (e.g. constant_batch_effect)
#' @param bias_func_args Additional arguments to be passed to `bias_func`
#' @return A data frame of size n*p with simulated data
#' @examples
#' \dontrun{
#' simulate_dataset(n = 5, p = 5, base = data.frame(matrix(rnorm(6 * 6), 6, 6)))
#' }
#' \dontrun{
#' simulate_dataset(10, 15)
#' }
#' \dontrun{
#' simulate_dataset(n = 5, p = 8, gse = "GSE3821")
#' }
#' \dontrun{
#' simulate_dataset(
#'   n = 10,
#'   p = 10,
#'   noise_func = poisson_noise,
#'   noise_func_args = list(lambda = 1)
#' )
#' }
#' \dontrun{
#' simulate_dataset(
#'   n = 10,
#'   p = 10,
#'   gse = "GSE3821",
#'   noise_func = uniform_noise,
#'   noise_func_args = list(min = 0, max = 1),
#'   bias_func = constant_batch_effect,
#'   bias_func_args = list(
#'     b = c(1, 1, 1, 2, 2, 2, 3, 3, 4, 4),
#'     f = 4,
#'     s = c(0, 1)
#'   )
#' )
#' }
#'
#' @details see Readme.md
simulate_dataset <- function(n = 5,
                             p = 5,
                             base = simulatr::normal_data(n, p),
                             gse = NULL,
                             noise_func = NULL,
                             noise_func_args = list(sd = 1),
                             bias_func = NULL,
                             bias_func_args = list(n = 1, p = 1, s = 1)) {
  if (is.null(gse)) {
    if (setequal(dim(base), c(n, p))) {
      result <- base
    } else {
      result <- base[sample(nrow(base), n), sample(ncol(base), p)]
    }
  } else {
    result <- simulatr::simulate_gse(n, p, gse)
  }

  if (!is.null(noise_func)) {
    result <- result + noise_func(n, p, noise_func_args)
  }

  if (!is.null(bias_func)) {
    result <- result + bias_func(n, p, bias_func_args)
  }

  return(result)
}
