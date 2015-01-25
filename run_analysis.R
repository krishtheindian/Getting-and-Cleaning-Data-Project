## run_analysis.R
## created by : R.Krishnamoorthy
## Course : Getting and Cleaning Data

## Purpose of the project is to collect, Analyse, and clean a dataset to 
## have a tidy data set that can be used for further analysis

## To do this the following steps to be completed
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation
## for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data
## set with the average of each variable for each activity and each subject.

library(plyr)

## Step 1 - Create one dataset by merging traning and test datasets
## Read the data from the txt files to tables

## It is assmumed that the data files are available where this R file exists
## with the subfolder structure as downloaded

## reading training sets
train_x <- read.table("train\\X_train.txt")
train_y <- read.table("train\\y_train.txt")
train_subject <-  read.table("train\\subject_train.txt")

## reading test sets
test_x <- read.table("test\\X_test.txt")
test_y <- read.table("test\\y_test.txt")
test_subject <-  read.table("test\\subject_test.txt")

## add the two respective sets
## combine x data
x_data <- rbind(train_x, test_x)

## combine y data
y_data <- rbind(train_y, test_y)

## combine subject data
subject_data = rbind(train_subject, test_subject)

## Step 1 completed

## Step 2 - Extract only the mean and standard deviation measurements 
## The information is available in the features.txt
features <- read.table("features.txt")

## get all the features that has either mean or std
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

## subset only the selected columns (std or mean)
x_data <- x_data[,mean_std_features]

## reset the column names
names(x_data) <- features[mean_std_features, 2]
## Step 2 completed

## Step 3 - Use descriptive activity names to name the activities in the data set 
## The readable activity names are available in the activity_labels.txt file

activities <- read.table("activity_labels.txt")

## update with the readable activity names
y_data[, 1] <- activities[y_data[, 1], 2]

## Step 3 completed

## Step 4 - label the data set with appropriate descriptive variable names. 
names(y_data) <- "activity"
names(subject_data) <- "subject"

## Step 4 completed

## Step 5 - creat a separate tidy data set with the average of each variable for 
## each activity and each subject.

## combine all the datasets in to one single dataset
full_data <- cbind(x_data, y_data, subject_data)

## create the average data set and write to the file
avg_data <- ddply(full_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(avg_data,"averages_data.txt",row.name=FALSE)

