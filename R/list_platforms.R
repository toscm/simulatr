list_platforms <- function() {
  file_path <- system.file("platform.csv", package = "simulatr")
  platform_data <- read.csv(file_path)

  return(platform_data)
}
