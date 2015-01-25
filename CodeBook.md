# Prepare Tidy Data Project Code Book
The purpose of this project to collect, work with and clean a dataset for further use.
The data from Human Activity Recognition Using Smartphones Data Set from UCI is used. Data collected from 30 subjects performing 6 daily activities (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying). 

## Steps Involved
A tidy dataset is achieved by performing the steps listed below in the `run_analysis.R`:

1. First individual Test & Train datasets are read and merged together with the `rbind` functions. The datasets have idenitical columns.
2. The `"features.txt"` file contains the detailed feature names captured for all the 561 features collected
3. From all the features, only the mean and standard deviation (std) feature names are extracted 
4. Using these features a specific dataset is subsetted (leaving other columns)
5. The readable acitivity names are read from the `"activity_labels.txt"` file and the updated in the dataset
6. Using the `cbind` function all the three datasets are merged (subjects, x and y)
7. Finally, we have a output text file with 180 rows (30 subjects, 6 activities) saved as `"averages_data.txt"`

## Variables & Transformations
* `train_x`, `train_y` & `train_subject` - are used to read the training data from files
* `test_x`,`test_y` & `test_subject` - are used to read the test data from files
* `x_data` holds the merged data of `train_x` and `test_x`
* `y_data` holds the merged data of `train_y` and `test_y`
* `subject_data` holds the merged data of `train_subject` and `test_subject`
* `mean_std_features' holds the desired columns (only mean and std) from the `"features.txt"` file extracted to `features` variable
* `activities` holds the readable activity names extracted from the `"activity_labels.txt"` file
* `full_data` combines all the three datasets (`x_data`,`y_data` & `subject_data`) using `cbind` function
* `avg_data` is used to create the average of each variable for each activity for each subject
* The output is stored to the txt file `"averages_data.txt"` using the `ddply` function and applying the `colMeans` function


