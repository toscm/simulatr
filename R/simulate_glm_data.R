#' @export
#' @name simulate_glm_data
#' @title Simulate a dataframe using glm
#' @description `simulate_glm_data()` returns a dataframe simulated using
#' generalized linear model
#' @param dat The dataframe from which new data is to
#' be simulated
#' @return A dataframe with simulated data
#' @examples \dontrun{
#' simulate_glm_data(base = simulatr::normal_data(5, 6))
#' }
#' \dontrun{
#' simulate_glm_data(dat = as.data.frame(simulatr::get_dataset(
#'     gse =
#'         "GSE3821"
#' )))
#' }
#' \dontrun{
#' simulate_glm_data(dat = simulatr::simulate_gse(10,
#'     10,
#'     gse = "GSE3821"
#' ))
#' }
simulate_glm_data <- function(dat) {
    d <- dat
    l <- length(colnames(d))
    d <- d[, sample(1:ncol(d))]
    for (i in 2:l) {
        pred_i <- colnames(d)[2:i - 1]
        model <- stats::glm(unlist(d[, i]) ~ .,
            data = d[, c(colnames(d)[1], pred_i)],
            family = "gaussian"
        )
        d[, i] <- stats::predict(model, type = "response")
    }
    return(d)
}
