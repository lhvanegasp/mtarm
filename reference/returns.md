# Returns of the closing prices of three financial indexes

This dataset contains daily returns computed from the closing prices of
the COLCAP, BOVESPA, and S&P 500 stock market indexes over the period
from February 10, 2010, to March 31, 2016, comprising 1,505
observations. The COLCAP index reflects the price dynamics of the 20
most liquid stocks traded on the Colombian stock market. The BOVESPA
index represents the Brazilian stock market, the largest and most
important exchange in Latin America and among the largest worldwide. The
Standard & Poor's 500 (S&P 500) index tracks the performance of 500
large-cap companies listed in the United States.

## Usage

``` r
data(returns)
```

## Format

A data frame with 1,505 rows and 4 variables:

- Date:

  A vector indicating the date of each observation.

- COLCAP:

  A numeric vector containing the returns of the COLCAP index.

- SP500:

  A numeric vector containing the returns of the S&P 500 index.

- BOVESPA:

  A numeric vector containing the returns of the BOVESPA index.

## References

Romero, L.V. and Calderon, S.A. (2021) Bayesian estimation of a
multivariate TAR model when the noise process follows a Student-t
distribution. Communications in Statistics - Theory and Methods, 50,
2508-2530.

## Examples

``` r
data(returns)
dev.new()
plot(ts(as.matrix(returns[,-1])), main="Returns")
```
