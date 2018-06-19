# Getting and Cleaning Data - Course Project

This repository contains an R script called **'run_analysis'**, a text file called **'tidy data'**, and a **codebook**.

To execute the R script successfully, first download the compressed folder containing raw data from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Then create a folder in your working directory called **'Getting&CleaningData'** to which contents of the compressed folder are to be extracted. Once these two steps are done the R script can be executed.

A step-by-step explanation of the manipulations within the R script has been provided using comments. However, a supplementary overview is provided below as well:
1. The following are done twice, once for test data and once again for train data:
   * Read in the dataset
   * Read in the activity labels 
   * Read in the subject IDs 
   * Column bind the dataset, activity labels, and subject IDs 
2. Row bind the two datasets from step one to create a master dataset  
3. Read in the feature names of the 561-feature vector 
4. Rename the columns of master data as per the feature names provided 
5. Retain only those columns in master dataset that contain either 'mean()' or 'std()' in their column name
6. Read in the descriptive activity names 
7. Replace activity labels of master data with descriptive activity names
8. Use dplyr package to do the following:
   * group the master data by descriptive activity names and subject IDs
   * calculate mean value in each column for every unique grouping 
9. Write the 30x6 rows of data from the above step (including column headers) into a text file

The newly written file is called 'tidy data' and it can be found within this repository. 
The codebook is a document which contains details regarding the variables found in 'tidy data'.



      
