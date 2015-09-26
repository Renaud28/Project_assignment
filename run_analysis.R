setwd("C:/Users/Renaud/Rcourses/gettingandcleaningthedata")

#all data extracted to working directory ./project/UCI HAR Dataset/UCI HAR Dataset

library(data.table)
library(plyr)
library(dplyr)
    

train_data<-fread("./project/UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
test_data<-fread("./project/UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

test_subject<-fread("./project/UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
train_subject<-fread("./project/UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

test_activity<-fread("./project/UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
train_activity<-fread("./project/UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

activity_label<-fread("./project/UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")


#select only columns with "mean()" and "std()", add column names to data set

col_names<-fread("./project/UCI HAR Dataset/UCI HAR Dataset/features.txt")
col_names<-col_names$V2
colnames(test_data)<-col_names
colnames(train_data)<-col_names

ext_bol1<-ext_bol2<-0
ext_bol1<-grep("mean()", col_names)
ext_bol2<-grep("std()", col_names)
ext_bol<-c(ext_bol1,ext_bol2)
ext_bol<-sort(ext_bol)

test_data<-subset(test_data, select=ext_bol)
train_data<-subset(train_data, select=ext_bol)

#join activity with activity label
train_activity<-arrange(join(train_activity,activity_label),V1)
test_activity<-arrange(join(test_activity,activity_label),V1)

#merge training and test data
merged_data<-rbind(train_data,test_data)
merged_subject<-rbind(train_subject,test_subject)
merged_activity<-rbind(train_activity,test_activity)

merged_activity<-subset(merged_activity,select=V2)

merged_all<-cbind(merged_subject, merged_activity,merged_data)


#add column names
colnames(merged_all)[1]<-"subject_id"
colnames(merged_all)[2]<-"activity"

###aggregate (mean) by subject_id and activity and order by subject
tidy<-aggregate(.~ subject_id + activity, merged_all, mean)
tidy<-tidy[order(tidy$subject_id),]

write.table(tidy, file = "tidydata.txt",row.names = FALSE)

