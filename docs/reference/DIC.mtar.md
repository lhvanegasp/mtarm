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
                  p.max=2, n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
DIC(fit1)
#>                     DIC
#> Gaussian.2.2  -17930.21
#> Gaussian.3.2  -18193.50
#> Laplace.2.2   -17955.60
#> Laplace.3.2   -18134.55
#> Slash.2.2     -18438.99
#> Slash.3.2     -18583.26
#> Student-t.2.2 -18066.27
#> Student-t.3.2 -18231.31

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar_grid(~ Bedon + LaPlata | Rainfall, data=riverflows,
                  row.names=Date, subset={Date<="2009-02-13"},dist="Laplace",
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=100,
                  n.sim=200, n.thin=2, plan_strategy="multisession")
DIC(fit2)
#>                  DIC
#> Laplace.2.1 13152.66
#> Laplace.2.2 13106.67
#> Laplace.2.3 13086.03
#> Laplace.3.1 13055.43
#> Laplace.3.2 13017.39
#> Laplace.3.3 13000.62

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar_grid(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                  data=iceland.rf,subset={Date<="1974-11-06"},row.names=Date,
                  dist=c("Slash","Student-t"), nregim.min=1, nregim.max=2,
                  p.min=15, p.max=15, q.min=4, q.max=4, d.min=2, d.max=2,
                  n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
DIC(fit3)
#>                         DIC
#> Slash.1.15.4.2     8244.281
#> Slash.2.15.4.2     7499.060
#> Student-t.1.15.4.2 8373.411
#> Student-t.2.15.4.2 7544.659

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=2, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
DIC(fit4)
#>                      DIC
#> Laplace.2.3.3   14960.85
#> Slash.2.3.3     14884.26
#> Student-t.2.3.3 14816.05
# }

```
