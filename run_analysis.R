library(plyr)

########################################################################
####Step - 1: Read the Data into R,Merge the test and Training Datasets
########################################################################

xtr1<-read.table("train/X_train.txt")
ytr1<-read.table("train/y_train.txt")
sub_train<-read.table("train/subject_train.txt")
xytr<-cbind(xtr1,ytr1,sub_train)

xte1<-read.table("test/X_test.txt")
yte1<-read.table("test/y_test.txt")
sub_test<-read.table("test/subject_test.txt")
xyer<-cbind(xte1,yte1,sub_test)

###Assign column names and merge test and training data sets
feature<-read.table("features.txt",stringsAsFactors = FALSE)[[2]]
fullobs<-rbind(xyer,xytr)
colnames(fullobs)<-c(feature,"activity","subject")
act_label<-read.table("activity_labels.txt")

###########################################################################
# Step - 3. Uses descriptive activity names to name the activities in the data set
###########################################################################

currentActivity = 1
for (currentActivityLabel in act_label$V2) {
  fullobs$activity <- gsub(currentActivity, currentActivityLabel, fullobs$activity)
  currentActivity <- currentActivity + 1
}

###########################################################################
# Step - 2. Extracts only mean and std deviation related data
###########################################################################


extract_obs <- fullobs[,grepl("mean|std|subject|activity", names(fullobs))]

###########################################################################
##Step-4 Give descriptive variable names
##########################################################################

names(extract_obs) <- gsub('\\(|\\)',"",names(extract_obs), perl = TRUE)

names(extract_obs) <- gsub('Acc',"Acceleration",names(extract_obs))
names(extract_obs) <- gsub('GyroJerk',"AngularAcceleration",names(extract_obs))
names(extract_obs) <- gsub('Gyro',"AngularSpeed",names(extract_obs))
names(extract_obs) <- gsub('Mag',"Magnitude",names(extract_obs))
names(extract_obs) <- gsub('^t',"TimeDomain.",names(extract_obs))
names(extract_obs) <- gsub('^f',"FrequencyDomain.",names(extract_obs))
names(extract_obs) <- gsub('\\.mean',".Mean",names(extract_obs))
names(extract_obs) <- gsub('\\.std',".StandardDeviation",names(extract_obs))
names(extract_obs) <- gsub('Freq\\.',"Frequency.",names(extract_obs))
names(extract_obs) <- gsub('Freq$',"Frequency",names(extract_obs))


###########################################################################
##Step-5 create tidy data set
##########################################################################
tidy_data = ddply(extract_obs, c("activity","subject"), numcolwise(mean))
write.table(tidy_data, file = "tidy_data.txt")