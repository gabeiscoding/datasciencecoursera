rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    by.state <- subset(df, df$State == state)
    if(nrow(by.state) == 0)
        stop("invalid state")
    
    if(outcome == "heart attack")
        col.idx <- 11
    else if(outcome == "heart failure")
        col.idx <- 17
    else if(outcome == "pneumonia")
        col.idx <- 23
    else
        stop("invalid outcome")
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    by.state[,col.idx] <- suppressWarnings(as.numeric(by.state[,col.idx]))
    by.cond <- subset(by.state, !is.na(by.state[,col.idx])) #Subset where no cond data
    by.cond <- by.cond[order(by.cond[,col.idx], by.cond$Hospital.Name), ] #Sort by condition, then hospital
    if(num == "best")
        num <- 1L
    else if(num == "worst")
        num <- nrow(by.cond)
    else
        num <- as.integer(num)
    if(!is.integer(num))
        stop("invalid num")
    if(num < 1 || num > nrow(by.cond))
        NA
    else
        by.cond$Hospital.Name[[num]]
}