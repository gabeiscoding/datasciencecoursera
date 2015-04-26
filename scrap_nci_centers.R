library(XML)

con = url("http://www.cancer.gov/researchandfunding/extramural/cancercenters/find-a-cancer-center")
h <- readLines(con)
close(con)

html <- htmlTreeParse(h, useInternalNodes = T)
centers <- xpathSApply(html,"//div[@class='institution-content ccc']",xmlValue)
centers <- sapply(centers, function(x) { y <- strsplit(x, '\n\t+', perl=T)[[1]]; y[nchar[y] > 0]})
centers <- lapply(centers, function(y) y[nchar(y) > 0])
centers
