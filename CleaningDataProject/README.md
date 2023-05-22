# Getting And Cleaning Data - Week 4 Project
## Peer-graded Assignment: Getting and Cleaning Data Course Project (Coursera)

### Instructions for this assignment were:

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries    calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it

=============================================================================================================

### The script required to generate the tidy data set is called run_analysis.R.

The following steps were undertaken to complete the project.

  1. Firstly we load the data.table library, then gather the datasets from the websites and unzips the files into a data folder. Files are then read into data.tables. 
  2. Next the script binds the training and the test sets to create one data set.  This includes the X, y and subject files.
     X - contains the values for the various measurements
     y - contains the activity code (1-6)
     subject - contains the subject id 
  3. The features.txt is used to name the variables of interest. The script then extracts only the measurements on the mean and standard deviation for each measurement (using these names to filter). 
  4. The activity_labels.txt file is used to enumerate the Activity coding used in the main dataset into strings that can be more easily digested by the human eye. 
  5. More appropriate variable names are slowly built up with a number of gsub commands that were applied iteratively on the data until I was happy with the naming. 
  6. The data that was created is used to create a new independent tidy data set with the average of each variable for each activity and each subject. the data tables group by functionality is used here to achieve the grouping and averaging.
  
  The tidy data set is available in this repository labelled tidy_data.txt.
  
  Run the script and then use the following to view the data:
      data <- read.table(datafile, header = TRUE) # where datafile is the path to the file
      View(data)
