#' @export
#' @name simulate_dataset
#' @title Simulate a data set
#' @description
#' `simulate_dataset()` returns a simulated dataset.
#' @param n The number of samples.
#' @param p The number of features.
#' @param beta A (q*p) matrix to denote the effect of each feature
#' @param base The base dataframe to use as basis for the simulated data.
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
#'   noise_func = uniform_noise,
#'   noise_func_args = list(min = 0, max = 1),
#'   bias_func = constant_batch_effect,
#'   bias_func_args = list(
#'     b = c(1, 1, 1, 2, 2, 2, 3, 3, 4, 4),
#'     f = 4,
#'     s = c(0, 1, 2, 3)
#'   )
#' )
#' }
#' \dontrun{
#' simulate_dataset(
#'   n = 10,
#'   p = 10,
#'   beta = matrix(1, 1, 10),
#'   noise_func = uniform_noise,
#'   noise_func_args = list(min = 0, max = 1),
#'   bias_func = constant_batch_effect,
#'   bias_func_args = list(
#'     b = 3,
#'     f = 4,
#'     s = c(2, 3)
#'   )
#' )
#' }
#' \dontrun{
#' simulate_dataset(
#'   n = 10,
#'   p = 10,
#'   base = data.frame(matrix(0, 10, 10)),
#'   beta = matrix(1, 1, 10),
#'   noise_func = uniform_noise,
#'   noise_func_args = list(min = 0, max = 0.5),
#'   bias_func = constant_batch_effect,
#'   bias_func_args = list(
#'     b = 3,
#'     f = 5,
#'     s = c(2, 3)
#'   )
#' )
#' }
#' \dontrun{
#' simulate_dataset(
#'   n = 5,
#'   p = 5,
#'   simulate_glm_data(dat = simulatr::simulate_gse(10, 10,
#'     gse = "GSE3821"
#'   ))
#' )
#' }
#' @details see Readme.md
#'
simulate_dataset <- function(n = 5,
                             p = 5,
                             base = simulatr::normal_data(n, p),
                             beta = NULL,
                             noise_func = matrix(0, n, p),
                             noise_func_args = NULL,
                             bias_func = matrix(0, n, p),
                             bias_func_args = NULL) {
  if (setequal(dim(base), c(n, p))) {
    result <- base
  } else {
    result <- base[
      sample(nrow(base), n, replace = FALSE),
      sample(ncol(base), p, replace = FALSE)
    ]
  }
  base_data <- result

  return_list <- list("raw_data" = base_data)
  itr <- 1

  if (!is.null(beta)) {
    y <- as.matrix(result) %*% t(beta)
    itr <- itr + 1
    return_list[["y"]] <- y
  }

  if (length(class(noise_func)) == 1) {
    temp_noise <- noise_func(n, p, noise_func_args)
  } else {
    temp_noise <- noise_func
  }
  result <- result + temp_noise
  itr <- itr + 1
  return_list[["Noise_matrix"]] <- matrix(temp_noise, n, p)

  if (length(class(bias_func)) == 1) {
    temp_bias <- bias_func(n, p, bias_func_args)
    itr <- itr + 1
    return_list[["Bias_arguments"]] <- temp_bias[[1]]
    itr <- itr + 1
    return_list[["Bias_matrix"]] <- temp_bias[[2]]
    itr <- itr + 1
    return_list[["Features_affected"]] <- temp_bias[[3]]
    result <- result + temp_bias[[2]]
  } else {
    temp_bias <- bias_func
    return_list[["Bias_matrix"]] <- temp_bias
    result <- result + temp_bias
  }
  itr <- itr + 1
  return_list[["Final_data"]] <- result
  return(return_list)
}
