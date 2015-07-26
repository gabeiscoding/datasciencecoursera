require(rCharts)
library(datasets)
library(reshape2)
library(dplyr)

#See "prepare_health_data.R" for preprocessing
by.day <- readRDS('health_data_by_day.rds')

#Linear Model:
train <- by.day[1:which(by.day$Day == "2015-06-27")[1],]
train$n <- (1:nrow(train))
model <- lm(Weight.lb~n, data=train)


shinyServer(function(input, output) {
    #Pred Models
    pred <- reactive({ predict(model, newdata = data.frame(n = input$days), interval="predict") })
    delta <- reactive({ input$weight - 196 })
    output$pred_weight <- renderText({ pred()[1] + delta() })
    output$pred_l <- renderText({ pred()[2] + delta() })
    output$pred_h <- renderText({ pred()[3] + delta() })
    
    #Caption
    output$caption <- renderText({
        switch(input$chart,
               "lbs" = "Weight",
               "cal" = "Dietary and Active Calories",
               "bpm" = "Min, Average and Max BPM (Measured by Apple Watch)",
               "mi" = "Measured Distance in Miles (iPhone and Apple Watch)",
               "percents" = "Proportion of Calories by Macro Nutrient Groups",
               "grams" = "Food Consumption by Types"
               )
    })
    
    #Weight chart
    output$plot_lbs <- renderChart({
        p <- xPlot(Weight.lb ~ Day, type = "line-dotted", data = by.day[!is.na(by.day$Weight.lb),], xScale="time")
        p$addParams(dom = 'plot_lbs')
        return(p)
    })
    
    #KCal Chart
    output$plot_cal <- renderChart({
        p <- mPlot(x = "Day", y = c("Dietary.Calories.kcal", "Active.Calories.kcal"), type = "Line", data = by.day[!is.na(by.day$Dietary.Calories.kcal),])
        p$set(pointSize = 0, lineWidth = 2, events=c("2015-06-27", "2015-07-24"), hideHover=FALSE, postUnits=" kcals")
        p$addParams(dom = 'plot_cal')
        return(p)
    })
    
    #Heart Rate (min, avg, max) from Apple Watch
    output$plot_bpm <- renderChart({
        p <- mPlot(x = "Day", y = c("Heart.Rate.min.bpm", "Heart.Rate.avg.bpm", "Heart.Rate.max.bpm"), type = "Line", data = by.day[!is.na(by.day$Heart.Rate.avg.bpm),])
        p$set(pointSize = 0, lineWidth = 2, events=c("2015-06-27", "2015-07-24"), hideHover=FALSE, postUnits=" bpm")
        p$addParams(dom = 'plot_bpm')
        return(p)
    })
    
    #Miles moved each day (phone and Apple Watch)
    output$plot_mi <- renderChart({
        p <- mPlot(x = "Day", y = c("Distance.mi"), type = "Line", data = by.day)
        p$set(pointSize = 3, lineWidth=0, events=c("2015-06-27", "2015-07-24"), hideHover=FALSE, postUnits=" mi")
        p$addParams(dom = 'plot_mi')
        return(p)
    })
    
    #Percentage of each days calories by Carbs, Protein, Fat
    output$plot_perc <- renderChart({
        percents <- melt(subset(by.day, Total.Computed.kcal > 0), id="Day", measure.vars=c("Protein.Percent", "Fat.Percent", "Carb.Percent"))
        percents <- percents %>% mutate(Day = as.integer(as.numeric(as.POSIXct(Day))))
        p <- Rickshaw$new()
        p$layer(x = "Day", y = "value", group="variable", data=percents, type = "area", width = 560)
        # add a helpful slider this easily; other features TRUE as a default
        p$set(slider = TRUE, scheme="munin")
        p$addParams(dom = 'plot_perc')
        return(p)
    })
    
    #Grams eaten each day of Carbs, Protein, Sugar, and different types of Fat
    output$plot_grams <- renderChart({
        grams <- melt(subset(by.day, Total.Computed.kcal > 0), id="Day", measure.vars=c("Saturated.Fat.g", "Polyunsaturated.Fat.g", "Other.Fat.g", "Sugar.g", "Protein.g", "Carbohydrates.g"))
        grams <- grams %>% mutate(Day = as.integer(as.numeric(as.POSIXct(Day))))
        p <- Rickshaw$new()
        p$layer(x = "Day", y = "value", group="variable", data=grams, type = "area", width = 560)
        # add a helpful slider this easily; other features TRUE as a default
        p$set(slider = TRUE, scheme="munin")
        p$addParams(dom = 'plot_grams')
        return(p)
    })
    
    output$plot <- renderUI({
        if(input$chart == "lbs"){
            showOutput("plot_lbs", "xcharts")
        }else if(input$chart == "cal"){
            showOutput("plot_cal", "morris")
        }else if(input$chart == "bpm"){
            showOutput("plot_bpm", "morris")
        }else if(input$chart == "mi"){
            showOutput("plot_mi", "morris")
        }else if(input$chart == "percents"){
            showOutput("plot_perc", "rickshaw")
        }else if(input$chart == "grams"){
            showOutput("plot_grams", "rickshaw")
        }
    })
})
