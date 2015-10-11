library(base)
library(lubridate)
Sys.setlocale("LC_ALL","English")

#Getting data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temp)
table <- read.table(unz(temp, "household_power_consumption.txt"),
                    header = T, 
                    sep = ";", 
                    stringsAsFactors = F,
                    na.strings="?")
unlink(temp)
rm(temp)

#Subsetting & getting data prepared for plotting
table$Date <- strptime(table$Date, 
                       format = "%d/%m/%Y")

target_df <- subset(table, Date >= "2007-02-01" & Date <= "2007-02-02")

time_temp_vector <- paste(target_df$Date, target_df$Time)   
target_df$Time <- strptime(time_temp_vector,
                           format = "%Y-%m-%d %H:%M:%S")
rm(time_temp_vector)

#Plotting
png(file="plot1.png",width=480,height=480)
par(cex = 0.7)
hist(target_df$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()