#' @export
#' @name get_dataset
#' @title Extract dataset
#' @description `simulate_gse()` returns a dataset for a given GSE number.
#' @param gse The GSE number
#' @return A matrix extracted from GEOquery package
#' @examples
#' \dontrun{
#' get_dataset(gse = "GSE3821")
#' }
#' @details
#' gse is a GEO accession number. This can be found in NCBI website.
#' A Series record defines a set of related Samples considered to be
#' part of a group, how they are ordered.A Series provides a focal
#' point and description of the experiment as a whole. Series records
#' may also contain tables describing extracted data, summary conclusions,
#' or analyses. Each Series record is assigned a unique and stable GEO
#' accession number (GSExxx).

get_dataset <- function(gse) {
    temp_base <- GEOquery::getGEO(gse, GSEMatrix = TRUE)
    x <- temp_base[[1]]
    temp_dat <- Biobase::exprs(x)
    return(temp_dat)
}
