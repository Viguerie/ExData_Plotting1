##This script reads data from a text file, modifies the data slightly, 
##plots a time series, and saves the plot as a png file  

##get the data
pData <- read.csv("household_power_consumption.txt", 
                  sep = ";", 
                  na.strings = "?"
                  )

## make the date column posix complient
pData <- transform(pData, Date = as.Date(Date, "%d/%m/%Y"))

##subset the data
pData <- subset(pData, Date >="2007-02-01" & Date <="2007-02-02")

##Create a single new date/time comun out of the separate date and Time fields
pData$DateTime <- with(pData,
                       as.POSIXct(paste(Date,Time), 
                                  format="%Y-%m-%d %H:%M:%S"
                                  )
                        )

##open the graphics device
png("plot3.png")

##Plot the graph with three series and a legend
##first line and set the x,y labels 
plot(Sub_metering_1 ~ DateTime, 
     data=pData, 
     type="l", 
     xlab = "", 
     ylab = "Energy sub metering"
     )

##second line
lines(Sub_metering_2 ~ DateTime, 
      data=pData, 
      col="red"
      )

##third line
lines(Sub_metering_3 ~ DateTime, 
      data=pData, 
      col="blue"
      )

##add the legend
legend("topright", 
       lty = c(1,1,1), 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       )

##close the graphics device
dev.off()