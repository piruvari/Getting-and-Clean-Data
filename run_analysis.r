setwd("D:/cursos/Getting and Cleaning Data/UCI HAR Dataset/")

#You should create one R script called run_analysis.R that does the following.

#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement.
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names.
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


###Read of the all files
activityLabel   <- read.table("./activity_labels.txt",header=FALSE)
features        <- read.table("./features.txt",header=FALSE)
subject_test    <- read.table("./test/subject_test.txt", header=FALSE)
X_test          <- read.table("./test/X_test.txt", header=FALSE)
y_test          <- read.table("./test/y_test.txt", header=FALSE)
body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt", header=FALSE)
body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt", header=FALSE)
body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt", header=FALSE)
body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt", header=FALSE)
body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt", header=FALSE)
body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt", header=FALSE)
total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt", header=FALSE)
total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt", header=FALSE)
total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt", header=FALSE)
subjectTrain    <- read.table("./train/subject_train.txt", header=FALSE)
xTrain          <- read.table("./train/X_train.txt", header=FALSE)
yTrain          <- read.table("./train/y_train.txt", header=FALSE)
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt", header=FALSE)
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt", header=FALSE)
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt", header=FALSE)
body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt", header=FALSE)
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt", header=FALSE)
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt", header=FALSE)
total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt", header=FALSE)
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt", header=FALSE)
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt", header=FALSE)


########1##############################

## add the train to test
subject     <- rbind(subjectTrain, subject_test)
x           <- rbind(xTrain, X_test)
y          <- rbind(yTrain, y_test)
##3-axial acelerómetro 
body_acc_x  <- rbind(body_acc_x_train, body_acc_x_test)
body_acc_z  <- rbind(body_acc_z_train, body_acc_z_test)
body_acc_y  <- rbind(body_acc_y_train, body_acc_y_test)
### 3-axial giroscopio
body_gyro_x <- rbind(body_gyro_x_train, body_gyro_x_test)
body_gyro_y <- rbind(body_gyro_y_train, body_gyro_y_test)
body_gyro_z <- rbind(body_gyro_z_train, body_gyro_z_test)
total_acc_x <- rbind(total_acc_x_train, total_acc_x_test)
total_acc_y <- rbind(total_acc_y_train, total_acc_y_test)
total_acc_z <- rbind(total_acc_z_train, total_acc_z_test)
#############################3##########################
# put the name ActivityDesc and replace the id to description of the activity
names(y)<-c("Activity")
activityDesc  <- factor(y$Activity,levels=activityLabel$V1,labels=activityLabel$V2)
activityDesc<-data.frame(activityDesc)
##############################4###############################3
# put the friendly name for the 30 voluntaries and name to features
names(subject)<- c("Subject")
names(x)<- features$V2

###############################1#########################
## merge the subjet activity and features

subjecty <- cbind(subject, activityDesc)
Data <- cbind(x, subjecty)
#################################2##################################
## extract of mean and std
ExtractFeatures<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
Extract<- c(as.character(ExtractFeatures), "Subject", "activityDesc" )
Data1 <-subset(Data,select=Extract)

############################################################################
#############result Data1
#############body_acc_x  
#############body_acc_z  
#############body_acc_y  
#############body_gyro_x 
#############body_gyro_y 
#############body_gyro_z 
#############total_acc_x 
#############total_acc_y 
#############total_acc_z 
##############################5###############################################

## create the tydi data

##install.packages('reshape2')
##library(reshape2)
##require(reshape2)
meltdata1 <- melt(Data1, id=c("Subject", "activityDesc"), na.rm=TRUE)
tidyData <- dcast(meltdata1, Subject + activityDesc ~ variable, mean)
write.csv(tidyData, "tidy.csv", row.names=FALSE)
write.table(tidyData, "tidy.txt", row.names=FALSE)

