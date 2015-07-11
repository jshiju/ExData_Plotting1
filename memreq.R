memreq <- function(path, rowcount){
  
  # read first 100 records
  data <- read.csv(path, header=T, sep=';', na.strings="?", 
                   nrows = 100, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
  
  object_size(data)
  
  # multiply with number of records * storage efficiency multiplier factor
  size <- object_size(data) * (rowcount/100) * 0.55
  
}
                   