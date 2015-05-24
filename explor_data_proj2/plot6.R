#plot6 from exploratory data analysis Project 2
#Assumes follow has been downloaded and extracted to wd: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

library(ggplot2)
library(RColorBrewer)
library(gridExtra)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI to Baltimore (county code 24510) and LA  (county code 06037)
BALT_or_LA <- subset(NEI, fips=="24510" | fips =="06037")

#SCC codes for Vehicles
SCC_VEH <- SCC[grep("Vehicles", SCC$SCC.Level.Three),]

#NEI ratings for these SCC codes
B_OR_LA_VEH <- subset(BALT_or_LA, SCC %in% SCC_VEH$SCC)

B_OR_LA_VEH$year <- factor(B_OR_LA_VEH$year)

cities <- factor(B_OR_LA_VEH$fips)
levels(cities) <- list("Baltimore"="24510", "LA"="06037")
B_OR_LA_VEH$city <- cities
by_city <- split(B_OR_LA_VEH, f = cities)

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California. Which city has
# seen greater changes over time in motor vehicle emissions?
png(file = 'plot6.png', width=480, height=480)

#Build a plot for each cit
plots <- lapply(names(by_city), function(city) {
    city_df <- by_city[[city]]
    
    #Tabulate totals by year
    total_by_year <- xtabs(Emissions ~ year, data=city_df)
    
    #Construct colors representative of these totals
    pal = colorRamp(brewer.pal(3,"YlOrRd"))
    colors_by_year = rgb(pal((total_by_year / (max(total_by_year)))), max=255)
 
    #box plots, of log scale emmissions
    #Color is representative of sum of total emition by year.
    ggplot(city_df, aes(year, log(Emissions))) +
        geom_boxplot(size=1, aes(fill=year)) +
        labs( x="Year", y=expression("Log of " * PM[2.5]), title = paste0("Emissions of Vehicles in ", city))  +
        scale_fill_manual(name="Year Totals", values=colors_by_year, labels = as.character(round(total_by_year)))
})

do.call(grid.arrange, plots)

dev.off()
#Conclusions: LA has not had sustained drop in emmissions, with 2008 looking roughly like 1999, compared to Baltimore
