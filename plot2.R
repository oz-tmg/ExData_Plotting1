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

#----- Plot 2 -----#
plot(df$DateTime, df$Global_active_power, type = "n", ylab = "Global active power (killowatts)", xlab = "datetime")
lines(df$DateTime, df$Global_active_power)

# Copy plot
dev.copy(png, "plot2.png")
dev.off()