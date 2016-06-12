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
data0702<-cbind(datetime,select(df,-(Date:Time)))

#plot1
png(filename='plot1.png', width=480, height=480, units='px')
hist(data0702$Global_active_power,main='Global Active Power',
     xlab='Global Active Power (kilowatts)',col='red')
dev.off()


#plot2
png(filename='plot2.png', width=480, height=480, units='px')
with(data0702, plot(datetime,Global_active_power,xlab='',
                    ylab='Global Active Power (kilowatts)',
                    type='l'))
dev.off()

#plot3
png(filename='plot3.png', width=480, height=480, units='px')
with(data0702, plot(datetime,y=Sub_metering_1,xlab='',
                    ylab='Energy sub metering',
                    type='l',col='black'))
with(data0702, lines(datetime,y=Sub_metering_2,col='red'))
with(data0702, lines(datetime,y=Sub_metering_3,col='blue'))
legend('topright', lty=c(1,1,1),
       col = c('black','red','blue'),
       legend = c('Sub_metering_1','Sub_metering_2',
                  'Sub_metering_3'))
dev.off()


#plot4
png(filename='plot4.png', width=480, height=480, units='px')
par(mfrow=c(2,2))
with(data0702, {
        plot(datetime, Global_active_power,xlab='',
             ylab='Global Active Power',type='l')
        
        plot(datetime, Voltage,type='l')
        
        
        plot(datetime,y=Sub_metering_1,xlab='',
             ylab='Energy sub metering',
             type='l',col='black')
        lines(datetime,y=Sub_metering_2,col='red')
        lines(datetime,y=Sub_metering_3,col='blue')
        
        legend('topright', lty=c(1,1,1),
               col = c('black','red','blue'),
               legend = c('Sub_metering_1','Sub_metering_2',
                          'Sub_metering_3'))
        
        plot(datetime, Global_reactive_power,type='l')
})
dev.off()