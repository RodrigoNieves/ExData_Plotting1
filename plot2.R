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
x <- data$DateTime
y <- data$Global_active_power

# Open Device PNG
png("plot2.png", width = 480,height = 480)

# Plot data
par(bg="transparent")
plot(x,y, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Close Device
dev.off()
