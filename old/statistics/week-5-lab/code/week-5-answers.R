# Install the package
# install.packages(c("wec", "psych"), repos = "http://cloud.r-project.org")

# Load packages
library(psych)
library(wec)

# Load data from packages
data(bfi)

# Load data from disk
BMI <- readRDS("../data/bmiW5.rds")

# Check the more intuitive coding of children
table(BMI$childless)
table(BMI$children)

# Obtain extra info on the data
?BMI

# Source the funcitons
source("custom-functions.R")

# Call help file for bfi
?bfi

# Create a factor out of the variable recording binary genders
gender <- factor(bfi$gender, levels = c(1, 2), labels = c("male", "female"))

# Create a factor out of the education variable (w/ meaningful labels)
education <- factor(bfi$education,
                    levels = 1:5,
                    labels = c(
                      "some_hs",
                      "hs_grad",
                      "some_college",
                      "college_grad",
                      "graduate_degree"
                    )
)

# Do a classic cross-tab
table(gender, education)["female", "graduate_degree"]

# Count the number of levels in the `education` factor
nlevels(BMI$education)

# Print the first (reference) level for sex
levels(BMI$sex)[1]

# Print the first (reference) level for education
levels(BMI$education)[1]

# Relevel the original education factor
BMI$education <- relevel(BMI$education, ref = "highest")

# And use it in to estimate the model model
out1 <- lm(BMI ~ sex + education, data = BMI)

# Check the output
summary(out1)

# Define a function to extract p-values from a fitted lm object:
getP <- function(obj, what) summary(obj)$coef[what, "Pr(>|t|)"]

# Define function to answer yes/no significance questions:
isSig <- function(obj, what, alpha = 0.05) {
  ifelse(getP(obj, what) < alpha, "YES", "NO")
}

# Answer the question
isSig(out1, "sexfemale")

# This is just the intercept!
coef(out1)["(Intercept)"]

# Change the contrast matrix
contrasts(BMI$education) <- contr.sum(levels(BMI$education))

# Give meaningful names
colnames(contrasts(BMI$education)) <- c("highest", "lowest")

# Fit the model
out3 <- lm(BMI ~ education + children, data = BMI)

# Take its summary
s3 <- summary(out3)

# And check it!
s3

# Define a function to automatically change the omitted group
changeOmitted <- function(x) relevel(x, ref = levels(x)[nlevels(x)])

# Use the changeOmitted function to change the omitted group
BMI$education            <- changeOmitted(BMI$education)

# Code the categorical predictor as desired
contrasts(BMI$education) <- contr.sum(levels(BMI$education))

# Give good names to the constrasts
colnames(contrasts(BMI$education)) <- c("middle", "highest")

# Fit the model, get summary, check
out4 <- lm(BMI ~ education + children, data = BMI)
s4   <- summary(out4)
s4

# Check the coding of the children variable
contrasts(BMI$children)

# Then, we only need the intercept!
coef(out4)["(Intercept)"]

# Extract the regression coefficient of interest
coef(out4)["educationhighest"]

# Check the pvalue with the isSig function
isSig(out4, "educationhighest")

# Extract the regression coefficient of interest
coef(out4)["educationmiddle"]

# Check the pvalue with the isSig function
isSig(out4, "educationmiddle")

# Use the contr.wec function to set wec effects codes
contrasts(BMI$education) <- contr.wec(BMI$education, omitted = "lowest")

# Fit the model again and check it
out5 <- lm(BMI ~ sex + education, data = BMI)
s5   <- summary(out5)
s5

# Use the contr.wec funciton again but set a different omitted group
contrasts(BMI$education) <- contr.wec(BMI$education, omitted = "highest")

# Fit and check
out6 <- lm(BMI ~ sex + education, data = BMI)
s6 <- summary(out6)
s6


# Print regression coefficient of interest
coef(out6)["educationlowest"]

# Extract pvalue with the isSig function
isSig(out6, "educationlowest")

# Print regression coefficient of interest
coef(out5)["educationhighest"]

# Extract pvalue with the isSig function
isSig(out5, "educationhighest")

# Fit a model without education as predictor
out7 <- update(out6, ". ~ . - education")

# Check the change in R-square
av7 <- anova(out7, out6)
av7

# CHeck the pvalue associated
sig <- av7[2, "Pr(>F)"] < 0.05
ifelse(sig, "YES", "NO")

# The F statistic!
av7[2, "F"]

