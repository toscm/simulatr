#' @export
#' @name get_gpl_data
#' @title Extract data
#' @description `get_gpl_data()` returns a information for a given GPL number.
#' @param gplnum The GPL number
#' @return A matrix extracted from GEOquery package
#' @examples
#' \dontrun{
#' get_gpl_data("GPL96")
#' }
#' @details
#' gple is a GEO accession number. This can be found in NCBI website.
#' A Platform record describes the list of elements on the array (e.g., cDNAs,
#' oligonucleotide probesets, ORFs, antibodies) or the list of elements that
#' may be detected and quantified in that experiment (e.g., SAGE tags,
#' peptides). Each Platform record is assigned a unique and stable GEO
#' accession number (GPLxxx). A Platform may reference many Samples that
#' have been submitted by multiple submitters.

get_gpl_data <- function(gplnum) {
  gpl <- GEOquery::getGEO(gplnum)

  # create matrix for data of the given platform
  a <- c(
    GEOquery::Meta(gpl)$geo_accession,
    GEOquery::Meta(gpl)$title,
    GEOquery::Meta(gpl)$technology,
    GEOquery::Meta(gpl)$organism,
    GEOquery::Meta(gpl)$status
  )
  matrix <- BiocGenerics::rbind(a)
  colnames(matrix) <- c("GEO Accession",
                        "Title",
                        "Technology",
                        "Organism",
                        "Status")
  return(matrix)
}
