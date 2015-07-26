
data(cars)
library(manipulate)
myPlot <- function(s) {
    plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
    abline(0, s)
}

manipulate(myPlot(s), s = slider(0, 2, step = 0.1))

require(devtools)
install_github('rCharts', 'ramnathv')
require(rCharts)
dTable(airquality, sPaginationType = "full_numbers")


install_github('slidify', 'ramnathv')
install_github('slidifyLibraries', 'ramnathv') #bunch of lib files needed to run
library(slidify)
setwd('~/dev/datasciencecoursera/')
author('project_deck') #populates empty slidify doc for you
