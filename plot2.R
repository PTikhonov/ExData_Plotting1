## loading libraries
library(dplyr)
library(tidyr)
setwd("~/GitHub/ExData_Plotting1")
      ##read file "household_power_consumption.txt" to a data frame "power". stringsAsFactors = FALSE
      power <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",  header = TRUE, stringsAsFactors = FALSE, sep = ";")
      
      ##concatenate and cast date and time fields
      power <- transform(power, DT = strptime(paste(Date,Time), format = "%e/%m/%Y %H:%M:%S"))
      
      ## filter dataset and transform characters into numeric type
      pwr1 <- filter(power, (DT >= "2007-02-01" & DT <= "2007-02-03")) 
      pwr1 <- transform(pwr1, Global_active_power = as.numeric(Global_active_power))
      pwr1 <- transform(pwr1, Sub_metering_1 = as.numeric(Sub_metering_1), Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3), Voltage = as.numeric(Voltage), Global_reactive_power = as.numeric(Global_reactive_power))
      
      ##initiate global param for plotting
      par(mfrow = c(1,1))

## Launch PNG device and create plot
png(file = "Plot2.png", height = 480, width=480)

##second plot
with(pwr1, plot(DT, Global_active_power, type = "l", ylab = "", xlab = ""))
title(ylab = "Global Active Power (kilowatts)")

## Close device
dev.off(which = dev.cur())
