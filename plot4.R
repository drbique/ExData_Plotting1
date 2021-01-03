
# Load Libraries


library(tidyverse)
library(lubridate)


# Download and unzip data file

fileURL   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename  <- "household_power_consumption.zip"

if(!file.exists(filename) ) {
  download.file(fileURL, filename)
}
if(!file.exists("household_power_consumption.txt") ) {
  unzip(filename)
}


# Read data from 2007-02-01 to 2007-02-02

pc <- read_delim("household_power_consumption.txt",
                 col_types = list(col_date(format = "%d/%m/%Y"),
                                  col_time(format = ""),
                                  col_number(),
                                  col_number(),
                                  col_number(),
                                  col_number(),
                                  col_number(),
                                  col_number(),
                                  col_number()),
                 delim = ";",
                 na = c("?")) %>% filter(between(Date, 
                      as.Date("2007-02-01"), as.Date("2007-02-02")))

# Combine date and time

pcdt <- mutate(pc, datetime = ymd_hms(paste(Date, Time)))

# Make Plot 

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

# Plot 1 - Top Left

plot(Global_active_power ~ datetime, pcdt, type = "l",
       ylab = "Global Active Power (kilowatts)", xlab = NA)

# Plot 2 - Top Right

plot(Voltage ~ datetime, pcdt, type = "l")

# Plot 3 - Bottom Left

plot(Sub_metering_1 ~ datetime, pcdt, type = "l", ylab = "Energy sub metering",
       xlab = NA)

lines(Sub_metering_2 ~ datetime, pcdt, type = "l", col = "red")

lines(Sub_metering_3 ~ datetime, pcdt, type = "l", col = "blue")

legend("topright", col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, bty = "n")

# Plot 4: Bottom Right

plot(Global_reactive_power ~ datetime, pcdt, type = "l")

dev.off()

# Clear env
rm(list = ls())