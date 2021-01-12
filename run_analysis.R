library(dplyr)

#read features and activity
features_labels<-read.table("./features.txt", header=FALSE) #561 values
activity_labels<-read.table("./activity_labels.txt", header=FALSE) #6 values

#read test data
y_test<-read.table("./test/y_test.txt",header=FALSE) #2947 rows with value of activity (from 1 to 6)
subject_test<-read.table("./test/subject_test.txt", header=FALSE) #2947 rows with value of subject (from 1 to 30)
X_test<-read.table("./test/X_test.txt", header=FALSE) #2947 rows with measures of 561 features
mydata1<-cbind(subject_test, y_test, X_test)

#free memory from unused datasets
rm(X_test)
rm(y_test)
rm(subject_test)

#read train data
y_train<-read.table("./train/y_train.txt",header=FALSE) #7352 rows with value of activity (from 1 to 6)
subject_train<-read.table("./train/subject_train.txt", header=FALSE) #7352 rows with value of subject (from 1 to 30)
X_train<-read.table("./train/X_train.txt", header=FALSE) #7352 rows with measures of 561 features
mydata2<-cbind(subject_train, y_train, X_train)

#free memory from unused datasets
rm(X_train)
rm(y_train)
rm(subject_train)

#1.	Merges the training and the test sets to create one data set
merged_data<-bind_rows(mydata1, mydata2)

#free memory from unused datasets
rm(mydata1)
rm(mydata2)

#assign the correct names to merged dataset columns
colnames(merged_data)<-c("Subject","Activity",features_labels[,2])

#free memory from unused datasets
rm(features_labels)

# save the resulting table on a file
write.table(merged_data, file="./merged_data.txt", sep=",", dec=".", na="NA", row.names=F, col.names=T)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Select columns whose names contains mean or std (plus columns Subject and Activity"
merged_data_sel<-merged_data %>% select(contains("Subject")|contains("Activity")|contains("mean")|contains("std"))

#free memory from unsed datasets
rm(merged_data)

# 3. Uses descriptive activity names to name the activities in the data set
# set Activity column with descriptive names taken from activity_labels
for (i in 1:length(merged_data_sel$Activity)) merged_data_sel$Activity[i]<-activity_labels[merged_data_sel$Activity[i],2]
rm(i)

#free memory from unsed datasets
rm(activity_labels)

# 4. Appropriately labels the data set with descriptive variable names. 
#remove "-" symbol and "()" from column names to make names more readables
colnames(merged_data_sel)<-gsub("-","_",names(merged_data_sel))
colnames(merged_data_sel)<-gsub("[()]","",names(merged_data_sel))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# sort the data frame by Subject and Activity
merged_data_sel<-arrange(merged_data_sel, Subject,Activity)
# calculate the mean for each column by group
merged_data_mean<-merged_data_sel%>%group_by(Subject, Activity) %>% summarize_all(mean)

#free memory from unsed datasets
rm(merged_data_sel)

# save the resulting table on a file
write.table(merged_data_mean, file="./merged_data_mean.txt", sep=",", dec=".", na="NA", row.names=F, col.names=T)

#free memory from unsed datasets
rm(merged_data_mean)

