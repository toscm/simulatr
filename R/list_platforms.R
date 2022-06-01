
list_platforms <- function(){
  data = read.csv("C:/Users/ASUS/simulatr/instplatform.csv")
  
  platforms <- data$Accession
  
  
  platform_data <- as.data.frame.table(data)
  platform_table <- platform_data[,3:11]
  colnames(platform_table) = c("Platform Number","Title","Technology","Taxonomy","Number of features","Number of datasets","Number of Series","Contact","Release Date")
  
  return(platform_table)
  
}





      