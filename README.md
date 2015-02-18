# Getting-and-Cleaning-Data
To upload the course project for this mooc
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Merges the training and the test sets to create one data set.

First, read each of the "test" files.

  testsub <- read.csv("data/test/subject_test.txt", header=FALSE)
  testy <- read.csv("data/test/y_test.txt", header=FALSE)
  testx <- read.csv("data/test/X_test.txt", header=FALSE, sep="")

Second, give the "test" data appropriate headers, where features[,2] are the names from the given features.txt

  names(testsub)<-"subject"
  names(testy)<-"activity"
  names(testx)<-features[,2]

Third, merge "test" data into a single dataset.

  test<-cbind(testsub, testy, testx)

Repeat for "train" files and then combine both "test" and "train" dataset into a single dataset "data".

  data<-rbind(test, train)

2. Extracts only the measurements on the mean and standard deviation for each measurement

The first line extracts the required data, while the next arranges them according to subject and activity (for readability).

  data_mean_sd<-data[,c(1,2,grep("std", colnames(data)), grep("mean", colnames(data)))]
  data_mean_sd<-arrange(data_mean_sd,subject,activity)

3. Uses descriptive activity names to name the activities in the data set.

Use a brute force way to rename the "activity" column.

  data_mean_sd$activity[data_mean_sd$activity==1]<-"WALKING"  
  data_mean_sd$activity[data_mean_sd$activity==2]<-"WALKING_UPSTAIRS"
  data_mean_sd$activity[data_mean_sd$activity==3]<-"WALKING_DOWNSTAIRS"
  data_mean_sd$activity[data_mean_sd$activity==4]<-"SITTING"
  data_mean_sd$activity[data_mean_sd$activity==5]<-"STANDING"
  data_mean_sd$activity[data_mean_sd$activity==6]<-"LAYING"

4. Appropriately labels the data set with descriptive variable names.

This has been done earlier first by reading the features from features.txt

  features <- read.csv("data/features.txt", header=FALSE, sep="")  
  
And then renaming using this

  names(testx)<-features[,2]

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  write.table(final, 'final.txt', row.name=FALSE)

