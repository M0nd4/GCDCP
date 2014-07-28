Codebook
========
The script performs the following steps to clean the data:

1. Read X_train.txt, y_train.txt, subject_train.txt from "./data/train" and safe in "trainX", "trainY" and "trainSubject" respectively.
2. Read X_test.txt, y_test.txt, subject_test.txt from "./data/test" and safe in "testData", "testLabel" and "testsubject" respectively.
3. Concatenate testData and trainData to generate a 10299x561 data frame "Data"; do the same with testLabel and trainLabel to generate a 10299x1 data frame "Label"; join testSubject to trainSubject to generate a 10299x1 data frame "Subject".
4. Read features.txt from "/data" and safe in "features". Extract the measurements on the mean and standard deviation. Finaly we obtain a 66 indices list. We get a subset of Data with 66 columns.
5. Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
6. Read activity_labels.txt  from  "./data"" and in "activity".
7. Clean the activity names in the second column of activity. We first make all names to lower cases. If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore.
8. Transform the values of Label according to the activity data frame.
9. Combine the Subject, Label and Data by column to get a new cleaned 10299x68 data frame "rawData". Properly name the first two columns, "Subject" and "Activity". The Subject column contains integers that range from 1 to 30 inclusive; the Activity column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.
10. Write the rawData out to "rawdata.txt" file in current working directory.
11. Generate a second independent tidy data set with the average of each measurement for each activity and each subject. 
 We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. For each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the result data frame and performing the two for-loops, we get a 180x68 data frame.
Write the result out to "tidydata.txt" file in current working directory.



#### Data Dictionary - Human Activity Recognition Using Smartphones Data Set

- Activity

        The activity was performed while wearing a smartphone
                1 walking
                2 walking_upstairs
                3 walking_downstairs
                4 sitting
                5 standing
                6 laying

-  Subject

        An identifier of the subject who carried out the experiment
                1 .. 30


**time domain signals denoted by prefix 't'**

- tBodyAcc_XYZ

        body acceleration signals (3-axial)

- tGravityAcc_XYZ

        gravity acceleration signals (3-axial)

- tBodyAccJerk_XYZ

        Jerk signals derived from body linear acceleration (3-axial)

- tBodyGyro_XYZ

        gyroscope signals (3-axial)

- tBodyGyroJerk_XYZ

        Jerk signals derived from angular velocity (3-axial)

- tBodyAccMag

        Euclidean norm of body acceleration signals

- tGravityAccMag

        Euclidean norm of gravity acceleration signals

- tBodyAccJerkMag

        Euclidean norm of Jerk signals derived from body linear acceleration

- tBodyGyroMag

        Euclidean norm of gyroscope signals

- tBodyGyroJerkMag

        Euclidean norm of Jerk signals derived from angular velocity


**frequency domain signals denoted by prefix 'f'**

- fBodyAcc_XYZ

        FFT of body acceleration signals (3-axial)

- fBodyAccJerk_XYZ

        FFT of Jerk signals derived from body linear acceleration (3-axial)

- fBodyGyro_XYZ

        FFT of gyroscope signals (3-axial)

- fBodyAccMag

        FFT of Euclidean norm of body acceleration signals

- fBodyAccJerkMag

        FFT of Euclidean norm of Jerk signals derived from body linear acceleration

- fBodyGyroMag

        FFT of Euclidean norm of gyroscope signals

- fBodyGyroJerkMag

        FFT of Euclidean norm of Jerk signals derived from angular velocity


**The set of variables that were estimated from these signals**

- Mean

        Mean value

- Std

        Standard deviation


