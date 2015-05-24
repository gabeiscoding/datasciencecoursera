#plot5 from exploratory data analysis Project 2
#Assumes follow has been downloaded and extracted to wd: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(ggplot2)
library(RColorBrewer)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI to Baltimore City, Maryland (county code 24510)
BALT <- subset(NEI, fips=="24510")

#SCC codes for Vehicles
SCC_VEH <- SCC[grep("Vehicles", SCC$SCC.Level.Three),]

#NEI ratings for these SCC codes in Baltimore
BALT_VEH <- subset(BALT, SCC %in% SCC_VEH$SCC)

BALT_VEH$year <- factor(BALT_VEH$year)

#Tabulate totals by year
total_by_year <- xtabs(Emissions ~ year, data=BALT_VEH)

#Construct colors representative of these totals
pal = colorRamp(brewer.pal(3,"YlOrRd"))
colors_by_year = rgb(pal((total_by_year / (max(total_by_year)))), max=255)

# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?
png(file = 'plot5.png', width=480, height=480)

#box plots, of log scale emmissions
#Color is representative of sum of total emition by year.
ggplot(BALT_VEH, aes(year, log(Emissions))) +
    geom_boxplot(size=1, aes(fill=year)) +
    labs( x="Year", y=expression("Log of " * PM[2.5]), title = "Emissions of Vehicles in Baltimore") +
    scale_fill_manual(name="Year Totals", values=colors_by_year, labels = as.character(round(total_by_year)))

dev.off()
#Conclusions: Total emissions have dropped and are lowest in 2008, although the median went up slightly

