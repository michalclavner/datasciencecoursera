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


#creating plot 1:
hist(DTsubset$Global_active_power,
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     main= "Global Active Power", col="red")
# setting y and x axis ticks:
y_ticks=seq(0, 1200, 200)
x_ticks=seq(0, 6, 2)
axis(1, at=x_ticks)
axis(2, at=y_ticks)

#saving the figure to a png file
dev.copy(png,file="plot1.png")
dev.off()




