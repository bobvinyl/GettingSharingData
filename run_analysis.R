# setwd("C:\\Users\\rlange1\\Box Sync\\Data Science\\GettingCleaning\\work\\project")

library(dplyr)
originalDataLoc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("data.zip")) {
    download.file(originalDataLoc,
                  "data.zip")
    dateDownloaded <- date()
    print(paste("File downloaded on ", dateDownloaded, ".", sep=""))
    write.table(c(paste("URL:",originalDataLoc,sep=" "),paste("Download Date:",dateDownloaded,sep=" ")),
                "data_download_info.txt",row.names=FALSE,col.names=FALSE)
    unzip("data.zip")
    print("Data unzipped.")
}

setwd(paste(getwd(),"\\UCI HAR Dataset",sep=""))

fields <- read.table("features.txt")

# Get the std and mean fields
impFields <- merge(fields[grep("std()",fields$V2,fixed=TRUE), ], 
                   fields[grep("mean()",fields$V2,fixed=TRUE), ], 
                   by.X="V1", by.Y="V1", all=TRUE, sort=TRUE)[,2]
impFieldNums <- sort(c(grep("std()",fields$V2,fixed=TRUE),
                       grep("mean()",fields$V2,fixed=TRUE)))

actLabels <- read.table("activity_labels.txt")

testdata <- read.table("test/subject_test.txt")
testdataX <- read.table("test/X_test.txt")
testdataY <- read.table("test/Y_test.txt")
traindata <- read.table("train/subject_train.txt")
traindataX <- read.table("train/X_train.txt")
traindataY <- read.table("train/Y_train.txt")

# Set working directory back so that output goes back in the project root
setwd(".\\..")

# Reduce to important fields and rename fields for test
testdataX <- testdataX[,impFieldNums]
names(testdataX) <- impFields
# Add subject
testdataX$subject <- testdata[,1]
# Add activity
testdataX$activity <- merge(testdataY, actLabels, by="V1")[,2]
testdataX <- testdataX[,c(67,68,1:66)]

# Reduce to important fields and rename fields for train
traindataX <- traindataX[,impFieldNums]
names(traindataX) <- impFields
# Add subject
traindataX$subject <- traindata[,1]
# Add activity
traindataX$activity <- merge(traindataY, actLabels, by="V1")[,2]
traindataX <- traindataX[,c(67,68,1:66)]

# Merge test and train data
mergeddata <- merge(testdataX, traindataX, by=names(testdataX), 
                    sort=TRUE, all=TRUE)

# Write tidied data to file
write.table(mergeddata,file="tidy_samsung_means_and_stds.txt",row.names=FALSE)

# Create second tidy data file
grouped <- group_by(tbl_df(mergeddata),subject,activity)
group_summ <- summarize(grouped,
                        "col3" = mean(names(grouped)[3])
                        )
#for(col in names(grouped)[3:length(names(grouped))]) {
#    
#}



