# wearableComputing
tidy data as per the ReadMe that can be read into R with read.table('./finalDataTidy.txt', header = TRUE)
==================================================================
README.md markdown document - explains the contents submitted with this project
==================================================================
run_analysis.R Rscript:

- contains the R code that will create a tidy data set from the source data downloaded at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- Follows the instructions below to create a tidy data set:
   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement.
   3. Uses descriptive activity names to name the activities in the data set
   4. Appropriately labels the data set with descriptive variable names.
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
==================================================================
CodeBook.md markdown document:
- contains citations
- describes the source data and study design
- explains the transformations performed in the Rscript to clean up the source data
- explains the variables in the tidy data set (finalDataTidy)
==================================================================
finalDataTidy.txt - text file containing the tidy data set
==================================================================
