##This script reads data from a text file, modifies the data slightly, 
##plots a four time series in a sigle fram, and saves the entire frame as a png file  

##get the data
pData <- read.csv("household_power_consumption.txt", 
                  sep = ";", 
                  na.strings = "?"
                  )

## make the date column posix complient
pData <- transform(pData, Date = as.Date(Date, "%d/%m/%Y"))

##subset the data
pData <- subset(pData, Date >="2007-02-01" & Date <="2007-02-02")

##Create a single new date/time comun out of the separate Date and Time fields
pData$DateTime <- with(pData,
                       as.POSIXct(paste(Date,Time), 
                                  format="%Y-%m-%d %H:%M:%S"
                                  )
                        )

##open the graphics device
png("plot4.png")

##create the 2x2 frame
par(mfrow = c(2,2))

##create the first graph
plot(Global_active_power ~ DateTime, 
     data=pData, type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)"
      )

##create the second graph
plot(Voltage ~ DateTime, 
     data=pData, 
     type="l"
      )

##third graph
plot(Sub_metering_1 ~ DateTime, 
     data=pData, 
     type="l", 
     xlab = "", 
     ylab = "Energy sub metering"
    )

      ##third graph - second line
      lines(Sub_metering_2 ~ DateTime, 
            data=pData, 
            col="red"
            )

      ##third graph - third line
      lines(Sub_metering_3 ~ DateTime, 
            data=pData, 
            col="blue"
            )
      
      ##third graph - add the legend
      legend("topright", 
             lty = c(1,1,1), 
             col = c("black", "red", "blue"), 
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
             bty = "n"
            )
      
##fourth graph
 plot(Global_reactive_power ~ DateTime, 
     data=pData, 
     type="l"
     )
 
 ##close the graphics device
 dev.off()