# Course:   Statistics and methodology
# Title:    Week 6 lab practice script
# Author:   Elliot Alderson
# Created:  2018-09-24
# Modified: 2023-03-09

# 1. Preliminaries -------------------------------------------------------------

# 1.2) Load the `rockchalk`, `DAAG`, and `psychTools` packages.
library(rockchalk)
library(DAAG)
library(psychTools)

# 1.3) load the `msqW6` and `ecorp` datasets
msqW6 <- readRDS("../data/msqW6.rds")
ecorp <- readRDS("../data/ecorp-salaries.rds")

# 1.4) Load the `leafshape` dataset
data(leafshape)

# 2. Continuous Variable Moderation --------------------------------------------

# Call help file for the msq data
?msq

# 2.1 
out0 <- lm(TA ~ EA * NegAff + PA, data = msqW6)
summary(out0)

# 2.2

summary(out0)
# EA:NegAff = 0.019562

# 2.3 

# Yes

# 2.4

# After controlling for the effect of Positive Affect on Energetic arousal, 
# the effect of Negative Affect on the effect of Energetic Arousal on Tense
# Arousal is 0.19562

# 2.5 

msqW6$NegAff0 <- msqW6$NegAff
msqW6$NegAff10 <- msqW6$NegAff - 10
msqW6$NegAff20 <- msqW6$NegAff - 20
mean(msqW6$NegAff0)
mean(msqW6$NegAff10)
mean(msqW6$NegAff20)


out0.1 <- lm(TA ~ EA * NegAff0 + PA, data = msqW6)
out0.2 <- lm(TA ~ EA * NegAff10 + PA, data = msqW6)
out0.3 <- lm(TA ~ EA * NegAff20 + PA, data = msqW6)

summary(out0.1)
summary(out0.2)
summary(out0.3)

# 2.6

# 0.297818

# 2.7

# Yes

# 2.8

# 0.493442

# 2.9

# yes

# 2.10

# 0.06890667

# 2.11

# No

# 2.12

plotout0 <- plotSlopes(
  model = out0,
  plotx = "EA",
  modx = "NegAff",
  modxVals = c(0, 10, 20)
  )

testout0 <- testSlopes(plotout0)


# 2.13
summary(out0.1)
summary(out0.2)
summary(out0.3)
testout0$hypotests

# 2.14

plot(testout0)

# -46.539311  -7.348106

# 2.15

# For all values above -7.348106

# 3 Binary Categorical Moderators ----------------------------------------------

# 3.1 

out1 <- lm(Salary ~ Experience * Sex, data = ecorp)
summary(out1)

# 3.2

# Yes

# 3.3

# 252.67

# 3.4

# yes

# 3.5

252.67 - 179.28
# 73.39

# 3.6
Sex2 <- relevel(ecorp$Sex, ref = ("female"))
out2 <- lm(Salary ~ Experience * Sex2, data = ecorp)
summary(out2)

# 3.7

slopes1 <- plotSlopes(
  model = out1,
  plotx = "Experience",
  modx = "Sex",
  plotPoints = FALSE
)

# 3.8

testSlopes(slopes1)

# 4 Nominal Categorical Moderators ---------------------------------------------

?leafshape

# 4.1

# Sabah, Panama, Costa Rica, N Queensland, S Queensland, Tasmania

# 4.2

table(leafshape$location)

# 4.3

out3 <- lm(bladelen ~ bladewid * location, data = leafshape)
summary(out3)

out3.1 <- lm(bladelen ~ bladewid + location, data = leafshape)
summary(out3.1)


# 4.4

anova(out3, out3.1)
# yes

# 4.5

# 4.4967

# 4.6
plotout3 <- plotSlopes(
  model = out3,
  plotx = "bladewid",
  modx = "location",
)

testout3 <- testSlopes(plotout3)
testout3$hypotests
# 1.5609438

# 4.7

# Yes

# 4.8

# 1.1782333

# 4.9

# Yes

# 4.10 South Queensland

# 0.9584670

# 4.11

# Yes

# 4.12

# Tasmania

# 4.13

table(leafshape$location)

# Small sample size of the location
