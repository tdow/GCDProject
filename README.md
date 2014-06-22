# GCDProject
==========

## Getting and Cleaning Data Course Project

This readme explains how the run_analysis.R code works.

The UCI HAR Dataset is assumed to be downloaded into the working directory.

The features.txt contains all the variable names. This is imported into the dataframe "header"

The vector "to_match" identifies all the feature names that contain either std() or mean()



## 1. Merges the training and the test sets to create one data set.

The x_train dataset is imported into the dataframe "xtrain". The labels from "header" are used to assign the variable names.

The y_train dataset is imported into the dataframe "ytrain". The variable name is labeled "ActivityID"

The subject_train dataset is imported into the dataframe "subtrain". The variable name is labeled "SubjectID"

The "to_match" vector is used to extract only the variables with names containing "mean" or "std" from xtrain . This subset is stored in "xtrain_meanstd"

cbind is then used to combine "subtrain", "ytrain" and "xtrain_meanstd" into a single dataset call "train"



The x_test dataset is imported into the dataframe "xtest". The labels from "header" are used to assign the variable names.

The y_test dataset is imported into the dataframe "ytest". The variable name is labeled "ActivityID"

The subject_test dataset is imported into the dataframe "subtest". The variable name is labeled "SubjectID"

The "to_match" vector is used to extract only the variables with names containing "mean" or "std" from xtest . This subset is stored in "xtest_meanstd"

cbind is then used to combine "subtest", "ytest" and "xtest_meanstd" into a single dataset call "test"

The test and train dataset are merged into a single dataset call "combined" using rbind.

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

The dataset combined only contains the measurements on the mean and standard deviations. These measurement were extracted when only the variable containing mean and std we used from the xtrain and xtest datasets as described above.

## 3. Uses descriptive activity names to name the activities in the data set

The activity_labels.txt file contains all the descriptive activity names. This is imported into the dataframe "activity" with variable names ID and Activity.

The dataframe is merged with the combined dataframe by matching the ActivityID variable in the combined dataframe with the Id variable in the activity dataframe.

The merged dataframe is called "merged"


## 4. Appropriately labels the data set with descriptive variable names.

The labels in the merged dataset already have descriptive variable names as the feature.txt file was used to the assign the variable names on import. When these names were being assigned, characters such as "-", "(" and ")" were replaced with ".". 
To improve the desciptive names, all "." were removed from the variable names using the gsub command.

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The merged data was melted. SubjectID, ActivityID and Activity are identifier variables.
The tidy data set with the average of each variable for each activity and subject was created by dcasting the melted data. 

The tidy data set is exported to tidyDataSet.csv in the working directory.

