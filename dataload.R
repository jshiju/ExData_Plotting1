###################################################################
# @project : EDA@Coursera                                         #
# @author  : jshiju                                               #
# @date    : 11/JUL/15                                            #
# @desc    : This script has convenience functions to load data   #
#            from a text file to a data set                       #
###################################################################


## load required packages
package <- c("dplyr");
if (!require(package, character.only=T, quietly=T, warn.conflicts=F)) {
  install.packages(package)
  library(package, character.only=T, quietly=T, warn.conflicts=F)
}

##
## defines a function which has methods to load, format and subset required data
##
dataProvider <- function(path){
  
  ## Getting full dataset    
  loadData <- function (data, rows){
    data <- read.csv(path, header=T, sep=';', na.strings="?", 
                     nrows = rows, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
    data
  };
  
  ## Formatting dates
  formatData <- function(data){
    data$Date <- as.Date(data$Date, format="%d/%m/%Y")
    data
  };
  
  ## Subsetting the data
  subsetData <- function(data){
    data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
    data
  };
  
  ## Converting dates
  convertDate <- function(data){
    datetime <- paste(as.Date(data$Date), data$Time)
    data$Datetime <- as.POSIXct(datetime)
    data
  };
  
  return(list(loadData = loadData, formatData = formatData, 
              subsetData = subsetData, convertDate = convertDate))
} 
