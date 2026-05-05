# vcov method for objects of class `mtar`

Computes estimates of the variance–covariance matrices for the scale
parameters of a fitted multivariate TAR model.

## Usage

``` r
# S3 method for class 'mtar'
vcov(object, ..., FUN = mean)
```

## Arguments

- object:

  an object of class `mtar`, typically obtained from a call to
  [`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md).

- ...:

  additional arguments passed to `FUN`.

- FUN:

  a function to be applied to the MCMC chains of the scale parameters in
  order to obtain point estimates. By default, `FUN` is set to
  [`mean()`](https://rdrr.io/r/base/mean.html).

## Value

A list containing the variance–covariance estimates obtained by applying
`FUN` to the MCMC chains associated with the scale parameters.
