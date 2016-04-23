==================================================================
Sara Hudanich
Getting & Cleaning Data Course Project
Johns Hopkins University (via Coursera)
==================================================================
References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

[2] https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
==================================================================
Source Data

A full description of the data used in this project can be found at The UCI Machine Learning Repository
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The source data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
==================================================================
Study Design (Anguita et al, README.txt)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' from the source data for more details. 
==================================================================
For each record in source data it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
=========================================
The relevant source data includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

Notes: 
======
- For the purpose of this project the contents in the Inertial Signals folders will not be used
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
==================================================================
Instructions for getting and cleaning source data.

## Part 1 - Merge the training and the test sets to create one data set

1. Download source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Clean up work space

3. Set working directory to where UCI HAR dataset was unzipped

4.Read in data in training files (./UCI HAR Data/train/..)
- Read in /features_info.txt and save as features (dim = 561, 1)
- Read in /activity_labels.txt and save as activityType (dim = 6, 2)
- Read in /train/X_train.txt and save as trainingSet (dim = 7352 rows, 561 col)
- Read in /train/y_train.txt and save as trainingLabels (dim = 7352 rows, 1 col)
- Read in /train/subject_train.txt and save as subjectTrain (dim = 7352, 1)
*Header should = FALSE on all of these to indicate there is no header

5. Assign column names for each of the variables in these files
- Name the columns of activityType "activityId" and "activityType" respectively
- Name the column of subjectTrain "subjectId"
- Name the columns of trainingSet as all of the contents of the second column in the features dataset
- Name the column of trainingLabels "activityId"
Note: since the content of trainingLabels (/train/y_train.txt) are the numeric values of activityType (/activity_labels.txt), they will share the column name "activityId"

6. Use cbind() to merge trainingLabels, subjectTrain and trainingSet into a final train file, labeled trainingAll (dim = 7352, 563)
Note: it's important to maintain the order as seen above when executing cbind()

7. Read in data in test files (./UCI HAR Data/test)
- Read in /test/subject_test.txt and save as subjectTest (dim = 2947, 1)
- Read in /test/X_test.txt and save as testSet (dim = 2947, 561)
- Read in /test/y_test.txt and save as testLabels (dim = 2947, 1)

8. Assign column names for each of the variables in subjectTest, testSet, and testLabels
- Name the column of subjectTest "subjectId"
- Name the columns of testSet as all of the contents of the second column in the features dataset
- Name the column of testLabels as "activityId"
Note: now all of these variables (column names) are similar to all of those in "trainingAll"

9. Use cbind() to merge testLabels, subjectTest, and testSet into a total test dataset called testAll (dim = 2947, 563)
Note: our two datasets trainingAll and testAll both now have 563 columns and share variable names

10. Finally, use rbind() to combine trainingAll and testAll datasets into our total dataset (called totalData (dim = 10299, 26))


## Part 2 - Extract the mean and standard deviations for each measurement:

1. Create a vector named "colNames"" consisting of all the column names in totalData

2. Create a logical vector named "logical" that will return TRUE values for ONLY the ID, mean(), and stddev() columns in totalData
Note: grepl() goes through colNames and returns TRUE for the colNames specified

3. Using the logical vector, subset totalData to keep only the columns Id, mean() and stddev() columns.

## Part 3 - Use descriptive activity names to name the activities in the data set:

1. Merge the activityType table with the totalData table by the shared variable 'activityId'. This will add a new variable 'activityType' that contains the second variable from the activityType table (also named activityType) and includes the descriptive activity names

2. Update the colNames vector so that it uses the new column names 


## Part 4 - Appropriately label the data set with descriptive variable names

1. First, use gsub() and metacharacters to fix the variable names
Note: in tidy data, variable names should be human readable, with no dots, underscores, or spaces, so we get rid of those
by subsituting those features in the current variable names with nothing so that they are eliminated.
Note: putting this process in a for loop is much quicker than assigning each variable one by one, considering the large number of variables to be updated here

2. Once again, update the colNames vector so that it uses the new descriptive variable names


## Part 5 - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

1. Create a new table called finalData which includes all column names of totalData except 'activityType'

2. Create a new table called finalDataTidy which summarizes finalData and includes only the mean of each variable for each activity and each subject
using the aggregate() function.

3. Merge finalDataTidy and the activityType table to include the activity names. Save as finalDataTidy

4. Export finalDataTidy data set to a .txt file
==================================================================
Code book

About the data:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

activityId 
- a numeric value 1-6 originally assigned to the values in variable activityType dataset; derived from contents of the training labels and test activity labels in the
original "/test/y_test.txt" and "/training/y_train.txt" files
-Values:
  1 WALKING
  2 WALKING_UPSTAIRS
  3 WALKING_DOWNSTAIRS
  4 SITTING
  5 STANDING
  6 LAYING

subjectId
- Originally derived from "/train/subject_train.txt"
- Identifies the subject who performed the activity for each window sample
- Numeric values 1-30 representing participants respectively

activityType
- Determines what activity was being performed by each participant while signals were being recorded
- Values:
  WALKING
  WALKING_UPSTAIRS
  WALKING_DOWNSTAIRS
  SITTING
  STANDING
  LAYING
==================================================================
Note: all variables below are derived from time domain triaxial signals at a constant rate of 50 Hz in the X, Y, and Z directions:

timeBodyAccMagnitudeMean
- The average of the magnitude of triaxial linear body acceleration signals

timeBodyAccMagnitudeStdDev
- The standard deviation of the magnitude of triaxial linear body acceleration signals

timeGravityAccMagnitudeMean
- The average of the magnitude of gravity acceleration signals

timeGravityAccMagnitudeStdDev
- The standard deviation of the magnitude of triaxial gravity acceleration signals

timeBodyAccJerkMagnitudeMean
- The average magnitude of three-dimensional body jerk signals derived from triaxial linear body acceleration signals

timeBodyAccJerkMagnitudeStdDev
- The standard deviation of three-dimensional body jerk signals derived from triaxial linear body acceleration signals

timeBodyGyroMagnitudeMean
- The average magnitude of triaxial body angular velocity signals

timeBodyGyroMagnitudeStdDev
- The standard deviation of the magnitude of triaxial body angular velocity signals

timeBodyGyroJerkMagnitudeMean
- The average of the magnitude of body jerk signals obtained by triaxial body angular velocity signals

timeBodyAccJerkMagnitudeStdDev
- The standard deviation of the magnitude of body jerk signals obtained by triaxial body linear acceleration signals
==================================================================
Note: the variables below indicate frequency domain signals, obtained by applying a Fast Fourier Transform (FFT) to some of the signals indicated in the variables above

freqBodyAccMagnitudeMean
- The average of the magnitude of triaxial linear body acceleration signals

freqBodyAccMagnitudeStdDev
- The standard deviation of the magnitude of triaxial linear body acceleration signals

freqBodyAccJerkMagnitudeMean
- The average of the magnitude of jerk signals derived from triaxial linear body acceleration signals

freqBodyAccJerkMagnitudeStdDev
- The standard deviation of the magnitude of jerk signals derived from triaxial linear body acceleration signals

freqBodyGyroMagnitudeMean
- The average of the magnitude of triaxial body angular velocity signals

freqBodyGyroMagnitudeStdDev
- The standard deviation of the magnitude of triaxial body angular velocity signals

freqBodyGyroJerkMagnitudeMean
- The average of the magnitude of jerk signals derived from body angular velocity signals

freqBodyGyroJerkMagnitudeStdDev
- The standard deviation of the magnitude of jerk signals derived from body angular velocity signals


