complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    # Give us the file name for a given ID
    specFileName <- function(id) {
        paste(directory, "//", sprintf("%03d", id), ".csv", sep="")
    }
    # Read each file specified by ID
    filesAsDataFrames <- lapply(lapply(id, specFileName), read.csv)
    
    completeCount <- function(df) sum(complete.cases(df))
    complete <- sapply(filesAsDataFrames, completeCount)
    data.frame(id=id, nobs=complete)
}
