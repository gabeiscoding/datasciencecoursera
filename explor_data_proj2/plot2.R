#plot2 from exploratory data analysis Project 2
#Assumes follow has been downloaded and extracted to wd: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI to Baltimore City, Maryland (county code 24510)
BALT <- subset(NEI, fips=="24510")
#sum by year
by.year <- xtabs(Emissions ~ year, data=BALT)

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
png(file = 'plot2.png', width=480, height=480)
barplot(by.year, ylab="Total PM2.5", col="red", main = "Baltimore City PM2.5 Levels by Year")
dev.off()
#Conclusion: PM2.5 levels have decreased overall between 1999 and 2008, but 2005 was higher
