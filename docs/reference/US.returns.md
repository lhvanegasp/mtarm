# U.S. Stock Returns

The dataset comprises observations of both continuously compounded and
simple returns derived from the S&P 500 index, along with the difference
of the Chicago Board Options Exchange Market Volatility Index (VIX). The
sample period spans from January 5, 2005, to April 24, 2026.

## Usage

``` r
data(US.returns)
```

## Format

A data frame with 5420 rows and 6 variables:

- Date:

  A vector indicating the date of each observation.

- SP500:

  A numeric vector giving the S&P500 index.

- VIX:

  A numeric vector giving the Chicago Board Options Exchange Market
  Volatility Index (VIX).

- CCR:

  A numeric vector giving the continuously compounded returns.

- SR:

  A numeric vector giving the simple returns.

- dVIX:

  A numeric vector giving the difference \\VIX\_{t-1}-VIX\_{t-2}\\.

## References

Massacci, D. (2014) A two-regime threshold model with conditional skewed
student-t distributions for stock returns. Economic Modelling, 43, 9-20.

## Examples

``` r
data(US.returns)
dev.new()
plot(ts(as.matrix(US.returns[,-1])))
```
