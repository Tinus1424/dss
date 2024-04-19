# Course:   Statistics and methodology
# Title:    Week 7 lab practice script
# Author:   Waymond Wang
# Created:  2018-10-09
# Modified: 2023-03-09

# 1. Preliminaries -------------------------------------------------------------

setwd("~/1_r/statistics/week-7-lab/code")
# 1.2) Use the library function to load the moments, lmtest, and sandwich packages.
library(moments)
library(lmtest)
library(sandwich)

# 1.3) Use the readRDS function to load the airQual.rds dataset into your workspace.
airQual <- readRDS("../data/airQual.rds")

# 2. Model specification -------------------------------------------------------

# 2.1

mod <- lm(Temp ~ Ozone + Wind + Solar.R, data = airQual)
summary(mod)
# 2.2

res <- resid(mod)
fit <- fitted(mod)

scatter.smooth(
  x = res,
  y = fit,
  span = 0.5
)

plot(mod, which = 1)

# 2.3

# The residuals do not have constant variance

# 2.4

# Add a quadratic expression

# 2.5

resettest(mod)

# 2.6

# Add a quadratic expression

# 2.7

mod1 <- update(mod, ". ~ . + I(Ozone^2)")
mod2 <- update(mod, ". ~ . + I(Wind^2)")
mod3 <- update(mod, ". ~ . + I(Solar.R^2)")


# 2.8

plot(mod1, which = 1)
plot(mod2, which = 1)
plot(mod3, which = 1)

# 2.9

resettest(mod1)
resettest(mod2)
resettest(mod3)

# 2.10

# mod1

# 2.11

# No

# 2.12

# Yes

# 3. Diagnostics ---------------------------------------------------------------

# 3.1

mod02 <- lm(Temp ~ Ozone + Wind + Solar.R + I(Ozone^2), data = airQual)
summary(mod02)

# 3.2

plot(mod02, which = 1)

# 3.3

# There are three marked influential observations

# 3.4

bptest(mod02)

# 3.5 

# Suggests heteroscedasticity

# 3.6

# Yes

# 3.7

res02 <- resid(mod02)
qqnorm(res02)
qqline(res02)
plot(density(res02))
skewness(res02)
kurtosis(res02)
shapiro.test(res02)
ks.test(res02, y = pnorm, mean = mean(res02), sd = sd(res02))

# 3.8

# No

# 3.9 

# Yes

# 4. Robust SEs

# 4.1

covHC1 <- vcovHC(mod02)

# 4.2

mod02a <- coeftest(mod02, vcov = covHC1)
summary(mod02)
summary(mod02a)

# 4.3

# Nothing?

# 4.4

mod02b <- update(mod02, ". ~ . + I(Wind^2) + I(Solar.R^2)")

# 4.5
covHC2 <- vcovHC(mod02b)

anova(mod02, mod02b)
waldtest(mod02, mod02b, vcov = covHC2)

# 4.6 

# Insignificant

# 4.7
summary(mod02)
summary(mod02b)

# 5. Influential observations --------------------------------------------------

# 5.1 

srs <- rstudent(mod2)
plot(srs)

# 5.2

# Relatively normally distributed

# 5.3

srs <- sort(abs(srs), decreasing = TRUE)
badsrs <- as.numeric(names(srs[1 : 2]))
badsrs

# 5.4

lev <- hatvalues(mod2)
lev
plot(lev)

# 5.5

# There are some high leverage variables

# 5.6

lev <- sort(lev, decreasing = TRUE)
badlev <- as.numeric(names(lev[1:3]))
badlev

# 5.7
cd <- cooks.distance(mod02)
cd
plot(cd)

# 5.8

# There are some influential variables

# 5.9

cd <- sort(cd, decreasing = TRUE)
badcd <- as.numeric(names(cd[1:5]))
badcd

# 5.10

dff <- dffits(mod02)
dff
plot(dff)

# 5.11

# There are some influential variables

# 5.12

dff <- sort(dff, decreasing = TRUE)
baddff <- as.numeric(names(dff[1:5]))
baddff

# 5.13
badcd
baddff

# No

# 5.14

# Influential

baddff

# High leverage

badlev

# Outlier

badsrs

# Mostly not the same

airQuali <- airQual[-baddff, ]

mod2.2 <- update(mod2, data = airQuali)

summary(mod2)
summary(mod2.2)

plot(mod2)
plot(mod2.2)


