# Getting-and-Cleaning-Data-Course-Project
# Coded by Massimiliano Veltroni
R code and Readme.MD files of my project course submission.

The code start loading dplyr library.

Generally inside the code unused data frames are removed as soon as possible to free memory.

# 1.	Merges the training and the test sets to create one data set
Information are read from variuos available files (features list, activity list).
Test data are read including list of activity values, list of subjectes doing the test and data value.
Read data are stored in a data frame.
The same actions are done for training data.
Test and training data are finally merged and names of columns is assigned reading features labels.
The merged data are saved on merged_data.txt file.

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Columns are selected based on mean or std text and reduced data frame is stored in merged_data_sel.

# 3. Uses descriptive activity names to name the activities in the data set
Set Activity column with descriptive names taken from activity_labels.

# 4. Appropriately labels the data set with descriptive variable names. 
I have decided to remove "-" symbol and "()" from column names to make names more readables.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Data on mergesort the data frame by Subject and Activity and stored in merged_data_sel.
The data are grouped by Subject and Activity and the mean is calculated by Group for each column.
merged_data_mean<-merged_data_sel%>%group_by(Subject, Activity) %>% summarize_all(mean)
The data are saved on merged_data_mean.txt file.
