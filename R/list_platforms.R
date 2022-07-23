#' @export
#' @name list_datasets
#' @title List all platform numbers
#' @description `lists_platforms()` returns a list of platforms that can be
#' found in NCBI website
#' @param platform The platform number
#' @return list of all platforms along with information about them
#' @details Provides information about all the platforms
#' @examples list_platforms()
#'
list_platforms <- function() {
  file_path <- system.file("platform.csv", package = "simulatr")
  platform_data <- read.csv(file_path)

  return(platform_data)
}
