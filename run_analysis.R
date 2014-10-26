run_analysis(){

setwd("C:/R_practice/UCI HAR Dataset")  
  
#read activity labels file
activity_labels<-read.table("activity_labels.txt")

#read features file
features<-read.table("features.txt")

#read train set, train labels and subject identifiers
X_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")


#rename variable names into descriptive format
colnames(y_train)<-c("activity_label")
features_list<-features$V2
colnames(X_train) <-features_list
colnames(subject_train)<-c("subject_id")

#merge train set data with labels and subject identifiers, make final train_set 
train_set<-cbind(subject_train, cbind(y_train, X_train))


#read test set, test labels and subject identifiers
X_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")

#rename variable names into descriptive format
colnames(y_test)<-c("activity_label")
colnames(X_test) <-features_list
colnames(subject_test)<-c("subject_id")

#merge test set data with labels and subject identifiers, make final test_set 
test_set<-cbind(subject_test,cbind(y_test, X_test))


#merge the training and the test sets to create one data set
data_set<-rbind(train_set, test_set)

#Extract only the measurements on the mean and standard deviation for each measurement.
measures<-c("subject_id", "activity_label","tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z","tBodyGyro-mean()-X","tBodyGyro-mean()-Y","tBodyGyro-mean()-Z","tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z","tBodyAccMag-mean()","tGravityAccMag-mean()","tBodyAccJerkMag-mean()","tBodyGyroMag-mean()","tBodyGyroJerkMag-mean()","fBodyAcc-mean()-X","fBodyAcc-mean()-Y","fBodyAcc-mean()-Z","fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z","fBodyGyro-mean()-X","fBodyGyro-mean()-Y","fBodyGyro-mean()-Z","fBodyAccMag-mean()","fBodyBodyAccJerkMag-mean()","fBodyBodyGyroMag-mean()","fBodyBodyGyroJerkMag-mean()",
            "tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z","tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z","tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z","tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z","tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z","tBodyAccMag-std()","tGravityAccMag-std()","tBodyAccJerkMag-std()","tBodyGyroMag-std()","tBodyGyroJerkMag-std()","fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z","fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z","fBodyGyro-std()-X","fBodyGyro-std()-Y","fBodyGyro-std()-Z","fBodyAccMag-std()","fBodyBodyAccJerkMag-std()","fBodyBodyGyroMag-std()","fBodyBodyGyroJerkMag-std()")

data_set_new<-subset(data_set, select=measures)

#grouping data by subject id and activity
data_set_new<-group_by(data_set_new, subject_id, activity_label)

#independent tidy data set with the average of each variable for each activity and each subject
data_set_final<-ddply(data_set_new, .(subject_id, activity_label), numcolwise(mean))

write.table(data_set_final, file="data_set_final.txt", row.name=FALSE)

}
