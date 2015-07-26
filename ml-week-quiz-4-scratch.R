library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 
vowel.train$y = factor(vowel.train$y)
vowel.test$y = factor(vowel.test$y)
set.seed(33833)

library(caret)
p1 <- train(y ~ . ,method="rf", data=vowel.train)
p2 <- train(y ~ . ,method="gbm", data=vowel.train)

sum(predict(p1,vowel.test) == vowel.test$y) / nrow(vowel.test)
sum(predict(p2,vowel.test) == vowel.test$y) / nrow(vowel.test)
agree <- which(predict(p1,vowel.test) == predict(p2,vowel.test))
sum(predict(p2,vowel.test[agree,]) == vowel.test$y[agree]) / nrow(vowel.test[agree,])
#[1] 0.6038961
#[1] 0.5108225
#[1] 0.63125

library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)

p1 <- train(diagnosis ~ . ,method="rf", data=training)
p2 <- train(diagnosis ~ . ,method="gbm", data=training)
p3 <- train(diagnosis ~ . ,method="lda", data=training)

p1.v <- predict(p1, testing)
p2.v <- predict(p2, testing)
p3.v <- predict(p3, testing)
ens.v <- data.frame(p1.v, p2.v, p3.v, diagnosis=testing$diagnosis)
ens.p <- train(diagnosis ~ ., method="rf", data=ens.v)
ens <- predict(ens.p, newdata=ens.v)
sum(p1.v == testing$diagnosis) / length(testing$diagnosis)
sum(p2.v == testing$diagnosis) / length(testing$diagnosis)
sum(p3.v == testing$diagnosis) / length(testing$diagnosis)
sum(ens == testing$diagnosis) / length(testing$diagnosis)
#[1] 0.7804878
#[1] 0.804878
#[1] 0.7682927
#[1] 0.8170732

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

library(largs)
set.seed(233)
lasso<-lars(as.matrix(training[,-c(9)]), training$CompressiveStrength, type="lasso", trace=TRUE)
plot(lasso)
#Cement

library(lubridate)  # For year() function below
dat = read.csv("~/dev/datasciencecoursera/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)
tstest = ts(testing$visitsTumblr, start=length(tstrain)+1)
library(forecast)
model <- bats(tstrain)
fcast <- forecast(model, h=length(tstest))

plot(fcast); lines(tstest,col="red")
fcastdata <- as.data.frame(fcast)
sum( tstest > fcastdata$`Lo 95` & tstest < fcastdata$`Hi 95`) / length(tstest)

set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(325)
library(e1071)
svm.model <- svm(CompressiveStrength ~ ., data = training)
svm.pred  <- predict(svm.model, testing)
#RMSE
sqrt(mean((svm.pred - testing$CompressiveStrength)^2))
