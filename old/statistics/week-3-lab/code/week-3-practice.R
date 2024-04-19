# Course:   Statistics and methodology
# Title:    Week 3 lab practice script
# Author:   Marcel the Shell with Shoes On
# Created:  2018-04-10
# Modified: 2023-02-15

# 1. Preliminaries -------------------------------------------------------------

# 1.1) Use the "install.packages" function to install the "MLmetrics" package.

# install.packages("MLmetrics", repos = "http://cloud.r-project.org")

# 1.2) Use the "library" function to load the "MLmetrics" packages.

library(MLmetrics)

# 1.3) Use the "paste0" function and the "readRDS" function to load the
#      "longleyW3.rds" data into your workspace.

setwd("~/1_r/statistics/week-3-lab/code")
dataDir <- "../data/"
fn1 <- "longleyW3.rds"
longleyW3 <- readRDS(paste0(dataDir, fn1))

# 2. Linear regression ---------------------------------------------------------
#2.1

slr.fit <- lm(GNP ~ Year, data = longleyW3)
slr.fit.sum <- summary(slr.fit)

#2.2 Effect is 2.092e+01 (20.92) 
slr.fit.sum

#2.3 Yes p < 0.001
slr.fit.sum
#2.4 Yes p < 0.001
slr.fit.sum
#2.5
mlr.fit <- lm(GNP ~ Year + Population, data = longleyW3)

mlr.fit.sum <- summary(mlr.fit)

#2.6 Yes p = 0.0345
mlr.fit.sum

#2.7 No, p = 0.0345
mlr.fit.sum

#2.8 Confint = -2.188717, 13.02292
confint(mlr.fit)

#2.9
mlr2.fit <- lm(GNP ~ Year + Employed, data = longleyW3)

#2.10 11.264
mlr2.fit.sum <- summary(mlr2.fit)

#2.11 Yes, p < 0.001
mlr2.fit.sum

#2.12 5.015448, 17.51210
confint(mlr2.fit, level = 0.99)

#2.13
mlr3.fit<- lm(GNP ~ Year + Unemployed, data = longleyW3)

#2.14 -0.1353
mlr3.fit.sum <- summary(mlr3.fit)

#2.15 Yes, p < 0.001
mlr3.fit.sum
## 3 Model Comparison

#3.1 deltaRsquare = 0.001927307
mlr.fit.sum$r.squared - slr.fit.sum$r.squared

#3.2 No (if Pr(>F) is the p stat, F is also very low though)
anova(slr.fit, mlr.fit)

#3.3 2.3675 

#3.4 32.8721

mlr2.mse <- MSE(y_pred = predict(mlr2.fit), y_true = longleyW3$GNP)

#3.5 29.68064
mlr3.mese <- MSE(y_pred = predict(mlr3.fit), y_true = longleyW3$GNP)

#3.6 Unemployed is a better predictor because lower MSE value

#3.7 No, because neither is nested in the other