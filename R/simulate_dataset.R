#' @export
#' @name simulate_dataset
#' @title Simulate a Dataset
#' @description `simulate_dataset()` returns a dataset of size n*p
#' @param n The number of samples.
#' @param p The number of features.
#' @param beta The model coefficients.
#' @param base The dataset to use as basis for the generation, e.g. HG-U133B for
#'   mRNA datasets measured with the Affymetrix HG-U133B microarray.
#' @param platform The platform for which data should be simulated.
#' @param family The type of model to use when generating the outcome variable.
#'   Either `gaussian`, `binomial` or `cox`.
#' @param cor Correlation strength within the data
#' @param cortype Method to use for generating the correlation within the
#'   dataset. See below for details.
#' @param noise_func A function taking the matrix as first argument and other
#' optional parameters as futher arguments
#' @param noise_func_args Additional arguments to be passed to `noise_func`
#' @param noise Amount of noise to add to each predictor
#' @param noisevar Variance of noise
#' @param bias Amount of bias to simulate
#' @param biastype Method to use for generating the bias. See below for details.
#' @return A matrix of size n*p.
#' @examples
#' \dontrun{
#' x <- simulate_dataset(n = 100, p = 1000, base = "HG-U133B")
#' # should return a matrix of size 100*1000 with genes measured by the
#' # HG-U133B microarray as features
#' x2 <- simulate(n, p, gse = matrix(rnorm(25), 5, 5), noise_func = unif_noise,
#' noise_func_args = list(min=0, max=1))
#' }
#' @details simulate_dataset <- function( n=3, p=4, beta=NULL, base="HG-U133B",
#'   family="gaussian", cor=0.5, cortype=1, noise=1, noisevar=1, bias=0,
#'   biastype=1 )
#'
#'
#'
#' 1 ta gse te 1 ta gpl kintu 1 ta gpl e onekgula gse



# 1 GPL == 1 or 1+ GSE


library(GEOquery)

simulate_dataset <- function(n,
                             p,
                             gse = NULL,
                             noise_func = add_random_noise,
                             noise_func_args = list(sd = 1)) {
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

  if (noise != 0) {
    result <- add_random_noise(result, sd)
  }

  return(result)
}

simulate_gse <- function(n, p, gse = "GSE3821") {
  # gse <- "GSE133001", "GSE362" p#22
  # gse <- "GSE133001"
  temp_data <- get_dataset(gse)
  # feature name
  rnames <- sample(rownames(temp_data), p, replace = FALSE)
  # sample name
  cnames <- sample(colnames(temp_data), n, replace = FALSE)
  # data value
  temp_list <- sample(temp_data, n * p, replace = FALSE)
  data <- data.frame(matrix(temp_list, nrow = p, ncol = n))
  colnames(data) <- cnames
  rownames(data) <- rnames
  return(data)
}

get_dataset <- function(gse = "GSE3821") {
  # gse <- "GSE133001", "GSE362" p#22
  temp_base <- getGEO(gse, GSEMatrix = TRUE)
  x <- temp_base[[1]]
  temp_dat <- exprs(x)

  return(temp_dat)
}

# rbinom, rpois, runif

normal_noise <- function(gse, sd) {
  n1 <- nrow(gse)
  m1 <- ncol(gse)
  temp_dataset <- gse
  temp_dataset <- temp_dataset + rnorm(n1*m1,0,sd)
  return(temp_dataset)
}
