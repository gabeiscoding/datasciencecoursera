Training For Jim Bridger Trail Run
========================================================
author: Gabe Rudy
date: 2015-07-26

Project Overview
========================================================
![map](jbtr_map.jpg)
***
To get in shape for a 10 mile mountain trail run called the Jim Bridger Trail Run on June 27, 2015, I started counting calaries using MyFitnessPal to drop to a target weight of 160.

With my iPhone (and Apple Watch starting early May) I had a trove of data colleted in HealthKit, and was able to export it using QS Access showing my training up to the race and after.


Measurements
========================================================
![map](jbtr_stats.jpg)
***
I reached my goal, finished the race in **1:52**, and placed 42 (out of ~120 men)

References:
 * [QS Access App](https://itunes.apple.com/gb/app/qs-access/id920297614?mt=8)
 * [MyFitnessPal App](https://www.myfitnesspal.com/)
 * [Jim Bridger Trail Run](http://www.bridgerskifoundation.org/jbtr)


Shiny App Construction
========================================================

The Shiny App Used the following rPlots libraries:

* xCharts
* Morris
* Richshaw

The left combo box used input resulted in a different component being rendered in a ```renderUI``` function. Allowing each plot to replace the main panel.

```
 output$plot <- renderUI({
        if(input$chart == "lbs"){
            showOutput("plot_lbs", "xcharts")
        }else if(input$chart == "cal"){
            showOutput("plot_cal", "morris")
        ...
```

Predictive Model
========================================================

A simple predictive model was computed based on my training data to predict weight after ```N``` days. Here is the model computed for ```100``` input days:

```r
by.day <- readRDS('jbtr/health_data_by_day.rds')

#Linear Model:
train <- by.day[1:which(by.day$Day == "2015-06-27")[1],]
train$n <- (1:nrow(train))
model <- lm(Weight.lb~n, data=train)
predict(model, newdata = data.frame(n = 100), interval="predict")
```

```
       fit      lwr     upr
1 175.9549 172.1478 179.762
```
