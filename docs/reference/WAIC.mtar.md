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
#> Gaussian.2.2  -17884.80
#> Gaussian.3.2  -18149.18
#> Laplace.2.2   -17944.52
#> Laplace.3.2   -18108.07
#> Slash.2.2     -17969.89
#> Slash.3.2     -18179.62
#> Student-t.2.2 -18042.16
#> Student-t.3.2 -18172.22

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar_grid(~ Bedon + LaPlata | Rainfall, data=riverflows,
                  row.names=Date, subset={Date<="2009-02-13"},dist="Laplace",
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=100,
                  n.sim=200, n.thin=2, plan_strategy="multisession")
WAIC(fit2)
#>                 WAIC
#> Laplace.2.1 13141.89
#> Laplace.2.2 13126.26
#> Laplace.2.3 13125.28
#> Laplace.3.1 13072.26
#> Laplace.3.2 13040.98
#> Laplace.3.3 13029.10

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
#> Slash.1.15.4.2     8306.202
#> Slash.2.15.4.2     7705.871
#> Student-t.1.15.4.2 8418.387
#> Student-t.2.15.4.2 7646.897

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=2, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
WAIC(fit4)
#>                     WAIC
#> Laplace.2.3.3   14970.87
#> Slash.2.3.3     15022.87
#> Student-t.2.3.3 14947.97
# }

```
