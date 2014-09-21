##################GET THE ZIP FILE AND UNZIP IT INTO A DIRECTORY##################
setwd("~/DataScientistClasses/GetCleanData/proj")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,dest="proj.zip")
unzip("proj.zip")

###################READ FILES IN AND MERGE TOGETHER###############################
setwd("~/DataScientistClasses/GetCleanData/proj/UCI HAR Dataset")


cname1 <- c("subject_nbr")
cname2 <- c("action_nbr")
cname3 <- c("action_nbr","action")

actLabels<-read.table("activity_labels.txt",header=FALSE,col.names=cname3)
features<-read.table("features.txt",header=FALSE)

subject_train<-read.table("./train/subject_train.txt",header=FALSE,col.names=cname1)
x_train<-read.table("./train/X_train.txt",header=FALSE)
y_train<-read.table("./train/y_train.txt",header=FALSE,col.names=cname2)

subject_test<-read.table("./test/subject_test.txt",header=FALSE,col.names=cname1)
x_test<-read.table("./test/X_test.txt",header=FALSE)
y_test<-read.table("./test/y_test.txt",header=FALSE,col.names=cname2)

##################1. Merge all data into on dataset#################################
train_df <- cbind(subject_train,y_train,x_train)
test_df <- cbind(subject_test,y_test,x_test)
all_df <- rbind(train_df,test_df)

#################2. EXTRACT COLUMNS FOR MEAN AND STANDARD DEVIATION#################

# GET THE COLUMN NUMBERS TO EXTRACT FROM MERGED DATASET
g1<-c(grep(c("mean+"),features[,2]),grep(c("std+"),features[,2]),grep(c("Mean+"),features[,2]))
g1<-sort(g1)
g2<-g1+2
g3<-c(1,2,g2)
# EXTRACT THE COLUMNS THAT HAVE MEAN AND STD IN THEM
extract_df <- all_df[,g3]

################ 3. Uses descriptive activity names to name the activities in the data set #######
nearfinal_df <- merge(extract_df,actLabels,by="action_nbr",all=TRUE)
nearfinal_df$action_nbr <- NULL

#################4. Appropriately labels the data set with descriptive variable names#############
cname4 <- c("subject_nbr",as.character(features[g1,2]),"action")
colnames(nearfinal_df) <- cname4

final_df <- nearfinal_df


############5. From the data set in step 4, creates a second, independent tidy data set with the average
############   of each variable for each activity and each subject.
library(plyr)
library(reshape2)
melt_df <- melt(final_df,id.vars=c("subject_nbr","action"))
ddply_df <- ddply(melt_df, .(subject_nbr,action,variable), summarize, mean=mean(value))
dcast_df <- dcast(ddply_df, subject_nbr+action~variable, value.var="mean")


##############WRITE DATASET FOR QUESTION 5 #########################################
write.table(dcast_df, file = "measure.txt", sep = ",", row.name=FALSE )

