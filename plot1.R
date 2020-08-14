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

#plot1
png(filename = "plot1.png")
with(data,hist(data$Global_active_power,col = "red",main = "Global Active Power",
               xlab = "Global Active Power (kilowatts)"))
dev.off()