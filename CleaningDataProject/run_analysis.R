# Script for Course "Getting and Cleaning Data" - Project

# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each
#    variable for each activity and each subject.

orgWD <- getwd()
setwd("CleaningDataProject")

# Set up data folder for project 
if (!file.exists("Data")) {
  dir.create("Data")
}

library(data.table)

source("../Utility/Utilities.R")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

fileLocations <- "Data"

unzipFromUrl(url,fileLocations)

filePath <- "Data/UCI HAR Dataset/"

columnNames <- as.character(fread(paste(filePath,"features.txt", sep=""))[,V2])
colIndicies <- grep("std|mean", columnNames,value= TRUE)

# Bring in the test data
testX <- fread(paste(filePath,"test/X_test.txt", sep=""),col.names = columnNames,header = FALSE)
testY <- fread(paste(filePath,"test/Y_test.txt", sep=""),col.names = c("Activity"),header = FALSE)
testSubjects <- fread(paste(filePath,"test/subject_test.txt", sep=""), col.names = c("Subject"),header = FALSE)
# Bind the test data together
testData<- cbind(testSubjects,testY,testX[,colIndicies,with = FALSE])

# Now the same for Train data
trainX <- fread(paste(filePath,"train/X_train.txt", sep=""),col.names = columnNames,header = FALSE)
trainY <- fread(paste(filePath,"train/Y_train.txt", sep=""),col.names = c("Activity"),header = FALSE)
trainSubjects <- fread(paste(filePath,"train/subject_train.txt", sep=""), col.names = c("Subject"),header = FALSE)
# Bind the train data together
trainData<- cbind(trainSubjects,trainY,trainX[,colIndicies,with = FALSE])


# 1) Now bind all the data together
# This caters for both 1) and 2) in the project spec (note that testData and trainData have already removed unwanted columns)
allData <- rbind(testData,trainData)

# 3) Uses descriptive activity names to name the activities in the data set
activityNames <- fread(paste(filePath,"activity_labels.txt", sep=""), header = FALSE) 

allData$Activity <- unlist(lapply(allData$Activity, function(x) {activityNames[,2][x]}))

# 4) Clean up variable names - Appropriately labels the data set with descriptive variable names.
cleanColNames <- names(allData)
# Special characters removed
cleanColNames <- gsub("[\\(\\)-]", "", cleanColNames)
# Replace leading letter with appropriate name
cleanColNames <- gsub("^t", "Time", cleanColNames)
cleanColNames <- gsub("^f", "Frequency", cleanColNames)
# Replace abbreviated actions
cleanColNames <- gsub("mean", "Mean", cleanColNames)
cleanColNames <- gsub("std", "StandardDeviation", cleanColNames)
# Replace abbreviated 
cleanColNames <- gsub("Acc", "Accelerometer", cleanColNames)
cleanColNames <- gsub("Gyro", "Gyroscope", cleanColNames)
cleanColNames <- gsub("Mag", "Magnitude", cleanColNames)
cleanColNames <- gsub("Freq", "Frequency", cleanColNames)
# Replace duplicated Body (BodyBody)
cleanColNames <- gsub("BodyBody", "Body", cleanColNames)
# Now replace the existing column names with these
colnames(allData) <- cleanColNames

# Group by "subject" and "activity" and calculate the mean for each group
summarizedData <- allData[, lapply(.SD, mean), by = .(Subject, Activity)][order(Subject)]

# 5) Create a second, independent tidy data set with the average of each variable for each activity and each subject
write.table(summarizedData, "tidy_data.txt", row.names = FALSE, quote = FALSE)
