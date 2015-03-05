## Coursera - Exploratory Data Analysis - Course Project 1

library(dplyr)

## Read the file into [R]
data <- read.table("household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   dec = ".",
                   na.strings = "?")

## Select rows from 2007-02-01 and 2007-02-02
data <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

## Combine Date and Time columns
data <- mutate(data, DateTime = paste(data$"Date", data$"Time", sep = " "))

## Convert to date and time classes
data <- mutate(data, DateTime = as.character(strptime(data[, "DateTime"],
                                                      "%e/%m/%Y %H:%M:%S")))
data <- mutate(data, DateTime = as.POSIXct(DateTime))

## Select and reorder columns
data <- data[c(10,3,4,5,6,7,8,9)]

## Open a new PNG device
png("plot2.png", width=480, height=480)

## Create plot 2
with(data, plot(DateTime, Global_active_power, xlab = "", 
                ylab = "Global Active Power (kilowatts)",type = "l"))

## Close device
dev.off()