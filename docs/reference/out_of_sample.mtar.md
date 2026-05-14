# Computing Out-of-Sample predictive accuracy measures

Computes Out-of-Sample predictive accuracy measures for two or more
objects of class `mtar`.

## Usage

``` r
# S3 method for class 'mtar'
out_of_sample(
  ...,
  newdata,
  n.ahead = NULL,
  credible = 0.95,
  by.component = TRUE,
  FUN = mean
)
```

## Arguments

- ...:

  one or more objects of class `mtar`.

- newdata:

  A `data.frame` containing future values of the threshold series (if
  included in the fitted model), the exogenous series (if included in
  the fitted model), and the realized values of the output series.

- n.ahead:

  A positive integer specifying the number of steps ahead to forecast.

- credible:

  An optional numeric value in \\(0,1)\\ specifying the level of the
  required prediction intervals. By default, `credible` is set to
  `0.95`.

- by.component:

  An optional logical argument. If `TRUE`, the predictive accuracy
  measures are computed separately for each component of the
  multivariate output series. By default, `by.component` is set to
  `TRUE`.

- FUN:

  An optional function used to summarize the `n.ahead` values computed
  for each predictive accuracy measure. By default, `FUN` is set to
  `mean`.
