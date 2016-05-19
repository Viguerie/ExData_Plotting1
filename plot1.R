##This script reads data from a text file, modifies the data slightly, 
##plots a histogram and saves the histogram as a png file  

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
pData$DateTime <- with(pData, as.POSIXct(paste(Date,Time), format="%Y-%m-%d %H:%M:%S"))

##open the graphics device
png("plot1.png")

##create the histogram
hist(data$Global_active_power, 
     col="red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)"
     )

##close the graphics device

dev.off()