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
list_datasets <- function(platform='GPL32170', source="GEOquery") {
  # retrieve all datasets measured with <platform> from GEOquery:
  x <- list() # this is just a placeholder for the real colde
  return(x)
}
