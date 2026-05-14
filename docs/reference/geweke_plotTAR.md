# Geweke-Brooks plot for objects of class `mtar`

This function is a wrapper around `geweke.plot()` that applies the
Geweke-Brooks convergence diagnostic to the MCMC chains obtained from a
fitted `mtar` model.

## Usage

``` r
geweke_plotTAR(
  x,
  frac1 = 0.1,
  frac2 = 0.5,
  nbins = 20,
  pvalue = 0.05,
  auto.layout = TRUE,
  ask,
  ...
)
```

## Arguments

- x:

  An object of class `mtar` returned by a call to
  [`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md).

- frac1:

  fraction to use from beginning of chain

- frac2:

  fraction to use from end of chain

- nbins:

  Number of segments

- pvalue:

  p-value used to plot confidence limits for the null hypothesis

- auto.layout:

  If `TRUE` then, set up own layout for plots, otherwise use existing
  one

- ask:

  If `TRUE` then prompt user before displaying each page of plots.
  Default is
  [`dev.interactive()`](https://rdrr.io/r/grDevices/dev.interactive.html).

- ...:

  Additional graphical parameters passed to the plotting routines.

## See also

[`geweke.plot`](https://rdrr.io/pkg/coda/man/geweke.plot.html)

## Examples

``` r
# \donttest{
###### Example 1: Returns of the closing prices of three financial indexes
data(returns)
fit1 <- mtar(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
             subset={Date<="2015-12-07"}, dist="Student-t",
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=100, n.sim=200,
             n.thin=2)
geweke_plotTAR(fit1)
#> 
#> Thresholds
#> 
#> Autoregressive coefficients Regime 1 
#> 
#> Scale parameter Regime 1 
#> 
#> Autoregressive coefficients Regime 2 
#> 
#> Scale parameter Regime 2 
#> 
#> Autoregressive coefficients Regime 3 
#> 
#> Scale parameter Regime 3 
#> 
#> Extra parameter

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=100, n.sim=200, n.thin=2)
geweke_plotTAR(fit2)
#> 
#> Thresholds
#> 
#> Autoregressive coefficients Regime 1 
#> 
#> Scale parameter Regime 1 
#> 
#> Autoregressive coefficients Regime 2 
#> 
#> Scale parameter Regime 2 
#> 
#> Autoregressive coefficients Regime 3 
#> 
#> Scale parameter Regime 3 

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=100, n.sim=200,
             n.thin=2, dist="Slash")
geweke_plotTAR(fit3)
#> 
#> Thresholds
#> 
#> Autoregressive coefficients Regime 1 
#> 
#> Scale parameter Regime 1 
#> 
#> Autoregressive coefficients Regime 2 
#> 
#> Scale parameter Regime 2 
#> 
#> Extra parameter

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=100,
             n.sim=200, n.thin=2, dist="Student-t")
geweke_plotTAR(fit4)
#> 
#> Thresholds
#> 
#> Autoregressive coefficients Regime 1 
#> 
#> Scale parameter Regime 1 
#> 
#> Autoregressive coefficients Regime 2 
#> 
#> Scale parameter Regime 2 
#> 
#> Extra parameter

# }
```
