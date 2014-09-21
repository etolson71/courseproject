Course Project for Getting and Cleaning Data
=============

The data was retreived from the internet location provide to us for the project.

Location:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data was downloaded from that site and upzipped into the working directory.

The data files were read in to data frames with some column names added to make future joining and
other activities easier.

The data came split between different files for each participant.  These were combined together so 
that all data was in one data frame for each observation.

The data came with the data split between a training and test data files.  These represent measurements
across different participants.  For our purposes, these were combined together.

One certain variables were needed for this analysis.  Those variables were extracted by searching for the
the mean and std in the variable names.

Variable names were added to the data from the feature file.  These names allow us to know what the
measurement was for.

Action variable was recoded to tell what action was being performed for that series of measurements.

Mean of each measurement variable was calculated for each participant and activity by melting the 
data and then summarizing it back up into a tidy dataset.

Finally the final measurement file was written to a text file so it could be moved to GitHub.
