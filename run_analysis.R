# 1. Merge the training and the test sets to create one data set
# Read training set
setwd("/Users/ralph/Development/Getting and Cleaning Data/Getting-and-Cleaning-Data")
trData <- read.table("./data/train/X_train.txt")
trLabels <- read.table("./data/train/y_train.txt")
trSubjects <- read.table("./data/train/subject_train.txt")
# Read test set
teData <- read.table("./data/test/X_test.txt")
teLabels <- read.table("./data/test/y_test.txt")
teSubjects <- read.table("./data/test/subject_test.txt")
# Join the data sets by row binding
jData <- rbind(trData, teData)
jLabels <- rbind(trLabels, teLabels)
jSubjects <- rbind(trSubjects, teSubjects)
# Clean up unused objects
rm(trData,teData,trLabels,teLabels,trSubjects,teSubjects)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# Read features
features <- read.table("./data/features.txt")
# Find variables (columns) related to mean and std deviation
columns <- grep("mean\\(.|std\\(.", features[,2])
# Subset the joined data set to extract the right columns
jData <- jData[, columns]
# Sanitize column names
names(jData) <- gsub("\\(\\)", "", features[columns,2])
names(jData) <- gsub("mean", "Mean", names(jData))
names(jData) <- gsub("std", "Std", names(jData))
names(jData) <- make.names(names(jData))
# Clean up unused objects
rm(columns,features)

# 3. Use descriptive activity names to name the activities in the data set
# Read activity data
act <- read.table("./data/activity_labels.txt")
act[,2] <- tolower(make.names(act[,2], allow_=F))
jLabels[,1] <- act[jLabels[,1],2]
names(jLabels) <- "activity"
# Clean up unused objects
rm(act)

# 4. Appropriately label the data set with descriptive variable names.
names(jSubjects) <- "subject"
# Bind data using column binding
tidyData1 <- cbind(jSubjects, jLabels, jData)
# Clean up unused objects
rm(jSubjects,jLabels,jData)

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidyData2 <- with(tidyData1, aggregate(tidyData1[,c(-1,-2)], list(subject, activity), mean))
# Fix column names after aggregation
names(tidyData2)[1] <- "subject"
names(tidyData2)[2] <- "activity"
# Sort data by "subject, activity"
tidyData2 <- tidyData2[order(tidyData2[,1:2]),]
tidyData2 <- tidyData2[1:180,]
# Write tidy data without row names as specified in assignment
write.table(tidyData2, file="tidy_data_with_means.txt",row.names=F)
