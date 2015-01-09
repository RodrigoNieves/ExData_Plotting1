# Read data
DT <- read.table("household_power_consumption.txt",sep=";",head=TRUE, stringsAsFactors = FALSE)
# Obtain Dates
dates <- as.Date(DT$Date,format="%d/%m/%Y")
# Obtain relevant data
data <- DT[dates == "2007-02-01" | dates == "2007-02-02",]
# Obtain Data and time
dateTime <- paste(data$Date,data$Time)
data$DateTime <- strptime(dateTime, "%d/%m/%Y %H:%M:%S")

# Obtain data to plot
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Open Device PNG
png("plot4.png", width = 480,height = 480)

# Plot data
par(bg="transparent")

par(mfrow= c(2,2))

# First subplot
with(data, plot(DateTime, Global_active_power, 
                type="l", 
                xlab="", 
                ylab="Global Active Power"))

# Second subplot
with(data, plot(DateTime, Voltage,
                type="l",
                xlab="datetime",
                ylab="Voltage"))
# Third subplot
# Set plot region
with(data,plot(
    c(DateTime,DateTime,DateTime),
    c(Sub_metering_1,Sub_metering_2,Sub_metering_3), 
    type = "n",
    xlab = "",
    ylab = "Energy sub metering"))

# Draw lines
with(data, lines(DateTime, Sub_metering_1))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))           

# Draw legend
legend("topright", lty=c(1,1), col = c("black","red","blue"),
       legend = c("Sub_meteting_1","Sub_metering_2","Sub_metering_3"), 
       bty="n")

# Foutrth subplot
with(data, plot(DateTime, Global_reactive_power,
                 type="l",
                 xlab="datetime",
                 ylab="Global_reactive_power"))
# Close Device
dev.off()