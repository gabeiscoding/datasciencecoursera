url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(url, destfile='hid.csv',method='curl')
#code book https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
hid <- read.csv('hid.csv')
strsplit(names(hid), 'wgtp')[[123]]

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
download.file(url, destfile='FGDBP.csv', method='curl')
fgdbp <- read.csv('FGDBP.csv', stringsAsFactors = FALSE)

gdb <- as.numeric(gsub(",", "", fgdbp[5:194,5]))
mean(gdb)

countryNames <- fgdbp[5:194,4]
grep("^United", countryNames)

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = 'FGDP.csv', method='curl')
FGDP <- read.csv('FGDP.csv', stringsAsFactors = FALSE)
FGDP_clean <- FGDP[5:194,]
FGDP_clean$rank = as.numeric(FGDP_clean$Gross.domestic.product.2012)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile = 'STATS_Country.csv', method='curl')
SC <- read.csv('STATS_Country.csv')
merged <- merge(FGDP_clean, SC, by.x="X", by.y="CountryCode")
length(grep("year end: +[jJ]une", merged$Special.Notes, value=TRUE))

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

in2012 <- sampleTimes[format(sampleTimes, "%Y") == "2012"]
length(in2012)
sum(weekdays(in2012) == "Monday")

