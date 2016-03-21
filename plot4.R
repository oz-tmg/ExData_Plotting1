setwd("~/datasciencecoursera/")

#----- Read in the Data -----#
initial <- read.table("household_power_consumption.txt", sep = ";", nrows=100, header=T, na.strings = "?")
classes <- sapply(initial, class)   
df <- read.table("household_power_consumption.txt", sep = ";", header=T, colClasses = classes, na.strings = "?")

#----- Format Data -----#
df$DateTime <- as.POSIXct(strptime(paste(as.character(df$Date), as.character(df$Time)), format = "%d/%m/%Y %H:%M:%S"))
df$Date <- as.Date(as.character(df$Date), format = "%d/%m/%Y")
minDate <- as.Date("2007-02-01", format = "%Y-%m-%d")
maxDate <- as.Date("2007-02-02", format = "%Y-%m-%d")
df <- df[minDate <= df$Date & df$Date <= maxDate,]

#----- Plot 4 -----#
par(mfrow = c(2, 2))

# Plot 2 in 1st Slot
plot(df$DateTime, df$Global_active_power, type = "n", ylab = "Global active power (killowatts)", xlab = "datetime")
lines(df$DateTime, df$Global_active_power)              

# 2nd Slot Plot
plot(df$DateTime, df$Voltage, type = "n", ylab = "Voltage", xlab = "datetime")
lines(df$DateTime, df$Voltage)                          

# 3rd Slot Plot
plot(df$DateTime, df$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "datetime")
lines(df$DateTime, df$Sub_metering_1, col = "black")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"),
       pt.cex = 1, cex=0.5)

# 4th Slot Plot
plot(df$DateTime, df$Global_reactive_power, type = "n", ylab = "Global reactive power", xlab = "datetime")
lines(df$DateTime, df$Global_reactive_power) 

# Copy plot
dev.copy(png, "plot4.png")
dev.off()