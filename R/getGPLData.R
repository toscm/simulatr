getGPLData <- function(gplnum){
  # access gpl data
  gpl <- getGEO(gplnum)

  # create matrix for data of the given platform
  a <- c(Meta(gpl)$geo_accession,Meta(gpl)$title,Meta(gpl)$technology,Meta(gpl)$organism,Meta(gpl)$status)
  matrix <- rbind(a)
  colnames(matrix) <- c('GEO Accession', 'Title', 'Technology', 'Organism', 'Status')

  #view matrix
  return(matrix)
}

# getGPLData('GPL32170')
install.packages("languageserver")