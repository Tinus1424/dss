# Course:   Statistics and methodology
# Title:    Week 4 lab practice script
# Author:   Marcellus McSquiddles
# Created:  2018-04-10
# Modified: 2023-01-12

# 1 Preliminaries ----------------------------------------------------------------

# 1.1) Use the "library" function to load the "MLmetrics" and "mice" packages.

library(MLmetrics)
library(mice)

# 1.2) Use the "source" function to source the "custom-functions.R" script.

source("custom-functions.R")

# 1.3) Use the "paste0" function and the "readRDS" function to load the "yps.rds"
#    and "bfiANC2.rds" datasets into your workspace.

dataDir <- "../data/"
yps <- readRDS(paste0(dataDir, "yps.rds"))
bfiANC2 <- readRDS(paste0(dataDir, "bfiANC2.rds"))

# 2. Split-Sample Cross-Validation ---------------------------------------------

# 2.1) Randomly split the sample into disjoint training and testing sets

# Set the random number seed
set.seed(235711)

# Create a vector to assign observations to a training and testing set
ind <- sample(c(rep("train", 800), rep("test", 210)))

# Assign rows of the data to the training and testing sets
tmp <- split(yps, ind)

# Create data.frames for the training and test sets
train <- tmp$train
test <- tmp$test

# 2.2) Estimate a baseline model on the training data: regresses `Number.of.friends` onto `Age` and `Sex`


lm0 <- lm(Number.of.friends ~ Age + Sex, data = train)
summary(lm0)

# 2.3

lm1 <- update(lm0, ". ~  . + Keeping.promises + Empathy + Friends.versus.money + Charity")
lm1.sum <- summary(lm1)

#2.4
lm2 <- update(lm0, ". ~ . + Branded.clothing + Entertainment.spending + Spending.on.looks + Spending.on.gadgets")
lm2.sum <- summary(lm2)

#2.5
lm3 <- update(lm0, ". ~ . + Workaholism + Reliability + Responding.to.a.serious.letter + Assertiveness")
lm3.sum <- summary(lm3)

#2.6
lm1_yhat_train <- predict(lm1)
lm2_yhat_train <- predict(lm2)
lm3_yhat_train <- predict(lm3)

#2.7
MSE(y_pred = lm1_yhat_train, y_true = train$Number.of.friends)
MSE(y_pred = lm2_yhat_train, y_true = train$Number.of.friends)
MSE(y_pred = lm3_yhat_train, y_true = train$Number.of.friends)

#2.8
lm1_yhat_test <- predict(lm1, newdata = test)
lm2_yhat_test <- predict(lm2, newdata = test)
lm3_yhat_test <- predict(lm3, newdata = test)

#2.9
MSE(y_pred = lm1_yhat_test, y_true = test$Number.of.friends)
MSE(y_pred = lm2_yhat_test, y_true = test$Number.of.friends)
MSE(y_pred = lm3_yhat_test, y_true = test$Number.of.friends)

#2.10

# lm2

#2.11

# lm2

## Split-sample CV (3-way)

#3.1 

# Set the random seed
set.seed(235711)

# Create an index to split the data according to what was requested
ind <- sample(c(rep("train", 700), rep("valid", 155), rep("test", 155)))

# Split the data based on the index you just created
yps2 <- split(yps, ind)

# Store the data sets with simple names
traina <- yps2$train
valida <- yps2$valid
testa <- yps2$test

#3.2
lm0a <- lm(Number.of.friends ~ Age + Sex, data = traina)
summary(lm0)

lm1a <- update(lm0, ". ~  . + Keeping.promises + Empathy + Friends.versus.money + Charity")
lm1a.sum <- summary(lm1a)

lm2a <- update(lm0, ". ~ . + Branded.clothing + Entertainment.spending + Spending.on.looks + Spending.on.gadgets")
lm2a.sum <- summary(lm2a)

lm3a <- update(lm0, ". ~ . + Workaholism + Reliability + Responding.to.a.serious.letter + Assertiveness")
lm3a.sum <- summary(lm3a)

lm1a.sum
lm2a.sum
lm3a.sum
#3.3

lm1a_yhat_valida <- predict(lm1a, newdata = valida)
lm2a_yhat_valida <- predict(lm2a, newdata = valida)
lm3a_yhat_valida <- predict(lm3a, newdata = valida)

#3.4
mse1 <- MSE(y_pred = lm1a_yhat_valida, y_true = valida$Number.of.friends)
mse2 <- MSE(y_pred = lm2a_yhat_valida, y_true = valida$Number.of.friends)
mse3 <- MSE(y_pred = lm3a_yhat_valida, y_true = valida$Number.of.friends)

#3.5
# lm3a
mse <- c(mse1, mse2, mse3)
which.min(mse)

#3.6
lm3a1 <- update(lm3a, data = rbind(traina, valida))
summary(lm3a1)

MSE(
  y_pred = predict(
    object = lm3a1,     # new estimates
    newdata = testa      # TEST data!
  ),
  y_true = testa$Number.of.friends # observed DV on the test data
)

## 4. K-Fold Cross-Validation
# 4.1

# Set the random seed
set.seed(235711)

# Create the index for splitting the data
index <- sample(c(rep("train", 800), rep("test", 210)))

# Use the split function to split data as requested
yps2 <- split(yps, index)

# Store objects with easy names
trainb <- yps2$train
testb <- yps2$test

# 4.2
lm0b <- lm(Number.of.friends ~ Age + Sex, data = trainb)
summary(lm0)

lm1b <- update(lm0, ". ~  . + Keeping.promises + Empathy + Friends.versus.money + Charity")
lm1b.sum <- summary(lm1b)

lm2b <- update(lm0, ". ~ . + Branded.clothing + Entertainment.spending + Spending.on.looks + Spending.on.gadgets")
lm2b.sum <- summary(lm2b)

lm3b <- update(lm0, ". ~ . + Workaholism + Reliability + Responding.to.a.serious.letter + Assertiveness")
lm3b.sum <- summary(lm3b)

lm1b.sum
lm2b.sum
lm3b.sum

# Define a vector containing the formulas for the requested models
models <- c(
  "Number.of.friends ~ Age + Sex + Keeping.promises + Empathy + Friends.versus.money + Charity",
  "Number.of.friends ~ Age + Sex + Branded.clothing + Entertainment.spending + Spending.on.looks + Spending.on.gadgets",
  "Number.of.friends ~ Age + Sex + Workaholism + Reliability + Responding.to.a.serious.letter + Assertiveness"
)


cve_fun <- cv.lm(
  data = yps2$train,    
  models = c(
    "Number.of.friends ~ Age + Sex + Keeping.promises + Empathy + Friends.versus.money + Charity",
    "Number.of.friends ~ Age + Sex + Branded.clothing + Entertainment.spending + Spending.on.looks + Spending.on.gadgets",
    "Number.of.friends ~ Age + Sex + Workaholism + Reliability + Responding.to.a.serious.letter + Assertiveness"
  ),
  K = 5,                       
  seed = 235711)

which.min(cve_fun)

MSE(y_pred = predict(object = lm2b, newdata = testb), y_true = testb$Number.of.friends)

# Multiple Imputation
colMeans(is.na(bfiANC2))
# 5.1 
meth <- c("", 
            "pmm", "pmm", "pmm", "pmm", "pmm", 
            "norm.boot", "norm.boot", "norm.boot", "norm.boot", "norm.boot",
            "norm", "norm", "norm", "norm", "norm",
            "",
            "polyreg",
            "")

names(meth) <- colnames(bfiANC2)

predMat <- quickpred(bfiANC2, mincor = 0.25, include = c("age", "sex"), exclude = "id")

miceOut <- mice(
  data = bfiANC2,
  m = 25,
  maxit = 15,
  seed = 314159,
  method = meth,
  predictorMatrix = predMat
  )

impList <- complete(miceOut, "all")

typeof(miceOut)

fits <- lapply(
  impList,
  function(x) lm(A1 ~ C1 + N1 + education, data = x)
)


# 5.2
plot(miceOut, "education", main = "Trace plot for education")
# 5.3
densityplot(miceOut)
# 5.4

# Except for C1 most track the original value very closely

# 5.5

fits.mids <- with(miceOut, lm(A1 ~ C1 + N1 + education))
poolFit <- pool(fits.mids)

#5.6

fits.mids2 <- with(miceOut, lm(A1 ~ C1 + N1 + education + age + sex))
poolFit2 <- pool(fits.mids2)

#5.7 Age on A1

summary(poolFit2)
#-0.02188277

# 5.8
# yes

# 5.9

pool.r.squared(fits.mids)

# 5.10

pool.r.squared(fits.mids2)


# 5.11
pool.r.squared(fits.mids2)[1] - pool.r.squared(fits.mids)[1]

# 5.12
D1(fits.mids2, fits.mids)

# 5.13
# 14.72923