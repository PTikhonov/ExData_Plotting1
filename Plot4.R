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
      
      

## Launch PNG device and create plot
png(file = "Plot4.png", height = 1000, width=1000)
par(mfrow = c(2,2))
##dashboard
with (pwr1,{
        plot(DT, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
        plot(DT, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")                
        plot(DT, Sub_metering_1, type = "l", ylab = "", xlab = "")                
        lines(DT, Sub_metering_2, type = "l", col = "red")
        lines(DT, Sub_metering_3, type = "l", col = "blue")
        title(ylab = "Energy sub metering")
        legend('topright',legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n", col = c("black","red", "blue"), lty = 1)
        plot(DT, Global_reactive_power, type = "l", xlab = "datetime")
})

## Close device
dev.off(which = dev.cur())
