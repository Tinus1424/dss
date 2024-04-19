# Course:   Statistics and methodology
# Title:    Multiple Imputation
# Author:   Kyle M. Lang, Edo
# Created:  2017-09-08
# Modified: 2023-02-14

# Set up -----------------------------------------------------------------------

# Clear the workspace
rm(list = ls(all = TRUE))

# Make sure the working directory is set to the location of this file
setwd("~/1_r/statistics/week-4-lab/code")

# Source the "custom-functions.R" script to get the MI-based prediction functions
source("custom-functions.R")

# Install new package
install.packages("mitools") # for MI pooling

# Load packages that we will need
library(mice) # for performing multiple imputation (MI)
library(mitools)

# Load Big Five (bfiOE) data from the lab folder
dataDir <- "../data/"
bfi <- readRDS(paste0(dataDir, "bfiOE.rds"))

# Define the folder where plots will be stored on your computer
plotDir <- "../plots/"

# Check the proportion of missing cases on each variable
colMeans(is.na(bfi))

# 1 Imputation Step ------------------------------------------------------------

# Perform MI (using default arguments)
miceOut <- mice(bfi)

# Check what is inside the resulting "mids" object:
ls(miceOut)

# Extract interesting specification info
miceOut$m # number of imputations

# Perform MI (custom arguments)
miceOut1 <- mice(
    data = bfi,
    seed = 235711,
    m = 20, # number of imputations
    maxit = 10, # number of iterations
    method = "pmm" # same univariate imputation method for every variable
)

# Extract interesting specification info
miceOut1$method

# 1.1 Specifying targeted imputation methods for each variable -----------------

# Check built-in (univariate) imputation methods
?mice

# Specify "norm" as univariate imputation method for every variable
meth <- rep("norm", ncol(bfi))

# and give good names to the vector
names(meth) <- colnames(bfi)

# Make sure binary and categorical variables use an appropriate method
meth["sex"] <- "logreg"
meth["education"] <- "polr"

# Impute missing using the method vector from above:
miceOut2 <- mice(
    data = bfi,
    seed = 235711,
    m = 5, # easier to follow and faster
    maxit = 10,
    method = meth # custom univariate imputation method vector
)

# Compare methods used
cbind(
    "default" = miceOut$method,
    "all pmm" = miceOut1$method,
    "targeted" = miceOut2$method
)

# 1.2 Specifying predictors for the univariate imputation models ---------------

# Quick and dirty predictor matrix
quickpred(data = bfi)

# Generate a predictor matrix:
predMat <- quickpred(
    data = bfi,
    mincor = 0.2, # minimum correlation required
    include = "sex" # force presence of predictors
)

# Impute missing using the predictor matrix from above:
miceOut3 <- mice(
    data = bfi,
    seed = 235711,
    m = 5,
    maxit = 10,
    method = meth,
    predictorMatrix = predMat,
)

# 1.3 Convergence checks -------------------------------------------------------

# Create trace plots of imputed variables' means and SDs:
plot(miceOut3)

# Trace plots with a better layout
plot(miceOut3, layout = c(2, 5))

# Trace plot for a single variable
plot(miceOut3, "education", main = "Trace plot for education")

# Save plots on your computer as a pdf:
pdf(paste0(plotDir, "micePlots.pdf"), onefile = TRUE)
plot(miceOut3)
dev.off()

# Check the imputations by plotting observed vs. imputed densities:
densityplot(miceOut3)

# Single variable
densityplot(miceOut3, ~O5)

# Single variable easier on the eyes
densityplot(miceOut3, ~ O5 | .imp)

# 2 Analysis Step --------------------------------------------------------------

# Create a list of multiply imputed datasets:
impList <- complete(miceOut3, "all")

# What object are we working with?
typeof(impList)

# What is in it?
lapply(impList, head)

# And what was the original data?
head(bfi)

# You can extract a single imputed data set
impList[[3]]

# Fit a regression model to an arbitrary list of MI data:
fits <- lapply(
    impList,
    function(x) lm(E1 ~ age + education, data = x)
)

# Use the mice package for it:
fits.mids <- with(miceOut3, lm(E1 ~ age + education))

# And fit a more complex model
fits.mids2 <- with(miceOut3, lm(E1 ~ O1 + age + education))

# 3 Pooling Step ---------------------------------------------------------------

# Pool an arbitrary list of fitted models:
poolFit <- MIcombine(fits)

# Summarize pooled results:
poolFit.arb <- summary(poolFit)

# Compute wald tests from pooled results:
teststats <- poolFit$coefficients / poolFit.arb$se

# Pool the estimates using the mice package:
poolFit.mipo <- pool(fits.mids)

# Print the pooled estimates:
summary(poolFit.mipo)

# Compare what you computed based on the arbitrary list of fitted models
cbind(poolFit.arb[, c("results", "se")], statistic = teststats)

# Compute the pooled R^2 using the mids object:
pool.r.squared(fits.mids)

# Compute increase in R^2:
pool.r.squared(fits.mids2)[1] - pool.r.squared(fits.mids)[1]

# Do an F-test for the increase in R^2:
D1(fits.mids2, fits.mids)
