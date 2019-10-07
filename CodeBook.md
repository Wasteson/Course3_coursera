1.	Study design
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2.	Loading package
library(dplyr)

Attaching package: 'dplyr'
The following objects are masked from 'package:stats':
    filter, lag
The following objects are masked from 'package:base':
    intersect, setdiff, setequal, union

3.	I’m downloading the file and unzipping it in the subfolder ‘data’ that supports my assignment (=wd)

> setwd("~/Desktop/skole/Getting and Cleaning Data_kurs3/final_assignment")
> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> download.file(fileUrl, destfile = "./data/final.zip", method = "curl")
> list.files("./data")
[1] "final.zip"
> dateDownloaded <- date()
> dateDownloaded
[1] "Mon Oct  7 10:59:03 2019"
> setwd("~/Desktop/skole/Getting and Cleaning Data_kurs3/final_assignment/data")
> unzip("final.zip")
> list.files()
[1] "UCI HAR Dataset" "final.zip"    

4.	Establishing each data frame into R

> features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
> dim(features)
[1] 561   2
> activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
> dim(activities)
[1] 6 2
> subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
> dim(subject_test)
[1] 2947    1
> x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
> dim(x_test)
[1] 2947  561
> y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
> dim(y_test)
[1] 2947    1
> subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
> dim(subject_train)
[1] 7352    1
> x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
> dim(x_train)
[1] 7352  561
> y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
> dim(y_train)
[1] 7352    1

5.	Then merges X train&test, Y train&test, Subject train&test into X, Y and Subject via rbind (row wise), getting the total rows within each set. Then merges X, Y and Subject in to one dataset [Merge] via cbind (column wise) getting all rows and columns.

> X <- rbind(x_train, x_test)
> dim(X)
[1] 10299   561
> Y <- rbind(y_train, y_test)
> dim(Y)
[1] 10299     1
> Subject <- rbind(subject_train, subject_test)
> dim(Subject)
[1] 10299     1
> Merge <- cbind(Subject, Y, X)
> dim(Merge)
[1] 10299   563

6.	Then tidying ‘Merge’ in the way that I extract only the subject and code variables in addition to variables containing mean and standard deviation. Assigning that merged and tided up dataset in to ‘Tidy1_2’.

> Tidy1_2 <- Merge %>% select(subject, code, contains("mean"), contains("std"))
> dim(Tidy1_2)
[1] 10299    88

7.	Adding descriptive names to the code columns so that the codes makes sense, by pairing code and description from the ‘activities’ dataset.

> Tidy1_2$code <- activities[Tidy1_2$code, 2]

8.	Setting descriptive names on variables by fixing character vectors with gsub to change wordings within each variable name. 

> names(Tidy1_2)[2] = "activity"
> names(Tidy1_2) <- gsub("Acc", "Accelerometer", names(Tidy1_2))
> names(Tidy1_2) <- gsub("^t", "Time", names(Tidy1_2))
> names(Tidy1_2) <- gsub("^f", "Frequency", names(Tidy1_2))
> names(Tidy1_2) <- gsub("BodyBody", "Body", names(Tidy1_2))
> names(Tidy1_2) <- gsub("mean", "Mean", names(Tidy1_2))
> names(Tidy1_2) <- gsub("std", "Std", names(Tidy1_2))
> names(Tidy1_2) <- gsub("Freq", "Frequency", names(Tidy1_2))
> names(Tidy1_2) <- gsub("Mag", "Magnitude", names(Tidy1_2))
> names(Tidy1_2) <- gsub("angle", "Angle", names(Tidy1_2))
> names(Tidy1_2) <- gsub("Frequencyuency", "Frequency", names(Tidy1_2))
> names(Tidy1_2) <- gsub("gravity", "Gravity", names(Tidy1_2))

9.	Creating the second tidy dataset ‘Tidy2’ by grouping and summarizing so that we are given the average of each variable.

> Tidy2_2 <- Tidy1_2 %>%
+ group_by(subject, activity) %>%
+ summarise_all(list(mean))
> write.table(Tidy2_2, "Tidy2_2.txt", row.names = FALSE)
