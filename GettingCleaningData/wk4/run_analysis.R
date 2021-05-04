library(dplyr)
library(reshape)

# set my work directory
wkdir <- setwd("~/Coursera/JHU-DS/GettingCleaningData/wk4")

# file handling
file <- file.path("./", "uci-dataset.zip")
dataset_dir <- file.path("./" , "UCI HAR Dataset")

if (!file.exists(file)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, file, method = "curl")
}

# unzip, exdir UCI HAR Dataset
if (!file.exists(dataset_dir)){
  unzip(file) 
}

activity_data_labels <- read.table(paste(wkdir, "/UCI HAR Dataset/features.txt",sep=""))
features <- read.table(paste(wkdir, "/UCI HAR Dataset/features.txt",sep=""))

subject_test <- read.table(paste(wkdir, "/UCI HAR Dataset/test/subject_test.txt",sep=""))
X_test <- read.table(paste(wkdir, "/UCI HAR Dataset/test/X_test.txt",sep=""))
y_test <- read.table(paste(wkdir, "/UCI HAR Dataset/test/y_test.txt",sep=""))
subject_train <- read.table(paste(wkdir, "/UCI HAR Dataset/train/subject_train.txt",sep=""))

X_train <- read.table(paste(wkdir, "/UCI HAR Dataset/train/X_train.txt",sep=""))
y_train <- read.table(paste(wkdir, "/UCI HAR Dataset/train/y_train.txt",sep=""))

Xy_test  <- cbind(subject_test, y_test, X_test)
Xy_train <- cbind(subject_train, y_train, X_train)

fullSet <- rbind(Xy_test, Xy_train)

# Test the full data set
head(fullSet, 1)
nrow(fullSet)
ncol(fullSet)
names(fullSet)

allNames <- c("subject", "activity", as.character(features$V2))
meanStdColumns <- grep("subject|activity|[Mm]ean|std", allNames, value = FALSE)
reducedSet <- fullSet[ ,meanStdColumns]

names(activity_data_labels) <- c("activityNumber", "activityName")
reducedSet$V1.1 <- activity_data_labels$activityName[reducedSet$V1.1]

reducedNames <- allNames[meanStdColumns]    # Normalize names after subsetting
reducedNames <- gsub("mean", "Mean", reducedNames)
reducedNames <- gsub("std", "Std", reducedNames)
reducedNames <- gsub("gravity", "Gravity", reducedNames)
reducedNames <- gsub("[[:punct:]]", "", reducedNames)
reducedNames <- gsub("^t", "time", reducedNames)
reducedNames <- gsub("^f", "frequency", reducedNames)
reducedNames <- gsub("^anglet", "angleTime", reducedNames)
names(reducedSet) <- reducedNames   # Apply new names to dataframe

tidy_Dataset <- reducedSet %>% group_by(activity, subject) %>% summarise_all(list(mean = mean))
write.table(tidy_Dataset, file = "tidy_dataset.txt", row.names = FALSE)

# Test and validate the tidy Data set, the big clean movement
head(tidy_Dataset, 1)
nrow(tidy_Dataset)
ncol(tidy_Dataset)
names(tidy_Dataset) # activity - subject (in pairs)

# read in tidy data set in detail and check so
# View(read.table("tidy_dataset.txt"))

