rm(list=ls())
library(dplyr)

################################################################################

## This section of the code checks if the input data set is already in the
## working directory (the household_power_consumption.txt file). It would be
## downloaded from the web source, otherwise.

filename_zip <- "assignment_dataset.zip"
filename_input <- "household_power_consumption.txt"

if (file.exists(filename_input)){
        print("Dataset already in working directory")
} else if (!file.exists(filename_zip)){
        file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(file_url, filename_zip)
        unzip(filename_zip)
}

################################################################################

## Read and subset Data

hpc_data <- read.table(filename_input, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")
hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
hpc_data <- filter(hpc_data, Date == "2007-02-01" | Date == "2007-02-02")

## Create new variable for date and time variables

date_time <- as.POSIXct(paste(hpc_data$Date, hpc_data$Time))

################################################################################

## 4

## Create new variable for date and time variables and save to png file

date_time <- as.POSIXct(paste(hpc_data$Date, hpc_data$Time))

## Plot series of data

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

plot(date_time, hpc_data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")

plot(date_time, hpc_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(date_time, hpc_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(date_time, hpc_data$Sub_metering_2, col = "red")
lines(date_time, hpc_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

plot(date_time, hpc_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()