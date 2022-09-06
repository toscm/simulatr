#' @export
#' @name simulate_gse
#' @title Simulate data from GSE
#' @description `simulate_gse()` returns a dataset of size n*p for
#' a given GSE number.
#' @param n The number of samples
#' @param p The number of features (e.g. genes)
#' @param gse The GSE number
#' @return A matrix of size n*p
#' @examples
#' \dontrun{
#' simulate_gse(10, 10, gse = "GSE3821")
#' }
#' @details
#' n and p define the dimension of the matrix to return.
#' gse is a GEO accession number. This can be found in NCBI website.
#' Each Series record is assigned a unique and stable GEO
#' accession number (GSExxx).

simulate_gse <- function(n = 10, p = 10, gse = "GSE3821") {
    temp_data <- simulatr::get_dataset(gse)
    if (dim(temp_data)[1] < n || dim(temp_data)[2] < p) {
        stop(
            "Dimension of the simulated data needs to be smaller or equal to
             the base data."
        )
    }
    # feature name
    rnames <- sample(rownames(temp_data), n, replace = FALSE)
    # sample name
    cnames <- sample(colnames(temp_data), p, replace = FALSE)
    # data value
    temp_list <- sample(temp_data, n * p, replace = FALSE)
    data <- data.frame(matrix(temp_list, nrow = n, ncol = p))
    colnames(data) <- cnames
    rownames(data) <- rnames
    return(data)
}
