> getwd()
[1] "/Users/mstonge/Desktop/TidyData_1"
> setwd("~/Desktop")
> setwd()
Error in setwd() : argument "dir" is missing, with no default
> getwd()
[1] "/Users/mstonge/Desktop"
> library(data.table)
data.table 1.12.8 using 2 threads (see ?getDTthreads).  Latest news: r-datatable.com
> library(data.table)
> featureNames <- read.table("UCI HAR Dataset/features.txt")
> activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
> subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
> activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
> featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
> subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
> activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
> featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
> subject <- rbind(subjectTrain, subjectTest)
> activity <- rbind(activityTrain, activityTest)
> features <- rbind(featuresTrain, featuresTest)
> colnames(features) <- t(featureNames[2])
> colnames(activity) <- "Activity"
> colnames(subject) <- "Subject"
> completeData <- cbind(features,activity,subject)
> columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
> requiredColumns <- c(columnsWithMeanSTD, 562, 563)
> dim(completeData)
[1] 10299   563
> extractedData <- completeData[,requiredColumns]
> dim(extractedData)
[1] 10299    88
> extractedData$Activity <- as.character(extractedData$Activity)
> for (i in 1:6){
+     extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
+ }
> extractedData$Activity <- as.factor(extractedData$Activity)
> names(extractedData)
 [1] "tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                   
 [3] "tBodyAcc-mean()-Z"                    "tBodyAcc-std()-X"                    
 [5] "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                    
 [7] "tGravityAcc-mean()-X"                 "tGravityAcc-mean()-Y"                
 [9] "tGravityAcc-mean()-Z"                 "tGravityAcc-std()-X"                 
[11] "tGravityAcc-std()-Y"                  "tGravityAcc-std()-Z"                 
[13] "tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"               
[15] "tBodyAccJerk-mean()-Z"                "tBodyAccJerk-std()-X"                
[17] "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                
[19] "tBodyGyro-mean()-X"                   "tBodyGyro-mean()-Y"                  
[21] "tBodyGyro-mean()-Z"                   "tBodyGyro-std()-X"                   
[23] "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                   
[25] "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"              
[27] "tBodyGyroJerk-mean()-Z"               "tBodyGyroJerk-std()-X"               
[29] "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"               
[31] "tBodyAccMag-mean()"                   "tBodyAccMag-std()"                   
[33] "tGravityAccMag-mean()"                "tGravityAccMag-std()"                
[35] "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"               
[37] "tBodyGyroMag-mean()"                  "tBodyGyroMag-std()"                  
[39] "tBodyGyroJerkMag-mean()"              "tBodyGyroJerkMag-std()"              
[41] "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                   
[43] "fBodyAcc-mean()-Z"                    "fBodyAcc-std()-X"                    
[45] "fBodyAcc-std()-Y"                     "fBodyAcc-std()-Z"                    
[47] "fBodyAcc-meanFreq()-X"                "fBodyAcc-meanFreq()-Y"               
[49] "fBodyAcc-meanFreq()-Z"                "fBodyAccJerk-mean()-X"               
[51] "fBodyAccJerk-mean()-Y"                "fBodyAccJerk-mean()-Z"               
[53] "fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"                
[55] "fBodyAccJerk-std()-Z"                 "fBodyAccJerk-meanFreq()-X"           
[57] "fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"           
[59] "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                  
[61] "fBodyGyro-mean()-Z"                   "fBodyGyro-std()-X"                   
[63] "fBodyGyro-std()-Y"                    "fBodyGyro-std()-Z"                   
[65] "fBodyGyro-meanFreq()-X"               "fBodyGyro-meanFreq()-Y"              
[67] "fBodyGyro-meanFreq()-Z"               "fBodyAccMag-mean()"                  
[69] "fBodyAccMag-std()"                    "fBodyAccMag-meanFreq()"              
[71] "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-std()"           
[73] "fBodyBodyAccJerkMag-meanFreq()"       "fBodyBodyGyroMag-mean()"             
[75] "fBodyBodyGyroMag-std()"               "fBodyBodyGyroMag-meanFreq()"         
[77] "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-std()"          
[79] "fBodyBodyGyroJerkMag-meanFreq()"      "angle(tBodyAccMean,gravity)"         
[81] "angle(tBodyAccJerkMean),gravityMean)" "angle(tBodyGyroMean,gravityMean)"    
[83] "angle(tBodyGyroJerkMean,gravityMean)" "angle(X,gravityMean)"                
[85] "angle(Y,gravityMean)"                 "angle(Z,gravityMean)"                
[87] "Activity"                             "Subject"                             
> names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
> names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
> names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
> names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
> names(extractedData)<-gsub("^t", "Time", names(extractedData))
> names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
> names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
> names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("angle", "Angle", names(extractedData))
> names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))
> names(extractedData)
 [1] "TimeBodyAccelerometerMean()-X"                    
 [2] "TimeBodyAccelerometerMean()-Y"                    
 [3] "TimeBodyAccelerometerMean()-Z"                    
 [4] "TimeBodyAccelerometerSTD()-X"                     
 [5] "TimeBodyAccelerometerSTD()-Y"                     
 [6] "TimeBodyAccelerometerSTD()-Z"                     
 [7] "TimeGravityAccelerometerMean()-X"                 
 [8] "TimeGravityAccelerometerMean()-Y"                 
 [9] "TimeGravityAccelerometerMean()-Z"                 
[10] "TimeGravityAccelerometerSTD()-X"                  
[11] "TimeGravityAccelerometerSTD()-Y"                  
[12] "TimeGravityAccelerometerSTD()-Z"                  
[13] "TimeBodyAccelerometerJerkMean()-X"                
[14] "TimeBodyAccelerometerJerkMean()-Y"                
[15] "TimeBodyAccelerometerJerkMean()-Z"                
[16] "TimeBodyAccelerometerJerkSTD()-X"                 
[17] "TimeBodyAccelerometerJerkSTD()-Y"                 
[18] "TimeBodyAccelerometerJerkSTD()-Z"                 
[19] "TimeBodyGyroscopeMean()-X"                        
[20] "TimeBodyGyroscopeMean()-Y"                        
[21] "TimeBodyGyroscopeMean()-Z"                        
[22] "TimeBodyGyroscopeSTD()-X"                         
[23] "TimeBodyGyroscopeSTD()-Y"                         
[24] "TimeBodyGyroscopeSTD()-Z"                         
[25] "TimeBodyGyroscopeJerkMean()-X"                    
[26] "TimeBodyGyroscopeJerkMean()-Y"                    
[27] "TimeBodyGyroscopeJerkMean()-Z"                    
[28] "TimeBodyGyroscopeJerkSTD()-X"                     
[29] "TimeBodyGyroscopeJerkSTD()-Y"                     
[30] "TimeBodyGyroscopeJerkSTD()-Z"                     
[31] "TimeBodyAccelerometerMagnitudeMean()"             
[32] "TimeBodyAccelerometerMagnitudeSTD()"              
[33] "TimeGravityAccelerometerMagnitudeMean()"          
[34] "TimeGravityAccelerometerMagnitudeSTD()"           
[35] "TimeBodyAccelerometerJerkMagnitudeMean()"         
[36] "TimeBodyAccelerometerJerkMagnitudeSTD()"          
[37] "TimeBodyGyroscopeMagnitudeMean()"                 
[38] "TimeBodyGyroscopeMagnitudeSTD()"                  
[39] "TimeBodyGyroscopeJerkMagnitudeMean()"             
[40] "TimeBodyGyroscopeJerkMagnitudeSTD()"              
[41] "FrequencyBodyAccelerometerMean()-X"               
[42] "FrequencyBodyAccelerometerMean()-Y"               
[43] "FrequencyBodyAccelerometerMean()-Z"               
[44] "FrequencyBodyAccelerometerSTD()-X"                
[45] "FrequencyBodyAccelerometerSTD()-Y"                
[46] "FrequencyBodyAccelerometerSTD()-Z"                
[47] "FrequencyBodyAccelerometerMeanFreq()-X"           
[48] "FrequencyBodyAccelerometerMeanFreq()-Y"           
[49] "FrequencyBodyAccelerometerMeanFreq()-Z"           
[50] "FrequencyBodyAccelerometerJerkMean()-X"           
[51] "FrequencyBodyAccelerometerJerkMean()-Y"           
[52] "FrequencyBodyAccelerometerJerkMean()-Z"           
[53] "FrequencyBodyAccelerometerJerkSTD()-X"            
[54] "FrequencyBodyAccelerometerJerkSTD()-Y"            
[55] "FrequencyBodyAccelerometerJerkSTD()-Z"            
[56] "FrequencyBodyAccelerometerJerkMeanFreq()-X"       
[57] "FrequencyBodyAccelerometerJerkMeanFreq()-Y"       
[58] "FrequencyBodyAccelerometerJerkMeanFreq()-Z"       
[59] "FrequencyBodyGyroscopeMean()-X"                   
[60] "FrequencyBodyGyroscopeMean()-Y"                   
[61] "FrequencyBodyGyroscopeMean()-Z"                   
[62] "FrequencyBodyGyroscopeSTD()-X"                    
[63] "FrequencyBodyGyroscopeSTD()-Y"                    
[64] "FrequencyBodyGyroscopeSTD()-Z"                    
[65] "FrequencyBodyGyroscopeMeanFreq()-X"               
[66] "FrequencyBodyGyroscopeMeanFreq()-Y"               
[67] "FrequencyBodyGyroscopeMeanFreq()-Z"               
[68] "FrequencyBodyAccelerometerMagnitudeMean()"        
[69] "FrequencyBodyAccelerometerMagnitudeSTD()"         
[70] "FrequencyBodyAccelerometerMagnitudeMeanFreq()"    
[71] "FrequencyBodyAccelerometerJerkMagnitudeMean()"    
[72] "FrequencyBodyAccelerometerJerkMagnitudeSTD()"     
[73] "FrequencyBodyAccelerometerJerkMagnitudeMeanFreq()"
[74] "FrequencyBodyGyroscopeMagnitudeMean()"            
[75] "FrequencyBodyGyroscopeMagnitudeSTD()"             
[76] "FrequencyBodyGyroscopeMagnitudeMeanFreq()"        
[77] "FrequencyBodyGyroscopeJerkMagnitudeMean()"        
[78] "FrequencyBodyGyroscopeJerkMagnitudeSTD()"         
[79] "FrequencyBodyGyroscopeJerkMagnitudeMeanFreq()"    
[80] "Angle(TimeBodyAccelerometerMean,Gravity)"         
[81] "Angle(TimeBodyAccelerometerJerkMean),GravityMean)"
[82] "Angle(TimeBodyGyroscopeMean,GravityMean)"         
[83] "Angle(TimeBodyGyroscopeJerkMean,GravityMean)"     
[84] "Angle(X,GravityMean)"                             
[85] "Angle(Y,GravityMean)"                             
[86] "Angle(Z,GravityMean)"                             
[87] "Activity"                                         
[88] "Subject"                                          
> extractedData$Subject <- as.factor(extractedData$Subject)
> extractedData <- data.table(extractedData)
> tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
> tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
> write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
