#' @export
#' @name simulate_dataset
#' @title Simulate a Dataset
#' @description `simulate_dataset()` returns a dataset of size n*p
#' @param n The number of samples.
#' @param p The number of features.
#' @param beta The model coefficients.
#' @param base The dataset to use as basis for the generation, e.g. HG-U133B for
#'   mRNA datasets measured with the Affymetrix HG-U133B microarray.
#' @param platform The platform for which data should be simulated.
#' @param family The type of model to use when generating the outcome variable.
#'   Either `gaussian`, `binomial` or `cox`.
#' @param cor Correlation strength within the data
#' @param cortype Method to use for generating the correlation within the
#'   dataset. See below for details.
#' @param noise Amount of noise to add to each predictor
#' @param noisevar Variance of noise
#' @param bias Amount of bias to simulate
#' @param biastype Method to use for generating the bias. See below for details.
#' @return A matrix of size n*p.
#' @examples
#' \dontrun{
#' x <- simulate_dataset(n=100, p=1000, base="HG-U133B")
#' # should return a matrix of size 100*1000 with genes measured by the
#' # HG-U133B microarray as features
#' }
#' @details simulate_dataset <- function( n=3, p=4, beta=NULL, base="HG-U133B",
#'   family="gaussian", cor=0.5, cortype=1, noise=1, noisevar=1, bias=0,
#'   biastype=1 )
#'   
#'   
#'   
#'   



#1 GPL == 1 or 1+ GSE 

simulate_dataset <- function(n=4,p=2,beta=NULL,base=NULL,platform=NULL,noise=0,noisevar=0,gse=NULL,family=NULL){
    if(base==NULL && beta==NULL){
      mat <- matrix(,n,p)
      var <- vector()
        for (i in 1:n){
          var <- rnorm(p)
          mat[i,1:p] <- var
      }
      return(mat)
    }
    else if(gse!=NULL){
      return(simulate_gse(gse))
    }
   else if(gpl != NULL){
     gse_ids <- list_datasets(platform)$gse_id
     for(i in gse){
       return(simulate_gse(gse_ids))
     }
  }
}


simulate_gse <- function(n,p,gse){
    gse <- "GSE781"
    temp <- getGEO(gse)
    tempnames(GPLList(gse))
    temp_data <- exprs(temp_base[[1]])
    temp_sample <- sample(temp_data,size=n*p,replace=FALSE)
    temp_matrix <- matrix(temp_sample,n,p)
    return(temp_matrix)
}
  

