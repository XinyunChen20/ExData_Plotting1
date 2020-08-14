# download file if it does not exist
file <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("electric_power_data.zip")){
    download.file(url,destfile = "electric_power_data.zip",method = "curl")
}
if (!file.exists(file)){
    unzip("electric_power_data.zip")
}
#read in the data set and choose the date of interest
data <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
#convert variables to appropriate classes
data$Time <- paste(data$Date,data$Time)
data$Time<-strptime(data$Time,"%Y-%m-%d %H:%M:%S")
names(data)[2] <- "DateTime"
data <- data[,2:9]
data[,2:8]<-lapply(data[,2:8],as.numeric)

#plot3
png(filename = "plot3.png")
with(data,{
    plot(DateTime,Sub_metering_1,type = "l",ylab = "Energy sub metering",xlab="")
    lines(DateTime,Sub_metering_2,col="red")
    lines(DateTime,Sub_metering_3,col="blue")
})
legend("topright",lwd=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()