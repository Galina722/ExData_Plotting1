##Downloading and unzipping file
if(!file.exists("./data")){dir.create("./data")}
fileurl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest1 <- "/Users/Galka/Downloads/Coursera/Exploratory Data Analysis/data/dataset.zip"
download.file (fileurl1, dest1)
unzip(zipfile="./data/dataset.zip",exdir="./data")
setwd(".data")

##Libraries
library(data.table)

##read file
data1 <- fread("household_power_consumption.txt",na.strings = "?", sep = ";", skip = 1)
names(data1) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",                    "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data1$Date <- as.Date(data1$Date, "%d/%m/%Y")

##creating subset for the only two dates needed
data2 <- subset(data1, data1$Date == "2007-02-01" | data1$Date == "2007-02-02")

##remove first data frame to free up memory
rm(data1)

##creating plot1 - histogram with a title - in PNG file
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist (data2$Global_active_power, col="red", main="Global Active Power", 
      xlab="Global Active Power (kilowatts)")

##close device
dev.off()