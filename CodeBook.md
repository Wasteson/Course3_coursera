1.	Study design
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


2.	Loading package: library(dplyr)


3.	I’m downloading the file and unzipping it to get 'UCI HAR Dataset' in the subfolder ‘data’ that supports my assignment (=wd)
   

4.	Establishing each data frame into R

features <- read.table("UCI HAR Dataset/features.txt" .. dim(features) -> 561/2  to get the selected features from the acceleromter and gyroscope

activities <- read.table("UCI HAR Dataset/activity_labels.txt" .. dim(activities) -> 6/2 to get the activities&codes

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt" .. dim(subject_test) -> 2947/1 contains observed test data

x_test <- read.table("UCI HAR Dataset/test/X_test.txt" .. dim(x_test) -> 2947/561 contains recorded test data

y_test <- read.table("UCI HAR Dataset/test/y_test.txt" .. dim(y_test) -> 2947/1 contains activity code labels

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt" .. dim(subject_train) -> 7352/1 contains observed train data

x_train <- read.table("UCI HAR Dataset/train/X_train.txt" .. dim(x_train) -> 7352/561 contains recorded train data

y_train <- read.table("UCI HAR Dataset/train/y_train.txt" .. dim(y_train) -> 7352/1 contains activity code labels


5. Then merges X train&test (10299/561), Y train&test (10299/1), Subject train&test (10299/1) into X, Y and Subject via rbind (row wise), getting the total rows within each set. Then merges X, Y and Subject in to one dataset [Merge] via cbind (column wise) getting all rows and columns (10299/563).


6.	Then tidying ‘Merge’ in the way that I extract only the subject and code columns in addition to measurements containing mean and standard deviation. Assigning that merged and tided up dataset in to ‘Tidy1_2’ (10299/88).


7.	Adding descriptive names to the code columns so that the codes makes sense, by pairing code and description from the ‘activities’ dataset.


8.	Setting descriptive names on variables by renaming a column and fixing character vectors with gsub to change wordings within each variable name. 

names(Tidy1_2)[2] = "activity"

names(Tidy1_2) <- gsub("Acc", "Accelerometer", names(Tidy1_2))

names(Tidy1_2) <- gsub("^t", "Time", names(Tidy1_2))

names(Tidy1_2) <- gsub("^f", "Frequency", names(Tidy1_2))

etc.

9.	Creating the second tidy dataset ‘Tidy2_2’ by grouping and summarizing so that we are given the average of each variable. Finally exporting this dataset as a file
