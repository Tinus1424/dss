# Course:   Statistics and methodology
# Title:    Collection of custom-made functions used in this course
# Author:   Edo and Kyle M. Lang.
# Created:  2023-02-13
# Modified: 2023-02-13

# Set up -----------------------------------------------------------------------

# Required packages
library(MASS)

# General student functions ----------------------------------------------------

bpOutliers <- function(x, iCoef = 1.5, oCoef = 3.0) {
    # Description: Function to find outliers via the boxplot method
    # Input:
    #   x     = Vector of numeric data to check for outliers
    #   iCoef = The coefficient that is multiplied by the inner quartile range 
    #           (IQR) to define the inner fences
    #   oCoef = The coefficient that is multiplied by the IQR to define the outer
    #           fences
    # Output: A two-element list containing the indices of any possible and
    #         probable outliers that were detected.
    # Body:

    # Compute inner and outer fences:
    iFen <- boxplot.stats(x, coef = iCoef)$stats[c(1, 5)]
    oFen <- boxplot.stats(x, coef = oCoef)$stats[c(1, 5)]
    
    # Return the row indices of flagged 'possible' and 'probable' outliers:
    list(possible = which(x < iFen[1] | x > iFen[2]),
         probable = which(x < oFen[1] | x > oFen[2])
         )
}

madOutliers <- function(x, cut = 2.5, na.rm = TRUE) {
    # Description: Function to find outliers via the MAD method
    # Input:
    #   x     = Vector of numeric data to check for outliers
    #   cut   = The value of the (absolute) test statistic above which an
    #           observation is flagged as an outlier
    #   na.rm = A logical switch. Should missing values be excluded when estimating
    #           the median and MAD?
    # Output: A vector containing the indices of any possible outliers detected.
    # Body:

    # Compute the median and MAD of x:
    mX   <- median(x, na.rm = na.rm)
    madX <- mad(x, na.rm = na.rm)
    
    # Return row indices of observations for which |T_MAD| > cut:
    which(abs(x - mX) / madX > cut)
}

mdOutliers <- function(data, critProb, statType = "mcd", ratio = 0.75, seed = NULL) {
    # Description: Function to find multivariate outliers via (robust) Mahalanobis
    #              distance
    # Input:
    #   data     = A data.frame to check for multivariate outliers
    #   critProb = The quantile of the chi-squared distribution used to define the
    #              critical value against which the Mahalanobis distances will be
    #              compared to flag outliers
    #   statType = The method of estimation used by "MASS::cov.rob" to estimate the
    #              mean vector and covariance matrix.
    #              Possible values are:
    #                - "mve"       = minimum volume ellipsoid method
    #                - "mcd"       = minimum covariance determinant method
    #                - "classical" = non-robust product-moment estimation
    #              See the documentation of "cov.rob" from the MASS package for
    #              more details.
    #   ratio    = The minimum proportion of observations that will be used to
    #              estimate the robust mean vector and covariance matrix.
    #   seed     = A random number seed.
    # Output: A vector of row indices for any observations flagged as outliers.
    # Body:
    
    # Set a seed, if one is provided:
    if (!is.null(seed)) set.seed(seed)

    # Compute (robust) estimates of the mean and covariance matrix:
    stats <- cov.rob(
        x = data,
        quantile.used = floor(ratio * nrow(data)),
        method = statType
    )

    # Compute robust squared Mahalanobis distances
    md <- mahalanobis(x = data, center = stats$center, cov = stats$cov)

    # Find the cutoff value:
    crit <- qchisq(critProb, df = ncol(data))

    # Return row indices of flagged observations:
    which(md > crit)
}

winsorizeOutliers <- function(x, ol) {
    # Description:  Function to winsorize univariate outliers
    # Input:
    #   x  = A numeric vector of data to be winsorized
    #   ol = A numeric vector giving the indices of 'x' containing outliers
    # Output: A modified version of "x" where the data in every entry represented
    #         in the "ol" vector is replaced by the closest legal datum.
    # Body: 

    # Get the outlying values:
    y <- x[ol]
    
    # Get a sorted list of unique data values:
    ux <- sort(unique(x))
    
    # Winsorize outliers in the positive tail:
    flag <- y > median(x)
    if(any(flag)) {
        lub        <- ux[which(ux == min(y[flag])) - 1]
        x[x > lub] <- lub
    }
    
    # Winsorize outliers in the negative tail:
    flag <- y < median(x)
    if(any(flag)) {
        glb        <- ux[which(ux == max(y[flag])) + 1]
        x[x < glb] <- glb
    }
    
    x # Return the winsorized data
}

cv.lm <- function(data, models, K = 10, names = NULL, seed = NULL) {
    # Description: Function to do K-fold cross-validation with lm()
    # Input:
    #   data   = A data.frame to use for model estimation
    #   models = A list of model formulas (given as character strings) representing
    #            the models to be compared via cross-validation
    #   K      = The number of folds to use
    #   names  = A character vector used to name the output. These names should
    #            match the ordering of the models given in the "models" argument.
    #   seed   = A random number seed
    # Output: A (named) vector containing the cross-validation errors for each
    #         model listed in the "models" argument
    # Body:

    # Set seed, if necessary:
    if(!is.null(seed)) set.seed(seed)
    
    # Create a partition vector:
    part <- sample(rep(1 : K, ceiling(nrow(data) / K)))[1 : nrow(data)]
    
    # Apply over candidate models:
    cve <- sapply(models, getCve, data = data, K = K, part = part)
    
    # Name output:
    if(!is.null(names))          names(cve) <- names
    else if(is.null(names(cve))) names(cve) <- paste("Model", 1 : length(cve))
    
    # Return CVE
    cve
}

summary.cellMeans <- function(obj) {
    # Description: A summary method for cell-means coded lm models.
    #              This function will correct the R^2 and F-stats from the usual 
    #              summary.lm() when applied to an object with cell-means coded 
    #              predictors.
    # Input:  A fitted lm object
    # Output: The correctly-computed summary object
    # Body: 

    # Get broken summaries:
    s0  <- summary.lm(obj)
    av0 <- anova(obj)

    # Extract model info:
    y  <- obj$model[ , 1]
    df <- obj$rank - 1

    # Compute correct measures of variability:
    ss <- crossprod(obj$fitted.values - mean(y))
    ms <- ss / df 

    # Compute correct stats:
    r2  <- as.numeric(ss / crossprod(y - mean(y)))
    r2a <- as.numeric(1 - (1 - r2) * ((length(y) - 1) / obj$df.residual))
    f   <- as.numeric(ms / av0["Residuals", "Mean Sq"])

    # Replace broken stats:
    s0$r.squared           <- r2
    s0$adj.r.squared       <- r2a
    s0$fstatistic[c(1, 2)] <- c(f, df)

    s0 # Return corrected summary
}

fixEcNames <- function(x) {
    # Description: Function to automatically fix EC names
    # Input: A factor with an effects-coded contrasts attribute
    # Ouput: A modified version of the input with appropriate column names for the
    #        contrasts matrix
    # Body:

    tmp                    <- contrasts(x)
    colnames(contrasts(x)) <- rownames(tmp)[rowSums(tmp) > 0]
    x
}

changeOmitted <- function(x) {
    # Description: Function to automatically change the omitted group for unweighted effects
    #              codes
    # Input: A factor with an effects-coded contrasts attribute
    # Ouput: A modified version of the input factor with the levels re-ordered to
    #        ensure a different omitted group
    # Body:

    relevel(x, ref = levels(x)[nlevels(x)])
}

# Subroutines ------------------------------------------------------------------

dvName <- function(x){
    # Description: Extract the DV name from an lm.fit object
    # NOTE: This function only works when lm() is run using the formula interface.
    # Body:

    all.vars(x$terms)[1]
}

getCve <- function(model, data, K, part) {
    # Description: Compute the cross-validation error:
    # Body:

    # Loop over K repetitions:
    mse <- c()
    for (k in 1:K) {
        # Partition data:
        train <- data[part != k, ]
        valid <- data[part == k, ]

        # Fit model, generate predictions, and save the MSE:
        fit <- lm(model, data = train)
        pred <- predict(fit, newdata = valid)
        mse[k] <- MSE(y_pred = pred, y_true = valid[, dvName(fit)])
    }
    # Return the CVE:
    sum((table(part) / length(part)) * mse)
}

# Mi Prediction routines -------------------------------------------------------

.lambda <- function(x) (x + 1) / (x + 3)

.fmi <- function(m, b, t) (1 + (1 / m)) * (b / t)

.miDf <- function(m, b, t, dfCom) {
    fmi <- .fmi(m, b, t)
    df0 <- (m - 1) * (1 / fmi^2)
    dfObs <- .lambda(dfCom) * dfCom * (1 - fmi)

    df0 / (1 + (df0 / dfObs))
}

splitImps <- function(imps, index) {
    # Split the imputed dataset by 'index':
    tmp <- lapply(imps, split, f = index)

    # Create lists of subsets of imputed data:
    out <- list()
    for (i in 1:length(tmp[[1]])) {
        out[[i]] <- lapply(tmp, "[[", x = i)
    }

    # Name output lists:
    names(out) <- names(tmp[[1]])

    out
}

predictMi <- function(fits, newData, interval = NA, pooled = TRUE) {
    # Generate imputation-specific predictions:
    predStuff <- list()
    for (m in 1:length(fits)) {
        predStuff[[m]] <-
            predict(fits[[m]], newdata = newData[[m]], se.fit = TRUE)
    }

    # Extract components from prediction objects:
    preds <- lapply(predStuff, "[[", x = "fit")
    seMat <- sapply(predStuff, "[[", x = "se.fit")
    scales <- sapply(predStuff, "[[", x = "residual.scale")

    # Return early when imputation-specific predictions are requested:
    if (!pooled) {
        return(preds)
    } else {
        predMat <- do.call(cbind, preds)
    }

    # Compute pooled predictions:
    preds <- rowMeans(predMat)

    # Compute within-imputation variance:
    if (is.na(interval) | interval == "confidence") {
        w <- rowMeans(seMat^2)
    } else if (interval == "prediction") {
        w <- colMeans(
            apply(seMat^2, 1, function(x, y) x + y, y = scales^2)
        )
    } else {
        stop(paste0(
            "'",
            interval,
            "' is not a valid argument for 'interval'. Should be either 'confidence' or 'prediction'."
        ))
    }

    # Compute between-imputation variance:
    b <- apply(predMat, 1, var)

    # Compute total variance:
    t <- w + b + (b / length(fits))

    # Compute df:
    df <- .miDf(length(fits), b, t, predStuff[[1]]$df)

    # Compute the FMIs:
    out <- cbind(est = preds, fmi = .fmi(length(fits), b, t))

    # Compute CIs and aggregate output:
    if (!is.na(interval)) {
        moe <- qt(0.975, df) * sqrt(t)
        out <- cbind(out, lwr = preds - moe, upr = preds + moe)
    }

    out
}

mseMi <- function(fits, newData) {
    # Generate imputation-specific predictions:
    preds <- predictMi(fits = fits, newData = newData, pooled = FALSE)

    # Compute imputation-specific MSEs:
    mse <- c()
    for (m in 1:length(fits)) {
        mse[m] <- MSE(
            y_pred = preds[[m]],
            y_true = newData[[m]][[dvName(fits[[1]])]]
        )
    }

    # Return the aggregate MSE:
    mean(mse)
}
