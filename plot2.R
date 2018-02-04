#read data from file
power_data<- read.delim("household_power_consumption.txt", header=TRUE, sep=";")


#get Feb 1 & 2 2007 data
power_data_Feb <-power_data[which(power_data$Date =="1/2/2007" |power_data$Date =="2/2/2007"  ),]
#Concatenate the columns for Date and Time
power_data_Feb$Date <- as.Date(power_data_Feb$Date,"%d/%m/%Y")
dateTime <- paste(power_data_Feb$Date, power_data_Feb$Time)
dateTime <- setNames(dateTime, "DateTime")
power_data_Feb <- cbind(dateTime, power_data_Feb)
power_data_Feb$dateTime <- as.POSIXct(dateTime)

# Make numeric Global_active_power
power_data_Feb <- transform(power_data_Feb,Global_active_power=as.numeric(Global_active_power))
#Create a plot 
plot(power_data_Feb$Global_active_power~power_data_Feb$dateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
#save to device
dev.copy(png, file="plot2.png",width=480,height=480)
dev.off()



