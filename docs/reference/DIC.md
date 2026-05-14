# Deviance Information Criterion (DIC)

Computes the Deviance Information Criterion (DIC), an adjusted
within-sample measure of predictive accuracy, for models estimated using
Bayesian methods.

## Usage

``` r
DIC(...)
```

## Arguments

- ...:

  one or more fitted model objects of the same class.

## Value

A numeric matrix containing the DIC values corresponding to each fitted
object supplied in `...`.

## References

Spiegelhalter D.J., Best N.G., Carlin B.P. and Van Der Linde A. (2002)
Bayesian Measures of Model Complexity and Fit. Journal of the Royal
Statistical Society Series B (Statistical Methodology), 64(4), 583–639.

Spiegelhalter D.J., Best N.G., Carlin B.P. and Van der Linde A. (2014).
The deviance information criterion: 12 years on. Journal of the Royal
Statistical Society Series B (Statistical Methodology), 76(3), 485–493.
