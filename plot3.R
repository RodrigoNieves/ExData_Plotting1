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
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Open Device PNG
png("plot3.png", width = 480,height = 480)

# Plot data
par(bg="transparent")

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
       legend = c("Sub_meteting_1","Sub_metering_2","Sub_metering_3"))

# Close Device
dev.off()