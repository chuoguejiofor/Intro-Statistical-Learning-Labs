# -*- coding: utf-8 -*-
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.api as sm
import statsmodels.formula.api as smf
#Simple Linear Regression
Boston = pd.read_csv('../data/Boston.csv', index_col=0)

Boston.columns
#medv (median house value), lstat(percent of households with low socioeconomic status)
lm = smf.ols(formula ='medv ~ lstat', data=Boston).fit()
print(lm.summary())

#Obtains confidence intervals for the coefficient estimates
print(lm.conf_int())

#Plots with the least squares regression line
#Looks like a non-linear association
Boston.plot(kind="scatter", x="lstat", y="medv")
preds = lm.predict(Boston.medv)
plt.plot(Boston.lstat, preds, c='red')

#The plot_regress_exog function is a convenience function that gives a 2x2 plot
fig = plt.figure(figsize=(12,8))
fig = sm.graphics.plot_regress_exog(lm, "lstat", fig=fig)

#Multiple Linear Regression

lm = smf.ols(formula ='medv ~ lstat+age', data=Boston).fit()
print(lm.summary())

#Include all predictors
lm = smf.ols(formula ='medv ~.', data=Boston).fit()
print(lm.summary())