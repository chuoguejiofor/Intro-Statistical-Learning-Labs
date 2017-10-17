library(MASS)
library(ISLR)

#Simple Linear Regression

names(Boston)
#medv (median house value), lstat(percent of households with low socioeconomic status)
lm.fit=lm(medv~lstat,data=Boston)
lm.fit

summary(lm.fit)

#Obtains confidence intervals for the coefficient estimates
confint(lm.fit)

#Produces confidence and predicition intervals
predict(lm.fit ,data.frame(lstat=c(5,10,15)), interval = "confidence")
predict(lm.fit ,data.frame(lstat=c(5,10,15)), interval = "prediction")

#Plots with the least squares regression line
attach(Boston)
plot(lstat, medv)
abline(lm.fit)

#Divides the plotting region into a 2x2 grid of panels
par(mfrow=c(2,2))
plot(lm.fit)

#Residuals
plot(predict(lm.fit), residuals(lm.fit))
#Studentized residuals
plot(predict(lm.fit), rstudent(lm.fit))

#Leverage statistics
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))
