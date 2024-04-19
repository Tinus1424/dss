# Lecture:  06prediction.pdf
# Topic:    Extra info on prediction and MI
# Author:   Edoardo Costantini
# Created:  2022-09-19
# Modified: 2023-02-13

# 1. Manual computation confidence and prediction intervals --------------------

# 1.1 Prepare data -------------------------------------------------------------

# Create index to split data into train and test
ind <- sample(
    c(
        rep("train", 20),
        rep("test", nrow(mtcars) - 20)
    )
)

# Apply index to mtcars data
mtcars_split <- split(mtcars, ind)

# Devide the data
test <- mtcars_split$test
train <- mtcars_split$train

# Fit model
lm_out <- lm(mpg ~ wt, data = train)

# Obtain predictions
y_hat <- predict(lm_out, newdata = train)
y_hat_test <- predict(lm_out, newdata = test)

# Define observed outcome
y <- train$mpg
y_test <- test$mpg

# Compute MSE on training data
n <- nrow(train)
sigma2 <- mse <- (sum((y_hat - y)^2)) / (n - 1 - 1)

# 1.2 Prediction interval for new observation ----------------------------------

# Prediction interval
y_hat_test_pi <- predict(
    lm_out,
    newdata = test,
    interval = "prediction"
)

# Extract x value for the new observation
xh <- test[1, "wt"]

# Extract predicted value for first new observation
yhh <- y_hat_test[1]

# Extract x value from training data
x <- train[, "wt"]
xb <- mean(train[, "wt"])

# Define critical value for the confidence/prediction interval
tcrit <- qt(.975, df = nrow(train) - 2)

# Compute manual standard error of prediction for future outcome
se_pr <- sqrt(sigma2 * (1 + 1 / n + (xh - xb)^2 / sum((x - xb)^2)))

# Compare R output with manual computation
rbind(
    R = y_hat_test_pi[1, 2:3],
    manual = c(
        yhh - tcrit * se_pr,
        yhh + tcrit * se_pr
    )
)

# 1.3 Confidence interval for conditional mean (y_hat) -------------------------

# Confidence interval
y_hat_test_ci <- predict(
    lm_out,
    newdata = test,
    interval = "confidence",
    se.fit = TRUE
)

# Compute manual standard error of predicted mean (of conditional mean)
y_hat_test_ci$se.fit[1]
se_cm <- sqrt(sigma2 * (1 / n + (xh - xb)^2 / sum((x - xb)^2)))

# Compute manual confidence interval of y_hat (conditional mean)
manual_ciyh <- c(
    yhh - tcrit * se_cm,
    yhh + tcrit * se_cm
)

# Compare R output with manual computation
rbind(
    R = y_hat_test_ci$fit[1, 2:3],
    manual = c(
        yhh - tcrit * se_cm,
        yhh + tcrit * se_cm
    )
)

# 2. Prediction based on multiply imputed data ---------------------------------

# Source the "custom-functions.R" script to get the cv.lm and MI-based prediction functions
source("custom-functions.R")

# Set a seed for this session
set.seed(235711)

# Load packages that we will need
library(mice) # for performing multiple imputation (MI)
library(mitools) # for MI pooling
library(MLmetrics) # for computing MSEs

# Load Big Five (bfiOE) data from the lab folder
dataDir <- "../data/"
bfi <- readRDS(paste0(dataDir, "bfiOE.rds"))

# Store the sample size of your data
n <- nrow(bfi)

# Specify "norm" as univariate imputation method for every variable
meth <- rep("norm", ncol(bfi))
names(meth) <- colnames(bfi)
meth["education"] <- "polr"

# Generate a predictor matrix:
predMat <- quickpred(
    data = bfi,
    mincor = 0.2, # minimum correlation required
    include = "sex" # force presence of predictors
)

# Impute missing using the predictor matrix from above:
miceOut <- mice(
    data = bfi,
    seed = 235711,
    m = 5,
    maxit = 10,
    method = meth,
    predictorMatrix = predMat,
)

# Create list of data
impList <- complete(miceOut, "all")

# Create a vector to assign train, and test membership:
index <- sample(c(rep("train", 400), rep("test", n - 400)))

# Split the multiple imputation datasets into training and testing sets:
impList2 <- splitImps(imps = impList, index = index)

# Check the contents
ls(impList2)
length(impList2$test)

# Train a model on each multiply imputed training set:
fits <- lapply(impList2$train, function(x) lm(E1 ~ ., data = x))

# Generate imputation-specific predictions:
preds0 <- predictMi(
    fits = fits, # list of lm outputs for the same model
    newData = impList2$test, # test part of the (MI) data
    pooled = FALSE # don't pool
)

# Generate pooled predictions:
preds1 <- predictMi(fits, newData = impList2$test, pooled = TRUE)

# Generate pooled predictions with confidence intervals:
predsCi <- predictMi(fits, newData = impList2$test, interval = "confidence")

# Generate pooled predictions with prediction intervals:
predsPi <- predictMi(fits, newData = impList2$test, interval = "prediction")

# 3. Cross-Validation based on multiply imputed data ---------------------------

# 3.1 Split Cross-Validation (Three-Way) ---------------------------------------

# Create a vector to assign train, validation, and test membership:
index2 <- sample(
    c(
        rep("train", 300),
        rep("valid", 130),
        rep("test", n - 430)
    )
)

# Split the multiply imputed data into training, validation, and testing sets:
impList3 <- splitImps(imps = impList, index = index2)

# Define some models to compare:
mods <- c(
    "E1 ~ sex + education + age",
    "E1 ~ E2 + E3 + E4 + E5",
    "E1 ~ E2 + E3 + E4 + E5 + O1 + O2 + O3 + O4 + O5",
    "E1 ~ ."
)

# Train the models and compute validation-set MSEs:
mse <- c()
for (m in mods) {
    fits <- lapply(
        X = impList3$train,
        FUN = function(x, mod) lm(mod, data = x),
        mod = m
    )
    mse[m] <- mseMi(fits = fits, newData = impList3$valid)
}

# Print them
mse

# Merge the MI training a validation sets:
index3 <- gsub(pattern = "valid", replacement = "train", x = index2)
impList4 <- splitImps(impList, index3)

ls(impList4)

# Refit the winning model and compute test-set MSEs:
fits <- lapply(
    X = impList4$train,
    FUN = function(x, mod) lm(mod, data = x),
    mod = mods[which.min(mse)]
)
mse <- mseMi(fits = fits, newData = impList4$test)

mse

# 3.2 K-Fold Cross-Validation --------------------------------------------------

# Conduct 10-fold cross-validation in each multiply imputed dataset:
tmp <- sapply(impList4$train, cv.lm, K = 10, models = mods, seed = 235711)

# Aggregate the MI-based CVEs:
cve <- rowMeans(tmp)
cve

# Refit the winning model and compute test-set MSEs:
fits <- lapply(
    X = impList4$train,
    FUN = function(x, mod) lm(mod, data = x),
    mod = mods[which.min(cve)]
)
mse <- mseMi(fits = fits, newData = impList4$test)

mse
