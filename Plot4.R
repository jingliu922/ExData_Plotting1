# read text file
mydata<-read.table("household_power_consumption.txt",header = TRUE, sep=";")   
head(mydata)
dim(mydata)
# check the attributes of each variable
sapply(mydata, "class")
# concatenate 'Date' and 'Time' fields to make a new field 'timestamp to contain both'

mydata$timestamp <- with(mydata, { timestamp <- strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S") })
mydata$Date<-as.Date(mydata$Date,"%d/%m/%Y")

sapply(mydata, "class")  
# truncate dataset to include only from "2007-02-01" to "2007-02-02"
mydata_2<-subset(mydata,mydata$Date>="2007-02-01" & mydata$Date<="2007-02-02")
dim(mydata_2) 
sapply(mydata_2, "class")  

# Convert factor to numeric
gap_f<-mydata_2$Global_active_power
gap_nbr<-as.numeric(levels(gap_f))[gap_f]


sub1_f<-mydata_2$Sub_metering_1
sub1_nbr<-as.numeric(levels(sub1_f))[sub1_f]

sub2_f<-mydata_2$Sub_metering_2
sub2_nbr<-as.numeric(levels(sub2_f))[sub2_f]

sub3_nbr<-mydata_2$Sub_metering_3

voltage_f<-mydata_2$Voltage
voltage_nbr<-as.numeric(levels(voltage_f))[voltage_f]

grp_f<-mydata_2$Global_reactive_power
grp_nbr<-as.numeric(levels(grp_f))[grp_f]

str(gap_nbr)
class(gap_nbr)
summary(gap_nbr)

str(sub1_nbr)
class(sub1_nbr)
summary(sub1_nbr)

str(sub2_nbr)
class(sub2_nbr)
summary(sub2_nbr)

str(sub3_nbr)
class(sub3_nbr)
summary(sub3_nbr)

str(voltage_nbr)
class(voltage_nbr)
summary(voltage_nbr)

str(grp_nbr)
class(grp_nbr)
summary(grp_nbr)

# Plot panel
mydata_2$sub1_nbr<-sub1_nbr
mydata_2$sub2_nbr<-sub2_nbr
mydata_2$sub3_nbr<-sub3_nbr
mydata_2$voltage_nbr<-voltage_nbr
mydata_2$grp_nbr<-grp_nbr

par(mfrow=c(2,2))
with(mydata_2,plot(timestamp,gap_nbr, type="l",xlab="",ylab="Global Active Power") )
with(mydata_2,plot(timestamp,voltage_nbr, type="l", xlab="datetime", ylab="Voltage"))

with(mydata_2,plot(timestamp,sub1_nbr, type="l",xlab="",ylab="Energy sub metering") )
lines(mydata_2$timestamp,sub2_nbr, type="l", col="red")
lines(mydata_2$timestamp,sub3_nbr, type="l", col="blue")
legend("topright",y.intersp=0.7,x.intersp=1,cex=0.7,lty = c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(mydata_2,plot(timestamp,grp_nbr, type="l",xlab="datetime",ylab="Global_reactive_power") )

dev.copy(png,'plot4.png')
dev.off()