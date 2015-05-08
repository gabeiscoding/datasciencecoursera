#Exploratory Data Analysis Project1
library(dplyr)
library(data.table)

initial <- read.table('household_power_consumption.txt', sep=";", stringsAsFactors = FALSE, nrows = 100, header=TRUE)
classes <- sapply(initial, class)
df <- data.table(read.table('household_power_consumption.txt', sep=";", stringsAsFactors = FALSE, header=TRUE, colClasses=classes, na.strings="?"))

#Subset to 2007-02-01 and 2007-02-02.
df <- subset(df, Date == '1/2/2007' | Date == '2/2/2007')
df <- cbind(df, datetime=do.call(function(Date, Time,...) strptime(paste(Date, Time), format="%d/%m/%Y %T"), df))

plot(Global_active_power ~ datetime, data=df)