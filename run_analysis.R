##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
# runAnalysis.r File Description:
# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################


# Step 1
# to set my working directory
setwd("C:/Users/t23bybh/Documents/UCI HAR Dataset")

# load features, extract them and subset only the indeces of means and st devs
featureNames <- read.table("features.txt")
ourFeatures <- grep("std|mean", featureNames$V2)

# Step 2
# load train and test features, extract them and subset only means and st devs
trainFeatures <- read.table("train/X_train.txt")
ourTrainFeatures <- trainFeatures[,ourFeatures]
testFeatures <- read.table("test/X_test.txt")
ourTestFeatures <- test.features[,ourFeatures]

# Step 3
# merge the train and test data sets
totalFeatures <- rbind(ourTrainFeatures, ourTestFeatures)
# add column names to the features
colnames(totalFeatures) <- featureNames[ourFeatures, 2]

# Step 4
# Read and merge the train and test activity 
trainActivities <- read.table("train/y_train.txt")
testActivities <- read.table("test/y_test.txt")
totalActivities <- rbind(trainActivities, testActivities)

# extract activity labels and link to activity codes
activityLabels <- read.table("activity_labels.txt")
totalActivities$activity <- factor(totalActivities$V1, levels = activityLabels$V1, labels = activityLabels$V2)

# Step 5
# extract the train and test subject data and merge
trainSubjects <- read.table("train/subject_train.txt")
testSubjects <- read.table("test/subject_test.txt")
totalSubjects <- rbind(trainSubjects, testSubjects)

# Step 6
# link the subjects to their activity
subjectsActivities <- cbind(totalSubjects, totalActivities$activity)
colnames(subjectsActivities) <- c("subjectID", "activity")

# Step 7
# Combine the activity, ID and measurement in a data frame
activityDF <- cbind(subjectsActivities, totalFeatures)

# Step 8
# create an independent tidy data set with the average of each variable 
# for each activity and each subject
result <- aggregate(activityDF[,3:(ncol(activityDF))], by = list(activityDF$subjectID, activityDF$activity), FUN = mean)
colnames(result)[1:2] <- c("subject.id", "activity")
write.table(result, file="data_tidy.txt", row.names = FALSE)
