#' @export
#' @name list_datasets
#' @title List Datasets useable as Base Datasets for Simulations
#' @description `lists_datasets()` returns a list of datasets that can be passed
#' to `simulate_dataset` as basis for the simulation.
#' @param platform e.g. HG-U133B for mRNA datasets measured with the Affymetrix
#' HG-U133B microarray.
#' @return A named list of datasets, where each dataset is represented by a list
#' with the following elements:
#' platform: platform specified as parameter
#' n: number of observations in the dataset
#' p: number of features in the dataset
#' download: function to actually download the dataset
#' @details list_datasets(pltfrm = "GPL95")
#' @examples
#' # to be done
#'
#'
#' 
#'
list_datasets <- function(pltfrm = "GPL95") {
  dtset <- GEOquery::getGEO(pltfrm)
  gse_id <- GEOquery::Meta(dtset)$series_id
  len <- length(gse_id)
  title <- array()
  type <- array()
  platform_id <- array()
  data_row_count <- array()

  for (i in 1:len) {
    get_gse_data <- GEOquery::getGEO(gse_id[i])
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
