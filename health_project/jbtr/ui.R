library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Fitness Data Training for Jim Bridger Trail Run"),
    
    sidebarPanel( width=3,
        selectInput("chart", "Chart:",
                    list("Weight" = "lbs", 
                         "Calories" = "cal", 
                         "Heart Rate" = "bpm",
                         "Distance" = "mi",
                         "Macro Nutrients" = "percents",
                         "Food Contents" = "grams"
                         )),
        p('To get in shape for a 10 mile mountain trail run called the Jim Bridger Trail Run on June 27, 2015, I started counting calaries using MyFitnessPal to drop to a target weight of 160.'),
        p('With my iPhone (and Apple Watch starting early May) I had a trove of data colleted in HealthKit, and was able to export it using QS Access showing my training up to the race and after.'),
        p('Select one of the charts above to see information gathered on my weight, food consumption, calories burned, miles moved and heart rate on a daily basis'),
        p('I reached my goal, finished the race in 1:52, and placed 42 (out of ~120 men)'),
        p('Resources:'),
        tags$ul(
            tags$li(tags$a(href="https://itunes.apple.com/gb/app/qs-access/id920297614?mt=8", "QS Access App")), 
            tags$li(tags$a(href="https://www.myfitnesspal.com/", "MyFitnessPal App")),
            tags$li(tags$a(href="http://www.bridgerskifoundation.org/jbtr", "JBTR"))
            )
        
    ),
    
    mainPanel(
        h3(textOutput("caption")),
        uiOutput("plot"),
        conditionalPanel(
            condition = "input.chart == 'lbs'",
            br(),
            br(),
            sidebarPanel( width = 10,
            p("A linear model was computed on weight between my start date and goal date."),
            p("Enter a starting weight and number of days on 'my program' to see a predicted weight using this model."),
            numericInput('weight', 'Starting Weight', 196, min=50, max=1000, step=1),
            numericInput('days', 'Number of Days', 224, min=1, step=1),
            p('Predicted weight: ', strong(textOutput("pred_weight", inline=TRUE)), 
              'with 0.95 CI of [', textOutput('pred_l', inline=TRUE), ', ', textOutput('pred_h', inline=TRUE), ']')
            )
        )
    )
))
