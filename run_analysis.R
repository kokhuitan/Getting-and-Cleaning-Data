run_analysis <- function() {

  library(plyr)
  
  ## Read in features
  features <- read.csv("data/features.txt", header=FALSE, sep="")  
  features_edit <- tolower(gsub("(\\(|\\)|\\-|\\,)","",features[,2]))
  
  ## Read test data and combine into a single data frame
  testsub <- read.csv("data/test/subject_test.txt", header=FALSE)
  names(testsub)<-"subject"
  testy <- read.csv("data/test/y_test.txt", header=FALSE)
  names(testy)<-"activity"
  testx <- read.csv("data/test/X_test.txt", header=FALSE, sep="")
  names(testx)<-features_edit
  test<-cbind(testsub, testy, testx)

  ## Read training data and combine into a single data frame
  trainsub <- read.csv("data/train/subject_train.txt", header=FALSE)
  names(trainsub)<-"subject"
  trainy <- read.csv("data/train/y_train.txt", header=FALSE)
  names(trainy)<-"activity"
  trainx <- read.csv("data/train/X_train.txt", header=FALSE, sep="")
  names(trainx)<-features_edit
  train<-cbind(trainsub, trainy, trainx)
  
  ## Combine test and training data
  data<-rbind(test, train)
  
  ## Extract mean and std data, followed by arranging by subject and activity
  data_mean_sd<-data[,c(1,2,grep("std", colnames(data)), grep("mean", colnames(data)))]
  
  ## Use descriptive activity names to name activities
  data_mean_sd$activity[data_mean_sd$activity==1]<-"WALKING"  
  data_mean_sd$activity[data_mean_sd$activity==2]<-"WALKING_UPSTAIRS"
  data_mean_sd$activity[data_mean_sd$activity==3]<-"WALKING_DOWNSTAIRS"
  data_mean_sd$activity[data_mean_sd$activity==4]<-"SITTING"
  data_mean_sd$activity[data_mean_sd$activity==5]<-"STANDING"
  data_mean_sd$activity[data_mean_sd$activity==6]<-"LAYING"
  
  ## Average each variable for each activity and each subject
  final <- ddply(data_mean_sd, .(subject, activity), .fun=function(x){colMeans(x[,-c(1:2)])})
  write.table(final, 'final.txt', row.name=FALSE)
  View(final)
}

