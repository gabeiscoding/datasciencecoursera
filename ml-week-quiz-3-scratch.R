library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

#1. Subset the data to a training set and testing set based on the Case variable in the data set. 
seg <- split(segmentationOriginal, segmentationOriginal$Case)

#2. Set the seed to 125 and fit a CART model with the rpart method using all predictor variables and default caret settings. 
set.seed(125)
library(rpart)
fit <- train(Class ~ ., method="rpart", data=seg$Train)

#3. In the final model what would be the final model prediction for cases with the following variable values:
predict(fit, newdata=data.frame(TotalIntenCh2 = c(23000), FiberWidthCh1 = c(10), PerimStatusCh1=c(2)), type="raw")
library(rattle)
fancyRpartPlot(fit$finalModel)

#a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2  => PS
#b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100  => WS
#c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100  => PS
#d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2 => NA


#The bias is larger and the variance is smaller.

library(pgmm)
data(olive)
olive = olive[,-1]
fit <- train(Area ~ ., method="rpart", data=olive)
newdata = as.data.frame(t(colMeans(olive)))
predict(fit, newdata = newdata)

library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)
fit <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, method="glm", family="binomial", data=trainSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
missClass(trainSA$chd, predict(fit, trainSA)) #27%
missClass(testSA$chd, predict(fit, testSA)) #31%

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 
vowel.train$y <- factor(vowel.train$y)
vowel.test$y <- factor(vowel.test$y)

set.seed(33833)
fit <- train(y ~ ., method="rf", data=vowel.train)
varImp(fit)
