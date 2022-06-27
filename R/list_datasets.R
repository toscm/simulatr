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

#list_datasets <- function(platform='GPL32170') {
 # dtset <- getGEO('GPL32170')
  #gse_id <- Meta(dtset)$series_id
  #info_gse <- getGEO(gse_id)
#  eData <- info_gse[[1]]
#  names(pData(eData))
 # return(info_gse)
#}

list_datasets <- function(pltfrm='GPL95'){
  dtset <- getGEO(pltfrm)
  gse_id <- Meta(dtset)$series_id
  len <- length(gse_id)
  title <- array()
  type <- array()
 # organism <- array()
  platform_id <- array()
  #series_id <- array()
  data_row_count <- array()
  
  for(i in 1:len){
      get_gse_data <- getGEO(gse_id[i])
      eData <- get_gse_data[[1]]
      gse_data <- pData(eData)
      title[i] = gse_data$title
      type[i] <- gse_data$type
      #organism[i] <- Meta(get_gsm_data)$organism
      platform_id[i] <- gse_data$platform_id
      #series_id[i] <- Meta(get_gsm_data)$series_id
      data_row_count[i] <- gse_data$data_row_count
      #GPLList() and GSMList() can be called
  }
    
    gse_dataframe <- data.frame(
      gse = gse_id,
      title = title,
      type = type,
      #organism = organism,
      platform = platform_id,
      #series_id = series_id,
      data_row_count = data_row_count
    )
    
    return (gse_dataframe)
    
  }


