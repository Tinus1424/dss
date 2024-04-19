# Course:   Statistics and methodology
# Title:    Week 2 lab practice exercises
# Author:   Your name
# Created:  2023-01-21
# Modified: 2023-02-03

# 1. Preliminaries -------------------------------------------------------------

# 1.1 - If you have not already done so, use the `install.packages` function to 
#       install the `mice` package.

install.packages("mice")

# 1.2 - Use the `library` function to load the `mice` and `MASS` packages.

library(mice)
library(MASS)

# 1.3 - Use the `paste0` function and the `readRDS` function to load the four datasets into memory.

# Define the path to the data directory
dataDir <- "week-2-lab/data/"

# Read the different data sets we will need for this session
bfi1 <- readRDS(paste0(dataDir, "bfi_clean.rds"))
bfi2 <- readRDS(paste0(dataDir, "bfiOE.rds"))
tests <- readRDS(paste0(dataDir, "tests.rds"))
airQual <- readRDS(paste0(dataDir, "airQual.rds"))

# 2. Inferential testing -------------------------------------------------------

t.test(agree ~ sex, data = bfi1)

#2.2

# The value of the estimated mean difference in agree = 0.398662

#2.3 

# estimated t-statistic t = -10.966

#2.4 

#Yes the difference is significant p-value < 2.2e-16

#3 Basic EDA techniques

#3.1 

#700r, 6c

#3.2 609.6414
mean(tests$SATQ)

#3.3 13357.14
var(tests$SATQ)

#3.4 620
median(tests$SATQ)

#3.5 hist
hist(tests$ACT)

#3.6 density
plot(density(tests$ACT))

#3.7 density on hist
hist(tests$ACT, probability = TRUE)
m <- mean(tests$ACT)
s <- sd(tests$ACT)
x <- seq(min(tests$ACT), max(tests$ACT), length.out = 1000)

lines(x = x, y = dnorm(x, mean = m, sd = s))

#3.8
boxplot(tests$ACT ~ tests$education)

#3.9
table(tests$education)

#3.10
with(tests, table(sex, education))

#3.11
with(tests, table(ACT >= 25, sex))

#4 Missing data descriptives

#4.1 Proportion missing

pm <- colSums(is.na(bfi2))
pm

#4.2 pm 01 
#3.9%

#4.3 obs
co <- colSums(!is.na(bfi2))
co

#4.4 
#541

#4.5 cov matrix
cc_mat <- md.pairs(bfi2)$rr / nrow(bfi2)
cc_mat
range(cc_mat)
#4.6 range
cc <- cc_mat[lower.tri(cc_mat)]
range(cc)
cc

#4.7
cc_mat
# 0.9556738

#4.8
pat <- cc_mat < 0.75
apply(pat, 2, function(x) names(x)[x])

#4.9
missPat <- md.pattern(bfi2)
options(max.print = 1e4)
missPat

#4.10
nrow(missPat) - 1
# 29

#4.11
miss <- missPat[-nrow(missPat), ncol(missPat)]
sum(miss == 1)
miss

#4.12
sum(as.numeric(names(miss)[miss == 1]))
# 338 

# Univariate outliers
# Use airQual + functions in demo script

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
# 5.1
lapply(airQual[, c("Ozone", "Solar.R", "Wind", "Temp")], FUN = bpOutliers)


# 5.2
# Ozone, 39 43 62 99 102 117
# Solar, None
# Wind, 9 18 48
# Temp, None

# 5.3
# None

# 5.4 & 5.5 > see 5.2

# 5.6
madOutliers <- function(x, cut = 3, na.rm = TRUE) {
  # Compute the median and MAD of x:
  mX   <- median(x, na.rm = na.rm)
  madX <- mad(x, na.rm = na.rm)
  
  # Return row indices of observations for which |T_MAD| > cut:
  which(abs(x - mX) / madX > cut)
} 

lapply(airQual[, c("Ozone", "Solar.R", "Wind", "Temp")], FUN = madOutliers)

# 5.7 & 5.8
#Ozone, 30 39 43 62 86 99 101 102 117 121
#Wind, 9 48

# 6 Multivariate outliers
# airQual data, robust MCD Mahalanobis for multivar out Ozone,
# Solar.R, Wind, and Temp
# seed to 235711

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

# 6.1
mcdMahalanobis(airQual[, c("Ozone", "Solar.R", "Wind", "Temp")], 0.99, seed = 235711)

# 5   8   9  15  18  24  25  26  30  39  43  48  62  75 102 117 148
# 6.2
mcdMahalanobis(airQual[, c("Ozone", "Solar.R", "Wind", "Temp")], 0.999, seed = 235711)
# 9  18  26  30  39  43  48  62 102 117

# 6.3
mcdMahalanobis(airQual[, c("Ozone", "Solar.R", "Wind", "Temp")], 
               0.99, ratio = 0.5, seed = 235711)
# 5   8   9  15  18  21  23  24  25  26  27  30  34  39  43  48  62  75
# 86 102 117 148

# 6.4
mcdMahalanobis(airQual[, c("Ozone", "Solar.R", "Wind", "Temp")], 
               0.999, ratio = 0.5, seed = 235711)
# 5   8   9  15  18  24  25  26  27  30  39  43  48  62  75 102 117 148

# 6.5
# increasing the cutoff value decreases the number of outliers
# increasing the sample size included in the calculation decreases 
# the number of outliers