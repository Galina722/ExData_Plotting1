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
data1 <- read.table ("household_power_consumption.txt",na.strings = "?", sep = ";", skip = 1)
names(data1) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",                    "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data1$Date <- as.Date(data1$Date, "%d/%m/%Y")

##creating subset for the only two dates needed
data2 <- subset(data1, data1$Date == "2007-02-01" | data1$Date == "2007-02-02")

##remove first data frame to free up memory
rm(data1)

##combine date and time columns together
timeStamp <- paste(data2$Date, data2$Time)
timeStamp <- setNames(timeStamp, "Time_Stamp")

##remove columns date and time
data3 <- data2[, !(names(data2) %in% c("Date", "Time"))]

##add new column timeStamp
data3 <- cbind(timeStamp, data3)
data3$timeStamp <- as.POSIXct(timeStamp)

##creating plot2 in PNG file
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data3$Global_active_power~data3$timeStamp, type="l", ylab="Global Active Power     (kilowatts)", xlab="")

##close device
dev.off()