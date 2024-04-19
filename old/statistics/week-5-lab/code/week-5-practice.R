# Course:   Statistics and methodology
# Title:    Week 5 lab practice script
# Author:   Mr. Peanutbutter
# Created:  2018-09-24
# Modified: 2023-02-23

# 1. Preliminaries -------------------------------------------------------------

# 1.1) Use the "install.packages" function to install the "wec" and "psych" packages.

# install.packages(c("wec", "psych"), repos = "http://cloud.r-project.org")

# 1.2) Use the "library" function to load the "psych" and "wec" packages.

library(psych)
library(wec)

# 1.3) Use the "data" function to load the "bfi" and "BMI" datasets into your workspace.

# Load data from psych pack
data(bfi)

# Load data from disk
BMI <- readRDS("../data/bmiW5.rds")

# 2. Factors -------------------------------------------------------------------
# 2.1 
?bfi
# 2.2 
bfi$gender <- factor(bfi$gender, levels = c(1, 2), labels = c("male", "female"))

bfi$education <- factor(bfi$education,
                        levels = c(1, 2, 3, 4, 5),
                        labels = c("HS", "finished HS", "some college",
                                   "college graduate", "graduate degree")
                        )

# 2.3
table(bfi$gender, bfi$education)
# 266


# 3. Dummy codes ---------------------------------------------------------------
# 3.1 
?BMI
# 3.2
contrasts(BMI$sex)

# male

# 3.3
contrasts(BMI$education)

# lowest

# 3.4
BMI$education2 <- relevel(BMI$education, ref = "highest")
contrasts(BMI$education2)

out1 <- lm(BMI ~ sex + education2, data = BMI)
out0 <- lm(BMI ~ education2, data = BMI)
# 3.5
summary(out1)
anova(out0, out1)
# yes

# 3.6 

# 24.5456

# 4. Unweighted Effects Codes --------------------------------------------------
# 4.1
BMI$education3 <- BMI$education
contrasts(BMI$education3) <- contr.sum(levels(BMI$education3))
contrasts(BMI$education3)
contrasts(BMI$children)

out2 <- lm(BMI ~ education3 + children, data = BMI)
summary(out2)

# 4.2
changeOmitted <- function(x) relevel(x, ref = levels(x)[nlevels(x)])

BMI$education4 <- changeOmitted(BMI$education)
contrasts(BMI$education4) <- contr.sum(levels(BMI$education4))
contrasts(BMI$education4)

out3 <- lm(BMI ~ education4 + children, data = BMI)
summary(out3)

# 4.3

#25.57683

# 4.4
summary(out3)
# -0.73465

# 4.5

# Yes, but not sure if I can say it from the lm, maybe ANOVA required

# 4.6 
summary(out3)
#0.84868

# 4.7

#yes

#5. Weighted Effects Codes------------------------------------------------------
# 5.1
BMI$education5 <- BMI$education
contrasts(BMI$education5) <- contr.wec(BMI$education5, omitted = "lowest")
out4 <- lm(BMI ~ education5 + sex, data = BMI)
summary(out4)

#5.2
BMI$education6 <- BMI$education
contrasts(BMI$education6) <- contr.wec(BMI$education6, omitted = "highest")
out5 <- lm(BMI ~ education6 + sex, data = BMI)
summary(out5)
#5.3
summary(out5)
#1.15972

#5.4
# Yes

#5.5
summary(out4)
#-0.69666
#5.6 
#yes

#5.7
out6 <- lm(BMI ~ sex, data = BMI)
summary(out6)

anova(out4, out6)
#Yes
#5.8
# F = 54.229
