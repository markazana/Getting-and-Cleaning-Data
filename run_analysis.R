##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Samarendra Pulicherla
## 2016-10-23

# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

# Clean up the environment workspace

rm(list = ls())


#Downloading the Dataset

if(!file.exists("./Cleaning Data")){dir.create("./Cleaning Data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Cleaning Data/Dataset.zip")


# Unzip dataSet to /Cleaning Data directory

unzip(zipfile="./Cleaning Data/Dataset.zip",exdir="./Cleaning Data")

#Loading the plyr package
library(plyr)


# Read in the data from files

features <- read.table('./Cleaning Data/UCI HAR Dataset/features.txt', header = FALSE)
activity <- read.table('./Cleaning Data/UCI HAR Dataset/activity_labels.txt', header = FALSE)

subjectTest <- read.table('./Cleaning Data/UCI HAR Dataset/test/subject_test.txt', header = FALSE)
xTest <- read.table('./Cleaning Data/UCI HAR Dataset/test/X_test.txt', header = FALSE)
yTest <- read.table('./Cleaning Data/UCI HAR Dataset/test/y_test.txt', header = FALSE)

subjectTrain <- read.table('./Cleaning Data/UCI HAR Dataset/train/subject_train.txt', header = FALSE)
xTrain <- read.table('./Cleaning Data/UCI HAR Dataset/train/X_train.txt', header = FALSE)
yTrain <- read.table('./Cleaning Data/UCI HAR Dataset/train/y_train.txt', header = FALSE)


#Assigning Column Names to the data from above files

colnames(features) <- c('featureId', 'feature_name')
colnames(activity) <- c('activityId', 'activity_name')

colnames(subjectTest) <- "subjectId" 
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"

colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityId"


# 1. Merge the training and the test sets to create one data set.

testData <- cbind(subjectTest, yTest, xTest)     #merging the test folder files
trainData <- cbind(subjectTrain, yTrain, xTrain) #merging the train folder files
merged_set_data <- rbind(trainData, testData)    #merging the overall Test and Train Files


# 2. Extract only the measurements on the mean and standard deviation for each measurement.

mean_std_values <- merged_set_data[,grepl("subject|activity|mean|std", names(merged_set_data))]   #Used grepl to extract the said columns


# 3. Use descriptive activity names to name the activities in the data set.

finalData <- merge(merged_set_data, activity, by='activityId',all.x=TRUE)   #Combine the Overall Test Data with respective Activity Names
finalData <- finalData[,c(2,1,564,3:563)]                                   #Arranging columns in the finalData Table to be readable


# 4. Appropriately label the data set with descriptive variable names.

colNames  <- colnames(finalData)             #Iterate along the column Names of the finalData to set Descriptive Variable Names
for (i in 1:length(colNames)) 
{
  colNames[i] <- gsub("\\()","",colNames[i])
  colNames[i] <- gsub("-std$","Standard_Deviation",colNames[i])
  colNames[i] <- gsub("-mean","Mean",colNames[i])
  colNames[i] <- gsub("^(t)","Time",colNames[i])
  colNames[i] <- gsub("^(f)","Frequency",colNames[i])
  colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] <- gsub("AccMag","Acc_Magnitude",colNames[i])
  colNames[i] <- gsub("([Bb]odyaccjerkmag)","Body_Acc_Jerk_Magnitude",colNames[i])
  colNames[i] <- gsub("JerkMag","Jerk_Magnitude",colNames[i])
  colNames[i] <- gsub("GyroMag","Gyro_Magnitude",colNames[i])
}

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_mean_data <- ddply(finalData, .(subjectId, activityId, activity_name), function(x) colMeans(x[, 4:564]))   #Use ddply function of plyr package to find column means

write.table(tidy_mean_data, './Cleaning Data/UCI HAR Dataset/tidyData.txt',row.names=FALSE,sep='\t')       #Export the tidy_mean_data to tidyData.txt



