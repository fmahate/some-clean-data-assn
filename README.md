# Human Activity Recognition Tidy Dataset

### Overview:

This project is an assignment for the __JHU/Coursera Getting & Cleaning data__ course transforming Human Activity Recognition raw dataset into tidy dataset with specific requirements to aggregate values for each measurement for each activity and each subject. The tidy dataset is narrow in scope compared to the original raw dataset as only measurements on the mean and the standard deviation are considered and included in the tidy dataset.

### Project Component(s):

The project consists of one R script: 

    run_analysis.R

All the processing is contained in one script. This script downloads the raw dataset, processes, and finally writes the tidy dataset to a file. Please refer to the __Codebook.md__ document for detailed description of all processing steps to transform the raw dataset to the tidy dataset. The __Codebook.md__ document also includes the data dictionary for the tidy dataset.

**Processing Steps (Copied from Codebook.md)** - in case reviewer missed the comment above!!!!

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


### Execution:

To perform the transformation and generate the tidy dataset, execute the following steps in R environment (R Studio or R Console):

1. Source the script
1. Execute the main() function as show below:

        main()

The tidy dataset will be output to data/tidy-uci-dataset/tidydataset.txt text file relative to the current working directory in the R environment. The text file output is space-delimited with column headers included in the file.

