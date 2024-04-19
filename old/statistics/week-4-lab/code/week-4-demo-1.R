# Course:   Statistics and methodology
# Title:    Prediction and cross-validation
# Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo, Ralph
# Created:  2017-09-08
# Modified: 2023-02-15
# Notes:    Cats data source: https://dataverse.nl/dataset.xhtml?persistentId=doi:10.34894/OXZRWO&version=2.0

# Set up -----------------------------------------------------------------------

# Clear the workspace
rm(list = ls(all = TRUE))

# Make sure the working directory is set to the location of this file
setwd("~/1_r/statistics/week-4-lab/code")

# Source the "custom-functions.R" script to get the cv.lm function
source("custom-functions.R")

# Set seed for this session
set.seed(235711)

# Load the ML metrics package for computing the MSE
library(MLmetrics)

# Load catsW4 data from the lab folder
dataDir <- "../data/"
filename <- "catsW4.rds"
catsW4 <- readRDS(paste0(dataDir, filename))

# Check the data
head(catsW4)

# 1. Split-Sample Cross-Validation (Simple Split) ------------------------------

# Create an indexing vector to assign train-test memberships to the observations
index <- sample(
  c(
    rep(x = "train", times = 1000),
    rep(x = "test", times = nrow(catsW4) - 1000)
  )
)

# Split the data into training and testing sets:
catsW4_ss <- split(
  x = catsW4, # values to be divided into groups
  f = index  # vector assigning the groups 
)

# What is the resulting object?
class(catsW4_ss)

# Extract the data from the resulting list:
train <- catsW4_ss$train
test  <- catsW4_ss$test

# Regress Loyalty onto Support and Equality using the training data:
lm1 <- lm(
  Loyalty ~ Support + Equality,
  data = train # could also be "catsW4_ss$train"
)

# Add Purpose and Empathy as predictors
lm2 <- update(lm1, ". ~ . + Purpose + Empathy")

# Add Company and Sex as predictors
lm3 <- update(lm2, ". ~ . + Company + Sex")

# Check that everything worked:
summary(lm1)
summary(lm2)
summary(lm3)

# Generate training-set predictions (i.e., y-hats) for the three models:
lm1_yhat_train <- predict(lm1)
lm2_yhat_train <- predict(lm2)
lm3_yhat_train <- predict(lm3)

# Generate training-set MSEs for the first model:
MSE(
  y_pred = lm1_yhat_train,  # predicted DV on the TRAINING data
  y_true = train$Loyalty    # observed DV from the TRAINING data
)

# And generate the training-set MSEs for the other two models:
MSE(y_pred = lm2_yhat_train, y_true = train$Loyalty)
MSE(y_pred = lm3_yhat_train, y_true = train$Loyalty)

# Generate test-set predictions for the first model:
lm1_yhat_test <-
  predict(
    lm1,            # model estimated on TRAINING data
    newdata = test  # observed DV from the TEST data
  )

# Generate test-set predictions for the other models:
lm2_yhat_test <- predict(lm2, newdata = test)
lm3_yhat_test <- predict(lm3, newdata = test)

# Generate test-set MSEs for the first model:
MSE(
  y_pred = lm1_yhat_test, # predicted DV on the TEST data
  y_true = test$Loyalty   # observed DV from the TEST data
)

# Generate test-set MSEs for the other models:
MSE(y_pred = lm2_yhat_test, y_true = test$Loyalty)
MSE(y_pred = lm3_yhat_test, y_true = test$Loyalty)

# Get y-hat confidence intervals for the model with the smallest test-set mse:
lm3_yhat_CI <- predict(
  lm3,                    # selected model estimated on TRAINING data
  newdata = test,         # TEST data!
  interval = "confidence" # type of interval desired
)

# Get prediction interval for the selected model:
lm3_yhat_PI <- predict(
  lm3,
  newdata = test,
  interval = "prediction" # !
)

# Look at the results
head(lm3_yhat_CI)
head(lm3_yhat_PI)

# 2. Split-sample Cross-Validation (3-way) -------------------------------------

# Create a vector to assign train, validation, and test membership:
index <- sample(
  c(
    rep("train", 800),
    rep("valid", 200),
    rep("test", nrow(catsW4) - 1000)
  )
)

# Check what you did:
table(index)

# Split the sample into training, validation, and testing sets:
catsW4_3w <- split(catsW4, index)

# Extract the data from the resulting list:
train <- catsW4_3w$train
valid <- catsW4_3w$valid
test <- catsW4_3w$test

# Fit a baseline model to the training data:
lm0 <- lm(Loyalty ~ Support + Equality, data = train)

# Fit four more complex competing models to the training data:
lm1 <- update(lm0, ". ~ . + Purpose")
lm2 <- update(lm0, ". ~ . + Empathy")
lm3 <- update(lm0, ". ~ . + Company")
lm4 <- update(lm0, ". ~ . + Sex")

# Let's show the models / formulas that we just created
lm0$call # Baseline model 
lm1$call # Baseline model + Purpose
lm2$call # Baseline model + Empathy
lm3$call # Baseline model + Company
lm4$call # Baseline model + Sex

# Estimate validation-set MSEs for the first model:
mse1 <- MSE(
  y_pred =
    predict(
      object = lm1,      # estimated model
      newdata = valid    # validation data!
    ),
  y_true = valid$Loyalty # observed DV in the validation data
)

# Estimate validation-set MSEs for the other three models:
mse2 <- MSE(y_pred = predict(lm2, newdata = valid),
            y_true = valid$Loyalty)
mse3 <- MSE(y_pred = predict(lm3, newdata = valid),
            y_true = valid$Loyalty)
mse4 <- MSE(y_pred = predict(lm4, newdata = valid),
            y_true = valid$Loyalty)

# Collect the resulting MSEs in a single vector
mse <- c(mse1, mse2, mse3, mse4)

# Find the smallest validation-set MSE
min(mse)

# Find the model with the smallest validation-set MSE:
which.min(mse)

# Re-estimate the chosen model using the pooled training and validation data:
lm1.2 <- update(
  object = lm1,              # model to estimate again
  data = rbind(train, valid) # combine train and validation data
)

# Check the output
summary(lm1)
summary(lm1.2)

# Estimate prediction error using the testing data:
MSE(
  y_pred = predict(
    object = lm1.2,     # new estimates
    newdata = test      # TEST data!
  ),
  y_true = test$Loyalty # observed DV on the test data
)

# 3. K-Fold Cross-Validation ---------------------------------------------------

# Store the sample size of our data:
N <- nrow(catsW4)

# Decide how many folds we want to use for the K-fold cross-validation:
K <- 10

# Create a vector of candidate models:
models <- c("Loyalty ~ Support + Equality + Purpose",
            "Loyalty ~ Support + Equality + Empathy",
            "Loyalty ~ Support + Equality + Company",
            "Loyalty ~ Support + Equality + Sex")

# Create a vector to partition to original data in K folds:
part <- sample(rep(1 : K, ceiling(N / K)))[1 : N]

# Observations will belong to a unique fold:
head(cbind(fold = part, catsW4), 20)
table((cbind(fold = part, catsW4))$fold) # Group size per fold

# Define an empty vector to store MSEs for each model:
cve <- c()

# Loop over candidate models:
for(m in 1 : length(models)) {
  # Set m value for demo purposes:
  # m <- 1 # consider the first model

  # Define an empty vector to store MSEs for every repetition for a single model
  mse <- c()

  # Loop over K repetitions:
  for(k in 1 : K) {
    # Set k value for demo purposes:
    # k <- 1 # consider the first fold

    # Partition data:
    dat0 <- catsW4[part != k, ] # ~ train
    dat1 <- catsW4[part == k, ] # ~ test
    
    # Fit model and generate predictions:
    fit  <- lm(models[m], data = dat0)
    pred <- predict(fit, newdata = dat1)
    
    # Save MSE:
    mse[k] <- MSE(y_pred = pred, y_true = dat1$Loyalty)

  }

  # Save the CVE:
  cve[m] <- mean(mse)

}

# Examine the K-fold cross-validation errors:
cve

# Extract the model returning the smallest K-fold cross-validation error
which.min(cve)

# Use the cv.lm() R function:
cve_fun <- cv.lm(
  data = catsW4,                      # input data
  models = c(                         # vector of competing models
    "Loyalty ~ Support + Equality + Purpose",
    "Loyalty ~ Support + Equality + Empathy",
    "Loyalty ~ Support + Equality + Company",
    "Loyalty ~ Support + Equality + Sex"
  ),
  K = 10,                             # number of folds
  seed = 235711                       # remember the seed!
)

# Examine the K-fold cross-validation errors:
cve_fun

# Extract the model returning the smallest K-fold cross-validation error:
which.min(cve_fun)
