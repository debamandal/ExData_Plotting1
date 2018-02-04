#Read Data
power_data<- read.delim("household_power_consumption.txt", header=TRUE, sep=";")

#Get feb 1,2 2017 data
power_data_Feb <-power_data[which(power_data$Date =="1/2/2007" |power_data$Date =="2/2/2007"  ),]

#Concatenate the columns for Date and Time
power_data_Feb$Date <- as.Date(power_data_Feb$Date,"%d/%m/%Y")
dateTime <- paste(power_data_Feb$Date, power_data_Feb$Time)
dateTime <- setNames(dateTime, "DateTime")
power_data_Feb <- cbind(dateTime, power_data_Feb)
power_data_Feb$dateTime <- as.POSIXct(dateTime)

#Convert to numeric sub meter data
power_data_Feb <- transform(power_data_Feb,Sub_metering_1=as.numeric(Sub_metering_1))
power_data_Feb <- transform(power_data_Feb,Sub_metering_2=as.numeric(Sub_metering_2))
power_data_Feb <- transform(power_data_Feb,Sub_metering_3=as.numeric(Sub_metering_3))
power_data_Feb <- transform(power_data_Feb,Global_active_power=as.numeric(Global_active_power))
power_data_Feb <- transform(power_data_Feb,Global_reactive_power=as.numeric(Global_reactive_power))
power_data_Feb <- transform(power_data_Feb,Voltage=as.numeric(Voltage))

#make the plot
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
with(power_data_Feb, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

#save to device
dev.copy(png, file="plot4.png",width=480,height=480)
dev.off()