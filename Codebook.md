# Codebook for the Human Activity Recognition Tidy Dataset 

## Introduction:

Codebook for the tidy dataset created from Human Activity Recognition raw dataset for the __JHU/Coursera Getting & Cleaning data__ course project. This document includes the processing of the raw data and its transformation into the tidy dataset. This document also presents the data dictionary for the tidy (processed) dataset.

## Transformation:

The following are the high level steps performed by the R script to process the raw dataset into the transformed (tidy) form:

1. Downloads the zipped raw dataset
1. Extracts the zipped dataset into a folder
1. Loads the features dataset, this corresponds to the data columns for the training and test datasets
1. Extracts only those features (and the correponding column-ids) that are for mean and standard deviation. These extracted features are the relevant columns from training and test datasets that will be kept in the tidy dataset. As per the documentation for the raw dataset (features_info.txt), the following functions are concerned with mean and standard deviation and therefore only those features (columns) are extracted for later steps:
   + mean(): Mean value
   + std(): Standard deviation
   + meanFreq(): Weighted average of the frequency components to obtain a mean frequency
1. Scrubs the feature names extracted in the above step (to be used as column names later) as follows:
   + Feature names start with t (for Time) and f (for Frequency). These mnemonic are spelled out in the scrubbed column name.
   + Features that end wth X, Y, or Z are measurement on the X, Y and Z axis respectively. As such, this is spelled out as "onXAxis" and so on.
   + Some of the feature names have a type, where the word "body" is repeated. The repeated "body" word is removed.
   + The rest of the feature name which indicates the actual feature in the feature name (such as bodyacc, gravityacc, bodyaccjerk, bodygyrojerk, etc.) have been retained as is rather than expanding this text and further bloating the column name into a mess of unreadable text. This part of the feature name is desciptive and have been clarified in the data dictionary below.
   + Each feature name is prepended with the word "average" as the tidy dataset will be the average (using the mean function) value for each measurement for each activity and each subject.
   + Case of the feature names are than converted to lower-case as instructed by prof. Jeff Leek in week 4 lectures!!
1. Loads the training dataset, subsetting to keep only those columns (variables) that were extracted in the previous step(s)
1. Assigns column names to the training dataset using the scrubbed feature names from the above steps
1. Loads the training activity ids and column-binds to the training dataset
1. Loads the training subject ids and column-binds to the training dataset
1. Loads the test dataset, subsetting to keep only those columns (variables) that were extracted few steps above
1. Assigns column names to the test dataset using the scrubbed feature names from the above steps
1. Loads the test activity ids and column-binds to the test dataset
1. Loads the test subject ids and column-binds to the test dataset
1. Combines the training and test dataset into one dataset by row-binding the two datasets
1. Aggregates the merged dataset so that each variable measurement is averaged (using the mean function) for each activity and each subject
1. Replaces the activity id in the aggregated dataset with the more descriptive activity labels
1. Outputs the tidy dataset to a file


## Data Dictionary:

This section presents the data dictionary for the tidy dataset.

#### NOTE on UNITS:
The variables in the raw dataset are normalized and bound to -1 and 1 (as per the documentation for the raw dataset) - which means the variable data is divided by its range and therefore the normalized data has no units.

#### NOTE on COLUMN NAMES:
Column names are scrubbed feature names that have been processed to be more descriptive (verbose) as per the steps outlined in the **Transformation** section above.

**activityname**: Activity Name

+ __Type:__ Factor (Character)
+ __Levels:__ WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING
 
**subjectid**: Identifier for the Subject

+ __Type:__ Integer
+ __Range:__ 1..30
 
**averagetimebodyaccmeanonxaxis**: Average time measurement of body acceleration mean on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1
 
**averagetimebodyaccmeanonyaxis**: Average time measurement of body acceleration mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1
 
**averagetimebodyaccmeanonzaxis**: Average time measurement of body acceleration mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccstdonxaxis**: Average time measurement of body acceleration standard deviation on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccstdonyaxis**: Average time measurement of body acceleration standard deviation on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccstdonzaxis**: Average time measurement of body acceleration standard deviation on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimegravityaccmeanonxaxis**: Average time measurement of gravity acceleration mean on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimegravityaccmeanonyaxis**: Average time measurement of gravity acceleration mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimegravityaccmeanonzaxis**: Average time measurement of gravity acceleration mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimegravityaccstdonxaxis**: Average time measurement of body acceleration standard deviation on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimegravityaccstdonyaxis**: Average time measurement of body acceleration standard deviation on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimegravityaccstdonzaxis**: Average time measurement of body acceleration standard deviation on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccjerkmeanonxaxis**: Average time measurement of body acceleration jerk mean on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccjerkmeanonyaxis**: Average time measurement of body acceleration jerk mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccjerkmeanonzaxis**: Average time measurement of body acceleration jerk mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccjerkstdonxaxis**: Average time measurement of body acceleration jerk standard deviation on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccjerkstdonyaxis**: Average time measurement of body acceleration jerk standard deviation on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccjerkstdonzaxis**: Average time measurement of body acceleration jerk standard deviation on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyromeanonxaxis**: Average time measurement of body gyroscope mean on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyromeanonyaxis**: Average time measurement of body gyroscope mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyromeanonzaxis**: Average time measurement of body gyroscope mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrostdonxaxis**: Average time measurement of body gyroscope standard deviation on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrostdonyaxis**: Average time measurement of body gyroscope standard deviation mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrostdonzaxis**: Average time measurement of body gyroscope standard deviation mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrojerkmeanonxaxis**: Average time measurement of body gyroscope jerk mean on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrojerkmeanonyaxis**: Average time measurement of body gyroscope jerk mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrojerkmeanonzaxis**: Average time measurement of body gyroscope jerk mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrojerkstdonxaxis**: Average time measurement of body gyroscope jerk standard deviation on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrojerkstdonyaxis**: Average time measurement of body gyroscope jerk standard deviation on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrojerkstdonzaxis**: Average time measurement of body gyroscope jerk standard deviation on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccmagmean**: Average time measurement of body acceleration magnitude mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccmagstd**: Average time measurement of body acceleration magnitude standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimegravityaccmagmean**: Average time measurement of gravity acceleration magnitude mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimegravityaccmagstd**: Average time measurement of gravity acceleration magnitude standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccjerkmagmean**: Average time measurement of body acceleration jerk magnitude mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodyaccjerkmagstd**: Average time measurement of body acceleration jerk magnitude standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyromagmean**: Average time measurement of body gyroscope magnitude mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyromagstd**: Average time measurement of body gyroscope magnitude standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrojerkmagmean**: Average time measurement of body gyroscope jerk magnitude mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagetimebodygyrojerkmagstd**: Average time measurement of body gyroscope jerk magnitude standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccmeanonxaxis**: Average frequency measurement of body acceleration mean on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1
 
**averagefrequencybodyaccmeanonyaxis**: Average frequency measurement of body acceleration mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1
 
**averagefrequencybodyaccmeanonzaxis**: Average frequency measurement of body acceleration mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1
 
**averagefrequencybodyaccstdonxaxis**: Average frequency measurement of body acceleration standard deviation on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccstdonyaxis**: Average frequency measurement of body acceleration standard deviation on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccstdonzaxis**: Average frequency measurement of body acceleration standard deviation on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccmeanfreqonxaxis**: Average frequency measurement of body acceleration mean frequency on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccmeanfreqonyaxis**: Average frequency measurement of body acceleration mean frequency on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccmeanfreqonzaxis**: Average frequency measurement of body acceleration mean frequency on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmeanonxaxis**: Average frequency measurement of body acceleration jerk mean on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmeanonyaxis**: Average frequency measurement of body acceleration jerk mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmeanonzaxis**: Average frequency measurement of body acceleration jerk mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkstdonxaxis**: Average frequency measurement of body acceleration jerk standard deviation on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkstdonyaxis**: Average frequency measurement of body acceleration jerk standard deviation on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkstdonzaxis**: Average frequency measurement of body acceleration jerk standard deviation on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmeanfreqonxaxis**: Average frequency measurement of body acceleration jerk mean frequency on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmeanfreqonyaxis**: Average frequency measurement of body acceleration jerk mean frequency on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmeanfreqonzaxis**: Average frequency measurement of body acceleration jerk mean frequency on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromeanonxaxis**: Average frequency measurement of body gyroscope mean on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromeanonyaxis**: Average frequency measurement of body gyroscope mean on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromeanonzaxis**: Average frequency measurement of body gyroscope mean on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyrostdonxaxis**: Average frequency measurement of body gyroscope standard deviation on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyrostdonyaxis**: Average frequency measurement of body gyroscope standard deviation on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyrostdonzaxis**: Average frequency measurement of body gyroscope standard deviation on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromeanfreqonxaxis**: Average frequency measurement of body gyroscope mean frequency on X axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromeanfreqonyaxis**: Average frequency measurement of body gyroscope mean frequency on Y axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromeanfreqonzaxis**: Average frequency measurement of body gyroscope mean frequency on Z axis

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccmagmean**: Average frequency measurement of body acceleration magnitude mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccmagstd**: Average frequency measurement of body acceleration magnitude standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccmagmeanfreq**: Average frequency measurement of body acceleration magnitude mean frequency

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmagmean**: Average frequency measurement of body acceleration jerk magnitude mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmagstd**: Average frequency measurement of body acceleration jerk magnitude standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodyaccjerkmagmeanfreq**: Average frequency measurement of body acceleration jerk magnitude mean frequency

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromagmean**: Average frequency measurement of body gyroscope magnitude mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromagstd**: Average frequency measurement of body gyroscope magnitude standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyromagmeanfreq**: Average frequency measurement of body gyroscope magnitude mean frequency

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyrojerkmagmean**: Average frequency measurement of body gyroscope jerk mean

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyrojerkmagstd**: Average frequency measurement of body gyroscope jerk standard deviation

+ __Type:__ Numeric
+ __Range:__ -1..1

**averagefrequencybodygyrojerkmagmeanfreq**: Average frequency measurement of body gyroscope jerk mean frequency

+ __Type:__ Numeric
+ __Range:__ -1..1

