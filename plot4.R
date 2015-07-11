###################################################################
# @project : EDA@Coursera                                         #
# @author  : jshiju                                               #
# @date    : 11/JUL/15                                            #
# @desc    : This script create a plot depicting household energy #
#            usage                                                #
###################################################################


## set working directory
## setwd("C:/Learn/R/Coursera/EDA/Project1")
## remove all unwanted objects
rm(list=ls())

## define global variables
filepath <- "./data/household_power_consumption.txt"
rowcount <- 2075259

## check memory requirements
source("memreq.R")
size <- memreq(filepath, rowcount)
sprintf("Approx. memory required to load the dataset with [%d] records = %s", rowcount, 
        format(structure(size, class="object_size"), units = "MB"))


source("dataload.R")

## initalize data provider
dp <- dataProvider(filepath)

##
## here we use the concepts of chaining to perform data loading, cleaning,
## formatting, converting and subsetting to build the required dataset
## 
data <- dp %>% 
  dp$loadData(rowcount) %>%
  dp$formatData() %>%
  dp$subsetData() %>%
  dp$convertDate()

##
## generate the plot by providing the required inputs
##
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="Datetime")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="Datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="Datetime")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Reactive Power (kilowatts)",xlab="Datetime")
})

##
## saving generated plot to png file
## 
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
