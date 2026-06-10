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
#> Gaussian.2.2  -17928.60
#> Gaussian.3.2  -18179.95
#> Laplace.2.2   -17952.65
#> Laplace.3.2   -18139.24
#> Slash.2.2     -18045.13
#> Slash.3.2     -18281.22
#> Student-t.2.2 -18087.67
#> Student-t.3.2 -18263.67

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar_grid(~ Bedon + LaPlata | Rainfall, data=riverflows,
                  row.names=Date, subset={Date<="2009-02-13"},dist="Laplace",
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=1000,
                  n.sim=2000, n.thin=2, plan_strategy="multisession")
DIC(fit2)
#>                  DIC
#> Laplace.2.1 13127.10
#> Laplace.2.2 13075.74
#> Laplace.2.3 13050.72
#> Laplace.3.1 13055.54
#> Laplace.3.2 13018.73
#> Laplace.3.3 13000.19

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
#> Slash.1.15.4.2     8248.268
#> Slash.2.15.4.2     7468.947
#> Student-t.1.15.4.2 8377.107
#> Student-t.2.15.4.2 7529.130

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=2, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
DIC(fit4)
#>                      DIC
#> Laplace.2.3.3   14960.38
#> Slash.2.3.3     15003.66
#> Student-t.2.3.3 14932.77
# }

```
