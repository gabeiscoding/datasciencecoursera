library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]


library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
hist(training$Superplasticizer)
min(training$Superplasticizer)
hist(log(training$Superplasticizer+1))

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
t <- training[,grep("^IL", colnames(training))]
PCs <- preProcess(t,method="pca",thresh=0.80)

#With PCs
preProc <- preProcess(t, method="pca", thresh=0.8)
trainPC <- predict(preProc, t)
modelFit <- train(training$diagnosis ~ ., method="glm", data=trainPC)
# calculate PCs for test data
testPC <- predict(preProc, testing[,grep("^IL", colnames(testing))])
# compare results
confusionMatrix(testing$diagnosis,predict(modelFit,testPC))

#Without PCs
modelFit2 <- train(training$diagnosis ~ ., method="glm", data=t)
# compare results
confusionMatrix(testing$diagnosis,predict(modelFit2,testing[,grep("^IL", colnames(testing))]))
