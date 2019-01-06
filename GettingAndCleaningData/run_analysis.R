
# clearing out the enviroment
rm(list = ls())

#loading libraries
library(data.table)

# location of the dataset
datadir <-'./data/UCI_HAR_Dataset/'


#reading in subject files
subject_train <- read.table(paste0(datadir,'./train/subject_train.txt'))
subject_test <- read.table(paste0(datadir,'./test/subject_test.txt'))
# combining the data sets:
subject_data <- rbind(subject_train, subject_test)
# there are 10299 observations from several subjects

#reading in data set files
data_train <- read.table(paste0(datadir,'./train/X_train.txt'))
data_test <- read.table(paste0(datadir,'./test/X_test.txt'))
# combining the data sets:
data <- rbind(data_train, data_test)  
# rows - observations
# columns - measurments 
  
#reading in data label files
labels_train <- read.table(paste0(datadir,'./train/y_train.txt'),stringsAsFactors = FALSE)
labels_test <- read.table(paste0(datadir,'./test/y_test.txt'),stringsAsFactors = FALSE)
# combining the data sets:
labels <- rbind(labels_train, labels_test)  

#reading in activity labels
activity_labels <- read.table(paste0(datadir,'activity_labels.txt'),stringsAsFactors = FALSE)


#reading in features
features <- read.table(paste0(datadir,'features.txt'),stringsAsFactors = FALSE)
# column name for the data

# assigning variables names for each column:
# type of activity
names(labels) <- "ActivityNumber"
names(activity_labels) <- c("ActivityNumber", "Activity")

# subject IDs
names(subject_data) <- "SubjectID"

# names for each column of the data
names(data)<-features$V2

# Merge Data into complete training set
FullDataSet = cbind(subject_data,labels,data)

#Extracting only the measurements on the mean and standard deviation for each measurement.
# creating a vector for the variable names
varnames<-names(FullDataSet)
# searching within the variable names
subset_indecies <-grep("-mean|-std|activitynumber|subjectid",tolower(varnames))
# extracting only the wanted variables names
Subset <- FullDataSet[,subset_indecies]

#Use descriptive activity names to name the activities in the data set
Subset$ActivityNumber <-as.character(Subset$ActivityNumber)

for (i in 1:6) {
  activity_indecies <-grep(as.character(i),Subset$ActivityNumber)
  Subset$ActivityNumber[activity_indecies] <- activity_labels$Activity[i]
  
}


# Appropriately labels the data set with descriptive variable names.
ColNames <- names(Subset)

ColNames[2] <-"Activity"

for (i in 3:length(ColNames)) 
{
  ColNames[i] <- gsub("\\()","",ColNames[i])
  ColNames[i] <- gsub("-std","StdDev",ColNames[i])
  ColNames[i] <- gsub("-mean","Mean",ColNames[i])
  ColNames[i] <- gsub("^(t)","Time-",ColNames[i])
  ColNames[i] <- gsub("^(f)","Freq-",ColNames[i])
  ColNames[i] <- gsub("([Gg]ravity)","Gravity",ColNames[i])
  ColNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",ColNames[i])
  ColNames[i] <- gsub("[Gg]yro","Gyro",ColNames[i])
  ColNames[i] <- gsub("AccMag","AccMagnitude",ColNames[i])
  ColNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",ColNames[i])
  ColNames[i] <- gsub("JerkMag","JerkMagnitude",ColNames[i])
  ColNames[i] <- gsub("GyroMag","GyroMagnitude",ColNames[i])
};

names(Subset) <- ColNames

# creating a second data set

write.table(Subset, 'Tidy_Subset.txt',row.names=FALSE,sep='\t')


