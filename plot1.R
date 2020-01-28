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

# creating plot1
hist(finalData$Global_active_power, 
     col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")

# creating PNG
dev.copy(png, file = "plot1.png",width=480, height=480)
dev.off()
