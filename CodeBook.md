Data obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

- X_train: data from the X_train.txt file
- Y_train: data from the Y_train.txt file
- X_test: data from the X_test.txt file
- Y_test: data from the Y_test.txt file
- X_total: data that bound the rows of X_train and X_test
- Y_total: data that bound the rows of Y_train and Y_test
- subject_test: data from the subject_test.txt file
- subject_train: data from the subject_train.txt file
- subject_total: data that bound the rows of subject_train and subject_test
- activity_labels: data from the activity_labels.txt file
- features: data from the features.txt file
- total_data: a data frame that bound the columns of X_total, Y_total, and subject_total
- tidydata: a subset of total_data where only variables containing a mean or a standard deviation were selected
- final: a data frame which is a subset of tidaydata containing the means of the times for each subject completing each activity
