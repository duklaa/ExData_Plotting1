#read the data
electricpower <- read.csv("household_power_consumption.txt", na.strings = "?", sep=";")

#concatenate the date and the time into a single variable
electricpower$datetime <- paste(electricpower$Date, electricpower$Time)

#convert the date variable to R Date format
electricpower$Date <- as.Date(electricpower$Date, "%d/%m/%Y")

#extract the subset of the data needed for the plot
plotdata <- electricpower[( (electricpower$Date == as.Date("2007-02-01")) | (electricpower$Date == as.Date("2007-02-02"))),]

#convert the Time and datetime variables to appropriate format
plotdata$Time <- strptime(plotdata$Time, "%H:%M:%S")
plotdata$datetime <- strptime(plotdata$datetime, "%d/%m/%Y %H:%M:%S")

#open the PNG device with specified filename and dimensions
png(file="plot2.png", width=480, height=480)

#draw the plot
with(plotdata, plot(plotdata$datetime, plotdata$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n"))
lines(plotdata$datetime, plotdata$Global_active_power)

#close the device
dev.off()