Introduction
The script run_analysis.R  performs the 5 steps described in the course project.

Step 1: Read the Data into R,Merge the test and Training Datasets using cbind ,read.table, and other functions.

Step 3: Gives Descriptive activity names to be assigned for activity achived thorugh pattern matching and replacement function gsub.

Step 2: Extracts only mean and std deviation related data using grep function

Step 4: Give descriptive variable names using gsub function.

Step 5: uses ddply function to calculate averages 


Variables used:

xtr1,ytr1,xytr,sub_train,xte1,yte1,xyte,sub_test,feature,act_label- variables used to read the datasets.

fullobs - data set containing the entire data

extract_obs - subsetted data set with only mean and std deviation variable

tidy_data -variable which contains the tidy data

