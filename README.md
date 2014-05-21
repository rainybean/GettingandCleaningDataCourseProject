### Introduction

This script loads and cleans the data set Human Activity Recognition Using Smartphones, and it produces a text file of summary statistics from formatted tidy data set as the output.


### Step 1: Merges the training and the test sets to create one data set

specific tasks include

1.  loads activity_labels.txt
2.  loads features.txt
3.  loads subject_test.txt (subject id for test set data)
4.  loads y_test.txt (activity id for test set data)
5.  loads X_test.txt (test set data)
6.  assembles test set data frame
7.  loads y_test.txt (activity id for test set data)
8.  loads y_test.txt (activity id for test set data)
9.  loads subject_train.txt (subject id for training set data)
10.  loads y_train.txt (activity id for training set data)
11.  loads X_train.txt (training set data)
12.  assemble training set data frame
13.  merges training and test sets


### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement


### Step 3: Uses descriptive activity names to name the activities in the data set

specific tasks include

1.  adds activity labels


### Step 4: Appropriately labels the data set with descriptive activity names

1.  writes to file (first tidy output)


### Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject

specific tasks include

1.  loads training signal files
2.  loads test signal files
3.  assembles training set data frame
4.  assembles test set data frame
5.  merges taining and test data frames
6.  melts signal data
7.  aggregates by subject id and activity id
8.  gets activity labels and produce final output
9.  writes to file (second tidy output - means)



