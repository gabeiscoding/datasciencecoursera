pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    # Give us the file name for a given ID
    specFileName <- function(id) {
        paste(directory, "//", sprintf("%03d", id), ".csv", sep="")
    }
    # Read each file specified by ID
    filesAsDataFrames <- lapply(lapply(id, specFileName), read.csv)
    # Row append all our data frames
    # Note: do.call is the only way I figured to bind a vector to the ... argument of rbind)
    df <- do.call(rbind, filesAsDataFrames)
    
    #Debug
    #print(dim(df))
    
    # Grab the field requested
    field <- df[[pollutant]]
    
    # Non-NA values
    obs <- field[!is.na(field)]
    mean(obs)
}
