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
png(filename = "plot1.png",width=480,height=480)
#Plot histogram using base plotting sys
hist(xdata,col="red",xlab = "Global Active Power (kilowatts)",main = "Global active power")
#Turn off device
dev.off()