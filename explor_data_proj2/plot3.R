#plot3 from exploratory data analysis Project 2
#Assumes follow has been downloaded and extracted to wd: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI to Baltimore City, Maryland (county code 24510)
BALT <- subset(NEI, fips=="24510")

#sum by year and type
year_by_type <- as.data.frame(xtabs(Emissions ~ year + type, data=BALT))
#Improve labels
levels(year_by_type$type) <- c("Non Road", "Non Point", "On Road",  "Point" )

# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008?
png(file = 'plot3.png', width=480, height=480)

ggplot(year_by_type, aes(year, Freq, color=type)) +
    geom_line(aes(group=type), size=2) +
    ylim(0, 2200) +
    labs( x="Year", y=expression("Total " * PM[2.5]), title = "Baltimore City Emissions by Pollutant Type") +
    scale_color_discrete(name="Type")

dev.off()
#Conclusions: Point pollution sources are higher in 2008 than 1999, othe types have decreased
