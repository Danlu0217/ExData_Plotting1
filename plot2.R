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
png(filename = "plot2.png",width=480,height=480)
#Plot non-numeric values on x-axis, pay attention that the date format needs to be right in order to have them converted to Thurs...
plot(xdata ~ data1$Datetime,type="l",xlab="",ylab="Global Active Power(kilowatts)")
dev.off()
