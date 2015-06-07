#read the data
electricpower <- read.csv("household_power_consumption.txt", na.strings = "?", sep=";")

#concatenate the date and the time into a single variable
electricpower$datetime <- paste(electricpower$Date, electricpower$Time)

#convert the date variable to R Date format
electricpower$Date <- as.Date(electricpower$Date, "%d/%m/%Y")

#extract the subset of the data needed for the plot
plotdata <- electricpower[( (electricpower$Date == as.Date("2007-02-01")) | (electricpower$Date == as.Date("2007-02-02"))),]

#open the PNG device with specified filename and dimensions
png(file="plot1.png", width=480, height=480)

#draw the plot
hist (plotdata$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red")

#close the device
dev.off()