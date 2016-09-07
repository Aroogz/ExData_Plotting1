
#loads/install required package
if ("sqldf" %in% row.names(installed.packages()) == FALSE){install.packages("sqldf")}
library(sqldf)
#check if data is available and downloads if data not found

if(!file.exists("household_power_consumption.txt")){
  dir.create("./Exploratory_Analysis")
  dir.create("./Exploratory_Analysis/data/")
  
  setwd("./Exploratory_Analysis/data/")
  
  #download file
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file_url, destfile = "Electric power consumption.zip")
  unzip("Electric power consumption.zip", exdir = ".")
}



#read in the required dataset
file <- read.csv.sql("household_power_consumption.txt", 
                     sql = "select * from file where Date in 
                    ('1/2/2007', '2/2/2007')", eol= "\n", sep= ";")

#pastes the date and time together to give complete datetime variable
file$full_date = strptime(paste(file$Date, file$Time), "%d/%m/%Y %H:%M:%S")

##Plot

#opens png device for plotting
png(filename = "Plot3.png", width = 480, height = 480)

#Plots
plot(file$full_date, file$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub metering")
lines(file$full_date, file$Sub_metering_2, col = "red")
lines(file$full_date, file$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, cex = 0.5)


#closes device
dev.off()