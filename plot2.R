library(dplyr)

labels <-read.table("household_power_consumption.txt", sep = ";", nrows=1, colClasses = 
                      c("character","character","character","character","character","character","character","character","character"),
                    na.strings = "?")

hpc <-read.table("household_power_consumption.txt", col.names = labels, sep = ";", skip = 1, colClasses = 
                   c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                 na.strings = "?")

hpc <- mutate((hpc),  Date.better = as.POSIXct(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S"))

hpc.f <- filter(filter(hpc, Date.better >= "2007-02-01"), Date.better < "2007-02-03")


png("plot2.png")
plot(hpc.f$Global_active_power ~ hpc.f$Date.better, type= "n",
     ylab = "Global Active Power (kilowatts)", xlab = "")
lines(hpc.f$Global_active_power ~ hpc.f$Date.better)
dev.off()