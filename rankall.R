rankall <- function(outcome, num = "best") {
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that outcome is valid
    if(outcome == "heart attack")
        col.idx <- 11
    else if(outcome == "heart failure")
        col.idx <- 17
    else if(outcome == "pneumonia")
        col.idx <- 23
    else
        stop("invalid outcome")
    
    states <- sort(unique(df$State))
    
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    rank.per.state <- function(state){
        by.state <- subset(df, df$State == state)
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
    hospitals <- sapply(states, rank.per.state)
    data.frame(hospital=hospitals, state=states, row.names=states)
}