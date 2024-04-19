# Course:   Statistics and methodology
# Title:    Week 5 lab demonstration script
# Author:   Kyle M. Lang, L.V.D.E. Vogelsmeier, Edo, Ralph
# Created:  2017-09-08
# Modified: 2023-03-06

# Set up -----------------------------------------------------------------------

# Clear the workspace
rm(list = ls(all = TRUE))

# Install a new package we will need for weighted effects codes
# install.packages("wec")

# Load package
library(wec)

# Set a seed for this session
set.seed(235711)

# Load the iris data 
data(iris)

# Make a Sub-sample of 100 rows to obtain unbalanced group sizes
iris_sub <- iris[sample(1 : nrow(iris), 100), ]

# 1. Factor Variables ----------------------------------------------------------

# Look at the 'Species' column of the data.frame iris:
iris_sub$Species

# Check if it's a factor:
is.factor(iris_sub$Species)

# Look at its structure
str(iris_sub$Species)

# Use summary() to obtain the number of observations per level
summary(iris_sub$Species)

# same as table!
table(iris_sub$Species)

# Factors have labeled levels:
levels(iris_sub$Species)
nlevels(iris_sub$Species)

# Factors have special attributes:
attributes(iris_sub)
attributes(iris_sub$Petal.Length)
attributes(iris_sub$Species)

# Factors are not numeric variables:
mean(iris_sub$Species)
var(iris_sub$Species)
iris_sub$Species - iris_sub$Species

# 1.1 Creating Factor Variables ------------------------------------------------

# Create a variable with 10 values
x <- c(1, 1, 2, 1, 3, 1, 2, 3, 2, 1)

# Explore how x looks
x

# What is its class?
class(x)

# What are its unique values?
unique(x)

# Transform x (numeric atomic vector) into a factor
y <- factor(x, levels = c(1, 2, 3))

# Explore how y looks
y
class(y)
levels(y)

# We can forget to create a level we needed
y <- factor(x, levels = c(1, 2))
y

# We can create an empty factor level
y <- factor(x, levels = c(1, 2, 3, 4))
y
table(y)

# We can let R choose levels by default
y <- factor(x)
y

# Arithmetic doesn't work anymore!
mean(y)

# Transform x into a factor with meaningful labels:
z <- factor(x,
    levels = c(1, 2, 3),
    labels = c("setosa", "versicolor", "virginica")
)
z
data.frame(x, z)

# Play around with the order of the levels
z2 <- factor(x,
    levels = c(2, 1, 3),
    labels = c("versicolor", "setosa", "virginica")
)
z2
data.frame(x, z, z2)

# Check whether the two factors with different orders are considered the same
all.equal(z, z2)

# Check the levels: the order is different!
levels(z)
levels(z2)

# 2 Working with categorical predictors in R -----------------------------------

# Let's plot Petal.length by Species
stripchart(iris_sub$Petal.Length ~ iris_sub$Species, vertical = T, method = "jitter")

# Add some informative labels to our plot
stripchart(iris_sub$Petal.Length ~ iris_sub$Species, vertical = T, method = "jitter", xlab = "Species", ylab = "Petal length (cm)", col = rainbow(3))

# Add mean lines to plot
x <- 1:3
y <- tapply(iris_sub$Petal.Length, iris_sub$Species, mean)
segments(x - 0.2, y, x + 0.2, y, lwd = 2) # The width of the segment is here set to ±0.2

# 2.1 Dummy Codes --------------------------------------------------------------

# Use a categorical variable (factor) as a predictor:
out1 <- lm(Petal.Length ~ Species, data = iris_sub)
summary(out1)

# Check the contrasts:
contrasts(iris_sub$Species)

# Change the reference group:
iris_sub$Species2 <- relevel(iris_sub$Species, ref = "virginica")

# Compare the order of the levels:
levels(iris_sub$Species)
levels(iris_sub$Species2)

# How are the contrasts affected:
contrasts(iris_sub$Species)
contrasts(iris_sub$Species2)

# Fit the same model, using the factor with different contrast matrix
out2 <- lm(Petal.Length ~ Species2, data = iris_sub)

# Compare the two outputs
summary(out1)
summary(out2)

# 2.2 Unweighted Effects Codes -------------------------------------------------

# Create a copy of the original factor (w/ original dummy coding)
iris_sub$Species3 <- iris_sub$Species

# We want to change the dummy contrast matrix to the uwc
contrasts(iris_sub$Species3)

# Use the 'contr.sum' function to create unweighted effects-coded contrasts:
?contr.sum

# Change the contrast of the new factor
contrasts(iris_sub$Species3) <- contr.sum(levels(iris_sub$Species3))

# Check it!
contrasts(iris_sub$Species3)

# Use the new fancy-pants Species factor:
out3 <- lm(Petal.Length ~ Species3, data = iris_sub)

# Check the output
summary(out3)

# How about some better names?
colnames(contrasts(iris_sub$Species3)) <- c("setosa", "versicolor")
contrasts(iris_sub$Species3)

# Fit the model again
out4 <- lm(Petal.Length ~ Species3, data = iris_sub)

# And enjoy easier-to-read results
summary(out4)

# Change the omitted group by changing the LAST level of a factor
iris_sub$Species4 <- iris_sub$Species
iris_sub$Species4 <- relevel(iris_sub$Species4, ref = "virginica")
contrasts(iris_sub$Species4) <- contr.sum(levels(iris_sub$Species4))

# Check contrasts!
contrasts(iris_sub$Species3)
contrasts(iris_sub$Species4)

# But don't forget to make the names meaningful
colnames(contrasts(iris_sub$Species4)) <- c("virginica", "setosa")

# Fit the model again
out5 <- lm(Petal.Length ~ Species4, data = iris_sub)

# Compared to out4
summary(out4)
summary(out5)

# Define a function to automatically change the omitted group:
changeOmitted <- function(x) relevel(x, ref = levels(x)[nlevels(x)])

# Use it on the original factor
tmp <- changeOmitted(iris_sub$Species)

# And check it worked as expected
levels(iris_sub$Species)
levels(tmp)

# 2.3 Weighted Effects Codes ---------------------------------------------------

# Use the 'contr.wec' function to create weighted effects-coded contrasts:
iris_sub$Species5            <- iris_sub$Species
contrasts(iris_sub$Species5) <- contr.wec(iris_sub$Species, omitted = "virginica")

# Check how the contrast matrix looks like:
contrasts(iris_sub$Species5)

# Understand the meaning of the wec:
- table(iris_sub$Species) / table(iris_sub$Species)["virginica"]

# Fit model and look at output
out6 <- lm(Petal.Length ~ Species5, data = iris_sub)
summary(out6)

# Create contrast with a different reference level:
iris_sub$Species6            <- iris_sub$Species
contrasts(iris_sub$Species6) <- contr.wec(iris_sub$Species, omitted = "setosa")
contrasts(iris_sub$Species6)
-table(iris_sub$Species) / table(iris_sub$Species)["setosa"]

# Fit the model again
out7 <- lm(Petal.Length ~ Species6, data = iris_sub)
summary(out6)
summary(out7)

# 2.4 Reverting to Default "Treatment" Contrasts -------------------------------

# Reverting to Default "Treatment" Contrasts
tmp <- iris_sub$Species6
contrasts(tmp)

# Dummy codes without names:
contrasts(tmp) <- contr.treatment(levels(tmp))
contrasts(tmp)

# 3. Testing the Effects of Categorical predictors -----------------------------

# Consider a model we have looked at before
summary(out1)

# Test the effect of Species:
out0 <- lm(Petal.Length ~ 1, data = iris_sub)
summary(out0)
anova(out0, out1)

# Test the partial effect of Species:
out8.1 <- lm(Petal.Length ~ Petal.Width, data = iris_sub)
out8.2 <- update(out8.1, ". ~ . + Species")

summary(out8.1)
summary(out8.2)

anova(out8.1, out8.2)
