# Effective sample size for `mtar` objects

This function computes the effective sample size, adjusted for
autocorrelation, of Markov chain Monte Carlo (MCMC) output obtained from
the Bayesian estimation of multivariate TAR models. It serves as a
wrapper around `effectiveSize()`, applying this function to the
posterior chains returned by
[`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md).

## Usage

``` r
effectiveSize_TAR(x)
```

## Arguments

- x:

  An object of class `mtar` produced by
  [`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md).

## Value

A list with the effective sample sizes for each parameter of the `mtar`
model.

## See also

[`effectiveSize`](https://rdrr.io/pkg/coda/man/effectiveSize.html)

## Examples

``` r
# \donttest{
###### Example 1: Returns of the closing prices of three financial indexes
data(returns)
fit1 <- mtar(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
             subset={Date<="2015-12-07"}, dist="Student-t",
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=1000, n.sim=2000,
             n.thin=2)
effectiveSize_TAR(fit1)
#> Error in effectiveSize(x2$thresholds): could not find function "effectiveSize"

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=1000, n.sim=2000, n.thin=2)
effectiveSize_TAR(fit2)
#> Error in effectiveSize(x2$thresholds): could not find function "effectiveSize"

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=1000, n.sim=2000,
             n.thin=2, dist="Slash")
effectiveSize_TAR(fit3)
#> Error in effectiveSize(x2$thresholds): could not find function "effectiveSize"

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=1000,
             n.sim=2000, n.thin=2, dist="Student-t")
effectiveSize_TAR(fit4)
#> Error in effectiveSize(x2$thresholds): could not find function "effectiveSize"

# }

```
