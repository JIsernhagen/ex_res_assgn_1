# "household_power_consumption.txt" must be unzipped in the working directory in order for this to function.
#read in the data, subset to the relevant dates, and transform/combine date and time into useful timestamp.
consumption <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
consumption <- subset(consumption, (Date == "1/2/2007" | Date == "2/2/2007"))
consumption <- within(consumption, Datetime <- as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#Create 2 x 2 frame
library(datasets)
par(mfcol = c(2, 2))

#construct plot#1
plot(consumption$Global_active_power ~ consumption$Datetime, data = consumption, col = "white", xlab = "", ylab="Global Active Power")
lines(consumption$Datetime, consumption$Global_active_power, col = "black")

#construct plot #2
plot(consumption$Sub_metering_1 ~ consumption$Datetime, data = consumption, col = "white", xlab = "", ylab = "Energy sub metering")
lines(consumption$Datetime, consumption$Sub_metering_1, col = "black")
lines(consumption$Datetime, consumption$Sub_metering_2, col = "red")
lines(consumption$Datetime, consumption$Sub_metering_3, col = "blue")
legend("topright", pch=c("-", "-", "-"), col=c("black", "blue","red"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#construct plot #3
plot(consumption$Voltage ~ consumption$Datetime, data = consumption, col = "white", xlab = "datetime", ylab = "Voltage")
lines(consumption$Datetime, consumption$Voltage, col = "black")

#construct plot #4
plot(consumption$Global_reactive_power ~ consumption$Datetime, data = consumption, col = "white", xlab = "datetime", ylab = "Global_reactive_power")
lines(consumption$Datetime, consumption$Global_reactive_power, col = "black")

#save the plot
dev.copy(png, file= "plot4.png") ##Copy my plot to a png file
dev.off() ## don't forget to close the png device.