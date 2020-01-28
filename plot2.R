# reading data
library(data.table)
library(dplyr)
library(chron)
data <- fread("household_power_consumption.txt")
finalData <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
finalData <- mutate(finalData,Date=as.Date(Date, format = "%d/%m/%Y"))
finalData <- mutate(finalData,Time=chron(times=finalData$Time))
vars <- names(select(finalData,Global_active_power:Sub_metering_2))
finalData[vars] <- sapply(finalData[vars],as.numeric)
finalData <- mutate(finalData,dateTime=paste(finalData$Date,finalData$Time))
library(lubridate)
finalData <- mutate(finalData,dateTime=ymd_hms(finalData$dateTime))

# creating plot2
plot(finalData$dateTime,finalData$Global_active_power, 
     type="l", xlab = "",ylab="Global Active Power (kilowatts)")

# creating PNG
dev.copy(png, file = "plot2.png",width=480, height=480)
dev.off()