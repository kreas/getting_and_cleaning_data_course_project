# -------------------------------------------------------------------------------------------------
# Getting and Cleaning Data Coursera Project
# - Timothy R. Warren
# - April 25th 2015
#
#
# You should create one R script called run_analysis.R that does the following.
#
# 1)  Merges the training and the test sets to create one data set.
# 2)  Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3)  Uses descriptive activity names to name the activities in the data set
# 4)  Appropriately labels the data set with descriptive variable names. 
# 5)  From the data set in step 4, creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject.
#
# 
# -------------------------------------------------------------------------------------------------

# Require libraries
library(plyr)

# 1) Merges the training and the test sets to create one data set.
# -------------------------------------------------------------------------------------------------

# Load the train data sets
x_train       <- read.table('UCI HAR Dataset/train/X_train.txt', header = F)
y_train       <- read.table('UCI HAR Dataset/train/y_train.txt', header = F)
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt', header = F)

# Load the test data sets
x_test        <- read.table('UCI HAR Dataset/test/X_test.txt', header = F)
y_test        <- read.table('UCI HAR Dataset/test/Y_test.txt', header = F)
subject_test  <- read.table('UCI HAR Dataset/test/subject_test.txt', header = F)

# Combine the data sets
x_data        <- rbind(x_train, x_test)
y_data        <- rbind(y_train, y_test)

subject       <- rbind(subject_train, subject_test)

# clean up unused data to free up memory.
rm(x_train, y_train, subject_train, x_test, y_test, subject_test)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# -------------------------------------------------------------------------------------------------

# load feature data
features      <- read.table('UCI HAR Dataset/features.txt')

# filter to only *-mean() and *-std() values.
ms_features   <- grep("-(mean|std)\\(\\)", features[, 2])
x_data        <- x_data[, ms_features]

# set the names of each column
names(x_data) <- features[ms_features, 2]

rm(features, ms_features) # clean up

# 3) Uses descriptive activity names to name the activities in the data set.
# -------------------------------------------------------------------------------------------------

# load the activity label definitions
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')

# Apply labels to y_data and set the label of the column.
y_data[, 1] <- activity_labels[y_data[, 1], 2]

rm(activity_labels) # clean up

# 4) Appropriately labels the data set with descriptive variable names.
# -------------------------------------------------------------------------------------------------

# Fetch the current column names from x_data/
cols = colnames(x_data)

# Convert them to more meaningful names.
cols <- gsub('\\(|\\)',"",cols, perl = TRUE)
cols <- gsub('Acc',"Acceleration", cols)
cols <- gsub('GyroJerk',"AngularAcceleration", cols)
cols <- gsub('Gyro',"AngularSpeed", cols)
cols <- gsub('Mag',"Magnitude", cols)
cols <- gsub('^t',"Time.",cols)
cols <- gsub('^f',"Frequency.", cols)
cols <- gsub('\\-mean',".MEAN", cols)
cols <- gsub('\\-std',".STD", cols)
cols <- gsub('Freq\\.',"Frequency.", cols)
cols <- gsub('Freq$',"Frequency", cols)
cols <- gsub('\\-', '.', cols)

# Assign x_data's column names with the converted data.
names(x_data) <- cols

# Assign y_data's column header.
names(y_data) <- 'Activity'

# Assin subjects header names
names(subject) <- 'Subject'

# combine all of the data sets into a single data set
data <- cbind(subject, y_data, x_data)

rm(cols, y_data, x_data, subject) # clean up

# 5)  From the data set in step 4, creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject.
# -------------------------------------------------------------------------------------------------

averages_by_subject <- ddply(data, c("Subject","Activity"), numcolwise(mean))
write.table(averages_by_subject, file = "./averages_by_subject.txt")
