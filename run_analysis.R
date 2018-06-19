### Read in the Test Data ###
test_data <- read.table(".//UCI HAR Dataset//test//X_test.txt")

### Read in the Subject IDs for Test Data ###
sub_ID <- read.table(".//UCI HAR Dataset//test//subject_test.txt")

### Read in the Activity Labels for Test Data ###
labels <- read.table(".//UCI HAR Dataset//test//y_test.txt")

### Combine (horizontally) the Test Data, Subject IDs for Test Data, & Activity Labels for Test Data ###
test_data <- cbind(cbind(labels,sub_ID), test_data)

### Read in the Training Data ###
train_data <- read.table(".//UCI HAR Dataset//train//X_train.txt")

### Read in the Subject IDs for Train Data ###
sub_ID_2 <- read.table(".//UCI HAR Dataset//train//subject_train.txt")

### Read in the Activity Labels for Train Data ###
labels_2 <- read.table(".//UCI HAR Dataset//train//y_train.txt")

### Combine (horizontally) the Train Data, Subject IDs for Train Data, & Activity Labels for Train Data ###
train_data <- cbind(cbind(labels_2,sub_ID_2),train_data)

### Combine (vertically) Training Data and Test Data  ###
merged_data <- rbind(test_data,train_data)

### Remove all the objects except for merged_data ###
rm(list = c("labels","labels_2","sub_ID","sub_ID_2","test_data","train_data"))

### Read in the names of features present in the 561-feature vector ###
features <- read.table(".//UCI HAR Dataset//features.txt", stringsAsFactors = F)

### Filtering feature names to only keep measurements on Mean and Standard Deviation ###
features <- features[grepl("mean\\(\\)|std\\(\\)",features$V2),]

### Creating a numeric vector to identify column numbers within merged_data ###
col_numbers <- features$V1 + 2

### Change the column names to the descriptive variable names ###
colnames(merged_data)[col_numbers] <- features$V2

### Filter merged_data to only keep measurements on Mean and Standard Deviation ###
merged_data <- merged_data[,c(1,2,col_numbers)]

### Read in descriptive activity names ###
act_names <- read.table(".//UCI HAR Dataset//activity_labels.txt")

### Create a new column with descriptive activity names ###
merged_data$Activity <- act_names[merged_data[,1],2]

### Rename the column with Subject IDs ###
colnames(merged_data)[2] <- "Subject_ID"

### Delete the column containing Activity Labels ###
merged_data <- merged_data[,-1]

### Delete all objects except merged_data ###
rm(list = c("act_names","features","col_numbers"))

### Replace t with time in descriptive activity names ###
colnames(merged_data)[seq(2,67)] <- gsub("^t","time",colnames(merged_data)[seq(2,67)]) 

### Replace f with freq in descriptive activity names ### 
colnames(merged_data)[seq(2,67)] <- gsub("^f","freq",colnames(merged_data)[seq(2,67)])

### if dplyr is not installed then initiate installation ###
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

### group by activity and subject then take mean of each variable ###
grouped_table <- merged_data %>% group_by(Subject_ID, Activity) %>% summarise_all(funs(mean))

### create a txt file which contains group_table ###
write.table(grouped_table, "tidy data.txt", row.names = FALSE)
