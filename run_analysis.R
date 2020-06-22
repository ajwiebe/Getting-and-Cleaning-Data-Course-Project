library(dplyr)
##loading in the features and appropriately naming the columns
features <- read.table("./UCI HAR Dataset/features.txt")
names(features)[names(features)== "V1"] <- "number"
names(features)[names(features)== "V2"] <- "functions"

##loading in x_test with corresponding column names 
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

## loading in y_test with appropriately named column
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
names(Y_test)[names(Y_test)== "V1"] <- "code"

## loading subject tests with corresponing column name 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test)[names(subject_test)== "V1"] <- "subject"

## loading in x_train with corresponing column names 
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

## loading in y_train with appropriate column names 
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
names(Y_train)[names(Y_train)== "V1"] <- "code"

## loading in subject_train with appropraite column name
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train)[names(subject_train)== "V1"] <- "subject"

## loading in features with appropriate column names 
features <- read.table("./UCI HAR Dataset/features.txt")
names(features)[names(features)== "V1"] <- "number"
names(features)[names(features)== "V1"] <- "functions"

## loading in activity labels with appropriate column names 
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity_labels)[names(activity_labels)== "V1"] <- "code"
names(activity_labels)[names(activity_labels)== "V2"] <- "activity"

## binding x, y, and subject data into individual data frames, then binding those into a complete frame
X_total <- rbind(X_train, X_test)
Y_total <- rbind(Y_train, Y_test)
subject_total <- rbind(subject_train, subject_test)
total_data <- cbind(subject_total, Y_total, X_total)

## creating a seperate frame for tidy data and selecting the appropriate columns, with appropriate labels
tidydata <- total_data %>% select(subject, code, contains("mean"), contains("sd"))
tidydata$code <- activity_labels[tidydata$code, 2]

## creating clear labels for each column 
names(tidydata)[2] = "activity"
names(tidydata)<-gsub("^t", "time", names(tidydata))
names(tidydata)<-gsub("^f", "frequency", names(tidydata))
names(tidydata)<-gsub("-mean()", "mean", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-std()", "std", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-freq()", "frequency", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata)<-gsub("Gyro", "gyroscope", names(tidydata))
names(tidydata)<-gsub("BodyBody", "body", names(tidydata))
names(tidydata)<-gsub("Mag", "magnitude", names(tidydata))
names(tidydata)<-gsub("angle", "angle", names(tidydata))
names(tidydata)<-gsub("gravity", "gravity", names(tidydata))

## creating a final clean data frame which includes the means for all combinations of subjects and activities
final <- tidydata %>% group_by(subject, activity) %>% summarize_all(funs(mean))

## writing the file for the final data
write.table(final, "final.txt", row.names = FALSE)
