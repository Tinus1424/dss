# Load packages
library(MLmetrics)
library(mice)
# Source functions
source("custom-functions.R")
# Load data
dataDir <- "../data/"
yps <- readRDS(paste0(dataDir, "yps.rds"))
bfiANC2 <- readRDS(paste0(dataDir, "bfiANC2.rds"))
# Set the random seed
set.seed(235711)

# Create a vector to assign observations to a training and testing set
ind <- sample(c(rep("train", 800), rep("test", 210)))

# Assign rows of the data to the training and testing sets
tmp <- split(yps, ind)

# Create data.frames for the training and test sets
train <- tmp$train
test <- tmp$test
# Fit the baseline model
lm0 <- lm(Number.of.friends ~ Age + Sex, data = train)
# Update the baseline model using the update function
lm1 <- update(lm0, ". ~ . + Keeping.promises + Empathy + Friends.versus.money + Charity")
# Update the baseline model using the update function
lm2 <- update(lm0, ". ~ . + Branded.clothing + Entertainment.spending + Spending.on.looks + Spending.on.gadgets")
# Update the baseline model using the update function
lm3 <- update(lm0, ". ~ . + Workaholism + Reliability + Responding.to.a.serious.letter + Assertiveness")
# Use the predict function to obtain prediction from each model
p1 <- predict(lm1)
p2 <- predict(lm2)
p3 <- predict(lm3)
# Use the MSE function from the MLmetric package to compute the training MSE
mse1 <- MSE(
  y_pred = p1, # predicted values based on our model
  y_true = train$Number.of.friends # true values of the DV in the training data
)
mse2 <- MSE(y_pred = p2, y_true = train$Number.of.friends)
mse3 <- MSE(y_pred = p3, y_true = train$Number.of.friends)
# Use the predict function to obtain predictions on the test data from each model
p1.2 <- predict(
  object = lm1, # model we are using to obtain predictions
  newdata = test # data on which predictions are obtained
)
p2.2 <- predict(lm2, newdata = test)
p3.2 <- predict(lm3, newdata = test)
# Use the MSE function from the MLmetric package to compute the test MSE
mse1.2 <- MSE(
  y_pred = p1.2, # predicted (test-set) values based on our model
  y_true = test$Number.of.friend # true values of the DV in the test(!) data
)
mse2.2 <- MSE(y_pred = p2.2, y_true = test$Number.of.friend)
mse3.2 <- MSE(y_pred = p3.2, y_true = test$Number.of.friend)
# Store the training MSEs in a single vector
mse <- c(mse1, mse2, mse3)

# Look at it
mse

# Ask R to return the smallest value in the vector
min(mse)

# Ask R to return the index of the smallest value in the vector
which.min(mse)
# Store the training MSEs in a single vector
mse.2 <- c(mse1.2, mse2.2, mse3.2)

# Look at it
mse.2

# Ask R to return the smallest value in the vector
min(mse.2)

# Ask R to return the index of the smallest value in the vector
which.min(mse.2)
# Set the random seed
set.seed(235711)

# Create an index to split the data according to what was requested
ind <- sample(c(rep("train", 700), rep("valid", 155), rep("test", 155)))

# Split the data based on the index you just created
yps2 <- split(yps, ind)

# Store the data sets with simple names
train <- yps2$train
valid <- yps2$valid
test <- yps2$test
# Estiamte the models on a different dataset
lm1.2 <- update(lm1, data = train)
lm2.2 <- update(lm2, data = train)
lm3.2 <- update(lm3, data = train)
# Use the predict function to obtain predictions on the validation set
p1.vali <- predict(
  object = lm1.2, # model estimated on training data
  newdata = valid # VALIDATION!
)
p2.vali <- predict(lm2.2, newdata = valid)
p3.vali <- predict(lm3.2, newdata = valid)
# Use the MSE function from the MLmetric package to compute the validation-set MSEs
mse1.vali <- MSE(y_pred = p1.vali, y_true = valid$Number.of.friend)
mse2.vali <- MSE(y_pred = p2.vali, y_true = valid$Number.of.friend)
mse3.vali <- MSE(y_pred = p3.vali, y_true = valid$Number.of.friend)
# Store the validation MSEs in a single vector
mse.vali <- c(mse1.vali, mse2.vali, mse3.vali)

# Look at it
mse.vali

# Print a response to the question
paste("I would choose model", which.min(mse.vali))
# Update the chosen model by estimating it again on a larger dataset
lm3.3 <- update(
  object = lm3.2, # chosen model
  data = rbind(train, valid) # combination of training and validation data sets
)
# Compute the predictions on the test data with the re-estimated chosen model
p3.test <- predict(lm3.3, newdata = test)

# Use the MSE function to obtain the estimate of the prediction error
MSE(
  y_pred = p3.test,
  y_true = test$Number.of.friend # TEST SET!
)
# Set the random seed
set.seed(235711)

# Create the index for splitting the data
index <- sample(c(rep("train", 800), rep("test", 210)))

# Use the split function to split data as requested
yps2 <- split(yps, index)

# Store objects with easy names
train <- yps2$train
test <- yps2$test
# Define a vector containing the formulas for the requested models
models <- c(
  "Number.of.friends ~ Age + Sex + Keeping.promises + Empathy + Friends.versus.money + Charity",
  "Number.of.friends ~ Age + Sex + Branded.clothing + Entertainment.spending + Spending.on.looks + Spending.on.gadgets",
  "Number.of.friends ~ Age + Sex + Workaholism + Reliability + Responding.to.a.serious.letter + Assertiveness"
)
# Perform the cross-validation with the cv.lm() function
cve <- cv.lm(
  data = train, # which data are we using for the K-fold CV?
  models = models, # which models are we comparing?
  K = 5, # how many folds?
  seed = 235711 # requested seed?
)

# Print the vector of cross-validation errors
cve

# And return the smallest one
cve[which.min(cve)]
# Train the selected model on the training data
lm.kcv.train <- lm(models[which.min(cve)], data = train)

# Use the MSE function on the test data
MSE(
  y_pred = predict(lm.kcv.train, newdata = test),
  y_true = test$Number.of.friends
)
# Check the column names:
meth <- rep("", ncol(bfiANC2))
names(meth) <- colnames(bfiANC2)

# Define our own method vector:
meth[2:6] <- rep("pmm", 5)
meth[7:11] <- rep("norm.boot", 5)
meth[12:16] <- rep("norm", 5)
meth["education"] <- "polyreg"

# Or fancy way
meth <- rep("", ncol(bfiANC2))
names(meth) <- colnames(bfiANC2)

meth[grep("^A\\d", names(meth))] <- "pmm"
meth[grep("^N\\d", names(meth))] <- "norm"
meth[grep("^C\\d", names(meth))] <- "norm.boot"
meth["education"] <- "polyreg"

# Check the method vector:
meth

# Use mice::quickpred to generate a predictor matrix:
predMat <- quickpred(
  data = bfiANC2,
  mincor = 0.25,
  include = c("age", "sex"),
  exclude = "id"
)

# Check the predictor matrix:
predMat

# Impute missing using the method vector from above:
miceOut1 <- mice(
  data = bfiANC2,
  m = 25, # number of imputations
  maxit = 15, # number of iterations
  predictorMatrix = predMat, # custom specified version
  method = meth, # custom imputation method vector
  printFlag = FALSE, # just to hide the output in the console
  seed = 314159 # desired seed
)
# Make trace plots for a few variables at the time
plot(miceOut1, c("A1", "C5", "education"))
# Or for all variables (not shown here)
plot(miceOut1)
# Make density plots
densityplot(miceOut1)
cat(
  "Yes. The imputation models look to have converged and the imputed values seem reasonable."
)
# Fit the same model to all imputed data sets using the `with()` the approach
fits1 <- with(miceOut1, lm(A1 ~ C1 + N1 + education))
# Fit a new model to all imputed data sets
fits2 <- with(miceOut1, lm(A1 ~ C1 + N1 + education + age + sex))
# Pool coefficient estimates
poolFit2 <- pool(fits2)

# Check output
summary(poolFit2)

# Extract the slope of interest
tmp <- poolFit2$pooled[poolFit2$pooled == "age", ]
tmp["estimate"]
# Compute the t-statistic:
tStat <- with(tmp, estimate / sqrt(t))

# Compute the p-value (or read it from the summary)
pVal <- 2 * pt(q = abs(tStat), df = tmp$df, lower.tail = FALSE)

# Check with an ifelse
ifelse(pVal < 0.05, "YES", "NO")
# Pool the R2 properly
r2.1 <- pool.r.squared(fits1)[, "est"]

# And print the value
r2.1
# Pool the R2 properly
r2.2 <- pool.r.squared(fits2)[, "est"]

# And print the value
r2.2
# Compute the difference in R2
r2.2 - r2.1
# Do an F-test for the increase in R^2:
out6b <- D1(fits2, fits1)

# Check with an ifelse if the Pvalue is less than .05
ifelse(out6b$result[, "P(>F)"] < 0.05, "YES", "NO")
# Exctract the F statistic that was used
out6b$result[, "F.value"]