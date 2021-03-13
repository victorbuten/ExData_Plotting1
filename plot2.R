### This is the script I made for downloading/prepping data for creating the plots, copy/pasted into all the plotting functions from importData.R
##-------------------------------------------------------------------------------------------------------------------------------
checkData <- function(){
  ### I start by checking if the dataset exists in the working directory. 
  ### If it doesn't, I then check for, and if needed download the zip file containing the dataset,
  ### before unzipping the downloaded file
  if(file.exists("household_power_consumption.txt")==FALSE){
    if(file.exists("data.zip")==FALSE){
      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                    destfile ="data.zip")
    }
    unzip("data.zip")
  }
}
getData <- function(){  
  library(dplyr)
  ### Read the data
  data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
  ### Subset data to only contain observations taken on 01/02/2007 and 02/02/2007
  data <- subset(data, as.Date(data$Date, format="%d/%m/%Y") == as.Date("01/02/2007", format="%d/%m/%Y")|as.Date(data$Date, format="%d/%m/%Y") == as.Date("02/02/2007", format="%d/%m/%Y"))
  ### Combine the date and time columns into one datetime column of type POSIXlt
  data <- data %>% mutate(Datetime=strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))
  ###Reorder data so that the date and time columns are dropped, and the datetime column is set to column 1
  data <- data[,c(10, 3:9)]
}  
##End of the copy/pasted download/prepping script ------------------------------------------------------------------------------------------------------------------------------------------


checkData()
data <- getData()
png("plot2.png")
par(mar=c(3,4,4,1))
plot(data$Datetime, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)")
dev.off()