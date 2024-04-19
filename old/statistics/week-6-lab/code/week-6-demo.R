# Course:   Statistics and methodology
# Title:    Week 6 lab demonstration script
# Author:   Kyle M. Lang, Edo
# Created:  2016-04-04
# Modified: 2023-03-07

# Set up -----------------------------------------------------------------------

# Clear the workspace
rm(list = ls(all = TRUE))

# load packages
library(rockchalk)
library(carData)

# 1. Continuous variable moderators --------------------------------------------

# Load the Ginzberg data on psychiatric patients hospitalized for depression
data(Ginzberg)

# Check the help file
?Ginzberg

# Effect of fatalism on depression:
out0 <- lm(depression ~ fatalism, data = Ginzberg)
summary(out0)

# Partial effect (additive model):
out1 <- lm(depression ~ fatalism + simplicity, data = Ginzberg)
summary(out1)

# Conditional effect (moderation/interaction):
out2 <- lm(depression ~ fatalism * simplicity, data = Ginzberg)
summary(out2)

# 1.1 Probing via centering (manually) -----------------------------------------

# Compute the mean of the moderator
m <- mean(Ginzberg$simplicity)

# Compute the standard deviation of the moderator
s <- sd(Ginzberg$simplicity)

# Center the moderator on its mean
Ginzberg$zMid <- Ginzberg$simplicity - m
mean(Ginzberg$zMid)
# Center the moderator on 1 standard deviation above its mean
Ginzberg$zHi <- Ginzberg$simplicity - (m + s)

# Center the moderator on 1 standard deviation below its mean
Ginzberg$zLo <- Ginzberg$simplicity - (m - s)
mean(Ginzberg$zLo)
# Test simple slope at 1 SD below the mean of the moderator:
out2.1 <- lm(depression ~ fatalism * zLo, data = Ginzberg)
summary(out2.1)

# Test simple slope at the mean of the moderator:
out2.2 <- lm(depression ~ fatalism * zMid, data = Ginzberg)
summary(out2.2)

# Test simple slope at 1 SD above the mean of the moderator:
out2.3 <- lm(depression ~ fatalism * zHi, data = Ginzberg)
summary(out2.3)

# 1.2 Probing via `rockchalk` package ------------------------------------------

# First we use 'plotSlopes' to estimate the simple slopes:
plotOut1 <- plotSlopes(
    model    = out2,
    plotx    = "fatalism",
    modx     = "simplicity",
    modxVals = "std.dev"
)

# We can also get simple slopes at the quartiles of simplicity's distribution:
plotOut2 <- plotSlopes(
    model    = out2,
    plotx    = "fatalism",
    modx     = "simplicity",
    modxVals = "quantile" # Now different!
)

# Or we can manually pick some values:
plotOut3 <- plotSlopes(
    model = out2,
    plotx = "fatalism",
    modx = "simplicity",
    modxVals = c(0.5, 1.0, 1.5, 2.0, 2.5) # Pick a point!
)

# Test the simple slopes via the 'testSlopes' function:
testOut1 <- testSlopes(plotOut1)

# Check out which objects are in it
ls(testOut1)

# Extract the simple slopes hypothesis tests
testOut1$hypotests

# Compare to the manual computations you did for the centering method
summary(out2.1)
summary(out2.2)
summary(out2.3)

# 1.3 Johnson-Neyman using rockchalk -------------------------------------------

# We already have the roots
ls(testOut1$jn)

# Region of significance:
testOut1$jn$roots

# Check interpretation:
testOut1$hypotests

# Visualize the region of significance:
plot(testOut1)

# 2. Binary categorical moderators ---------------------------------------------

# Load data:
bfi <- readRDS("../data/bfi-scored.rds")

# Effect of agreeableness on neuroticism:
out0 <- lm(neuro ~ agree, data = bfi)
summary(out0)

# Partial effect (additive model):
out1 <- lm(neuro ~ agree + sex, data = bfi)
summary(out1)

# Conditional effect (moderation/interaction):
out2 <- lm(neuro ~ agree * sex, data = bfi)
summary(out2)

# Test 'female' simple slope by changing the reference group:
bfi$sex2 <- relevel(bfi$sex, ref = "female")

# New coding does not change conclusions on interaction:
out2.1 <- lm(neuro ~ agree * sex2, data = bfi)
summary(out2.1)

# Visualize the continuous-binary interaction:
plotSlopes(
    model = out2,
    plotx = "agree",
    modx = "sex",
    plotPoints = FALSE
)

# 3. Nominal categorical moderators (G > 2) ------------------------------------

# Load data:
data(iris)

# Additive model:
out0 <- lm(Petal.Width ~ Sepal.Width + Species, data = iris)
summary(out0)

# Moderated model:
out1 <- lm(Petal.Width ~ Sepal.Width * Species, data = iris)
summary(out1)

# Test for significant moderation:
anova(out0, out1)

# Test different simple slopes by changing reference group:
iris$Species2 <- relevel(iris$Species, ref = "virginica")
iris$Species3 <- relevel(iris$Species, ref = "versicolor")

out1.1 <- lm(Petal.Width ~ Sepal.Width * Species2, data = iris)
out1.2 <- lm(Petal.Width ~ Sepal.Width * Species3, data = iris)

summary(out1)
summary(out1.1)
summary(out1.2)

# Do the same test using 'rockchalk':
plotOut1 <- plotSlopes(
    model = out1,
    plotx = "Sepal.Width",
    modx = "Species"
)

# And obtain the hypothesis tests
testOut1 <- testSlopes(plotOut1)
testOut1$hypotests
