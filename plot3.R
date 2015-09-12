# "household_power_consumption.txt" must be unzipped in the working directory in order for this to function.
#read in the data, subset to the relevant dates, and transform/combine date and time into useful timestamp.
consumption <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
consumption <- subset(consumption, (Date == "1/2/2007" | Date == "2/2/2007"))
consumption <- within(consumption, Datetime <- as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#construct the plot
library(datasets)
plot(consumption$Sub_metering_1 ~ consumption$Datetime, data = consumption, col = "white", xlab = "", ylab = "Energy sub metering")
lines(consumption$Datetime, consumption$Sub_metering_1, col = "black")
lines(consumption$Datetime, consumption$Sub_metering_2, col = "red")
lines(consumption$Datetime, consumption$Sub_metering_3, col = "blue")
legend("topright", pch=c("-", "-", "-"), col=c("black", "blue","red"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#save the plot
dev.copy(png, file= "plot3.png") ##Copy my plot to a png file
dev.off() ## don't forget to close the png device.