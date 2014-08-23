Getting-and-Cleaning-Data
=========================

Coursera Online Course - Peer Assessment Project

This file describes how the run_analysis.R script works:

* Download and extract the data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder to 'data'
* Put the run_analysis.R file into the same folder as the data directory and make sure you set your working directory within R to that directory
* Next, source("run_analysis.R") within R to generate the tidy data set
* Within the working directory you should find the output data file called 'tidy_data_with_means.txt'
* Read the data into a new data frame within R:
	df <- read.table('tidy_data_with_means.txt')

Final notes: Comments on how the tidy data was created is available within the R script.