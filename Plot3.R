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
sub1_f<-mydata_2$Sub_metering_1
sub1_nbr<-as.numeric(levels(sub1_f))[sub1_f]

sub2_f<-mydata_2$Sub_metering_2
sub2_nbr<-as.numeric(levels(sub2_f))[sub2_f]

sub3_nbr<-mydata_2$Sub_metering_3

str(sub1_nbr)
class(sub1_nbr)
summary(sub1_nbr)

str(sub2_nbr)
class(sub2_nbr)
summary(sub2_nbr)

str(sub3_nbr)
class(sub3_nbr)
summary(sub3_nbr)


# Plot 3
mydata_2$sub1_nbr<-sub1_nbr
mydata_2$sub2_nbr<-sub2_nbr
mydata_2$sub3_nbr<-sub3_nbr

with(mydata_2,plot(timestamp,sub1_nbr, type="l",xlab="",ylab="Energy sub metering") )
lines(mydata_2$timestamp,sub2_nbr, type="l", col="red")
lines(mydata_2$timestamp,sub3_nbr, type="l", col="blue")
legend("topright",y.intersp=0.7,x.intersp=1,inset=2,lty = c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.copy(png,'plot3.png')
dev.off()