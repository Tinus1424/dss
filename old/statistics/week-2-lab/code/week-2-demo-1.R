# Course:   Statistics and methodology
# Title:    Week 2 lab demonstration script 1
# Author:   Kyle M. Lang, Edo, Ralph
# Created:  2018-09-10
# Modified: 2023-02-01

# Set up -----------------------------------------------------------------------

# Clear the work space:
rm(list = ls(all = TRUE))

# Set your working directory to the "code" directory:
setwd("~/1_r/statistics/week-2-lab/code")

# 1. File I/O ------------------------------------------------------------------

# Define two character vectors
s1 <- "Hello"
s2 <- "World!"

# Paste the strings contained in character vectors together
paste(s1, s2)
paste(s1, s2, sep = "_")
paste0(s1, s2)

# We can use 'paste' to build file paths:
dataDir <- "../data/"
outDir <- "../output/"
fileName <- "mtcars.rds"

# Read data from disk:
mtcars <- mtcars

# We have two versions of 'read.csv':
mtcars <- read.csv(paste0(dataDir, "mtcars.csv"), row.names = 1) # US format
mtcars <- read.csv2(paste0(dataDir, "mtcars2.csv"), row.names = 1) # EU format

# Look at the top of the dataset:
head(mtcars)

# See the order stats of each variable:
summary(mtcars)

# See the internal structure of the object:
str(mtcars)

# Save the summary:
saveRDS(summary(mtcars), file = paste0(outDir, "mtcars_summary.rds"))

# 2. Compute Descriptive Stats -------------------------------------------------

# Mean:
mean(mtcars$wt)
mtcars[["wt"]]
mtcars[, 1]
mtcars[["mpg"]]
# Variance:
var(mtcars$wt)

# SD:
sd(mtcars$wt)

# Median:
median(mtcars$wt)

# Range:
range(mtcars$wt)
min(mtcars$wt)
max(mtcars$wt)

# Quantiles:
quantile(mtcars$wt, prob = c(0.05, 0.95))

# Calculate the Pearson correlation matrix:
cor(mtcars)

# Calculate the Spearman correlation matrix:
cor(mtcars, method = "spearman")

# Calculate the Kendall correlation matrix:
cor(mtcars, method = "kendall")

# Calculate covariance matrix:
cov(mtcars)

# Compute variable means:
colMeans(mtcars)

# Compute the SDs for every column (i.e., variable) in a data set:
apply(
    X = mtcars, # some matrix of values
    MARGIN = 2, # apply to the columns (as opposed to rows)
    FUN = sd # which function to apply
)

# Compute variable medians:
apply(mtcars, 2, FUN = median)

# Compute frequency tables:
table(mtcars$carb)

# Compute contingency table:
table(trans = mtcars$am, gears = mtcars$gear)

# Compute contingency table (alternative):
with(mtcars, table(cyl, carb))

# 3. Simple Inferential Analyses -----------------------------------------------

# Simple mean differences (assume equal variance):
t.test(mpg ~ am, var.equal = TRUE, data = mtcars)

# Simple mean differences (do NOT assume equal variance):
t.test(mpg ~ am, var.equal = FALSE, data = mtcars)

# Test mean differences with direction hypothesis:
t.test(mpg ~ am, alternative = "less", data = mtcars)

# Alternative code to obtain the same result:
mpgA <- with(mtcars, mpg[am == 0]) # Subset mpg for automatic transmission
mpgM <- with(mtcars, mpg[am == 1]) # Subset mpg for manual transmission
t.test(x = mpgA, y = mpgM, alternative = "less") # D = mX - mY

# Bivariate correlation:
cor(x = mtcars$wt, y = mtcars$mpg)

# Bivariate correlation test:
cor.test(x = mtcars$wt, y = mtcars$mpg)

# Correlation with a directional hypothesis:
cor.test(x = mtcars$disp, y = mtcars$qsec, alternative = "less")

# 4. Intro to plotting ---------------------------------------------------------

# Read test data:
tests <- readRDS(paste0(dataDir, "tests.rds"))

# Summarize the dataset:
summary(tests)

# Generate a marginal boxplot of ACT score:
boxplot(tests$ACT)

# Generate boxplots of SATV (verbal) scores with grouping by sex:
boxplot(SATV ~ sex, data = tests)

# Generate boxplots of SATQ (quantitative) scores with grouping by sex:
boxplot(SATQ ~ sex, data = tests)

# Generate a histogram of age:
hist(tests$age)

# Generate a kernel density plot of age:
plot(density(tests$age))

# Overlay normal density onto histogram:
hist(tests$age, probability = TRUE)

m <- mean(tests$age)
s <- sd(tests$age)
x <- seq(min(tests$age), max(tests$age), length.out = 1000)

lines(x = x, y = dnorm(x, mean = m, sd = s))

# Create a bi-variate scatterplot:
plot(x = tests[, "age"], y = tests[, "SATV"])

# Create a scatterplot matrix:
pairs(tests[, -c(1, 2)])
