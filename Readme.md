Readme.md
## Dataset preparation as per instructions in Coursera "getting and cleaning data course project"

[details of experiment and original data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Function run_analysis() overview

	Function run_analysis() is performing the following steps
	- reads the supplied raw data 
	- does some basic tidying of the columnnames
	- merges training and test data-sets
	- extracts only these variables with mean() and std() values
	- adds activity names and subject-number to the data-set
	- calculates mean per subject and activity
	- writes 'raw' and 'mean' data to .csv files	 

# Major steps in data processing
1. Reading feature names from the text file provided in the zipped download file then extracting the names into a character vector.
Extracting column numbers for ...mean()... and ...std().... values.
The numeric vector will then be used for extracting the appropriate columns from the complete dataframe.
2. Reading activity names from provided file
3. Tidying the feature_names in a minimalistic way
Reason: Column header names provided appear to be a good compromise between being 
meaningful and brief. All converted to lowercase to avoid typos and "()" , which provides no
apparent added value removed. Abbreviations appear meaningful. 
It appears that the "read.table" function has the side effect to replace
meta-characters in columnnames by "." Is is being used as implicit way to tidy
columnnames, using "." as logical separator in names
4. Reading training and testing data, thereby using feature-names as column-headers
Potential target value data are labeled "activity" and "subject" respectively
5. Merging train and test data sets for the features, the subject and the activity
6. As per instructions select features in relation to "mean()" and "std()" from 
complete dataframe using the col_ind vector
7. Creating the complete dataframe from features and target values activity and subject
8. Now addressing the last point of the exercise: Calculating the mean value for all 
observations per activity and subject. The corresponding numbers are known and 
hardcoded here. This could be further changed for more subjects or other acticities
but currently there is no value in doing this.
The mean values are appended at the end of the dataframe. That way an identical 
format is guaranteed. This could be ineffective for larger dataframes, but for
the data volumes here it would not matter 
9. Changing activity numbers to meaningful activity descriptions from provided file
10. Now extracting the orginal raw data and the mean values from the complete dataframe
11. Writing the files as .txt data
12. Returning the dataframe to allow inspection to see if requirements have been met

# Variable details
Please see file code_book.txt

# acknowledgements
thanks to the original authors:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
