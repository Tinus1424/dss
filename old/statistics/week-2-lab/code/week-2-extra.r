# Lecture:  01basics.pdf
# Topic:    Computing (Welch's) t-tests by hand
# Author:   Edoardo Costantini
# Created:  2022-09-13
# Modified: 2023-02-09
# Note:     Extra material, not required, just for fun!

# Manual computations ----------------------------------------------------------

# Define the path to the data directory
dataDir <- "../data/"

# Read the different data sets we will need for this session
bfi1 <- readRDS(paste0(dataDir, "bfi_clean.rds"))

# T test: group mean difference ------------------------------------------------

# Conduct a t-test to check for difference in mean levels of "agree" (i.e.,
# agreeableness) between males and females

mdtest <- t.test(agree ~ sex, data = bfi1, var.equal = TRUE)

# You can compute all of the values obtained with the t.test() function manually.
# This is extra content that might help you understand important statistical
# concepts.
# However, you do NOT need to know how to do this for the exam / quiz.

# Get get all the information you need on the two samples (men and women)
mean_1 <- mean(bfi1$agree[bfi1$sex == "male"]) # mean of agree for men
s2_1 <- var(bfi1$agree[bfi1$sex == "male"]) # variance of agree for men
n_1 <- sum(bfi1$sex == "male") # sample size of men

mean_2 <- mean(bfi1$agree[bfi1$sex == "female"]) # mean of agree for women
s2_2 <- var(bfi1$agree[bfi1$sex == "female"]) # variance of agree for women
n_2 <- sum(bfi1$sex == "female") # sample size of women

# Define the estimate (difference in means) according to the null hypothesis
est_h0 <- 0

# Compute the estimate of interest (difference between group means)
est <- mean_1 - mean_2

# Compute the pooled standard deviation
pool_sd <- sqrt(((n_1 - 1) * s2_1 + (n_2 - 1) * s2_2) / (n_1 + n_2 - 2))

# Compute the variability measure (standard error of the estimate)
variability <- pool_sd * sqrt(1 / n_1 + 1 / n_2)

# Compute the t-statistic
t_statistic <- (est - est_h0) / variability

# Compute the degrees of freedom
df <- n_1 + n_2 - 2

# Obtain the p-value by checking the probability of observing the
# t_statistic you observed or something more extreme on a t-distribution
# with degrees of freedom df
pvalue <- pt(q = t_statistic, df = df) * 2 # * 2 because it's a two sided test!

# Compare results
cbind(
  man = c( # Compute by us!
    t = t_statistic,
    df = df,
    pval = pvalue
  ),
  R = c( # Returned by R
    t = mdtest$statistic,
    df = mdtest$parameter,
    pval = mdtest$p.value
  )
)

# T test: Pearson correlation coefficient --------------------------------------

# Test for a significant Pearson correlation between "agree" and "neuro" (i.e., neuroticism)
cortest <- with(bfi1, cor.test(agree, neuro))

# Compute everything manually
r <- cor(bfi1$agree, bfi1$neuro) # correlation coefficient
n <- nrow(bfi1) # sample size
t_statistic <- r * sqrt((n - 2) / (1 - r^2)) # t-statistic
df <- n - 2 # degrees of freedom
pvalue <- pt(q = t_statistic, df = df) * 2 # * 2 because it's a two sided test!

# Compare results
cbind(
  man = c( # Compute by us!
    t = t_statistic,
    df = df,
    pval = pvalue
  ),
  R = c( # Returned by R
    t = cortest$statistic,
    df = cortest$parameter,
    pval = cortest$p.value
  )
)

# Welch test: the most general T test ever -------------------------------------
# Unequal sample sizes and variances

# Define some population values
u1 <- 20 # mean of variable of interest in group 1
u2 <- 22 # mean of variable of interest in group 2
v1 <- 16^2 # variance of variable of interest in group 1
v2 <- 1^2 # variance of variable of interest in group 2
n1 <- 10 # number of observations on variable of interest in group 1
n2 <- 20 # number of observations on variable of interest in group 2

# Set a seed
set.seed(20230208)

# Draw data for two groups with UNEQUAL variance and sample size
x1 <- rnorm(n = n1, mean = u1, sd = sqrt(v1))
x2 <- rnorm(n = n2, mean = u2, sd = sqrt(v2))

# Observed mean difference?
theta <- mean(x2) - mean(x1)

# Check whether the observed mean difference is statistically significant
ttestouteq <- t.test(x1, x2, var.equal = TRUE)
ttestouteq$p.value

# Check whether the observed mean difference is statistically significant
ttestout <- t.test(x1, x2, var.equal = FALSE)
ttestout$p.value

# Compute degrees of freedom by hand
num <- (sd(x1)^2 / n1 + sd(x2)^2 / n2)^2
den <- sd(x1)^4 / (n1^2 * (n1 - 1)) + sd(x2)^4 / (n2^2 * (n2 - 1))
df_man <- num / den

# Compute standard error of the difference in means
sdelta <- sqrt(sd(x1)^2 / n1 + sd(x2)^2 / n2)

# T statistic
tstat <- theta / sdelta

# Compute the P-value
pval <- pt(abs(tstat), df = df_man, lower.tail = FALSE) * 2

# Compare with results from baseline R function
round(
  cbind(
    man = c(
      est = theta,
      t = abs(tstat),
      se = sdelta,
      df = df_man,
      pval = pval
    ),
    R = c(
      est = diff(ttestout$estimate),
      t = abs(ttestout$statistic),
      se = ttestout$stderr,
      df = ttestout$parameter,
      pval = ttestout$p.value
    )
  ), 3
)

# What would have happened had we assumed equal variance?

# 1. Different standard error computation

# Equal variance
se_eq <- sqrt(
  ((n1 - 1) * var(x1) + (n2 - 1) * var(x2)) / (n1 + n2 - 2)
) * sqrt(1 / n1 + 1 / n2)

# Unequal variance
se_uneq <- sqrt(sd(x1)^2 / n1 + sd(x2)^2 / n2)

# 2. Different degrees of freedom computation

# Equal variance
df_eq <- n1 + n2 - 2

# Unequal variance
num <- (sd(x1)^2 / n1 + sd(x2)^2 / n2)^2
den <- sd(x1)^4 / (n1^2 * (n1 - 1)) + sd(x2)^4 / (n2^2 * (n2 - 1))
df_uneq <- num / den

# Compare results of t tests with equal and unequal variance assumptions
round(
  cbind(
    eq = c(
      est = theta,
      se = se_eq,
      t = theta / se_eq,
      df = df_eq,
      pval = pt(abs(theta / se_eq), df = se_eq, lower.tail = FALSE) * 2
    ),
    uneq = c(
      est = theta,
      se = se_uneq,
      t = theta / se_uneq,
      df = df_uneq,
      pval = pt(abs(theta / se_uneq), df = se_uneq, lower.tail = FALSE) * 2
    )
  ), 3
)

# Note: the se is underestimated when assuming equal variance when we should not
