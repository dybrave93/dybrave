getwd()
setwd("/Users/dybrave/Desktop")
getwd()
install.packages("dplyr")
library(dplyr)
inputData<- read.csv("adult.csv")
str(inputData)
summary(inputData)
options(install.packages.check.source="no")

#EDA
ABOVE50K<- filter(inputData,ABOVE50K==1)
BELOW50K<- filter(inputData,ABOVE50K==0)
attributes(inputData)
inputData[1:5, ]
head(inputData)
tail(inputData)
head(inputData,10)
idx<- sample(1:nrow(inputData),5)
idx
inputData[idx, ]
inputData[1:10,"EDUCATION"]
inputData[1:10,1]
inputData$EDUCATION[1:10]
summary(inputData)
quantile(inputData$EDUCATIONNUM)
quantile(inputData$EDUCATIONNUM,c(0.1,0.3,0.65))
var(inputData$EDUCATIONNUM)
mean(inputData$EDUCATIONNUM)
median(inputData$EDUCATIONNUM)
range(inputData$EDUCATIONNUM)
quantile(inputData$EDUCATIONNUM)
hist(inputData$EDUCATIONNUM)
plot(density(inputData$EDUCATIONNUM))
table(inputData$EDUCATIONNUM)
pie(table(inputData$EDUCATIONNUM))
barplot(table(inputData$EDUCATIONNUM))

#After checking the distributions of individual variables, we then investigate the relationships between two variables. Below we calculate covariance and correlation between variables with cov()and cor()
cov(inputData$EDUCATIONNUM,inputData$ABOVE50K)
cov(inputData$AGE,inputData$ABOVE50K)
cor(inputData$EDUCATIONNUM,inputData$ABOVE50K)
cor(inputData$AGE,inputData$ABOVE50K)
cor(inputData[,1:15])

aggregate(EDUCATIONNUM ~ ABOVE50K, summary, data=inputData)

boxplot(EDUCATIONNUM ~ ABOVE50K, data=inputData, xlab="ABOVE50K", ylab="EDUCATIONNUM")

plot(inputData$RELATIONSHIP, inputData$RACE, col=inputData$ABOVE50K, pch=as.numeric(inputData$ABOVE50K))


pairs(inputData)

lsfit(inputData$EDUCATIONNUM, inputData$ABOVE50K)$coefficients

lm(EDUCATION ~ AGE, data=inputData)$coefficients
plot(inputData$EDUCATION, inputData$AGE, pch=21, bg=c("green3","red")
     [unclass(inputData$ABOVE50K)], main="Income data", xlab="education", 
     ylab="AGE")
abline(lm(EDUCATION ~ AGE, data=inputData)$coefficients, col="black")

summary(lm(EDUCATIONNUM ~ AGE, data=inputData))

plot(inputData$EDUCATIONNUM, inputData$AGE, pch=21, bg=c("green3","red")
     [unclass(inputData$ABOVE50K)], main="Income Data", xlab="Education number", ylab="age")
abline(lm(EDUCATIONNUM ~ AGE, data=inputData)$coefficients, col="black")
abline(lm(EDUCATIONNUM ~ AGE, data=inputData[which(inputData$ABOVE50K=="0" ),])
       $coefficients, col="green3")
abline(lm(EDUCATIONNUM ~ AGE, data=inputData[which(inputData$ABOVE50K=="1" ),])
       $coefficients, col="red")

lm(EDUCATIONNUM ~ OCCUPATION, data=inputData)$coefficients
plot(inputData$EDUCATIONNUM, inputData$OCCUPATION, pch=21, bg=c("green3","red")
     [unclass(inputData$ABOVE50K)], main="Income data", xlab="education number", 
     ylab="OCCUPATION")
abline(lm(EDUCATIONNUM ~ OCCUPATION, data=inputData)$coefficients, col="black")
#data munging
install.packages("gapminder")
library(gapminder)
filter(inputData,ABOVE50K==1)
filter(inputData,SEX== "Female")
filter(inputData,EDUCATIONNUM < 11)
inputData[inputData$EDUCATIONNUM < 11, ]
subset(inputData, SEX =="Female", )
inputData %>% head
inputData %>% head(3)
inputData %>% select(EDUCATIONNUM, SEX)

inputData %>% select(EDUCATIONNUM, SEX)%>%
head(4)

inputData %>% filter(SEX == "female")
select(-EDUCATIONNUM, -SEX)
install.packages("tidyr")
library(tidyr)


###naive bayes
inputData$ABOVE50K<-factor(inputData$ABOVE50K)
str(inputData$ABOVE50K)
table(inputData$ABOVE50K)
sample_inputData=sample(150,110,replace=FALSE)
inputData_training=inputData[sample_inputData,]
inputData_test=inputData[-sample_inputData,]
inputData_training_labels=inputData[sample_inputData,]$ABOVE50K
inputData_test_labels=inputData[-sample_inputData,]$ABOVE50K
table(inputData_training$ABOVE50K)
table(inputData_test$ABOVE50K)
##training a model
install.packages("e1071")
library(e1071)
inputData_classifier<- naiveBayes(inputData_training,inputData_training_labels)
##evaluating model performance
inputData_test_pred<-predict(inputData_classifier,inputData_test)
inputData_test_pred
install.packages("gmodels")
library(gmodels)
CrossTable(inputData_test_pred, inputData_test_labels,prop.chisq=FALSE, prop.t=FALSE, dnn=c('predicted','actual'))
##improving model performance
inputData_classifier2<-naiveBayes(inputData_training,inputData_training_labels,laplace=1)
inputData_test_pred2<- predict(inputData_classifier2, inputData_test)
inputData_test_pred2
CrossTable(inputData_test_pred2, inputData_test_labels,prop.chisq=FALSE, prop.t=FALSE, prop.r=FALSE, dnn=c('predicted','actual'))

###decision tree
table(inputData$RELATIONSHIP)
table(inputData$MARITALSTATUS)
summary(inputData$AGE)
summary(inputData$EDUCATIONNUM)
table(inputData$ABOVE50K)
set.seed(123)
train_sample<-sample(1000,900)
str(train_sample)
inputData_train<-inputData[train_sample, ]
inputData_test<-inputData[-train_sample, ]
prop.table(table(inputData_train$ABOVE50K))
prop.table(table(inputData_test$ABOVE50K))
#training a model
install.packages('C50')
library(C50)
str(inputData_train$ABOVE50K)
inputData_model<-C5.0 (inputData_train[-17],factor(inputData_train$ABOVE50K))
inputData_model
summary(inputData_model)
#evaluating model performance
inputData_pred<-predict(inputData_model,inputData_test)
install.packages('gmodels')
library(gmodels)
CrossTable(inputData_test$ABOVE50K,inputData_pred, prop.chisq=FALSE, prop.c=FALSE, prop.r=FALSE, dnn=c('actual default','predicted default'))

##logistic regression 
head(inputData)
table(inputData$ABOVE50K)
input_ones<-inputData[which(inputData$ABOVE50K ==1), ]
input_zeros<-inputData[which(inputData$ABOVE50K ==0), ]
set.seed(100)
input_ones_training_rows<-sample(1:nrow(input_ones),0.7*nrow(input_ones))
input_zeros_training_rows<-sample(1:nrow(input_zeros),0.7*nrow(input_ones))
training_ones<-input_ones[input_ones_training_rows, ]
training_zeros<-input_zeros[input_zeros_training_rows, ]
trainingData<-rbind(training_ones,training_zeros)
test_ones<-input_ones[-input_ones_training_rows, ]
test_zeros<- input_zeros[-input_zeros_training_rows, ]
testData<- rbind(test_ones, test_zeros)
#create WOE for categorical variables
for(factor_var in factor_vars){
  inputData[[factor_var]] <- WOE(X=inputData[, factor_var], Y=inputData$ABOVE50K)
}
head(inputData)
#compute information values
install.packages("X11")
install.packages("XQuartz")
install.packages("smbinning")
library(smbinning)
factor_vars <- c ("WORKCLASS", "EDUCATION", "MARITALSTATUS", "OCCUPATION", "RELATIONSHIP", "RACE", "SEX", "NATIVECOUNTRY")
continuous_vars <- c("AGE", "FNLWGT","EDUCATIONNUM", "HOURSPERWEEK", "CAPITALGAIN", "CAPITALLOSS")
iv_df <- data.frame(VARS=c(factor_vars, continuous_vars), IV=numeric(14))  
for(factor_var in factor_vars){ 
	smb <- smbinning.factor(trainingData, y="ABOVE50K", x=factor_var) 
	if(class(smb) != "character"){ iv_df[iv_df$VARS == factor_var, "IV"] <- smb$iv}}
for(continuous_var in continuous_vars){
  smb <- smbinning(trainingData, y="ABOVE50K", x=continuous_var) 
  if(class(smb) != "character"){ 
    iv_df[iv_df$VARS == continuous_var, "IV"] <- smb$iv
  }
}
iv_df <- iv_df[order(-iv_df$IV), ]  
iv_df

#Build Logit Models and Predict
logitMod <- glm(ABOVE50K ~ RELATIONSHIP + AGE + CAPITALGAIN + OCCUPATION + EDUCATIONNUM, data=trainingData, family=binomial(link="logit"))
predicted <- plogis(predict(logitMod, testData)) 
install.packages("InformationValue")
library(InformationValue)
optCutOff<- optimalCutoff(testData$ABOVE50K, predicted)[1]

#model diagnose
summary(logitMod)
vif(logitMod)
misClassError(testData$ABOVE50K, predicted, threshold =optCutOff)
plotROC(testData$ABOVE50K,predicted)
Concordance(testData$ABOVE50K, predicted)
sensitivity(testData$ABOVE50K, predicted, threshold = optCutOff)
specificity(testData$ABOVE50K, predicted, threshold = optCutOff)
confusionMatrix(testData$ABOVE50K, predicted, threshold=optCutOff)

