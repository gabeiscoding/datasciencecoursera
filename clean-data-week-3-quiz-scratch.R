#scratch space for work on week 3 quiz for Getting and Cleaning data
library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="hid.csv", method="curl")

hid <- read.csv('hid.csv')
#ACR == 3 is lot sizes of >=10 acres
#AGS == 6 is .$10000+ in agricultural sales
agricultureLogical = hid$ACR == 3 & hid$AGS == 6

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg', destfile = 'jeff.jpg', method="curl")
library(jpeg)
jeff <- readJPEG('jeff.jpg', native=TRUE)
quantile(jeff, c(0.3, 0.8))

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', destfile = 'FGDP.csv', method='curl')
FGDP <- read.csv('FGDP.csv', stringsAsFactors = FALSE)
FGDP_clean <- FGDP[5:194,]
FGDP_clean$rank = as.numeric(FGDP_clean$Gross.domestic.product.2012)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv', destfile = 'STATS_Country.csv', method='curl')
SC <- read.csv('STATS_Country.csv')
merged <- merge(FGDP_clean, SC, by.x="X", by.y="CountryCode")
sorted <- merged %>% mutate(gdb=as.numeric(gsub(",","", X.3))) %>% arrange(gdb) %>% rename(country=X.2) %>% select(gdb, country, Income.Group, rank)
print(nrow(sorted))
print(sorted[13,2]) #Q3

mean(subset(sorted, Income.Group == 'High income: OECD')$rank)
mean(subset(sorted, Income.Group == 'High income: nonOECD')$rank)

sorted %>% filter(Income.Group %in% c('High income: OECD', 'High income: nonOECD'))  %>% group_by(Income.Group) %>% summarise(avg_rank=mean(rank))
#Income.Group avg_rank
#1 High income: nonOECD 91.91304
#2    High income: OECD 32.96667

library(Hmisc)
merged <- merge(FGDP_clean, SC, by.x="X", by.y="CountryCode", all.x=TRUE)
sorted <- merged %>% mutate(gdb=as.numeric(gsub(",","", X.3))) %>% arrange(gdb) %>% rename(country=X.2) %>% select(gdb, country, Income.Group, rank)
sorted$gdb.quantiles <- cut2(sorted$gdb, g=5)
table(sorted$gdb.quantiles)

#nrow(filter(sorted, Income.Group == "Lower middle income" & gdb.quantiles == "[262832,16244600]"))
#filter(sorted, Income.Group == "Lower middle income" & gdb.quantiles == "[262832,16244600]")

table(sorted$Income.Group, sorted$gdb.quantiles)
