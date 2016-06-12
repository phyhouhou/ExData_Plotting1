#Read data
#setwd("~/couresera/ProgrammingAssignment5")
#import and then subset the entire data file
library(data.table)
power_consumption<-fread('household_power_consumption.txt',
                         header=T, sep=';', na.strings='?')
#str(power_consumption)

#subset the date period between 2007-2-1 and 2007-2-2
df<-data.frame(subset(power_consumption, 
                      Date %in% c("1/2/2007","2/2/2007")))


#convert the Date and Time variables
datetime<-strptime(paste(as.Date(df$Date,format='%d/%m/%Y'),df$Time),
                   format="%Y-%m-%d %H:%M:%S")
library(dplyr)
data0702<-cbind(datetime,select(df,-(Date:Time)))

#plot1
png(filename='plot1.png', width=480, height=480, units='px')
hist(data0702$Global_active_power,main='Global Active Power',
     xlab='Global Active Power (kilowatts)',col='red')
dev.off()


