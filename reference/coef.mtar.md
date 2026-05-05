# coef method for objects of class `mtar`

coef method for objects of class `mtar`

## Usage

``` r
# S3 method for class 'mtar'
coef(object, ..., FUN = mean)
```

## Arguments

- object:

  an object of class `mtar` obtained from a call to the
  [`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md)
  function.

- ...:

  additional arguments passed to `FUN`.

- FUN:

  a function to be applied to the MCMC chains associated with each model
  parameter. By default, `FUN` is set to `mean`.

## Value

A list containing the summary statistics obtained by applying `FUN` to
the MCMC chains of each model parameter.
