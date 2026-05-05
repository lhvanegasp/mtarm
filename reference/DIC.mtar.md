# Deviance Information Criterion (DIC) for objects of class `mtar`

This function computes the Deviance Information Criterion (DIC) for
objects of class `mtar`.

## Usage

``` r
# S3 method for class 'mtar'
DIC(...)
```

## Arguments

- ...:

  one or several objects of the class *mtar*.

## Value

A numeric matrix containing the DIC values corresponding to each *mtar*
object in the input.

## See also

[WAIC](https://lhvanegasp.github.io/mtarm/reference/WAIC.md)

## Examples

``` r
# \donttest{
###### Example 1: Returns of the closing prices of three financial indexes
data(returns)
fit1 <- mtar_grid(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
                  subset={Date<="2015-12-07"}, dist=c("Gaussian","Student-t",
                  "Slash","Laplace"), nregim.min=2, nregim.max=3, p.min=2,
                  p.max=2, n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
DIC(fit1)
#>                     DIC
#> Gaussian.2.2  -17932.95
#> Gaussian.3.2  -18200.59
#> Laplace.2.2   -17957.06
#> Laplace.3.2   -18146.81
#> Slash.2.2     -18048.38
#> Slash.3.2     -18277.74
#> Student-t.2.2 -18064.88
#> Student-t.3.2 -18330.33

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar_grid(~ Bedon + LaPlata | Rainfall, data=riverflows,
                  row.names=Date, subset={Date<="2009-02-13"},dist="Laplace",
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=1000,
                  n.sim=2000, n.thin=2, plan_strategy="multisession")
DIC(fit2)
#>                  DIC
#> Laplace.2.1 13117.93
#> Laplace.2.2 13075.83
#> Laplace.2.3 13051.25
#> Laplace.3.1 13056.26
#> Laplace.3.2 13018.06
#> Laplace.3.3 12986.01

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar_grid(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                  data=iceland.rf,subset={Date<="1974-11-06"},row.names=Date,
                  dist=c("Slash","Student-t"), nregim.min=1, nregim.max=2,
                  p.min=15, p.max=15, q.min=4, q.max=4, d.min=2, d.max=2,
                  n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
DIC(fit3)
#>                         DIC
#> Slash.1.15.4.2     8249.091
#> Slash.2.15.4.2     7470.261
#> Student-t.1.15.4.2 8378.278
#> Student-t.2.15.4.2 7541.864

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=1, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
#> Error in getGlobalsAndPackages(expr, envir = envir, globals = globals): The total size of the 7 globals exported for future expression (‘FUN()’) is 981.89 MiB. This exceeds the maximum allowed size 500.00 MiB per plan() argument 'maxSizeOfObjects'. This limit is set to protect against transfering too large objects to parallel workers by mistake, which may not be intended and could be costly. See help("future.globals.maxSize", package = "future") for how to adjust or remove the default threshold via an R option The three largest globals are ‘FUN’ (981.65 MiB of class ‘function’), ‘mycall’ (240.07 KiB of class ‘call’) and ‘grid’ (895 bytes of class ‘list’)
DIC(fit4)
#> Error: object 'fit4' not found
# }

```
