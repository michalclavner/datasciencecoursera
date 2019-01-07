This code book describes the variables within of the data set "Tidy_Subset.txt", which is created when running the "run_analysis.R" script.

Raw data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of the raw data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Structure of "Tidy_Subset.txt":

"Tidy_Subset.txt" is a data frame composed of 81 variables (columns) and 10299 observations (rows).

Column 1 (class: numeric) subject ID (ranging from 1 to ?)

Column 2 (class: char) : activity ( 6 types of activities :  WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS, LAYING, SITTING, STANDING)

Columns 3 to 81: mean and standard deviation (StdDev) of several measurment measured on each subjet during the 6 various activities.
