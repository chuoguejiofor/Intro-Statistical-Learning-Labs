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
#Looks like a non-linear association
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

#Multiple Linear Regression

lm.fit=lm(medv~lstat+age, data=Boston)
summary(lm.fit)

#Short hand to include all the predictors
lm.fit=lm(medv~.,data=Boston)
summary(lm.fit)

#The car library is a "Companion to Applied Regression"
#The vif() function, is part of the car package
library(car)
vif(lm.fit)

#To do a regression on all but one variable
lm.fit1=lm(medv~.-age, data=Boston)
summary(lm.fit1)

#Interaction Terms

#Lstat*age includes lstat, age, and the interaction term lstat X age
summary(lm(medv~lstat*age, data=Boston))

#Non-linear Transformations of the Predictors

#I() is needed since '^' has a special meaning in a formula
lm.fit2=lm(medv~lstat + I(lstat^2), data=Boston)
summary(lm.fit2)

#We can use anova() here to compare the quadratic fit to the linear fit
lm.fit=lm(medv~lstat, data=Boston)
anova(lm.fit, lm.fit2)

#When lstat^2 is included, there is little pattern in the residuals
par(mfrow=c(2,2))
plot(lm.fit2)

#In order to create a cubic fit, we can include a predictor of the form I(X^3)
#This can get cumbursome for high-order polynomials. A better approach is with poly()
lm.fit5=lm(medv~poly(lstat, 5), data=Boston)
summary(lm.fit5)

#Qualitative Predictors

#The Carseats data includes qualitative predictors.
#Such as Shelveloc, an indicator of shelving location quality.
#Bad, Medium, Good
names(Carseats)

#R generates dummy variables automatically
lm.fit=lm(Sales~.+Income:Advertising+Price:Age, data=Carseats)
summary(lm.fit)

#The contrasts() function returns the coding that R uses for the dummy variables.
attach(Carseats)
contrasts(ShelveLoc)
