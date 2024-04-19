# Course:   Statistics and methodology
# Title:    Week 2 lab demonstration script 2
# Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo
# Created:  2018-09-10
# Modified: 2023-01-31

# Set up -----------------------------------------------------------------------

# Clear the workspace:
rm(list = ls(all = TRUE))

# Set your working directory to the "code" directory:
setwd("~/1_r/statistics/week-2-lab/code")

# Load packages
library(mice) # For missing data descriptives
library(MASS) # For robust stats

# Define the data directory:
dataDir <- "../data/"

# 1. Missing data descriptives -------------------------------------------------

# Read Big Five Inventory (BFI) data from folder
bfi <- readRDS("../data/bfiANC.rds")

# Compute variable-wise counts of missing values:
cm <- colSums(is.na(bfi))
cm

# Compute variable-wise proportions of missing values:
pm <- colMeans(is.na(bfi))
# is the same as colSums(is.na(bfi)) / nrows(bfi)
pm

# Compute variable-wise count of observed values:
co <- colSums(!is.na(bfi))
co

# Compute variable-wise proportions of observed values:
po <- colMeans(!is.na(bfi))
po

# Compute variable-wise count of observed values (alternative):
nrow(bfi) - cm

# Compute variable-wise proportions of observed values (alternative):
1 - pm

# Summarize the proportion of missing cases:
range(pm)
mean(pm)
median(pm)

# Find variables with more than 10% of the cases missing:
pm[pm > 0.1]

# Find missing data patterns:
missPat <- md.pattern(bfi)

# Increase the max print by a lot
options(max.print = 1e4)

# And print the missing data patterns matrix again
missPat

# Extract the variable-wise missing counts:
missPat[nrow(missPat), ]
missPat[nrow(missPat), -ncol(missPat)]

# Extract the pattern-wise missing counts:
missPat[ , ncol(missPat)]
missPat[-nrow(missPat), ncol(missPat)]

# Extract the counts of pattern membership:
as.numeric(rownames(missPat))
as.numeric(rownames(missPat))[-nrow(missPat)]

missPat[nrow(missPat), ]

# Close the graphics device:
dev.off()

# Compute covariance coverage matrix:
cc_mat <- md.pairs(bfi)$rr / nrow(bfi)
cc_mat

# Extract unique coverage values from the covariance coverage matrix:
cc <- cc_mat[lower.tri(cc_mat)]

# Obtain the range of the coverage values
range(cc)

# Check whether all coverages exceed some threshold:
all(cc > 0.8)

# Find problematic pairs (use entire covariance coverage matrix):
pat <- cc_mat <= 0.8
apply(pat, 2, function(x) names(x)[x])

# 2. Outlier analysis (univariate) ---------------------------------------------

# Load SAT-test data from folder
tests <- readRDS(paste0(dataDir, "tests.rds")) 

# 2.1 Boxplot method -----------------------------------------------------------

# Temporarily store the SATV variable in a numeric vector:
x <- tests[, "SATV"]

# Create a boxplot of SATV:
boxplot(x)

# Compute the statistics underlying a boxplot:
boxplot.stats(x)

# Compute the inner fences for the boxplot method:
iFen <- boxplot.stats(x, coef = 1.5)$stats[c(1, 5)]

# Compute the outer fences for the boxplot method:
oFen <- boxplot.stats(x, coef = 3.0)$stats[c(1, 5)]

# Check which values are POSSIBLE outliers on this variable:
which(x < iFen[1] | x > iFen[2])

# Check which values are PROBABLE outliers on this variable:
which(x < oFen[1] | x > oFen[2])

# Define a function to implement the boxplot method:
bpOutliers <- function(x) {
    # Compute inner and outer fences:
    iFen <- boxplot.stats(x, coef = 1.5)$stats[c(1, 5)]
    oFen <- boxplot.stats(x, coef = 3.0)$stats[c(1, 5)]

    # Return the row indices of flagged 'possible' and 'probable' outliers:
    list(
        possible = which(x < iFen[1] | x > iFen[2]),
        probable = which(x < oFen[1] | x > oFen[2])
    )
}
# R automatically returns the last object when defining a function

# Use the bpOutlier function on a single variable
bpOutliers(tests[, "SATV"])

# Flag outliers in multiple columns with a single line of code:
lapply(tests[, c("SATQ", "SATV")], FUN = bpOutliers)

# 2.2 Median Absolute Deviation method -----------------------------------------

# Compute the median of SATV
medX <- median(x)

# Compute the median absolute deviation of SATV
madX <- mad(x)

# Compute the test statistic
Tmad <- (x - medX) / madX

# Define a cut-off value
cut <- 2

# Check for which observations |T_MAD| > cut:
which(abs(Tmad) > cut)

# Define a function to implement the MAD method:
madOutliers <- function(x, cut = 2.5, na.rm = TRUE) {
    # Compute the median and MAD of x:
    mX   <- median(x, na.rm = na.rm)
    madX <- mad(x, na.rm = na.rm)
    
    # Return row indices of observations for which |T_MAD| > cut:
    which(abs(x - mX) / madX > cut)
} 

# Find potential outliers in SATQ and SATV according to MAD method:
lapply(tests[, c("SATQ", "SATV")], FUN = madOutliers)

# 3. Outlier analysis (multivariate) -------------------------------------------
#    Using the Robust Mahalanobis distance method

# Consider the numeric columns of our dataset
tests_num <- tests[, c("age", "ACT", "SATV", "SATQ")]

# Compute the (robust) estimates of the mean and covariance matrix of the data:
stats <- cov.mcd(tests_num)

# Compute the (squared) Mahalanobis distances:
smd <- mahalanobis(
    x = tests_num,
    center = stats$center,
    cov = stats$cov
)

# Return the Mahalanobis distance on the scale we care about:
md <- sqrt(smd)

# Count the number of columns (i.e., variables) in the data:
K <- ncol(tests_num)

# Find the cutoff value:
crit <- sqrt(qchisq(p = 0.99, df = K))

# Return row indices of flagged observations:
which(md > crit)

# Define a function to implement a robust version of Mahalanobis distance using
# MCD estimation:
mcdMahalanobis <- function(data, prob, ratio = 0.75, seed = NULL) {
    # Set a seed, if one is provided:
    if(!is.null(seed)) set.seed(seed)
    
    # Compute robust (MCD) estimates of the means and covariance matrix:
    stats <- cov.mcd(data, quantile.used = floor(ratio * nrow(data)))
    
    # Compute robust squared Mahalanobis distances
    md <- mahalanobis(x = data, center = stats$center, cov = stats$cov)
    
    # Find the cutoff value:
    crit <- qchisq(prob, df = ncol(data))
    
    # Return row indices of flagged observations:
    which(md > crit)
}

# Flag potential multivariate outliers:
mcdMahalanobis(data = tests[ , -c(1, 2)], prob = 0.99, seed = 235711)
