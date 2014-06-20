################################################################################
################################################################################
## Filename:    run_analysis.R
## Author:      Hidden for grading purpose
## Desc:        Assignment for "Cleaning and Getting Data" course
## Date:        June 15, 2014
################################################################################
################################################################################

## Imports
library(reshape2)
library(data.table)


################################################################################
## Desc:    Download and extract (unzip) raw data
## Returns: The extracted folder path
################################################################################
downloadAndExtractRawData <- function(filenameWOExt,
                                      pkgFileExt,
                                      extractedFolderPattern,
                                      dataDir="./data") {
  
  # Create data dir:
  if(!file.exists(dataDir)) {dir.create(dataDir)}
  
  # Download raw data package:
  localFilePkgPath <- paste0(dataDir, "/", filenameWOExt, ".", pkgFileExt)
  if(!file.exists(localFilePkgPath)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, localFilePkgPath, mode="wb")
    dateDownloaded <- date()
    message(paste("Date Downloaded:",dateDownloaded))
  }
  
  # Extract raw data package:
  # suppress warning which are generated when files (if exist) are not overwritten!
  suppressWarnings(unzip(localFilePkgPath, overwrite=FALSE, exdir=dataDir, setTimes=TRUE))
  
  # Verify and return the extracted package folder name
  extractedPkgFolderPath <- list.files(dataDir, full.names=TRUE, pattern=extractedFolderPattern)
  if(length(extractedPkgFolderPath) != 1) {
    message("Error trying to unzip and locating the uncompressed folder from the following:")
    print(extractedPkgFolderPath)
    stop("Error trying to unzip and locating the uncompressed folder!")
  }
  extractedPkgFolderPath
}

################################################################################
## Desc:    Writes the data to the specified file.
################################################################################
writeTidyData <- function(data,
                          outputDir="./data/tidy-uci-dataset",
                          filenameWithExt="tidydataset.txt" ) {
  
  # Create output dir
  if(!file.exists(outputDir)) {dir.create(outputDir)}
  
  # Backup the output file (if it exists):
  localFilename <- paste0(outputDir, "/", filenameWithExt)
  if (file.exists(localFilename)) {
    file.copy(localFilename, paste0(outputDir, "/", "Copy of ", filenameWithExt), overwrite=TRUE)
    file.remove(localFilename)
  }
  
  # Write the data to the specified file
  write.table(data, file=localFilename, row.names=FALSE)
}

################################################################################
## Desc:    Load, filter, and scrub features data (columns for the main dataset)
## Returns: The filtered/scrubbed main dataset columns in a data.frame 
##          with "columnNumber" and "columnName" cols.
################################################################################
loadFeaturesDS <- function(
  dir,
  filename = "features.txt", 
  colFilterPattern = 
    "-([Mm][Ee][Aa][Nn]|[Mm][Ee][Aa][Nn][Ff][Rr][Ee][Qq]|[Ss][Tt][Dd])\\(\\)(-*)", 
  colSubsPatternAndReplacement = data.frame(
    pattern =
      c("(^t)([a-zA-Z]+)-([Mm][Ee][Aa][Nn]|[Mm][Ee][Aa][Nn][Ff][Rr][Ee][Qq]|[Ss][Tt][Dd])\\(\\)-([Xx]|[Yy]|[Zz])", 
        "(^t)([a-zA-Z]+)-([Mm][Ee][Aa][Nn]|[Mm][Ee][Aa][Nn][Ff][Rr][Ee][Qq]|[Ss][Tt][Dd])\\(\\)", 
        "(^f)([a-zA-Z]+)-([Mm][Ee][Aa][Nn]|[Mm][Ee][Aa][Nn][Ff][Rr][Ee][Qq]|[Ss][Tt][Dd])\\(\\)-([Xx]|[Yy]|[Zz])", 
        "(^f)([a-zA-Z]+)-([Mm][Ee][Aa][Nn]|[Mm][Ee][Aa][Nn][Ff][Rr][Ee][Qq]|[Ss][Tt][Dd])\\(\\)",
        "(^.+?)([Bb][Oo][Dd][Yy][Bb][Oo][Dd][Yy])(.*$)"), 
    replacement =
      c("AverageTime\\2\\3On\\4Axis", 
        "AverageTime\\2\\3", 
        "AverageFrequency\\2\\3On\\4Axis", 
        "AverageFrequency\\2\\3",
        "\\1body\\3"))) {
  
  filepath <- paste0(dir, "/", filename)
  
  # Load the features data (column number and names for the main dataset)
  dataColumns <- read.table(filepath, stringsAsFactors=FALSE,
                            col.names=c("columnNumber", "columnName"),
                            colClasses=c("integer", "character"))
  
  # Filter columns using the given pattern
  dataColumns <- dataColumns[grep(colFilterPattern, dataColumns$columnName),]
  
  # Scrub column names
  for(i in 1:nrow(colSubsPatternAndReplacement)) {
    dataColumns$columnName <- 
      gsub(colSubsPatternAndReplacement$pattern[i], colSubsPatternAndReplacement$replacement[i],
           dataColumns$columnName)
  }
  
  dataColumns
}

################################################################################
## Desc:    Load the data column names
## Returns: The data columns data.frame containing "columnNumber" and "columnName"
################################################################################
loadDataColumnNames <- function(dir) {
  # Generate filename:
  colNameFilePath <- paste0(dir, "/features.txt")
  
  # Load the data column names
  dataColumns <- read.table(colNameFilePath, stringsAsFactors=FALSE,
                            col.names=c("columnNumber", "columnName"),
                            colClasses=c("integer", "character"))
  
  # Clean-up the column-names
  dataColumns$columnName <- lapply(dataColumns$columnName, FUN=function(X){gsub("-mean\\(\\)-", "Mean", X)} )
  dataColumns$columnName <- lapply(dataColumns$columnName, FUN=function(X){gsub("-std\\(\\)-", "StdDev", X)} )
  
  dataColumns
}

################################################################################
## Desc:    Load the activity names
## Returns: The activity data.frame containing "activityID" and "activityName"
################################################################################
loadActivityNames <- function(dir) {
  # Generate filename:
  activityLabelsFilePath <- paste0(dir, "/activity_labels.txt")
  
  # Load the data column names
  activityNames <- read.table(activityLabelsFilePath, stringsAsFactors=FALSE,
                            col.names=c("activityID", "activityName"),
                            colClasses=c("integer", "character"))
  
  activityNames
}


################################################################################
## Desc:    Load the raw data set (training or test)
## Returns: The loaded raw data set (data.frame)
################################################################################
loadDataset <- function(dir, setname, dataColumns) {
  # Generate filenames:
  fileExtension <- ".txt"
  dataFilePath <- paste0(dir, "/", setname, "/X_", setname, fileExtension)
  activityFilePath <- paste0(dir, "/", setname, "/y_", setname, fileExtension)
  subjectFilePath <- paste0(dir, "/", setname, "/subject_", setname, fileExtension)
  
  # Load the dataset
  mainData <- read.table(dataFilePath, stringsAsFactors=FALSE)
  
  # Keep relevant cols only and assign col-names
  mainData <- mainData[, dataColumns$columnNumber]
  colnames(mainData) <- dataColumns$columnName
  
  # Load the subject data and add as column to the dataset
  subjectData <- read.table(subjectFilePath, stringsAsFactors=FALSE, col.names=c("subjectID"))
  mainData$subjectID <- subjectData$subjectID
  
  # Load the activity data and add as column to the dataset
  activityData <- read.table(activityFilePath, stringsAsFactors=FALSE, col.names=c("activityID"))
  mainData$activityID <- activityData$activityID
  
  mainData
}

################################################################################
## Desc:    Aggregates each variable column for each activity and each subject.
## Returns: The aggregated dataset
################################################################################
aggregateVariablesCols <- function(data, 
                                   keyCols=c("activityID", "subjectID"), 
                                   eq=(activityID + subjectID ~ variable), 
                                   fn=mean) {
  
  # Convert data into tall/skinny using melt to convert variable columns into 
  # variable key-value pair
  ## Retains keyCols as id cols
  ## Remaining cols are converted into variable key-value pair
  allCols <- colnames(data)
  varCols <- setdiff(allCols, keyCols)
  meltData <- melt(data, id=keyCols, measure.vars=varCols)
  
  # Re-format the tall/skinny data back to wider format and
  # aggregate at the same time using the specified function
  aggregatedData <- dcast(meltData, formula=eq, fun.aggregate=fn)
  
  aggregatedData
}


################################################################################
## Desc:    Adds a column: "activityName" that is descriptive activity name
##          for each corresponding "activityID" and then deletes the 
##          "activityID" column.
## Returns: The dataset (data.table) with activity-names replacing activity-Id
################################################################################
addActivityNameToDataset <- function(x, y) {
  
  # Convert data.frames to data.tables to merge the two datasets using
  # the key of "activityID"
  DT1 <- data.table(x)
  setkey(DT1, activityID)
  
  DT2 <- data.table(y)
  setkey(DT2, activityID)
  
  DT <- merge(DT1, DT2)
  
  # Remove "activityID" column from the merged data.table
  DT[,activityID:=NULL]
}

################################################################################
## Desc:    Main function:
##          It performs all the tasks of the assignment producing a tidy dataset.
##          It starts with downloading and extracting the raw dataset to 
##          processing the raw data (as per the given requirements) into a tidy
##          dataset.
## Returns: The tidy dataset (data.table)
################################################################################
main <- function() {
  ## Constants
  dataDir <- "./data"
  filenameWOExt <- "UCI-HAR-Dataset"
  pkgFileExt <- "zip"
  extractedFolderPattern <- "(^UCI)(.*)(Dataset$)"
  
  # Download and extract (unzip) raw data
  extractedPkgDir <- downloadAndExtractRawData(filenameWOExt, pkgFileExt, extractedFolderPattern, dataDir)
  
  # Load the feature dataset (which actually is the data column names)
  dataColumns <- loadFeaturesDS(extractedPkgDir)
  
  # Load the activity names dataset
  activityNames <- loadActivityNames(extractedPkgDir)
  
  # Load the raw data set - training and test
  # Merge the training and test sets into one dataset
  trainingDataset <- loadDataset(extractedPkgDir, "train", dataColumns)
  testDataset <- loadDataset(extractedPkgDir, "test", dataColumns)
  mergedDataset <- rbind(trainingDataset, testDataset)
  
  # Generate the aggregated dataset with the average of each variable for each activity and each subject
  averagedDataset <- aggregateVariablesCols(mergedDataset)
  
  # Replace activity-Id with the descriptive activity-name
  dataset <- addActivityNameToDataset(activityNames, averagedDataset)
  
  # Convert column names to lower-case: Prof Jeff Leek prefers lower-case column names!!
  # On the other hand, I find it hard to read - therefore do it last after everything is working!!
  setnames(dataset, old=colnames(dataset), new=tolower(colnames(dataset)))
  
  # Output the tidy dataset to a file
  writeTidyData(dataset)
  
  dataset
}
