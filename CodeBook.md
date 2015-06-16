#Code Book

##Data
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##What `run_analysis.R` does
1. Read the following text files: X\_train.txt, y\_train.txt, subject\_train.txt, X\_test.txt, y\_test.txt and subject\_test.txt, and store them as variables `xTrain, yTrain, sTrain, xTest, yTeset` and `sTest` respectively.
2. Bind train data and its test counterpart as a combined data frame. Repeat this three times so that variables `X, Y` and `S` are generated.
3. Read the text file features.txt and store it as variable `features`. We need to extract only values related to mean and standard deviation, so we assign the corresponding list as `indices`. Then we subset the variable `X`. Afterwards, clean the column names of such subset of `X`, namely, we remove `()`, `-` in names, and capitalize the first letter of "M" and "S".
4. Read the text file activity\_labels.txt and store as variable `activity`. Then clean the activity names in the second column of activity. We lower case all names first, if the name has an underscore within, we capitalize the first letter right after underscore.
5. We column-combine `S, Y, X` and name it `cleaned`, then  write it out as a text file "merged_data.txt"
6. We generate a second independent tidy data set with the average of each measurement for each activity and each subject. And write the result out as "final_data.txt" file.
