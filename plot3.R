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

#Make the plot
with(power_data_Feb, {
     plot(Sub_metering_1~dateTime , type="l",ylab="Global Active power(kilowatts)",xlab="")
     lines(Sub_metering_2~dateTime, col="red")
     lines(Sub_metering_3~dateTime, col="blue")
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#save to device
dev.copy(png, file="plot3.png",width=480,height=480)
dev.off()