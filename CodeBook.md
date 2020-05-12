Introduction
The codes required to complete this project consist of the following two files:

run_analysis.R, which is the main program.
supporting_functions.R, which contains the supporting functions to improve the code readability in the main program.
Supporting functions
load_data loads the input text file and returns a data frame.
create_data_list loads data for multiple filenames and creates and returns a list containing the corresponding dataframes.
merge_datamerges the training and test X, y data frames and returns a single data frame.
update_data updates the activity id to descriptive activity names.
Additional packages used
dplyr, tidyr, reshape2
Variable names
main_directory contains the data directory on the local disk.
input_order contains "features" and "activity" identifiers.
col_names contains the list of column labels for "features.txt" and "activity_labels.txt' files.
filepaths contains "features" and "activity" filpaths in the main direcotry
feature_activity_list stores a list containing features and activity data frames.
input_order_traintest contains order identifiers to store training, test sets and subject file.
col_names_traintest stores the column names for loading train/test sets and subject file.
filepaths_traintest contains a vector of train/test sets and subject filepaths.
train_test_data_list stores a list containing data frames for train/test sets and subject file.
merged_data contains a data frame that is obtained by merging all loaded data.
subset_cols contains indices of column names that contain mean and standard deviation of measurements.
merged_data_subset contains dataframe with mean and standard deviation measurement features.
descriptive_data contains dataframe with "activity_id" transformed into "activity_name".
tidy_data stores the final tidy data.
How the program works?
A step-by-step description of how the program works is described as follows:

The course project data was downloaded from the given link and stored in a local directory.
All required data are then loaded using the create_data_list function from the supporting_functions.R file.
Training/tests sets are then merged using the merged_data function from the supporting_functions.R file. It uses the bind_rows and bind_cols functions from the dplyr package.
Indices containing the mean and standard deviation of measurements in the column names are found using the grep function.
Using the above indices, a subset of merged_data containing only the mean and standard deviation measurements are obtained.
The activity ids are transformed into activity names/labels using the update_data function from the supporting_functions.R file. It uses the merge, mutate, and select functions from the tidyr package. The data now contain descriptive variables and column names.
Finally, a tidy data frame containing the average values for each of subject and activity is created using the melt and dcast functions from the reshape2 package. This data is then output as tidy_data_set.txt using write.table function, for anyone to check and validate the result.
