# Out-of-sample predictive accuracy measures

Computes out-of-sample predictive accuracy measures for one or more
fitted models of the same class, based on their predictive
distributions.

## Usage

``` r
out_of_sample(..., newdata, n.ahead)
```

## Arguments

- ...:

  one or more fitted model objects of the same class.

- newdata:

  a data frame containing the future values of the output series
  required to evaluate predictive performance.

- n.ahead:

  a positive integer specifying the number of forecast steps ahead to
  use in the predictive performance evaluation.
