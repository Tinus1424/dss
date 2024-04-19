# Course:   Statistics and methodology
# Title:    Week 3 lab demonstration script
# Author:   Kyle M. Lang, Edo
# Created:  2017-09-08
# Modified: 2023-01-31

# Set up -----------------------------------------------------------------------

# Make sure workspace is clean
rm(list = ls(all = TRUE))

# Install required packages
#install.packages("MLmetrics", repos = "http://cloud.r-project.org")

# Load required packages (required for MSEs)
library(MLmetrics)

# Make sure the working directory is set to the location of this file

setwd("~/1_r/statistics/week-3-lab/code")

# Define data location
dataDir <- "../data/"

# Load boring cars data from the lab folder
cars <- readRDS(paste0(dataDir, "boring-cars.rds"))

# Load Mercedes data from the lab folder
mercedes <- readRDS(paste0(dataDir, "mercedes.rds"))

# 1. Simple Linear Regression --------------------------------------------------

# Fit a simple linear regression model:
slr.fit0 <- lm(qsec ~ hp, data = cars)

# Centers the intersect of hp on the mean
mhp <- cars$hp - mean(cars$hp)

slr.fit <- lm(qsec ~ mhp, data = cars)


# See what's inside the fitted lm object:
# Returns a character vector of all the names inside the objects
ls(slr.fit)

# Summarize the results:
summary(slr.fit0)
summary(slr.fit)

# You can store the 'summary' output as an object in your R environment:
slr.fit.sum <- summary(slr.fit)

# And you can check what is inside that object:
ls(slr.fit.sum)

# Access the R^2 slot in the summary object:
slr.fit.sum$r.squared

# Extract coefficients:
coef(slr.fit)

# Extract residuals:
resid(slr.fit)

# Extract fitted values:
fitted(slr.fit)

# Which (in this case) is the same as the predicted values:
predict(slr.fit)

# 1.1 Reproduce the inferential tests from week 2 lab --------------------------

# t-test:
t.test(mpg ~ am, data = cars, var.equal = TRUE)

# t-test with linear regression:
summary(lm(mpg ~ am, data = cars))

# correlation test:
with(cars, cor.test(mpg, wt))

# correlation test w/ linear regression (naive)
summary(lm(mpg ~ wt, data = cars))

# correlation test w/ linear regression (standardized variables and coefficients)
summary(lm(scale(mpg) ~ scale(wt), data = cars))

# 2. Multiple Linear Regression ------------------------------------------------

# Fit a multiple linear regression model:
mlr.fit <- lm(qsec ~ hp + wt + carb, data = cars)

# Summarize the model:
mlr.fit.sum <- summary(mlr.fit)

# Extract R^2:
mlr.fit.sum$r.squared

# Extract F-stat:
mlr.fit.sum$fstatistic

# Extract coefficients:
mlr.coef <- coef(mlr.fit)

# Extract the regression coefficient estimates standard errors from the model fit
mlr.coef.se <- sqrt(diag(vcov(mlr.fit)))

# Manually compute t-statistics for each coefficient estimate:
mlr.coef.t <- mlr.coef / mlr.coef.se

# Compare the t-statistics and standard errors
mlr.fit.sum
cbind(
    Est = mlr.coef,
    se = mlr.coef.se,
    t = mlr.coef.t
)

# Compute confidence intervals for all coefficients:
confint(mlr.fit)

# Compute confidence intervals for arbitrary parameters:
confint(mlr.fit, parm = c("hp", "wt"))

# Compute 99% confidence intervals
confint(mlr.fit, parm = c("hp", "wt"), level = 0.99)

# 2.1 Model comparison ---------------------------------------------------------

# Compute the change in R^2:
mlr.fit.sum$r.squared - slr.fit.sum$r.squared

# Significant increase in R^2?
anova(slr.fit, mlr.fit)

# Compute the Mean Square Error (MSE) of prediction for the simple linear regression
slr.mse <- MSE(
    y_pred = predict(slr.fit),  # predicted values by the model
    y_true = cars$qsec          # observed values on dv
)

# Compute the Mean Square Error (MSE) of prediction for the multiple linear regression
mlr.mse <- MSE(y_pred = predict(mlr.fit), y_true = cars$qsec)

# Compare MSE values:
slr.mse
mlr.mse

# 2.2 Model building in R ------------------------------------------------------

# Define a starting model
slr.fit <- lm(qsec ~ hp, data = cars)

# Update the model, the long way:
mlr.fit <- lm(qsec ~ hp + wt + gear + carb, data = cars)

# Update the model, the short way:
mlr.fit.2 <- update(slr.fit, ". ~ . + wt + gear + carb")

# And the result is the same!
all.equal(mlr.fit, mlr.fit.2)

# We can also remove variables:
slr.fit.2 <- update(mlr.fit, ". ~ . - wt - gear - carb")

# And the result is the same!
all.equal(slr.fit, slr.fit.2)

# We can estimate the same model on different data:
mlr.fit.new <- update(
    mlr.fit,
    data = mercedes # new data set
)

# The fits will be different!
summary(mlr.fit.new)

summary(mlr.fit)
