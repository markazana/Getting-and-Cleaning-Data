### Description
Additional information about the variables, data and transformations used in the course project  week-3 assignment "Getting and 
Cleaning Data" course.

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six 
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the 
waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant 
rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into
two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding
windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion 
components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to
have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was 
obtained by calculating variables from the time and frequency domain.

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###The Following are the Steps performed for creation of the R Script - run_analysis.R

##Step 1:
-> Downloading the Dataset.
-> Unzip dataSet to /Cleaning Data directory
-> Read in the data from files :
    - features.txt
    - activity_labels.txt
    - subject_train.txt
    - x_train.txt
    - y_train.txt
    - subject_test.txt
    - x_test.txt
    - y_test.txt
-> Assigning Column Names to the data from above files

##Step 2: Merge the training and the test sets to create one data set
-> First we merge the Test Folder files
-> Next we merge the Train Folder Files
-> Then we combine the both Test and Train merged data sets to form a new overall dataset which contains the data from both the above 
   said data
