library(dplyr)

#Enter all the data into the dataframe hpc
labels <-read.table("household_power_consumption.txt", sep = ";", nrows=1, colClasses =
                  c("character","character","character","character","character","character","character","character","character"),
                  na.strings = "?")

hpc <-read.table("household_power_consumption.txt", col.names = labels, sep = ";", skip = 1, colClasses =
                  c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                  na.strings = "?")

#remove extraneous entries from hpc, this is our cleaned data, stored in hpc.f
hpc <- mutate((hpc),  Date.better = as.POSIXct(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S"))

hpc.f <- filter(filter(hpc, Date.better >= "2007-02-01"), Date.better < "2007-02-03")

#output a plot file
png("plot3.png")
#pallette
plot(hpc.f$Sub_metering_1 ~ hpc.f$Date.better, type= "n",
     ylab = "Energy sub metering", xlab = "")

#data lines
lines(hpc.f$Sub_metering_1 ~ hpc.f$Date.better, col = "black")
lines(hpc.f$Sub_metering_2 ~ hpc.f$Date.better, col = "red")
lines(hpc.f$Sub_metering_3 ~ hpc.f$Date.better, col = "blue")

#legend
legend("topright", legend = c("Sub Metering 1", "Sub Metering 2","Sub Metering 3"), col = c("black","red","blue"), pch = "_")
dev.off()
