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
png(filename = "Plot2.png", width = 480, height = 480)

#plot
plot(file$full_date, file$Global_active_power, 
     type = "l", xlab = "", ylab = "Global Active Power (Kilowatts)")

#closes device
dev.off()
