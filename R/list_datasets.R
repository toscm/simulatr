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

#library
library(GEOquery)

#get data for specific platform 

getGPLData <- function(gplnum){
  # access gpl data
  gpl <- getGEO(gplnum)
 
  # create matrix for data of the given platform
  a <- c(Meta(gpl)$geo_accession,Meta(gpl)$title,Meta(gpl)$technology,Meta(gpl)$organism,Meta(gpl)$status)
  matrix <- rbind(a)
  colnames(matrix) <- c('GEO Accession', 'Title', 'Technology', 'Organism', 'Status')
 
  #view matrix
  View(matrix)
  
  
}

getGPLData('GPL32170')

