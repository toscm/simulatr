#' @export
#' @name list_datasets
#' @title List Datasets useable as Base Datasets for Simulations
#' @description `lists_datasets()` returns a list of datasets that can be passed
#' to `simulate_dataset` as basis for the simulation.
#' @param platform The platform number
#' @return A dataframe with information about series which used a specific
#' platform
#' @details A Platform record describes the list of elements on the array (e.g.,
#' cDNAs, oligonucleotide, probesets, ORFs, antibodies) or the list of elements
#' that may be detected and quantified in that experiment (e.g., SAGE tags,
#' peptides). Each Platform record is assigned a unique and stable GEO accession
#' number (GPLxxx). A Series record defines a set of related Samples considered
#' to be part of a group, how the Samples are related, and if and how they are
#' ordered. A Series provides a focal point and description of the experiment as
#' a whole. Series records may also contain tables describing
#' extracted data, summary conclusions, or analyses. Each Series record is
#'assigned a unique and stable GEO accession number (GSExxx). S
#' @examples list_datasets(platform = "GPL95")
#'
list_datasets <- function(platform) {
  dtset <- GEOquery::getGEO(platform)
  gse_id <- GEOquery::Meta(dtset)$series_id
  len <- length(gse_id)
  title <- array()
  type <- array()
  platform_id <- array()
  data_row_count <- array()

  for (i in 1:len) {
    get_gse_data <- GEOquery::getGEO(gse_id[i], GSEMatrix = TRUE)
    edata <- get_gse_data[[1]]
    gse_data <- Biobase::pData(edata)
    title[i] <- gse_data$title
    type[i] <- gse_data$type
    platform_id[i] <- gse_data$platform_id
    data_row_count[i] <- gse_data$data_row_count
  }
  gse_dataframe <- data.frame(
    gse = gse_id,
    title = title,
    type = type,
    platform = platform_id,
    data_row_count = data_row_count
  )

  return(gse_dataframe)
}
