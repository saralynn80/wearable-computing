## Clean up workspace
rm(list=ls())

## Set working directory to where UCI HAR dataset was unzipped
setwd('~/Desktop/Coursera/')

# 1. Merge the training and the test sets to create one data set.

## Read in all data from txt files

features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
activityType <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainingSet <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainingLabels <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

## Assign column names to the imported data
colnames(activityType) = c('activityId', 'activityType');
colnames(subjectTrain) = "subjectId";
colnames(trainingSet) = features[,2];
colnames(trainingLabels) = "activityId";

## Column bind trainingSet, trainingLabels, and subjectTrain to create the total training dataset.
trainingAll <- cbind(trainingLabels, subjectTrain, trainingSet)

## Read in data from test files
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

## Assign column names to subjectTest, testSet and testLabels
colnames(subjectTest) = "subjectId";
colnames(testSet) = features[,2];
colnames(testLabels) = "activityId";

## Column bind to merge subjectTest, testSet and testLabels and create the total test dataset
testAll <- cbind(testLabels, subjectTest, testSet)

## Create the final dataset by combining trainingAll and testAll datasets via rbind
totalData <- rbind(trainingAll, testAll)
totalData

## 2. Extract only the measurements on the mean and standard deviation for each measurement

# Create a vector of the column names of the totalData set
colNames <- colnames(totalData)

# Create a logical vector that contains TRUE values for the ID, mean(), and stddev() columns only
logical <- (grepl("activity..", colNames) | grepl("subject..", colNames) | grepl("-mean..", colNames) 
            & !grepl("-meanFreq..", colNames) & !grepl("mean..-", colNames) | grepl("-std..", colNames)
            & !grepl("-std()..-", colNames))

#Subset to keep the desired columns
totalData <- totalData[logical==TRUE]

# 3. Use descriptive activity names to name the activities in the data set

# Merge the activityType table with the totalData table
totalData <- merge(totalData, activityType, by = 'activityId',  all.x = TRUE)

# Update the colNames vector so that it uses the new column names
colNames <- colnames(totalData)

# 4. Appropriately label the data set with descriptive variable names

# First, use gsub()  and metacharacters to fix the variable names
for (i in 1:length(colNames)) {
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

# Reassign new descriptive column names to the totalData set
colnames(totalData) <- colNames

# 5. From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# Ignore the activityType column and create a new table called finalData
finalData <- totalData[,names(totalData) != 'activityType']

# Summarize finalData including only the mean of each variable for each activity and each subject
finalDataTidy <- aggregate(finalData[,names(finalData) != c('activityId', 'subjectId')], 
                           by = list(activityId = finalData$activityId,
                                     subjectId = finalData$subjectId), mean)

# Include the activity names by merging finalDataTidy and the activityType table
finalDataTidy <- merge(finalDataTidy, activityType, by = 'activityId', all.x = TRUE)

# Export finalDataTidy data set to a .txt file
write.table(finalDataTidy, './finalDataTidy.txt', row.names = TRUE, sep = '/t')

# Read finalDataTidy into R
read.table('./finalDataTidy.txt', header = TRUE)