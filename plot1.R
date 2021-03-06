# "household_power_consumption.txt" must be unzipped in the working directory in order for this to function.
#read in the data, subset to the relevant dates, and transform/combine date and time into useful timestamp.
consumption <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
consumption <- subset(consumption, (Date == "1/2/2007" | Date == "2/2/2007"))
consumption <- within(consumption, Datetime <- as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#construct the plot
library(datasets)
hist(consumption$Global_active_power, col="red", breaks = 12, main = "Global Active Power", xlab="Global Active Power (kilowatts)")

#save the plot
dev.copy(png, file= "plot1.png") ##Copy my plot to a png file
dev.off() ## don't forget to close the png device.
