#########
# Project for Getting and Cleaning Data
#
# Download data on wearable device measurements
#
# Data from 30 samples, 21 training set, 9 test set

library(dplyr)
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="getdata-projectfiles-Dataset.zip", mode="wb")
unzip("getdata-projectfiles-Dataset.zip")

# Read and merge test and train data together

#Test data
test_subjects = read.table('test/subject_test.txt')[,1]
test_activities = read.table('test/y_test.txt')[,1]
test_measurements <- data.table(read.table('test/X_test.txt', header=FALSE))
test_id <- rep(1, length(test_subjects)) #idicator that these are test measurements
test <- cbind(train_or_test=test_id, subject=test_subjects, activity=test_activities, test_measurements)

#Train data
train_subjects = read.table('train/subject_train.txt')[,1]
train_activities = read.table('train/y_train.txt')[,1]
train_measurements <- data.table(read.table('train/X_train.txt', header=FALSE))
train_id <- rep(2, length(train_subjects)) #idicator that these are test measurements
train <- cbind(train_or_test=train_id, subject=train_subjects, activity=train_activities, train_measurements)

#Row bind these two datasets
data <- bind_rows(test, train)

# Extracts only the measurements on the mean and standard deviation for each measurement. 

#features.txt contains the header labels as a second column
labels <- read.table('features.txt', stringsAsFactors = FALSE)[,2]
#clean up these column headers
labels <- sub(',','_',sub('\\)', '', sub('\\(', '', sub('\\(\\)','',labels))))
#replace our data table headers with the first 3 headers and these new names
new_headers = c(colnames(data)[1:3], labels)
colnames(data) <- new_headers

#subset our table down to only columns that have "mean()" or "std()" in them
label_idxs <- c(1,2,3, grep("mean|std", new_headers))
data <- data[,label_idxs]

# Uses descriptive activity names to name the activities in the data set
activity_labels = read.table('activity_labels.txt', stringsAsFactors = FALSE)[,2]

data <- mutate(data, activity=factor(activity, labels=activity_labels), train_or_test=factor(train_or_test,labels=c('train','test')))

# Looks like we don't care about train_or_test
data <- select(data, -train_or_test)

# average of each variable for each activity and each subject
grouped <- data %>% group_by(subject, activity) %>% summarise_each(funs(mean))

# write this out
write.table(grouped, file="grouped_measurements.txt", row.name=FALSE)