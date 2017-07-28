run_analysis <- function(){
	library(dplyr)
##
##	Function run_analysis() is performing the following steps
##	- reads the supplied raw data 
##	- does some basic tidying of the columnnames
##	- merges training and test data-sets
##	- extracts only these variables with mean() and std() values
##	- adds activity names and subject-number to the data-set
##	- calculates mean per subject and activity
##	- writes 'raw' and 'mean' data to .csv files	 
##
## 	Reading feature names from the text file provided in the zipped download file
## 	then extracting the names into a character vector
##	
	features <- read.table("./UCI HAR Dataset/features.txt", sep = " ")
	feature_names <- features$V2
##
##	Extracting column numbers for ...mean()... and ...std().... values
##	The numeric vector will then be used for extracting the appropriate columns
##	from the complete dataframe
##
	mean_ind <- grep("mean\\(\\)",feature_names)
	std_ind <- grep("std\\(\\)",feature_names)
	col_ind <- sort(c(mean_ind,std_ind))
##
##	Reading activity names from provided file
##
	activity_desc <- read.table("./UCI HAR Dataset/activity_labels.txt",
		row.names=NULL)	
##
## 	Tidying the feature_names in a minimalistic way
##	Reason: Column header names provided appear to be a good compromise between being 
##	meaningful and brief. All converted to lowercase to avoid typos and "()" , which provides no
##	apparent added value removed. Abbreviations appear meaningful. 
##	It appears that the "read.table" function has the side effect to replace
##	meta-characters in columnnames by "." Is is being used as implicit way to tidy
##	columnnames, using "." as logical separator in names
##
	feature_names <- sub("mean\\(\\)", "mean", tolower(feature_names))
	feature_names <- sub("std\\(\\)", "std", feature_names)
##
##	Reading training and testing data, thereby using feature-names as column-headers
##	Potential target value data are labeled "activity" and "subject" respectively
##
	x_train <- read.table("./UCI HAR Dataset/train/x_train.txt",
		col.names = feature_names,row.names=NULL)
	y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",
		col.names = "activity",row.names=NULL)
	x_test <- read.table("./UCI HAR Dataset/test/x_test.txt",
		col.names = feature_names,row.names=NULL)
	y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",
		col.names = "activity",row.names=NULL)
	subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",
		col.names = "subject",row.names=NULL)
	subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",
		col.names = "subject",row.names=NULL)
##
## 	merging train and test data sets for the features, the subject and the activity
##
	y_all <- rbind(y_train,y_test)
	subject_all <- rbind(subject_train,subject_test)
	x_all <- rbind(x_train,x_test)
##	
##	as per instructions select features in relation to "mean()" and "std()" from 
##	complete dataframe using the col_ind vector
##
	x_sel <- x_all[,col_ind]
##
##	Creating the complete dataframe
##
	x_sel <- cbind(x_sel,y_all,subject_all)
##
## 	Now addressing the last point of the exercise: Calculating the mean value for all 
##	observations per activity and subject. The corresponding numbers are known and 
##	hardcoded here. This could be further changed for more subjects or other acticities
##	but currently there is no value in doing this.
##	The mean values are appended at the end of the dataframe. That way an identical 
##	format is guaranteed. This could be ineffective for larger dataframes, but for
##	the data volumes here it would not matter 
##
	for (iact in 1:6) {
		for (isub in 1:30) {
		x_sel_filter <- filter(x_sel, activity == iact & subject == isub)
		x_sel <- rbind(x_sel,colMeans(x_sel_filter))
		}
	}
##
##	changing activity numbers to meaningful descriptions
##	this could have done earlier, but here it is more efficient from coding perspective
##
	x_sel$activity <- activity_desc[x_sel$activity,2]
##
##	Now extracting the orginal raw data and the mean values from the complete dataframe
##
	x_raw <- x_sel[1:10299,]
	x_mean <- x_sel[10300:10479,]
##
##	Writing the files as .csv data
	write.table(x_raw, file = "HAR_raw_train+test-mean+std_by_GK.txt", 
		sep = " ", row.names = FALSE)
	write.table(x_mean, file = "HAR_means_train+test-mean+std_by_GK.txt", 
		sep = " ", row.names = FALSE)
##
## 	returning the dataframe to allow inspection to see if requirements have been met
##
	return(x_mean)
}
		