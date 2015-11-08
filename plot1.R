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
png("plot1.png")
hist(hpc.f$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
