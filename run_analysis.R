# Step 1: Merges the training and the test sets to create one data set.
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
sTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
sTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X <- rbind(xTrain, xTest)
Y <- rbind(yTrain, yTest)
S <- rbind(sTrain, sTest)

# Step 2: Extracts only the measurements on the mean and standard deviation
# for each measurement.
features <- read.table("./UCI HAR Dataset/features.txt")
indices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
X <- X[, indices]
names(X) <- gsub("\\(\\)", "", features[indices, 2]) 
names(X) <- gsub("mean", "Mean", names(X))
names(X) <- gsub("std", "Std", names(X))
names(X) <- gsub("-", "", names(X))
                 
# Step 3: Uses descriptive activity names to name the activities in the data set.
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityY <- activity[Y[, 1], 2]
Y[, 1] <- activityY
names(Y) <- "activity"

# Step 4: Appropriately labels the data set with descriptive variable names.
names(S) <- "subject"
cleaned <- cbind(S, Y, X)
write.table(cleaned, "merged_data.txt")

# Step 5: From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
sLength <- length(table(S))
activityLength <- dim(activity)[1]
colNum <- dim(cleaned)[2]
result <- matrix(NA, nrow=sLength*activityLength, ncol=colNum)
result <- as.data.frame(result)
colnames(result) <- colnames(cleaned)
row <- 1
for (i in 1:sLength) {
    for (j in 1:activityLength) {
        result[row, 1] <- sort(unique(S)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleaned$subject
        bool2 <- activity[j, 2] == cleaned$activity
        result[row, 3:colNum] <- colMeans(cleaned[bool1&bool2, 3:colNum])
        row <- row + 1
    }
}
write.table(result, "final_data.txt")