#Download and Read the file#
temp<-tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
datafile<-unzip(temp)
#Read file,file in table has 9 variables
data<-read.table(datafile,sep =";")
#Ajust time format in order to pick data based on time
time<-as.Date(data$V1,format="%d/%m/%Y")
#Add time new column to the existing data frame "data"
data$time<-time
#Subset the data based on date
data1<-subset(data,data$time>="2007-02-01"&data$time<="2007-02-02")
#Adjust x data, factor converted to numeric. Note that factor needs to be converted to character first, then converted to numeric
xdata<-as.numeric(as.character(data1$V3))
#Convert date into weekday
#Mkae the weekday data a new column in data frame data1
datetime <- paste(as.Date(data1$V1,format="%d/%m/%Y"), data1$V2)
data1$Datetime <- as.POSIXct(datetime)
#Convert submerging_1 data into numeric
png(filename = "plot3.png",width=480,height=480)
s1<-as.numeric(as.character(data1$V7))
plot(s1 ~ data1$Datetime,type="l",ylab = "Energy sub metering",xlab="")
#Convert submerging_2 data into numeric
s2<-as.numeric(as.character(data1$V8))
lines(s2 ~ data1$Datetime,type="l",col="red")
#Convert submerging_3 data into numeric
s3<-as.numeric(as.character(data1$V9))
lines(s3 ~ data1$Datetime,type="l",col="blue")
#Add legend
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty=1)
dev.off()