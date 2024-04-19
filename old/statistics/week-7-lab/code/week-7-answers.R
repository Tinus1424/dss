# Install the packages
#install.packages(
#  pkgs = c("moments", "lmtest", "sandwich"),
#  repos = "http://cloud.r-project.org"
#)

# Load the packages
library(moments)
library(lmtest)
library(sandwich)

# Read the data
airQual <- readRDS("../data/airQual.rds")

# Fit the requested model
out1 <- lm(Temp ~ Ozone + Wind + Solar.R, data = airQual)

summary(out1)

# Plot the loess line
scatter.smooth(x = predict(out1), y = resid(out1))

# Add a horizontal line at 0, the assumed mean for the errors
abline(h = 0, col = "gray")

# Perform Ramsey reset with defaults
resettest(out1)

# print.response("The model is misspecified.")

# Define the predictors that should use the additional squared term
vars <- c("Solar.R", "Ozone", "Wind")

# Update the baseline model with the squared terms
fits <- lapply(
  X = vars,
  FUN = function(x, base) {
    update(base, paste0(". ~ . + I(", x, "^2)"))
  },
  base = out1
)

# Give meaningful names to the new list of fits
names(fits) <- vars

# Apply the summary function to each fit object
lapply(fits, summary)

# Define a plot device with 1 row and three columns
par(mfrow = c(1, 3))

# Obtain the loess residual plot for every fitted model
for (v in vars) {
  scatter.smooth(
    x = fitted(fits[[v]]),   # fitted values of interest
    y = resid(fits[[v]]),    # residuals of interest
    main = v                 # title
  )
}

# Apply the Ramsey reset test to each new model
reset <- lapply(fits, resettest)

# Look at the results
reset

# Extract the model with the smallest Ramsey reset test statistic
best <- which.min(sapply(reset, "[[", x = "statistic"))

# Print the name of the associated model
names(reset)[best]

# Is the p-value below 0.05?
check <- reset[[best]]$p.value < 0.05

# Then, the answer is...
ifelse(check, "YES", "NO")

# Fit linear model
modO2 <- lm(Temp ~ Ozone + Wind + Solar.R + I(Ozone^2), data = airQual)

# Extract the residuals
res0 <- resid(modO2)

# Extract the predicted values
pred0 <- predict(modO2)

# Plot the residual plot with the loess line
scatter.smooth(x = pred0, y = res0)

# Add reference horizontal line
abline(h = 0, col = "gray")

# Conduct Breusch-Pagan test
bptest(modO2)

# Obtain QQ plots
qqnorm(res0)
qqline(res0)

# Plot the density of the residuals
plot(density(res0))

# Compute skewness and kurtosis
skewness(res0)
kurtosis(res0)

# Perform tests to check non-normality
shapiro.test(res0)
ks.test(x = res0, y = pnorm, mean = mean(res0), sd = sd(res0))

# Heteroscedastic estiamtes of covariance matrix for modO2
covHC0 <- vcovHC(modO2)

# Use the heteroscedastic estimate to test significance
coeftest(modO2, vcov = covHC0)

# Check out the results from the original model
summary(modO2)$coefficients

# Update current model with requested terms
modO2.2 <- update(modO2, ". ~ . + I(Wind^2) + I(Solar.R^2)")

# Print the summary
summary(modO2.2)

# Use the waldtest functoin to perform change in R-squared test
waldtest(modO2, modO2.2, vcov = vcovHC)

# Use the traditional anova function to perform a change in R-squared test
anova(modO2, modO2.2)

#print.response("The robust version produces a larger F (test) statistic, resulting in a smaller p-value, compared to the standard approach that assumes homoscedasticity.")
# Compute the studentized residuals
sr0 <- rstudent(modO2)

# Compute an index plot of the residuals
plot(sr0)

# Define function to find names of elements with biggest values
findBiggest <- function(x, n) {
  as.numeric(names(sort(abs(x), decreasing = TRUE)[1:n]))
}

# Use function to find names of biggest elements
badSr <- findBiggest(sr0, 2)

# Print results
badSr

# Compute leverages (or hat values)
lv0 <- hatvalues(modO2)

# Plot leverages
plot(lv0)

# Find biggest 3 leverages
badLv <- findBiggest(lv0, 3)

# And check out the results
badLv

# Compute cook's distances
cd0 <- cooks.distance(modO2)

# Plot cook's distances
plot(cd0)

# Find the names of the 5 observations with biggest cook distances
badCd <- findBiggest(cd0, 5)

# Print results
badCd

# Compute differences in fits
df0 <- dffits(modO2)

# Plot results
plot(df0)

#print.response("Five cases appear to be potentially influential.")
# Find the names of the 5 observations with biggest DFFITS
badDf <- findBiggest(abs(df0), 5)

# Print results
badDf

# Check whether the observations are the same
check <- all.equal(sort(badDf), sort(badCd))

# And return a clear answer
ifelse(check, "YES", "NO")

# Print the names of the observations flagged
badSr
badLv
badDf

# Re-estimate the model without flagged observations
modO2.3 <- update(modO2, data = airQual[-badDf, ])

# And check out the summary
summary(modO2.3)

# Print the results from the original model
summary(modO2)

