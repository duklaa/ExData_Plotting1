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
png(file="plot4.png", width=480, height=480)

#set the parameters for 2 x 2 plotting
par(mfrow = c(2,2))

#draw the first plot (top left)
with(plotdata, plot(plotdata$datetime, plotdata$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n"))
lines(plotdata$datetime, plotdata$Global_active_power)

#draw the second plot (top right)
with(plotdata, plot(plotdata$datetime, plotdata$Voltage, xlab="datetime", ylab = "Voltage", type = "n"))
lines(plotdata$datetime, plotdata$Voltage)


#draw the third plot (bottom left)

#plot the data for sub_metering_1
with(plotdata, plot(plotdata$datetime, plotdata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", ylim=c(0,40), type = "n"))

#plot the data for sub_metering_2
par(new=T)
with(plotdata, plot(plotdata$datetime, plotdata$Sub_metering_2, xlab = "", ylab = "", axes=F, ylim=c(0,40), type = "n"))

#plot the data for sub_metering_3
par(new=T)
with(plotdata, plot(plotdata$datetime, plotdata$Sub_metering_3, xlab = "", ylab = "", axes=F, ylim=c(0,40), type = "n"))

#draw the plotted lines for sub_metering_1, sub_metering_2, and sub_metering_3
lines(plotdata$datetime, plotdata$Sub_metering_1, col="Black")
lines(plotdata$datetime, plotdata$Sub_metering_2, col="Red")
lines(plotdata$datetime, plotdata$Sub_metering_3, col="Blue")

#draw the legend
legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", lwd=2, lty=c(1,1,1))



#draw the fourth plot (bottom right)
with(plotdata, plot(plotdata$datetime, plotdata$Global_reactive_power, xlab="datetime", ylab = "Global_reactive_power", type = "n"))
lines(plotdata$datetime, plotdata$Global_reactive_power)

#close the device
dev.off()
