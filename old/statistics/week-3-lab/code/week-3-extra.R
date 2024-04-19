# Lecture:  04slr.pdf and 05mlr.pdf
# Topic:    Simple and multiple linear regression output manually
# Author:   Edoardo Costantini
# Created:  2022-09-13
# Modified: 2023-02-10
# Note:     Extra material is not required knowledge for this course, just fun!

# 1. Calculating lm output manually --------------------------------------------

# 1.1 Prepare the environment --------------------------------------------------

    # Define variables
    y <- mtcars$mpg   # dependent variable
    x <- mtcars$cyl   # single predictor
    n <- nrow(mtcars) # sample size

    # Fit a simple linear model
    lmfit <- lm(y ~ x)

    # Check the estimates we want to replicate
    cbind(summary(lmfit)$coefficients, confint(lmfit))
    
# 1.2 Calculate intercept and regression coefficients --------------------------

    # Create a "design matrix"
    X <- cbind(constant = 1, x)

    # Perform matrix multiplication that leads to estimate
    bs <- solve(t(X) %*% X) %*% t(X) %*% y

    # Simplify the object
    bs <- as.vector(bs)

    # Give meaningful names
    names(bs) <- c("b0", "b1")

# 1.3 Calculate the standard errors --------------------------------------------

    # Calculate fitted values
    y_hat <- fitted(lmfit)            # R function 1
    y_hat <- predict(lmfit)           # R function 2
    y_hat <- bs["b0"] + bs["b1"] * x  # by hand

    # How many parameters did we estimate?
    k <- length(bs)

    # Calculate s_hat (residual error standard deviation)
    s2 <- sigma(lmfit)^2               # R function
    s2 <- sum((y - y_hat)^2) / (n - k) # by hand

    # SE based on formula seen in class
    se <- c(
        b0 = sqrt(s2 * (1 / n + mean(x)^2 / sum((x - mean(x))^2))), # se of intercept
        b1 = sqrt(s2 / sum((x - mean(x))^2)) # se of b1             # se of regression coef
    )

# 1.4 Calculate the t values (test statistic) ----------------------------------

    tvals <- bs / se

# 1.5 calculate the p-values ---------------------------------------------------

    # Compute p-value
    pvals <- pt(            # probability on the left / right of a given q on a t distribution
        q = abs(tvals),     # the t-values we want to use
        df = n - k,         # degrees of freedom defining the specific t distribution
        lower.tail = FALSE, # take the upper tail (always returns correct value for abs(q))
    ) * 2                   # it's a two-tailed test

# 1.6 Confidence intervals -----------------------------------------------------

    # Confidence interval level
    lvl <- 0.95

    # Compute the precise critical value
    tcrit <- abs(qt(p = (1 - lvl) / 2, df = n - k))

    # Compute upper bound of lvl-CI:
    CI_upr <- bs + tcrit * se

    # Compute lower bound of lvl-CI:
    CI_lwr <- bs - tcrit * se

# 1.7 compare results ----------------------------------------------------------

    # R computations
    cbind(summary(lmfit)$coefficients, confint(lmfit))

    # Manual computations
    cbind(
        bs,
        se,
        tvals,
        pvals,
        CI_lwr, 
        CI_upr
    )

# 2 Exploring relationship between R2 and the F statistic ----------------------

# 2.1 Prepare the environment --------------------------------------------------

    # Define variables
    y <- mtcars$mpg # dependent variable
    x1 <- mtcars$cyl # first predictor
    x2 <- mtcars$wt # second predictor
    n <- nrow(mtcars) # sample size
    p <- 2 # number of predictors

    # Fit model
    lmfit <- lm(y ~ x1 + x2)

    # Compute summary
    summary(lmfit)

# 2.2 R2 significance testing --------------------------------------------------

    # Compute fitted values
    y_hat <- fitted(lmfit)

    # Compute residuals
    Er <- TSS <- sum((y - mean(y))^2) # baseline prediction error
    Ef <- SSE <- sum((y - y_hat)^2) #     # prediction error

    # Compute degrees of freedom
    dfR <- (n - 0 - 1) # for the restricted model
    dfF <- (n - p - 1) # for the full model

    # Compute the f statistic
    Fstat <- ((Er - Ef) / (dfR - dfF)) / (Ef / dfF)
    summary(lmfit)$fstatistic

    # Plot the null hypothesis F distribution
    df1 <- p
    df2 <- n - p - 1
    plot(density(rf(1e4, df1, df2)))
    abline(v = Fstat)

    pf(Fstat, df1, df2, lower.tail = FALSE)

    # Relationship to R^2
    R2 <- 1 - Ef / Er
    summary(lmfit)$r.squared
    # Not the same as the F score, but:
    # - in Ef/Er, if Ef is bigger, R2 is smaller -> model is not good
    # - in Er - Ef, if Ef is bigger, F is smaller -> model is not good

# 2.3 R2 model comparison ------------------------------------------------------

    # Define objects you'll need
    y <- mtcars$mpg # store the dependent variable
    n <- nrow(mtcars) # store the sample size

    # Model 1
    lmfit1 <- lm(mpg ~ cyl, data = mtcars)

    # Model 2
    lmfit2 <- lm(mpg ~ cyl + wt + hp, data = mtcars)

    # Test R2 change with anova R-function
    R2_change <- anova(lmfit1, lmfit2)

    # Compute residuals
    TSS <- sum((y - mean(y))^2)
    Er <- SSEr <- sum((y - predict(lmfit1))^2) # baseline prediction error
    Ef <- SSEf <- sum((y - predict(lmfit2))^2) # prediction error
    R2_change$RSS

    # Compute degrees of freedom
    dfR <- (n - (length(lmfit1$coefficients) - 1) - 1)
    dfF <- (n - (length(lmfit2$coefficients) - 1) - 1)
    R2_change$Res.Df

    # Compute the f statistic
    Fstat <- ((Er - Ef) / (dfR - dfF)) / (Ef / dfF)
    R2_change$F

    # Anova output
    pf(Fstat, df1 = dfR - dfF, df2 = dfF, lower.tail = FALSE)
    R2_change$"Pr(>F)"

    # Null hypothesis distribution
    plot(density(rf(1e4, df1 = dfR - dfF, df2 = dfF)), xlim = c(0, 20))
    abline(v = Fstat)

# 2.4 Relationship of F and R^2 ------------------------------------------------

    # Define R2 for the two models
    R2f <- 1 - SSEf / TSS
    R2r <- 1 - SSEr / TSS

    # Compute the difference in R2 between the full and restricted model (d for delta)
    dR2 <- R2f - R2r

    # Check how you would compute the Fstat starting from dR2
    all.equal(
        target = Fstat,
        current = dR2 * TSS / (dfR - dfF) / (Ef / dfF)
    )

    # Check how you would compute the dR2 starting from Fstat
    all.equal(
        target = dR2,
        current = Fstat * (Ef / dfF) * (dfR - dfF) / TSS
    )

# 2.4.1 How do we get there? ---------------------------------------------------

    # 1. Consider the general formula to compute the F statistic

    # Compute the F statistic with the general formula
    ((Er - Ef) / (dfR - dfF)) / (Ef / dfF)

    # Note that Er = SSEr and Ef = SSEf (Alternative general formula)
    ((SSEr - SSEf) / (dfR - dfF)) / (Ef / dfF)

    # 2. Consider the usual formula to compute the change in R-square

    # The R change is their difference
    R2f - R2r

    # Which we can write in full
    (1 - SSEf / TSS) - (1 - SSEr / TSS)

    # 3. Simplify this formula by removing the parenthesis

    # Carry over the minus
    1 - SSEf / TSS - 1 + SSEr / TSS

    # Get rid of the 1s: 1 - 1 = 0
    SSEr / TSS - SSEf / TSS

    # Write with the common denominator
    dR2 <- (SSEr - SSEf) / TSS

    # 4. Solve dR2 = (SSEr - SSEf) / TSS for (SSEr - SSEf)

    # Multiply left and write by TSS:
    dR2 * TSS == (SSEr - SSEf) / TSS * TSS

    # Which simplifies to:
    dR2 * TSS == (SSEr - SSEf)

    # Replace (SSEr - SSEf) with (dR2 * TSS) in the F general formula:
    (dR2 * TSS / (dfR - dfF)) / (Ef / dfF)

    # Compare to original F statistic:
    Fstat

    # Yay!