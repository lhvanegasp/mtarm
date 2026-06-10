# mtarm: Multivariate Threshold Autoregressive (TAR) models

## Overview

`mtarm` is an R package for Bayesian estimation, inference, model
comparison, and forecasting in multivariate Threshold Autoregressive
(TAR) models. The package supports multiple innovation distributions,
automatic variable selection through Stochastic Search Variable
Selection (SSVS), and both standard forecasting and rolling-origin
forecast evaluation. The package accommodates multivariate TAR models
with exogenous variables and allows for flexible error specifications,
including Gaussian, Student-$`t`$, skew-normal, skew-Student-$`t`$,
Laplace, slash, contaminated normal, and symmetric hyperbolic
distributions.

## Installation

Install the development version from GitHub:

``` r

remotes::install_github("lhvanegasp/mtarm")
```

Load the package:

``` r

library(mtarm)
```

## Main Features

- Bayesian estimation of all model parameters in multivariate TAR
  models, except for the number of regimes.

- Support for multiple threshold regimes and exogenous variables.

- Automatic variable selection through Stochastic Search Variable
  Selection (SSVS).

- Flexible innovation distributions, including heavy-tailed and skewed
  alternatives.

- Standard forecasting and rolling-origin forecast evaluation.

- Model comparison using the Deviance Information Criterion (DIC),
  Watanabe-Akaike Information Criterion (WAIC), log-score (LS), Energy
  Score (ES), Absolute Percentage Error (APE), and related predictive
  measures.

- Residual diagnostics based on quantile-type residuals.

- Integration with the `coda` package for convergence assessment and
  posterior analysis.

- Parallel model estimation and specification search through
  [`mtar_grid()`](https://lhvanegasp.github.io/mtarm/reference/mtar_grid.md).

## Quick Start

The following example illustrates how a $`\text{TAR}(3;p=(1,1,2))`$
Student-$`t`$ model can be fitted on a bivariate output series:

``` r

library(mtarm)

data(returns)
fit <- mtar(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
            subset={Date<="2015-12-07"}, dist="Student-t",
            ars=ars(nregim=3,p=c(1,1,2)), n.burnin=1000, n.sim=2000,
            n.thin=2)

summary(fit)
```

Generate forecasts:

``` r

newdata <- subset(returns, Date>"2015-12-07")
pred <- predict(fit, newdata=newdata, n.ahead=nrow(newdata), credible=0.95)

pred[["summary"]]
```

## Documentation

Additional examples and detailed explanations are available in the
package website:

<https://lhvanegasp.github.io/mtarm/>

Reference manual:

<https://lhvanegasp.github.io/mtarm/reference/>

Articles and vignettes:

<https://lhvanegasp.github.io/mtarm/articles/>

## Reproducibility

For reproducible analyses, users are encouraged to set a random seed
before model estimation:

``` r

set.seed(6666)
```

All examples included in the documentation website and package vignettes
can be reproduced directly from the source code distributed with the
package.

## Citation

If you use `mtarm` in academic work, please cite the corresponding
package paper:

Vanegas, L. H., et al. *mtarm: Bayesian Multivariate Threshold
Autoregressive Models in R*.
