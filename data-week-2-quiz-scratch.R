
#counting character length in lines
lines <- readLines(url("http://biostat.jhsph.edu/~jleek/contact.html "))

sapply(c(10,20,30,100), function(l) nchar(lines[[l]]))


#using sqldf
install.packages("sqldf")

library(sqldf)
setwd("~/dev/datasciencecoursera/")

acs <- read.csv("getdata-data-ss06pid.csv")
r <- sqldf("select pwgtp1 from acs where AGEP < 50")

r <- unique(acs$AGEP)
r2 <- sqldf("select distinct AGEP from acs")
r3 <- r2$AGEP


#last question
install.packages("foreign")
library(foreign)

#fwf takes a width
df <- read.fwf("getdata-wksst8110.for", skip=4, widths = c(15, 4, -1, 3,-5, 4,-1,3,-5,4,-1,3,-5,4,-1,3))
View(df)
sum(df$V4)
