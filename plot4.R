library(lubridate)

## Download and unzip the data
file <- "exdata_data_household_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir <-""


if(!file.exists(file)){
  download.file(url,file, mode = "wb") 
}

if(!file.exists(dir)){
  unzip("exdata_data_household_power_consumption.zip", files = NULL, exdir=".")
}

## Clean the data
tbl <- read.table("household_power_consumption.txt", sep=';', skip=66637, nrows=2880)
colnames(tbl) <- colnames(read.table("household_power_consumption.txt", sep=';', nrow = 1, header = TRUE))
tbl$Date <- as.Date(tbl$Date, "%d/%m/%Y")
tbl$Time <- as.character(tbl$Time)
tbl$DateTime <- ymd_hms(with(tbl, paste(Date, Time)))

## Plot the data
dev.copy(png,"plot4.png", width=480, height=480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(tbl, {
  # here three plots are filled in with their respective titles
  plot(DateTime, Global_active_power, type='l', ylab="Global active power", xlab='', lwd=1)
  plot(Voltage~DateTime, type='l', ylab="Voltage", xlab='datetime')
  plot(Sub_metering_1~DateTime, type='l', ylab='Energy Sub metering', xlab='')
  lines(Sub_metering_2~DateTime, type='l', col='red')
  lines(Sub_metering_3~DateTime, type='l', col='blue')
  legend("topright", lty=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DateTime, Global_reactive_power, type='l', xlab='datetime', lwd=1)})
dev.off()