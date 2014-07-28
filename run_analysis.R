################################################################################
## 1. Merges the training and the test sets to create one data set.           ##
## 2. Extracts only the measurements on the mean and standard deviation       ##
## for each measurement.                                                      ##
## 3. Uses descriptive activity names to name the activities in the data      ##
## set                                                                        ##
## 4. Appropriately labels the data set with descriptive variable names.      ##
## 5. Creates a second, independent tidy data set with the average of         ##
## each variable for each activity and each subject.                          ##
################################################################################
## Reference: https://github.com/sumatheja/datacleaning_courseproject


##------------------------------------------------------------------------------
#### Part1. Reading subject_train, X_train, y_train from the folder 'train'.
##------------------------------------------------------------------------------
trainX       <- read.table("./data/train/X_train.txt")
dim(trainX)                                                       # 7352*561
head(trainX)
trainY       <- read.table("./data/train/y_train.txt")
table(trainY)
trainSubject <- read.table("./data/train/subject_train.txt")
testData     <- read.table("./data/test/X_test.txt")
dim(testData)                                                     # 2947*561
testLabel    <- read.table("./data/test/y_test.txt")
table(testLabel)
testSubject  <- read.table("./data/test/subject_test.txt")
Data         <- rbind(trainX, testData)
dim(Data)                                                         # 10299*561
Label        <- rbind(trainY, testLabel)
dim(Label)                                                        # 10299*1
Subject      <- rbind(trainSubject, testSubject)
dim(Subject)                                                      # 10299*1

##------------------------------------------------------------------------------
#### Part2. Extracting the data for mean and standard deviation.
##------------------------------------------------------------------------------
features       <- read.table("./data/features.txt")
dim(features)                                                     # 561*2
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices)                                            # 66
Data           <- Data[, meanStdIndices]
dim(Data)                                                         # 10299*66
names(Data)    <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # rm "()"
## capitalize M
names(Data)    <- gsub("mean", "Mean", names(Data))
## capitalize S
names(Data)    <- gsub("std", "Std", names(Data))
## remove "-" in column names
names(Data)    <- gsub("-", "", names(Data))

##------------------------------------------------------------------------------
#### Part3. Descriptive activity names
##------------------------------------------------------------------------------
activity                     <-read.table("./data/activity_labels.txt")
activity[, 2]                <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel                <- activity[Label[, 1], 2]
Label[, 1]                   <- activityLabel
names(Label)                 <- "Activity"

##------------------------------------------------------------------------------
## Part4. Appropriately labels
##------------------------------------------------------------------------------
names(Subject) <- "Subject"
rawData        <- cbind(Subject, Label, Data)
dim(rawData)                                                      #10299*68
##write out the 1st dataset
write.table(rawData, "rawdata.txt")

##------------------------------------------------------------------------------
## Part5. Independent tidy data set
##------------------------------------------------------------------------------
subjectLen         <- length(table(Subject))                      # 30
activityLen        <- dim(activity)[1]                            # 6
columnLen          <- dim(rawData)[2]
tidyData           <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)
tidyData           <- as.data.frame(tidyData)
colnames(tidyData) <- colnames(rawData)
row                <- 1
for(i in 1:subjectLen)
{
    for(j in 1:activityLen)
        {
            tidyData[row, 1]           <- sort(unique(Subject)[, 1])[i]
            tidyData[row, 2]           <- activity[j, 2]
            bool1                      <- i == rawData$Subject
            bool2                      <- activity[j, 2] == rawData$Activity
            tidyData[row, 3:columnLen] <-
                colMeans(rawData[bool1&bool2, 3:columnLen])
            row                        <- row + 1
        }
}
head(tidyData)
tidyData <- tidyData[order(tidyData$Activity),]
## write out the 2nd dataset
write.table(tidyData, row.names=F,"tidydata.txt")
