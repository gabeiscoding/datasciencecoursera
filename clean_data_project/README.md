The script `run_analysis.R` implements the Project for the *Getting and Cleaning Data* (https://class.coursera.org/getdata-013) course.

The scripts assumes the files unziped from [the provided project data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) are in the current working directory.

Running the script will do the following:

 1. Read the txt files in the top level and test and train folders
 2. Merge first the train and test dataset, providing clean column headers for measurements
 3. Subbset columns related to std/mean based on the presence of "mean" or "std" in their measurement headings
 4. Relabel activities with their names
 5. Create summary dataset with mean values of measurements grouped by sample and activities 
 4. Write this summary to `grouped_measurements.txt` as a space delimited text file
 
 See CodeBook.md for description of `grouped_measurements.txt`
 