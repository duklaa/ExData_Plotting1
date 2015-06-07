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
png(file="plot3.png", width=480, height=480)

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
legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, lty=c(1,1,1))

#close the device
dev.off()

