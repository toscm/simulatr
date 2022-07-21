#' @export @name simulate_dataset @title Simulate a Dataset @description
#' `simulate_dataset()` returns a dataset of size n*p @param n The number of
#' samples. @param p The number of features. @param beta The model coefficients.
#' @param base The dataset to use as basis for the generation, e.g. HG-U133B for
#' mRNA datasets measured with the Affymetrix HG-U133B microarray. @param
#' platform The platform for which data should be simulated. @param family The
#' type of model to use when generating the outcome variable. Either `gaussian`,
#' `binomial` or `cox`. @param cor Correlation strength within the data @param
#'   cortype Method to use for generating the correlation within the dataset.
#' See below for details. @param noise_func A function taking the matrix as
#' first argument and other optional parameters as futher arguments @param
#'   noise_func_args Additional arguments to be passed to `noise_func` @param
#' noise Amount of noise to add to each predictor @param noisevar Variance of
#' noise @param bias Amount of bias to simulate @param biastype Method to use
#'   for generating the bias. See below for details. @return A matrix of size
#' n*p. @examples \dontrun{ x <- simulate_dataset(n = 100, p = 1000, base =
#' "HG-U133B")
#' # should return a matrix of size 100*1000 with genes measured by the
#' # HG-U133B microarray as features
#' x2 <- simulate(n, p, gse = matrix(rnorm(25), 5, 5), noise_func = unif_noise,
#'   noise_func_args = list(min = 0, max = 1) ) } @details simulate_dataset <-
#'   function( n=3, p=4, beta=NULL, base="HG-U133B", family="gaussian", cor=0.5,
#' cortype=1, noise=1, noisevar=1, bias=0, biastype=1 )
#'
#'
#'
#' 1 ta gse te 1 ta gpl kintu 1 ta gpl e onekgula gse



# 1 GPL == 1 or 1+ GSE


library(GEOquery)

simulate_dataset <- function(n,
                             p,
                             gse = NULL,
                             noise_func = NULL,
                             noise_func_args = list(sd = 1),
                             bias_func = NULL,
                             bias_func_args = list(n = 1, p = 1, s = 1)) {
  if (is.null(gse)) {
    mat <- matrix(, p, n)
    var <- vector()
    for (i in 1:p) {
      var <- rnorm(n)
      mat[i, 1:n] <- var
      df <- data.frame(mat)
    }
    result <- df
  } else {
    result <- simulate_gse(n, p, gse)
  }

  if (!is.null(noise_func)) {
    result <- result + noise_func(n, p, noise_func_args)
  }

  if (!is.null(bias_func)) {
    result <- result + bias_func(n, p, bias_func_args)
  }

  return(result)
}


random_noise <- function(n, p, noise_func_args) {
  return(rnorm(n * p, noise_func_args$sd))
}

uniform_noise <- function(n, p, noise_func_args) {
  return(runif(n * p, noise_func_args$min, noise_func_args$max))
}

binomial_noise <- function(n, p, noise_func_args) {
  return(rbinom(n * p, noise_func_args$size, noise_func_args$prob))
}

poisson_noise <- function(n, p, noise_func_args) {
  return(rpois(n * p, noise_func_args$lambda))
}

exponential_noise <- function(n, p, noise_func_args) {
  return(rexp(n * p, noise_func_args$rate))
}
