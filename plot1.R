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

## 1

## Plot a histogram of global active power values

hist(hpc_data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## Save to png file

dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()