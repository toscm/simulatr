#' @export
#' @name list_platforms
#' @title List all platform numbers
#' @description `lists_platforms()` returns a list of platforms that can be
#' found in NCBI website
#' @return list of all platforms along with information about them
#' @details Provides information about all the platforms
#' @examples \dontrun{
#' list_platforms()
#' }
#'
list_platforms <- function() {
  platform_data <- rd()

  return(platform_data)
}

read_data <- function() {
  readRDS(file = system.file("platform.rds", package = "simulatr"))
}

rd <- memoise::memoise(read_data)
