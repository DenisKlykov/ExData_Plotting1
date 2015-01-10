# Read file
FileName="household_power_consumption.txt"
library(data.table)
DT <- read.table(FileName, sep = ";", header = T, na.strings = c("?", ""))
# convert time
DT$DateTime <- paste(DT$Date, DT$Time)
DT$DateTime <- as.POSIXct(DT$DateTime, format = "%d/%m/%Y %H:%M:%S")
# del Date, Time
DT$Time <- NULL
DT$Date <- NULL
# get small data
StartDate <- as.POSIXct("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S")
EndDate   <- as.POSIXct("2007-02-02 23:59:59", format="%Y-%m-%d %H:%M:%S")
DT <- subset(DT, DateTime>=StartDate & DateTime<=EndDate)
# plot and save PNG
png(file = "plot3.png", bg = "transparent")
plot(DT$DateTime,DT$Sub_metering_1,type="l",
     xlab="", ylab="Energy sub metering")
points(DT$DateTime,DT$Sub_metering_2,type="l", col="red")
points(DT$DateTime,DT$Sub_metering_3,type="l", col="blue")
legend("topright",col = c("black","red","blue"),lty=1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()