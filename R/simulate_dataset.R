#' @export
#' @name simulate_dataset
#' @title Simulate a Dataset
#' @description `simulate_dataset()` returns a dataset of size n*p
#' @param n The number of samples.
#' @param p The number of features.
#' @param beta The model coefficients.
#' @param base The dataset to use as basis for the generation, e.g. HG-U133B
#' for mRNA datasets measured with the Affymetrix HG-U133B microarray.
#' @param family The type of model to use when generating the outcome variable.
#' Either `gaussian`, `binomial` or `cox`.
#' @param cor Correlation strength within the data
#' @param cortype Method to use for generating the correlation within the
#' dataset. See below for details.
#' @param noise Amount of noise to add to each predictor
#' @param noisevar Variance of noise
#' @param bias Amount of bias to simulate
#' @param biastype Method to use for generating the bias. See below for details.
#' @return A matrix of size n*p.
#' @examples
#' \dontrun{
#' x <- simulate_dataset(n=100, p=1000, base="HG-U133B")
#' # should return a matrix of size 100*1000 with genes measured by the
#' # HG-U133B microarray as features
#' }
#' @details to be done
simulate_dataset <- function(
	n,
	p,
	beta=NULL,
	base="HG-U133B",
	family="gaussian",
	cor=0.5,
	cortype=1,
	noise=1,
	noisevar=1,
	bias=0,
	biastype=1
) {
	matrix(rnorm(n*p), n, p)
}
