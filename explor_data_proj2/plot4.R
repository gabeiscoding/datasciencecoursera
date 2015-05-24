#plot4 from exploratory data analysis Project 2
#Assumes follow has been downloaded and extracted to wd: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(ggplot2)
library(RColorBrewer)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#SCC codes for Coal fuel Combustion sources
SCC_COAL <- SCC[grep("Coal", SCC$SCC.Level.Three),]
SCC_COAL_COMB <- SCC_COAL[grep("Combustion", SCC_COAL$SCC.Level.One),]

#NEI ratings for these SCC codes
NEI_COAL <- subset(NEI, SCC %in% SCC_COAL_COMB$SCC)

NEI_COAL$year <- factor(NEI_COAL$year)

#Tabulate totals by year
total_by_year <- xtabs(Emissions ~ year, data=NEI_COAL)

#Construct colors representative of these totals
pal = colorRamp(brewer.pal(3,"YlOrRd"))
colors_by_year = rgb(pal((total_by_year / (max(total_by_year)))), max=255)

# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?
png(file = 'plot4.png', width=480, height=480)

#Violin plots, by nonpoint and point of log scale emissions
#Color is representative of sum of total emition by year.
ggplot(NEI_COAL, aes(year, log(Emissions))) +
    geom_violin(size=1, aes(fill=year)) +
    facet_grid(type ~ . ) +
    labs( x="Year", y=expression("Log of " * PM[2.5]), title = "Emissions of Coal Combustion Sources") +
    scale_fill_manual(name="Year Totals", values=colors_by_year, labels = as.character(round(total_by_year)))

dev.off()
#Conclusions: 2008 showed a significant drop in coal combustion pollution
