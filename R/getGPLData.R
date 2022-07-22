getGPLData <- function(gplnum) {
  # access gpl data
  gpl <- GEOquery::getGEO(gplnum)

  # create matrix for data of the given platform
  a <- c(
    GEOquery::Meta(gpl)$geo_accession,
    GEOquery::Meta(gpl)$title,
    GEOquery::Meta(gpl)$technology,
    GEOquery::Meta(gpl)$organism,
    GEOquery::Meta(gpl)$status
  )
  matrix <- rbind(a)
  colnames(matrix) <- c("GEO Accession",
                        "Title",
                        "Technology",
                        "Organism",
                        "Status")
  return(matrix)
}
