# Lecture:  08moderator.pdf
# Topic:    Exploring simple slopes analysis
# Author:   Edoardo Costantini
# Created:  2022-10-04
# Modified: 2023-03-08

# Set up -----------------------------------------------------------------------

    # Load fundamental package
    library(rockchalk)
    library(carData)

    # Load data
    data(Ginzberg)

    # Fit some linear model with interaction terms
    out <- lm(depression ~ fatalism * simplicity, data = Ginzberg)
    summary(out)

    # Extract coefficients (get rid of intercept to simplify indexing)
    b <- summary(out)$coefficients[-1, ]

    # Define alpha level
    alpha <- .05

    # Define degrees of freedom (n - p - 1)
    dfs <- summary(out)$df[2]

# Replicate computations of simple slopes --------------------------------------

    # Define value of interest for the moderator
    Z <- 0

    # Compute with rockchalk package
    plotOut <- plotSlopes(out,
        plotx      = "fatalism", # focal predictor
        modx       = "simplicity", # moderator
        modxVals   = Z, # points on the moderator to test
        plotPoints = TRUE
    )

    # Check the the simple slopes tests via the 'testSlopes' function
    testOut <- testSlopes(plotOut)
    testOut$hypotests

    # Extract coefficients
    b1 <- b[1, "Estimate"] # conditional effect
    b3 <- b[3, "Estimate"] # interaction effect

    # Extract standard errors
    se_b1 <- b[1, "Std. Error"] # conditional effect
    se_b3 <- b[3, "Std. Error"] # interaction effect
    cov_b1_b3 <- vcov(out)[1+1, 1+3] # covariance between the two

    # Compute the simple slope
    fz <- b1 + b3 * Z

    # Compute the standard error of the simple slope at some level Z of interest
    se_fz <- sqrt(se_b1^2 + 2 * Z * cov_b1_b3 + Z^2 * se_b3^2)

    # Compute T crit at some level of Z of interest
    t_crit <- fz / se_fz

    # Compute p-value associated
    pvalue <- pt(t_crit, df = dfs, lower.tail = FALSE) * 2

    # Compare with roots from plotSlopes function package
    round(
        data.frame(
            manual = c(
                Z = Z,
                estimate = fz,
                se = se_fz,
                t = t_crit,
                pvalue = pvalue
            ),
            rock = as.numeric(testOut$hypotests[1, ])
        ), 8
    )

# Johnson-Neyman Technique -----------------------------------------------------

    # Define the critical value based on alpha, and dfs
    t2_crit <- (qt(alpha / 2, df = dfs))^2

    # Compute a, b and c
    a <- t2_crit * se_b3^2 - b3^2
    b <- 2 * t2_crit * cov_b1_b3 - 2 * b1 * b3
    c <- t2_crit * se_b1^2 - b1^2

    # Compute roots
    Z1 <- (-b + sqrt(b^2 - 4 * a * c)) / (2 * a)
    Z2 <- (-b - sqrt(b^2 - 4 * a * c)) / (2 * a)
    c(Z1, Z2)

    # Compare results
    cbind(
        manual = c(
            a = a,
            b = b,
            c = c,
            inroot = NA, # we did not compute this (don't care)
            root.low = Z1,
            root.high = Z2
        ),
        rocl = unlist(testOut$jn)
    )
