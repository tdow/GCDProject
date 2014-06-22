library(reshape2)

headers <- read.table("./UCI HAR Dataset/features.txt")
to_match <- grep("mean()|std()", headers[,2])

activity <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("Id", "Activity"))

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = t(headers[,2]))
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names="ActivityID" )
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="SubjectID")

xtrain_meanstd <- xtrain[,to_match]

train <- cbind(subtrain,ytrain, xtrain_meanstd)




xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = t(headers[,2]))
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names="ActivityID" )
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="SubjectID")

xtest_meanstd <- xtest[,to_match]

test <- cbind(subtest,ytest, xtest_meanstd)

combined <- rbind(train, test)
merged <- merge(combined, activity, by.x="ActivityID", by.y="Id")

names(merged) <- gsub("\\.", "", names(merged))

meltedData <- melt(merged, id.vars=c("SubjectID", "ActivityID", "Activity"))
tidy <- dcast(meltedData, SubjectID + Activity ~ variable, mean)

write.csv(tidy, "./tidyDataSet.csv", row.names=FALSE)
