# "household_power_consumption.txt" must be unzipped in the working directory in order for this to function.
#read in the data, subset to the relevant dates, and transform/combine date and time into useful timestamp.
consumption <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
consumption <- subset(consumption, (Date == "1/2/2007" | Date == "2/2/2007"))
consumption <- within(consumption, Datetime <- as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

library(datasets)
#construct plot#1
plot(consumption$Global_active_power ~ consumption$Datetime, data = consumption, col = "white", xlab = "", ylab="Global Active Power (kilowatts)")
lines(consumption$Datetime, consumption$Global_active_power, col = "black")

#save the plot
dev.copy(png, file= "plot2.png") ##Copy my plot to a png file
dev.off() ## don't forget to close the png device.