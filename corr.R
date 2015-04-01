corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
    # Read each CSV file in directory
    filesAsDataFrames <- lapply(list.files(directory, full.names=TRUE, pattern="*.csv"), read.csv)
    
    # Numeric vector of size 0
    res <- vector('numeric', 0)
    
    # For each, add to our res correlation between sulfate and nitrate for
    # completed rows if # completed rows is paste our threshold
    for(df in filesAsDataFrames) {
        if(sum(complete.cases(df)) > threshold) {
            df <- subset(df, complete.cases(df))
            res <- append(res, cor(df$sulfate, df$nitrate))
        }     
    }
    res
}
