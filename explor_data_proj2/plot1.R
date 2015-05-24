#plot1 from exploratory data analysis Project 2
#Assumes follow has been downloaded and extracted to wd: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#sum by year
by.year <- xtabs(Emissions ~ year, data=NEI)

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
png(file = 'plot1.png', width=480, height=480)
barplot(by.year, ylab="Total PM2.5", col="red", main = "United States PM2.5 Levels by Year")
dev.off()
#Conclusion: PM2.5 levels have decreased year over year
