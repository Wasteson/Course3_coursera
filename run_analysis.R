##Loading package
library(dplyr)

##Set wd
setwd("~/Desktop/skole/Getting and Cleaning Data_kurs3/final_assignment")

##Data download and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/final.zip", method = "curl")

##Reset wd and unzip
setwd("~/Desktop/skole/Getting and Cleaning Data_kurs3/final_assignment/data")
unzip("final.zip")

##Establishing data into R
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

##Merging the training and the test sets to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merge <- cbind(Subject, Y, X)

##Extracting only the measurements on the mean and standard deviation for each measurement
Tidy1_2 <- Merge %>% select(subject, code, contains("mean"), contains("std"))

##Using descriptive activity names to name the activities in the data set
Tidy1_2$code <- activities[Tidy1_2$code, 2]

##Appropriately labeling the data set with descriptive variable names
names(Tidy1_2)[2] = "activity"
names(Tidy1_2) <- gsub("Acc", "Accelerometer", names(Tidy1_2))
names(Tidy1_2) <- gsub("^t", "Time", names(Tidy1_2))
names(Tidy1_2) <- gsub("^f", "Frequency", names(Tidy1_2))
names(Tidy1_2) <- gsub("BodyBody", "Body", names(Tidy1_2))
names(Tidy1_2) <- gsub("mean", "Mean", names(Tidy1_2))
names(Tidy1_2) <- gsub("std", "Std", names(Tidy1_2))
names(Tidy1_2) <- gsub("Freq", "Frequency", names(Tidy1_2))
names(Tidy1_2) <- gsub("Mag", "Magnitude", names(Tidy1_2))
names(Tidy1_2) <- gsub("angle", "Angle", names(Tidy1_2))
names(Tidy1_2) <- gsub("Frequencyuency", "Frequency", names(Tidy1_2))
names(Tidy1_2) <- gsub("gravity", "Gravity", names(Tidy1_2))

##creating a second, independent tidy data set with the average of each variable for each activity and each subject.
Tidy2_2 <- Tidy1_2 %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))
write.table(Tidy2_2, "Tidy2_2.txt", row.names = FALSE)
