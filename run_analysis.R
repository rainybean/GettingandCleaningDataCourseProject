#set working directory
setwd("C:/Users/user/Desktop/R")

###1.Merges the training and the test sets to create one data set.
#load activity_labels.txt
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
names(activity_labels) <- c("activity_id","activity")

#load features.txt
features <- read.table("./data/UCI HAR Dataset/features.txt",sep="",header=FALSE)
names(features) <- c("feature_id","feature")

#load subject_test.txt (subject id for test set data)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",sep="\t",header=FALSE)
names(subject_test) <- c("subject_id")

#load y_test.txt (activity id for test set data)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",sep="",header=FALSE)
names(y_test) <- c("activity_id")

#load X_test.txt (test set data)
X_test <- read.fwf("./data/UCI HAR Dataset/test/X_test.txt",
                   widths=c(rep(16,561)),colClasses="numeric",
                   header=FALSE,stringsAsFactors=FALSE,n=2947,
                   buffersize=100) 
names(X_test) <- features$feature

#assemble test set data frame
df.test <- cbind(group="test",subject_id=subject_test$subject_id,
                 activity_id=y_test,X_test)


#load subject_train.txt (subject id for training set data)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
names(subject_train) <- c("subject_id")

#load y_train.txt (activity id for training set data)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",sep="",header=FALSE)
names(y_train) <- c("activity_id")

#load X_train.txt (training set data)
X_train <- read.fwf("./data/UCI HAR Dataset/train/X_train.txt",
                    widths=c(rep(16,561)),colClasses="numeric",
                    header=FALSE,stringsAsFactors=FALSE,
                    buffersize=100) 
names(X_train) <- features$feature

#assemble training set data frame
df.train <- cbind(group="train",subject_id=subject_train$subject_id,
                  activity_id=y_train,X_train)


#merges training and test sets
df <- rbind(df.test,df.train)


###2.Extracts only the measurements on the mean and standard deviation for each measurement. 
df.s <- df[,c(grep("-mean\\(\\)|-std\\(\\)",c(names(df)),perl=TRUE,value=TRUE))]
df.s <- cbind(df[,1:3],df.s)


###3.Uses descriptive activity names to name the activities in the data set
#add activity labels
df.s <- merge(df.s,activity_labels,by.x="activity_id",by.y="activity_id",all.x=FALSE)
df.s <- df.s[,c(2,3,1,70,4:69)]


###4.Appropriately labels the data set with descriptive activity names.
names(df.s) <- gsub("^t","time_",names(df.s),ignore.case=FALSE,perl=FALSE,fixed=FALSE,useBytes=FALSE)
names(df.s) <- gsub("^f","frequency_",names(df.s),ignore.case=FALSE,perl=FALSE,fixed=FALSE,useBytes=FALSE)
names(df.s) <- gsub("-","_",names(df.s),ignore.case=FALSE,perl=FALSE,fixed=FALSE,useBytes=FALSE)
names(df.s) <- gsub("mean\\(\\)","mean",names(df.s),ignore.case=FALSE,perl=FALSE,fixed=FALSE,useBytes=FALSE)
names(df.s) <- gsub("std\\(\\)","std",names(df.s),ignore.case=FALSE,perl=FALSE,fixed=FALSE,useBytes=FALSE)
names(df.s) <- gsub("Mag","_Mag",names(df.s),ignore.case=FALSE,perl=FALSE,fixed=FALSE,useBytes=FALSE)


###5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#load training signal files
filenames <- list.files("./data/UCI HAR Dataset/train/Inertial Signals/",pattern="*txt")
names <- gsub(".txt","",filenames,ignore.case=FALSE,perl=FALSE,fixed=FALSE,useBytes=FALSE)

for(i in names){
    filepath <- file.path("./data/UCI HAR Dataset/train/Inertial Signals/",paste(i,".txt",sep=""))
    assign(i, read.fwf(filepath,
                       widths=c(rep(16,128)),colClasses="numeric",
                       header=FALSE,stringsAsFactors=FALSE,
                       buffersize=100))
}


#load test signal files
filenames <- list.files("./data/UCI HAR Dataset/test/Inertial Signals/",pattern="*txt")
names <- gsub(".txt","",filenames,ignore.case=FALSE,perl=FALSE,fixed=FALSE,useBytes=FALSE)

for(i in names){
    filepath <- file.path("./data/UCI HAR Dataset/test/Inertial Signals/",paste(i,".txt",sep=""))
    assign(i, read.fwf(filepath,
                       widths=c(rep(16,128)),colClasses="numeric",
                       header=FALSE,stringsAsFactors=FALSE,
                       buffersize=100))
}


#assemble training set data frame
body_acc_x_train2 <- cbind(group="train",variable="body_acc",dimension="x",subject_train,y_train,body_acc_x_train)
body_acc_y_train2 <- cbind(group="train",variable="body_acc",dimension="y",subject_train,y_train,body_acc_y_train)
body_acc_z_train2 <- cbind(group="train",variable="body_acc",dimension="z",subject_train,y_train,body_acc_z_train)
body_gyro_x_train2 <- cbind(group="train",variable="body_gyro",dimension="x",subject_train,y_train,body_gyro_x_train)
body_gyro_y_train2 <- cbind(group="train",variable="body_gyro",dimension="y",subject_train,y_train,body_gyro_y_train)
body_gyro_z_train2 <- cbind(group="train",variable="body_gyro",dimension="z",subject_train,y_train,body_gyro_z_train)
total_acc_x_train2 <- cbind(group="train",variable="total_acc",dimension="x",subject_train,y_train,total_acc_x_train)
total_acc_y_train2 <- cbind(group="train",variable="total_acc",dimension="y",subject_train,y_train,total_acc_y_train)
total_acc_z_train2 <- cbind(group="train",variable="total_acc",dimension="z",subject_train,y_train,total_acc_z_train)

df2.train <- rbind(body_acc_x_train2,body_acc_y_train2,body_acc_z_train2,
                   body_acc_z_train2,body_gyro_y_train2,body_gyro_z_train2,
                   total_acc_x_train2,total_acc_y_train2,total_acc_z_train2)

#assemble test set data frame
body_acc_x_test2 <- cbind(group="test",variable="body_acc",dimension="x",subject_test,y_test,body_acc_x_test)
body_acc_y_test2 <- cbind(group="test",variable="body_acc",dimension="y",subject_test,y_test,body_acc_y_test)
body_acc_z_test2 <- cbind(group="test",variable="body_acc",dimension="z",subject_test,y_test,body_acc_z_test)
body_gyro_x_test2 <- cbind(group="test",variable="body_gyro",dimension="x",subject_test,y_test,body_gyro_x_test)
body_gyro_y_test2 <- cbind(group="test",variable="body_gyro",dimension="y",subject_test,y_test,body_gyro_y_test)
body_gyro_z_test2 <- cbind(group="test",variable="body_gyro",dimension="z",subject_test,y_test,body_gyro_z_test)
total_acc_x_test2 <- cbind(group="test",variable="total_acc",dimension="x",subject_test,y_test,total_acc_x_test)
total_acc_y_test2 <- cbind(group="test",variable="total_acc",dimension="y",subject_test,y_test,total_acc_y_test)
total_acc_z_test2 <- cbind(group="test",variable="total_acc",dimension="z",subject_test,y_test,total_acc_z_test)

df2.test <- rbind(body_acc_x_test2,body_acc_y_test2,body_acc_z_test2,
                  body_acc_z_test2,body_gyro_y_test2,body_gyro_z_test2,
                  total_acc_x_test2,total_acc_y_test2,total_acc_z_test2)

#merge taining and test data frames
df2 <- rbind(df2.test,df2.train)

#melt signal data
require(reshape2)
molten = melt(df2, id = c(1:5))

#aggregate by subject id and activity id
molten.a <- aggregate(value~(subject_id+activity_id),data=molten,FUN=mean)

#get activity labels and produce final output
molten.a <- merge(molten.a,activity_labels,by.x="activity_id",by.y="activity_id",all.x=FALSE)
molten.a <- molten.a[,c(2,1,4,3)]
names(molten.a) <- c("subject_id","activity_id","activity","mean")
molten.a


#write to file
write.table(molten.a,"tidy.txt",sep="\t",row.names=FALSE)


