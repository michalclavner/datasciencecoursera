rm(list=ls())

#GOAL: 
#       Our overall goal here is simply to examine how household energy usage 
#       varies over a 2-day period in February, 2007

#read in the data
datadir <-'./Data/'
filename <- paste0(datadir,'household_power_consumption.txt')
DT<- read.table(filename,header=TRUE, sep=";", na="?", stringsAsFactors=FALSE)

#convert the Date and Time variables to Date/Time classes 
DT$Time <- strptime(paste(DT$Date, DT$Time), "%d/%m/%Y %H:%M:%S")
DT$Date <- as.Date(DT$Date, "%d/%m/%Y")

#subsetting the data to include data from the dates 2007-02-01 and 2007-02-02
Daterange <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
DTsubset <- DT[DT$Date %in% Daterange ,]


#creating plot 4:

png("plot4.png", width=600, height=600) # need to specify the size now, because otherwise, the legend showed up cropped
par(mfrow=c(2,2))

with(DTsubset,{
#subplot 1:
  plot(Time,Global_active_power,type="l",xlab="", ylab= "Global Active Power (kilowatts)")
#subplot 2:
  plot(Time,Voltage,type="l",xlab="datetime", ylab= "Voltage")
#subplot 3:
  # initializing the plot:
  plot(Time,Sub_metering_1,type='n',xlab="", ylab= "Energy sub metering")
  #adding the different variables
  lines(Time,Sub_metering_1, type="l", col="black",
        xlab="", ylab="Energy sub metering")
  lines(Time,Sub_metering_2, type="l", col="red",
        xlab="", ylab="Energy sub metering")
  lines(Time,Sub_metering_3, type="l", col="blue",
        xlab="", ylab="Energy sub metering")
  legend("topright",col =c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1,bty = "n")
#subplot 4:
  plot(Time,Global_reactive_power,type="l",xlab="datetime")
  
})

dev.off()














# getting the weekdays for the day
DAYoftheWeek <- weekdays(DTsubset$Date)
# initializing the plot:
plot(DTsubset$Time,DTsubset$Sub_metering_1,type='n',xlab="", ylab= "Energy sub metering")
#adding the different variables
lines(DTsubset$Time,DTsubset$Sub_metering_1, type="l", col="black",
      xlab="", ylab="Energy sub metering")
lines(DTsubset$Time,DTsubset$Sub_metering_2, type="l", col="red",
      xlab="", ylab="Energy sub metering")
lines(DTsubset$Time,DTsubset$Sub_metering_3, type="l", col="blue",
      xlab="", ylab="Energy sub metering")
#adding legends:
legend("topright",col =c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)
#saving the plot:
dev.copy(png,file="plot3.png")
dev.off()











