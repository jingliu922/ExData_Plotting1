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

str(gap_nbr)
class(gap_nbr)
summary(gap_nbr)

# Plot 2
mydata_2$gap_nbr<-gap_nbr
with(mydata_2,plot(timestamp,gap_nbr, type="l",xlab="",ylab="Global Active Power (kilowatts)") )

dev.copy(png,'plot2.png')
dev.off()