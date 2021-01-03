
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

# Make Plot 

hist(pc$Global_active_power, xlab = "Global Active Power (kilowatts)",
       col = "red", main = "Global Active Power")

# Save Plot 

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

# Clear env

rm(list = ls())
 