#' @export
#' @name normal_data
#' @title Create normal data
#' Gaussian or normal distribution
#' @param n The number of samples
#' @param p The number of features (e.g. genes)
#' @return A matrix of size n*p
#' @examples
#' \dontrun{
#' normal_data(10, 10)
#' }
#'
normal_data <- function(n, p) {
    df <- data.frame(matrix(stats::rnorm(n * p), n, p))
    return(df)
}
