Code Book
This code book summarizes the resulting data fields in data_tidy.txt.
This file is a code book that describes the variables, the data, and any transformations performed to clean up the data

The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

run_analysis.R performs the following (in short)

1. Reads in the features file, test and train feature files ("testFeatures", "trainFeatures") 
2. Merges the training and test data sets into one called "totalFeatures".
3. Uses only the mean or standard deviations from the original dataset to obtain "ourTestFeatures" and "ourTrainFeatures"
4. Reads in the train and test activity files and merges them ("trainActivities", "testActivities", "totalActivities")
5. Reads the activities labels file ("activityLabels") and links the activity names to the 
    activity codes ("totalActivities$activity")
6. Reads the subject ids for train and test sets ("trainSubjects","testSubjects" respectively) and
    merges them in one df ("totalSubjects")
7. Creates a data frame called "activityDF" with activity labels, subject ids and data from the test 
    and train measurement files
5. Organises the "activityDF" by subjectID and activity and saves the "result" as a txt file ("mean_results.txt").
