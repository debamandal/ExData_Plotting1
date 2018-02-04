#read data from file
power_data<- read.delim("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

#get Feb 1 & 2 2007 data
power_data_Feb <-power_data[which(power_data$Date =="1/2/2007" |power_data$Date =="2/2/2007"  ),]
# Make numeric Global_active_power
power_data_Feb <- transform(power_data_Feb,Global_active_power=as.numeric(Global_active_power))
#make the plot
hist(power_data_Feb$Global_active_power, col="red", 
     xlab="Global Active Power(kilowatts)",main="Global Active Power")
#save to device
dev.copy(png, file="plot1.png",width=480,height=480)
dev.off()
