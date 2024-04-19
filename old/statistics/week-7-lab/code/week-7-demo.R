# Course:   Statistics and methodology
# Title:    Week 7 lab demonstration script
# Author:   Kyle M. Lang, Edo
# Created:  2017-10-08
# Modified: 2023-03-14

# Set up -----------------------------------------------------------------------

# Clean environment
rm(list = ls(all = TRUE))
setwd("~/1_r/statistics/week-7-lab/code")

# Load the packages we need
library(MASS)     # For the 'Cars93' data
library(lmtest)   # Provides Breusch-Pagan and RESET Tests
library(moments)  # Provides skewness and kurtosis
library(sandwich) # Provided HC variance estimators

# Load some data:
data(Cars93)

# 1. Regression diagnostics ----------------------------------------------------

# Fit a linear model of interest
out1 <- lm(Price ~ Horsepower + MPG.city + Passengers, data = Cars93)

# Look at the summary
summary(out1)

# 1.1 Homoscedasticity ---------------------------------------------------------

# Extract the residuals
res1  <- resid(out1)

# Extract the fitted values
yHat1 <- fitted(out1)

# 1.1.1 Visual check: residual plot --------------------------------------------

# Residuals vs. Fitted plot
plot(y = res1, x = yHat1)

# Add a horizontal line as a visual aid
abline(h = 0, col = "red")

# 1.1.2 Test: Breusch-Pagan Test -----------------------------------------------

# Run the Breusch-Pagan Test:
bptest(out1)

# 1.1.3 Consequences of assuming homoscedasticity (when we shouldn't) ----------

# Compute regular ACOV
cov1 <- vcov(out1)

# Identify the standard errors
summary(out1)$coefficients

# Or equivalently
sqrt(diag(cov1))

# Compute Heteroscedasticity Consistent (HC) estimate of the ACOV
covHC1 <- vcovHC(out1)

# So the HC standard errors are
sqrt(diag(covHC1))

# Perform robust t-tests for the coefficients
coeftest(out1, vcov = covHC1)

# Define a more complex model (e.g. by adding some interactions):
out1.2 <- update(out1, ". ~ . + Horsepower * MPG.city + Passengers * MPG.city")
summary(out1.2)

# Test the change in R2 assuming homoscedasticity
anova(out1, out1.2)

# Compute the HC vcov for the more complex model
covHC1.2 <- vcovHC(out1.2)

# And perform the change in R-squared test using the appropriate covariance matrix
waldtest(out1, out1.2, vcov = covHC1.2)

# 1.2 Normality of the residuals -----------------------------------------------

# 1.2.1 Understanding normality ------------------------------------------------

# How a normal distribution looks like
plot(density(rnorm(10000)))

# Create a kernel density plot of 'Price'
plot(density(Cars93$Price))

# What is the skewness of a normal distribution?
skewness(rnorm(10000))

# Check skewness of 'Price'
skewness(Cars93$Price)

# What is the kurtosis of a normal distribution?
kurtosis(rnorm(10000))

# Check kurtosis of 'Horsepower'
kurtosis(Cars93$Horsepower)

# 1.2.2 Normality of the residuals ---------------------------------------------

# Create a kernel density plot of the residuals
plot(density(res1))

# Skewness of the residuals from model out1
skewness(res1)

# Kurtosis of the residuals from model out1
kurtosis(res1)

# Q-Q Plot
qqnorm(res1)
qqline(res1)

# Alternative using plot.lm function
plot(out2, which = 2)

# Test the normality of residuals via Shapiro-Wilk test
shapiro.test(res1)

# Test the normality of residuals via Kolmogorov-Smirnov test
ks.test(x = res1, y = pnorm, mean = mean(res1), sd = sd(res1))

# 1.3 Model (mis)specification -------------------------------------------------

# 1.3.1 Nonlinear trends in residual plots -------------------------------------

# Plot the model residuals against the fitted values (w/ loess line)
scatter.smooth(
  x = yHat1,
  y = res1,
  span = 0.5 # smoothness parameter for loess
)

# Add horizontal line as visual aid
abline(h = 0, col = "gray")

# Alternative using plot.lm function
plot(out1, which = 1)

# 1.3.2 Functional form misspecification test ----------------------------------

# Consider a different model
out2 <- lm(MPG.city ~ Horsepower + Fuel.tank.capacity + Weight, data = Cars93)
summary(out2)

# Visual: Nonlinear Trends in residual (vs. predicted) plot
plot(out2, which = 1)

# Perform the Ramsey RESET Test
resettest(out2)

# Update the model to investigate if the relationship with Horsepower is quadratic
out2.1 <- update(out2, ". ~ . + I(Horsepower^2)")
summary(out2.1)

# Nonlinear Trends in residual (vs. predicted) plot
plot(out2.1, which = 1)

# Perform the Ramsey RESET Test again
resettest(out2.1)

# Update the model to investigate if relationship with Weight is quadratic
out2.2 <- update(out2, ". ~ . + I(Weight^2)")
summary(out2.2)

# Nonlinear Trends in residual (vs. predicted) plot
plot(out2.2, which = 1)

# Perform the Ramsey RESET Test again
resettest(out2.2)

# 2 Influential observations ---------------------------------------------------

# 2.1 Studentized residuals ----------------------------------------------------

# Compute Externally studentized residuals
sr2 <- rstudent(out2.2)
sr2

# Create index plot of studentized residuals:
plot(sr2)

# Find outliers
badSr2 <- which(abs(sr2) > 3)
badSr2

# 2.2 Leverages ----------------------------------------------------------------

# Compute leverages
lev2 <- hatvalues(out2.2)
lev2

# Create index plot of leverages:
plot(lev2)

# Identify high-leverage observations
lev2.s <- sort(lev2, decreasing = TRUE)
lev2.s

# Store the observation numbers for the most extreme leverages:
badLev2 <- as.numeric(names(lev2.s[1 : 3]))
badLev2

# Or select observations having a leverage higher than 0.2
badLev2 <- which(lev2 > 0.2)
badLev2

# Residuals + Leverage Plot:
plot(out2.2, which = 5)

# 2.3 Measures of influence ----------------------------------------------------

# Compute all of the influence measures
im2 <- influence.measures(out2.2)
im2

# Compute the difference in fits DFFITS (Global)
dff2 <- dffits(out2.2)
dff2

# Compute Cook's Distance (Global)
cd2  <- cooks.distance(out2.2)
cd2

# Compute differences in betas DFBETAS (coefficient specific)
dfb2 <- dfbetas(out2.2)
dfb2

# Create index plots for measures of influence
plot(dff2)
plot(cd2)
plot(dfb2[ , 1])
plot(dfb2[ , 2])
plot(dfb2[ , 3])
plot(dfb2[ , 4])
plot(dfb2[ , 5])

# Find the single most influential observation according to Cook's distance
maxCd   <- which.max(cd2)
maxCd

# Find the single most influential observation according to dff
maxDff  <- which.max(abs(dff2))
maxDff

# Find the single most influential observation on the intercept
maxDfbI <- which.max(abs(dfb2[ , 1]))
maxDfbI

# Find the single most influential observation on quadratic term
maxDfbQ <- which.max(abs(dfb2[ , 5]))
maxDfbQ

# 2.4 Treating influential observations ----------------------------------------

# Exclude the most influential observation according to Cook's distance:
Cars93.i <- Cars93[-maxCd, ]

# Refit the quadratic model:
out2.2i <- update(out2.2, data = Cars93.i)

# Compare the fits
summary(out2.2)
summary(out2.2i)
