setwd("~/1_r/statistics/week-0-practice/code")
library(tidyverse)

normaldist <- rnorm(n = 100, mean = 10, sd = 3)
normaldist2 <- rnorm(n = 100, mean = 11, sd = 5)
df <- data.frame(normaldist, normaldist2)

ggplot(df, aes(normaldist)) + 
  geom_histogram(bins = 15, fill = "red") +
  labs(x = "Normally distributed variable distributed in 15 bins",
       y = "Observed count for each bin")

ggplot(df, aes(normaldist)) +
  geom_density() +
  labs(x = "Possible values for X",
       y = "Relative frequency")

ggplot(df) +
  geom_density(aes(normaldist), fill = "red", alpha = 0.5) +
  geom_density(aes(normaldist2), fill = "green", alpha = 0.5) +
  labs(x = "Possible values of X",
       y = "Relative frequency",
       title = "Two normally distributed variables")


