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
tbl <- read.table("household_power_consumption.txt", sep=';', skip=66637, nrows=2880, na    = c("?"))
colnames(tbl) <- colnames(read.table("household_power_consumption.txt", sep=';', nrow = 1, header = TRUE))
tbl$Date <- as.Date(tbl$Date, "%d/%m/%Y")
tbl$Time <- as.character(tbl$Time)
tbl$DateTime <- ymd_hms(with(tbl, paste(Date, Time)))

## Plot the data

dev.copy(png,"plot2.png", width=480, height=480)
with(tbl, plot(DateTime, Global_active_power, type='l', ylab="Global active power (kilowatts)", lwd=1))
dev.off()