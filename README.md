# GettingSharingData
Repository for the class project of Getting and Sharing Data

run_analysis.R downloads the following data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It unzips the files and processes them as follows:

1. Reads features.txt which contains the field names for each data file.
2. Stores the fields determined to be standard deviation and mean calculations as determined by ending with "std()" or "mean()."
3. Reads the activity labels used to convert the numeric activity code itno meaningful text.
4. Reads the following files from the test and train directories:
	* test/subject_test.txt (test subjects)
	* test/X_test.txt (test data collected)
	* test/Y_test.txt (test activities)
	* train/subject_train.txt (train subjects)
	* train/X_train.txt (train data collected)
	* train/Y_train.txt (train activities)
5. Reduces the data frame from X_test.txt and X_train.txt (the main data frames) down to the std and mean fields as determined in step 2 above.
6. Adds meaningful column names per the names form step 2 above.
7. Add columns and data for subject and activity to main data frames.
8. Merge test and train data into a single data frame.
9. Write the tidy data created above out to a file.

Secondary processing to create a second output file which contains averges of each field above grouped by subject and activity:

1. Create grouped_df (tbl_df with grouped_by applied) to the concatenation of test and train data above.
2. Calculate the mean of each field using the above grouping.
3. Write this summary out to a file.