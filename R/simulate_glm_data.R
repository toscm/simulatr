#' @export
#' @name simulate_glm_data
#' @title Simulate a dataframe using glm
#' @description `simulate_glm_data()` returns a dataframe simulated using
#' generalized linear model
#' @param dat The dataframe from which new data is to
#' be simulated
#' @return A dataframe with simulated data
#' @examples \dontrun{
#' simulate_glm_data(dat = simulatr::normal_data(5, 6))
#' }
#' \dontrun{
#' simulate_glm_data(dat = as.data.frame(simulatr::get_dataset(
#'     gse = "GSE3821"
#' )))
#' }
#'
simulate_glm_data <- function(dat) {
    d <- dat
    l <- length(colnames(d))
    d <- d[, sample(seq_len(ncol(d)))]
    feature1 <- d[, 1]
    quant <- stats::runif(length(d[, 1]), 0, 1)
    d[, 1] <- stats::quantile(feature1, quant)
    for (i in 2:l) {
        pred_col <- colnames(d)[2:i - 1]
        cur_col <- colnames(d)[i]
        model <- stats::glm(unlist(dat[, cur_col]) ~ .,
            data = dat[, c(colnames(d)[1], pred_col)],
            family = "gaussian"
        )
        d[, i] <- stats::predict(model, type = "response")
    }
    return(d)
}
