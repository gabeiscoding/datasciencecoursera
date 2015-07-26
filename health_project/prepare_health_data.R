library(dplyr)
library(lubridate)
library(rCharts)
library(reshape2)

setwd('~/dev/datasciencecoursera/health_project/')
h <-read.csv('Health Data.csv', stringsAsFactors = FALSE)

#Start and Finish have values like 29-Sep-2014 21:00
h2 <- h %>% mutate(
        Start = parse_date_time(Start, "%d-%m-%Y %H:%M"),
        Finish = parse_date_time(Finish, "%d-%m-%Y %H:%M"),
        Day = format(Start, "%Y-%m-%d"))

names(h2) <- gsub('\\.+$','', gsub('..', '.', names(h2), fixed=TRUE ))

#Fill in some NAs as appropriate
h2$Weight.lb[h2$Weight.lb == 0] <- NA
h2$Heart.Rate.count.min[h2$Heart.Rate.count.min < 50] <- NA #0 and a few < 50 measurements that are clearly errors

by.day <- h2 %>%
     group_by(Day) %>%
     summarise(
            Weight.lb = max(Weight.lb, na.rm=TRUE),
            Active.Calories.kcal = sum(Active.Calories.kcal),
            Distance.mi = sum(Distance.mi),
            Steps.count = sum(Steps.count),
            Heart.Rate.min.bpm = min(Heart.Rate.count.min, na.rm=TRUE),
            Heart.Rate.max.bpm = max(Heart.Rate.count.min, na.rm=TRUE),
            Heart.Rate.avg.bpm = mean(Heart.Rate.count.min, na.rm=TRUE),
            Dietary.Calories.kcal = sum(Dietary.Calories.cal) / 1000,
            Body.Fat.Percentage = max(Body.Fat.Percentage),
            Carbohydrates.g = sum(Carbohydrates.mg) / 1000,
            Protein.g = sum(Protein.g),
            Total.Fat.g = sum(Total.Fat.g),
            Polyunsaturated.Fat.g = sum(Polyunsaturated.Fat.g),
            Saturated.Fat.g = sum(Saturated.Fat.g),
            Sugar.g = sum(Sugar.g))

by.day$Active.Calories.kcal[by.day$Active.Calories.kcal == 0] <- NA
by.day$Dietary.Calories.kcal[by.day$Dietary.Calories.kcal < 600] <- NA
by.day$Body.Fat.Percentage[by.day$Body.Fat.Percentage == 0] <- NA

#Start at first day with weight
first = which(by.day$Weight.lb > 0)[1]
by.day <- by.day[first:(nrow(by.day)-1),] #strip last day as well

#Compute percetage of calories composed of Carbohydrates, Fat, Protein
#Fat: 1 gram = 9 calories 
#Protein: 1 gram = 4 calories 
#Carbohydrates: 1 gram = 4 calories
by.day <- by.day %>% mutate( Total.Computed.kcal = (Carbohydrates.g*4 + Protein.g*4 + Total.Fat.g*9),
                         Carb.Percent = ((Carbohydrates.g*4)/Total.Computed.kcal) * 100,
                         Protein.Percent = ((Protein.g*4)/Total.Computed.kcal) * 100,
                         Fat.Percent = ((Total.Fat.g*9)/Total.Computed.kcal) * 100,
                         Other.Fat.g = Total.Fat.g - (Polyunsaturated.Fat.g + Saturated.Fat.g) )

saveRDS(by.day, 'jbtr/health_data_by_day.rds')

m1 <- mPlot(x = "Day", y = c("Weight.lb"), type = "Line", data = by.day[!is.na(by.day$Weight.lb),])
m1$set(pointSize = 0, lineWidth = 2, ymin='auto', events=c("2014-11-16", "2015-06-27", "2015-07-24"), hideHover=FALSE, postUnits="lbs")
m1$save("graph1.html")

#Weight
m2 <- xPlot(Weight.lb ~ Day, type = "line-dotted", data = by.day[!is.na(by.day$Weight.lb),], xScale="time")
m2$save("graph2.html")

m3 <- xPlot(Dietary.Calories.kcal ~ Day, type = "line-dotted", data = by.day[!is.na(by.day$Dietary.Calories.kcal),], xScale="time")
m3$save("graph3.html")

#Dietary and Active Calories (MyFitnessPal and Apple Watch/Phone)
m4 <- mPlot(x = "Day", y = c("Dietary.Calories.kcal", "Active.Calories.kcal"), type = "Line", data = by.day[!is.na(by.day$Dietary.Calories.kcal),])
m4$set(pointSize = 0, lineWidth = 2, events=c("2015-06-27", "2015-07-24"), hideHover=FALSE, postUnits=" kcals")
m4$save("graph4.html")

#Heart Rate (min, avg, max) from Apple Watch
m5 <- mPlot(x = "Day", y = c("Heart.Rate.min.bpm", "Heart.Rate.avg.bpm", "Heart.Rate.max.bpm"), type = "Line", data = by.day[!is.na(by.day$Heart.Rate.avg.bpm),])
m5$set(pointSize = 0, lineWidth = 2, events=c("2015-06-27", "2015-07-24"), hideHover=FALSE, postUnits=" bpm")
m5$save("graph5.html")

#Miles moved each day (phone and Apple Watch)
m6 <- mPlot(x = "Day", y = c("Distance.mi"), type = "Line", data = by.day)
m6$set(pointSize = 3, lineWidth=0, events=c("2015-06-27", "2015-07-24"), hideHover=FALSE, postUnits=" mi")
m6$save("graph6.html")

#Percentage of each days calories by Carbs, Protein, Fat
percents <- melt(subset(by.day, Total.Computed.kcal > 0), id="Day", measure.vars=c("Protein.Percent", "Fat.Percent", "Carb.Percent"))
percents <- percents %>% mutate(Day = as.integer(as.numeric(as.POSIXct(Day))))
m7 <- Rickshaw$new()
m7$layer(x = "Day", y = "value", group="variable", data=percents, type = "area", width = 560)
# add a helpful slider this easily; other features TRUE as a default
m7$set(slider = TRUE, scheme="munin")
m7$save("graph7.html")

#Grams eaten each day of Carbs, Protein, Sugar, and different types of Fat
grams <- melt(subset(by.day, Total.Computed.kcal > 0), id="Day", measure.vars=c("Saturated.Fat.g", "Polyunsaturated.Fat.g", "Other.Fat.g", "Sugar.g", "Protein.g", "Carbohydrates.g"))
grams <- grams %>% mutate(Day = as.integer(as.numeric(as.POSIXct(Day))))
m8 <- Rickshaw$new()
m8$layer(x = "Day", y = "value", group="variable", data=grams, type = "area", width = 560)
# add a helpful slider this easily; other features TRUE as a default
m8$set(slider = TRUE, scheme="munin")
m8$save("graph8.html")

train <- by.day[1:which(by.day$Day == "2015-06-27")[1],]
train$n <- (1:nrow(train))
m <- lm(Weight.lb~n, data=train)
#Example prediction '10' days out
predict(m, newdata = data.frame(n = 10), interval="predict")
