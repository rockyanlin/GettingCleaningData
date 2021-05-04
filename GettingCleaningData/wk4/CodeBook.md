# Code Book
###### < This code book provides the details about the data identifiers, measurements, and overall contents output into tidy_dataset.txt >

## Data – Dissection 
The data set consists of the files described in detail below: 
- features_info.txt: Shows information about the variables used on the feature vector
- features.txt: List of all features
- activity_labels.txt: Links the class labels with their activity name
- train/X_train.txt: Training set
- train/y_train.txt: Training labels
- test/X_test.txt: Test set
- test/y_test.txt: Test labels
- train/subject_train.txt: Each row identifies the subject who performed the activity for each - window sample.
- train/Inertial Signals/total_acc_x_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units g. Every row shows a 128 element vector. !!And also the same description applies for the total_acc_y_train.txt and total_acc_z_train.txt files for the Y and Z axis.!!
- train/Inertial Signals/body_acc_x_train.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- train/Inertial Signals/body_gyro_x_train.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

## Processing and Variables
### Step-1: Merge training and test sets to create one data set
###### Read Activity and Feature Labels – variables
activity_labels = six activity codes and corresponding activity names
features = feature names for X_test, X_train subject_test = test set subject number, 1-30

###### Read Test data - variables
subject_test = test set subject number, 1-30
X_test = test set feature measurements
y_test = test set activity, coded 1-6
###### Read Train data - variables 
subject_train = train set subject number, 1-30
X_train = train set feature measurements
y_train = train set activity, coded 1-6
###### Combine subjects, activity labels, and features into test and train sets - variables
Xy_test = subject_test, y_test, X_test combined, by columns
Xy_train = subject_train, y_train, X_train combined, by columns
fullSet = test, train, combined by rows
###### Combine test and train sets into full data set - - variables
tidy_Dataset = data set with average of each variable, by activity, by subject

### Step-2: Extract only measurements on mean and standard deviation
A names variable (allNames) that included the subject, activity and all feature names was created. This variable was subsetted to include only the subject, activity, and variables that included mean and standard deviation (std). This subsetted names variable was then used to extract the corresponding columns in the full data set. The result was saved as the reducedSet.
allNames = set of names corresponding to fullSet, not yet applied
meanStdColumns = subject, activity, and all columns with mean or standard deviation
reducedSet = fullSet subsetted with meanStdColumns
reducedNames = allNames subsetted with meanStdColumns, renamed to R conventions;
applied to reducedSet

### Step-3: Use descriptive activities names for activity measurements
The coded values for activity were changed to the activity name. This change was accomplished by indexing the activity_labels variable.

### Step-4: Appropriately Label the Dataset with Descriptive Variable Names
The names allNames variable was subsetted in the same manner as the data. The resulting reducedNames variable was processed in a number of steps: capital letters were applied, punctuation was removed, abbreviations “t” and “f” were changed to time and frequency. Finally, theses modified names were applied to the reducedSet.

### Step-5: Create tidy data set with average of each variable, by activity, by subject
The reducedSet from the end of Step-4 was grouped by subject, then by activity, and summarized so that the observations in each row were the means of the variable columns, for that subject/activity. This was accomplished by applying the dply package verbs “group_by” and “summarise_each”. The resulting tidy data set was written to a file called “tidy_dataset.txt”.

The concluded activity - subject (in pairs) variables:
| "activity"                  |               "subject"       |
| --- | --- |
timeBodyAccMeanX_mean       |              timeBodyAccMeanY_mean                    
timeBodyAccMeanZ_mean      |               timeBodyAccStdX_mean                     
timeBodyAccStdY_mean    |                  timeBodyAccStdZ_mean                     
timeGravityAccMeanX_mean |                 timeGravityAccMeanY_mean                 
timeGravityAccMeanZ_mean  |                timeGravityAccStdX_mean                  
timeGravityAccStdY_mean    |               timeGravityAccStdZ_mean                  
timeBodyAccJerkMeanX_mean   |              timeBodyAccJerkMeanY_mean                
timeBodyAccJerkMeanZ_mean |                timeBodyAccJerkStdX_mean                 
timeBodyAccJerkStdY_mean  |                timeBodyAccJerkStdZ_mean                 
timeBodyGyroMeanX_mean    |                timeBodyGyroMeanY_mean                   
timeBodyGyroMeanZ_mean    |                timeBodyGyroStdX_mean                    
timeBodyGyroStdY_mean     |                timeBodyGyroStdZ_mean                    
timeBodyGyroJerkMeanX_mean |               timeBodyGyroJerkMeanY_mean               
timeBodyGyroJerkMeanZ_mean  |              timeBodyGyroJerkStdX_mean                
timeBodyGyroJerkStdY_mean   |              timeBodyGyroJerkStdZ_mean                
timeBodyAccMagMean_mean     |              timeBodyAccMagStd_mean                   
timeGravityAccMagMean_mean  |              timeGravityAccMagStd_mean                
timeBodyAccJerkMagMean_mean |              timeBodyAccJerkMagStd_mean               
timeBodyGyroMagMean_mean    |              timeBodyGyroMagStd_mean                  
timeBodyGyroJerkMagMean_mean |             timeBodyGyroJerkMagStd_mean              
frequencyBodyAccMeanX_mean   |             frequencyBodyAccMeanY_mean               
frequencyBodyAccMeanZ_mean  |              frequencyBodyAccStdX_mean                
frequencyBodyAccStdY_mean   |              frequencyBodyAccStdZ_mean                
frequencyBodyAccMeanFreqX_mean |           frequencyBodyAccMeanFreqY_mean           
frequencyBodyAccMeanFreqZ_mean  |          frequencyBodyAccJerkMeanX_mean           
frequencyBodyAccJerkMeanY_mean  |          frequencyBodyAccJerkMeanZ_mean           
frequencyBodyAccJerkStdX_mean   |          frequencyBodyAccJerkStdY_mean            
frequencyBodyAccJerkStdZ_mean   |          frequencyBodyAccJerkMeanFreqX_mean       
frequencyBodyAccJerkMeanFreqY_mean |       frequencyBodyAccJerkMeanFreqZ_mean       
frequencyBodyGyroMeanX_mean       |        frequencyBodyGyroMeanY_mean              
frequencyBodyGyroMeanZ_mean        |       frequencyBodyGyroStdX_mean               
frequencyBodyGyroStdY_mean          |      frequencyBodyGyroStdZ_mean               
frequencyBodyGyroMeanFreqX_mean |          frequencyBodyGyroMeanFreqY_mean          
frequencyBodyGyroMeanFreqZ_mean  |         frequencyBodyAccMagMean_mean             
frequencyBodyAccMagStd_mean       |        frequencyBodyAccMagMeanFreq_mean         
frequencyBodyBodyAccJerkMagMean_mean |     frequencyBodyBodyAccJerkMagStd_mean      
frequencyBodyBodyAccJerkMagMeanFreq_mean   frequencyBodyBodyGyroMagMean_mean        
frequencyBodyBodyGyroMagStd_mean      |    frequencyBodyBodyGyroMagMeanFreq_mean    
frequencyBodyBodyGyroJerkMagMean_mean  |   frequencyBodyBodyGyroJerkMagStd_mean     
frequencyBodyBodyGyroJerkMagMeanFreq_mean | angleTimeBodyAccMeanGravity_mean         
angleTimeBodyAccJerkMeanGravityMean_mean | angleTimeBodyGyroMeanGravityMean_mean    
angleTimeBodyGyroJerkMeanGravityMean_mean | angleXGravityMean_mean                   
angleYGravityMean_mean                   | angleZGravityMean_mean 
