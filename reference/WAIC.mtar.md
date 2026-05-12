# Watanabe-Akaike or Widely Available Information Criterion (WAIC) for objects of class `mtar`

This function computes the Watanabe-Akaike or Widely Available
Information Criterion (WAIC), for objects of class `mtar`.

## Usage

``` r
# S3 method for class 'mtar'
WAIC(...)
```

## Arguments

- ...:

  one or several objects of the class *mtar*.

## Value

A numeric matrix containing the WAIC values corresponding to each *mtar*
object in the input.

## See also

[DIC](https://lhvanegasp.github.io/mtarm/reference/DIC.md)

## Examples

``` r
# \donttest{
###### Example 1: Returns of the closing prices of three financial indexes
data(returns)
fit1 <- mtar_grid(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
                  subset={Date<="2015-12-07"}, dist=c("Gaussian","Student-t",
                  "Slash","Laplace"), nregim.min=2, nregim.max=3, p.min=2,
                  p.max=2, n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
WAIC(fit1)
#>                    WAIC
#> Gaussian.2.2  -17912.50
#> Gaussian.3.2  -18063.03
#> Laplace.2.2   -17947.37
#> Laplace.3.2   -18110.82
#> Slash.2.2     -18037.68
#> Slash.3.2     -18174.88
#> Student-t.2.2 -18053.52
#> Student-t.3.2 -18176.81

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar_grid(~ Bedon + LaPlata | Rainfall, data=riverflows,
                  row.names=Date, subset={Date<="2009-02-13"},dist="Laplace",
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=100,
                  n.sim=200, n.thin=2, plan_strategy="multisession")
WAIC(fit2)
#>                 WAIC
#> Laplace.2.1 13164.26
#> Laplace.2.2 13124.35
#> Laplace.2.3 13073.90
#> Laplace.3.1 13067.29
#> Laplace.3.2 13049.13
#> Laplace.3.3 13025.70

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar_grid(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                  data=iceland.rf,subset={Date<="1974-11-06"},row.names=Date,
                  dist=c("Slash","Student-t"), nregim.min=1, nregim.max=2,
                  p.min=15, p.max=15, q.min=4, q.max=4, d.min=2, d.max=2,
                  n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
WAIC(fit3)
#>                        WAIC
#> Slash.1.15.4.2     8307.484
#> Slash.2.15.4.2     7630.011
#> Student-t.1.15.4.2 8415.070
#> Student-t.2.15.4.2 7638.518

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=1, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
#> Error in getGlobalsAndPackages(expr, envir = envir, globals = globals): The total size of the 7 globals exported for future expression (‘FUN()’) is 639.70 MiB. This exceeds the maximum allowed size 500.00 MiB per plan() argument 'maxSizeOfObjects'. This limit is set to protect against transfering too large objects to parallel workers by mistake, which may not be intended and could be costly. See help("future.globals.maxSize", package = "future") for how to adjust or remove the default threshold via an R option The three largest globals are ‘FUN’ (639.47 MiB of class ‘function’), ‘mycall’ (240.07 KiB of class ‘call’) and ‘grid’ (895 bytes of class ‘list’)
WAIC(fit4)
#> Error: object 'fit4' not found
# }

```
