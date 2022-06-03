#' @export
#' @name list_datasets
#' @title List Datasets useable as Base Datasets for Simulations
#' @description `lists_datasets()` returns a list of datasets that can be passed
#' to `simulate_dataset` as basis for the simulation.
#' @param platform e.g. HG-U133B for mRNA datasets measured with the Affymetrix
#' HG-U133B microarray.
#' @param source where to search for datasets.
#' @return A named list of datasets, where each dataset is represented by a list
#' with the following elements:
#' platform: platform specified as parameter
#' n: number of observations in the dataset
#' p: number of features in the dataset
#' download: function to actually download the dataset
#' @examples
#' # to be done
#' @details to be done

list_datasets <- function(pltfrm='GPL32170') {
  dtset <- getGEO('GPL32171')
  gse_id <- Meta(dtset)$series_id
  
  info_gse <- getGEO(gse_id)
  
  return(info_gse)
}

list_gsm <- function(pltfrm='GPL32170'){
  dtset <- getGEO('GPL32171')
  gsm_id <- Meta(dtset)$sample_id
  
  len <- length(gsm_id)
  
  title <- array()
  
  type <- array()
  
  organism <- array()
  
  platform_id <- array()
  
  series_id <- array()
  
  data_row_count <- array()
  
  for(i in 1:len){
    
      get_gsm_data <- getGEO(gsm_id[i])
      
      title[i] = Meta(get_gsm_data)$title
      
      type[i] <- Meta(get_gsm_data)$type
      
      organism[i] <- Meta(get_gsm_data)$organism
      
      platform_id[i] <- Meta(get_gsm_data)$platform_id
      
      series_id[i] <- Meta(get_gsm_data)$series_id
      
      data_row_count[i] <- Meta(get_gsm_data)$data_row_count
      
      
      
    }
    
    gsm_dataframe <- data.frame(
      gsm = gsm_id,
      title = title,
      type = type,
      organism = organism,
      platform = platform_id,
      series_id = series_id,
      data_row_count = data_row_count
    )
    
    return (gsm_dataframe)
    
  }

