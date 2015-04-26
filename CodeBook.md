# Getting and Cleaning Project Data

* **Timothy R. Warren**
* Date: 2015-4-25
* GitHub: https://github.com/kreas/getting_and_cleaning_data_course_project

## Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

<cite>Getting and Cleaning Data Course Project -- <u>Coresera - Getting and Cleaning Data</u> -- https://class.coursera.org/getdata-013/human_grading</u> </cite>

### Source

Data used for this example can be donwloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Procedure
Please note that the script `run_analysis.R` assumes that you have extracted the data from the source above into the directory `./UCI HAR Dataset` in the projects root.

### 1: Merges the training and the test sets to create one data set.

Load the data for each of the files:

* subject_train.txt
* x_train.txt
* y_train.txt
* subject_test.txt
* x_test.txt
* y_test.txt

Merge the data from the test and train data sets into the data tables:

* `x_data`
* `y_data`
* `subject`

Once the data has been merge the original data from the files is removed from memory.

### 2: Extracts only the measurements on the mean and standard deviation for each measurement.

Feature infromation is loaded from features.txt and assign it to the variable `feature`.

It is then parsed into a logical vector and sorted returning only the columns that contain STD and MEAN information. It is stored as the variable `ms_features`

`x_data` is then filtered to by  `ms_features` returning only the desired informaiton.

ms_feature is remove from memeory

### 3: Uses descriptive activity names to name the activities in the data set

Activity informaiton is loaded from activities.txt and used as the distionary to assign the named values for `y_data`


### 4: Appropriately labels the data set with descriptive variable names.

Column names are extracted from x_data using the gsub function the the names are converted into a more readable format.

Column names are assigned to `x_data`, `y_data` and `subject`.

The data sets are then merged into a signle data table `data` and the work environment is cleaned up.

### 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The resulting data table from step 4 (`data`) is used to create a seperate data table that contains the average of each activity seperated by subject. It is assigned to the variable `averages_by_subject`.

`averages_by_subject` is then saved as a CSV file in the root directory with the file name *averages_by_subject.csv*
