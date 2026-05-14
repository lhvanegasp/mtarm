# Computing Out-of-Sample predictive accuracy measures

Computes Out-of-Sample predictive accuracy measures for an object of
class `listmtar`.

## Usage

``` r
# S3 method for class 'listmtar'
out_of_sample(
  x,
  newdata,
  n.ahead = NULL,
  credible = 0.95,
  by.component = FALSE,
  FUN = mean,
  ...
)
```

## Arguments

- x:

  An object of class `listmtar` returned by the routine
  [`mtar_grid()`](https://lhvanegasp.github.io/mtarm/reference/mtar_grid.md).

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

- ...:

  optional arguments to FUN.

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
oos1 <- out_of_sample(fit1, newdata=subset(returns, Date>"2015-12-07"),
                      n.ahead=75, by.component=TRUE, FUN=median)
oos1
#>               Log.Score Energy.Score   COLCAP.AE  BOVESPA.AE COLCAP.APE
#> Gaussian.2.2  -6.147162   0.01485287 0.007778722 0.011063987   98.43464
#> Gaussian.3.2  -6.104088   0.01584963 0.006442467 0.009906040   99.43435
#> Laplace.2.2   -5.672093   0.01437056 0.007483142 0.009909471   89.66106
#> Laplace.3.2   -5.673805   0.01592874 0.007693708 0.007553702   93.54082
#> Slash.2.2     -6.221693   0.01384485 0.007423758 0.008915786   94.48742
#> Slash.3.2     -5.854266   0.01544330 0.007618164 0.008857125   96.37134
#> Student-t.2.2 -5.915787   0.01401025 0.007746516 0.010010657   94.63552
#> Student-t.3.2 -5.925805   0.01578688 0.008001252 0.010176804   96.80771
#>               BOVESPA.APE    COLCAP.SE   BOVESPA.SE COLCAP.Width BOVESPA.Width
#> Gaussian.2.2     91.62344 6.050851e-05 1.224118e-04   0.03307717    0.04881115
#> Gaussian.3.2     96.08782 4.150538e-05 9.812962e-05   0.03346090    0.04679821
#> Laplace.2.2      88.42978 5.599741e-05 9.819762e-05   0.03721819    0.05546690
#> Laplace.3.2      95.81994 5.919314e-05 5.705842e-05   0.03684655    0.05460677
#> Slash.2.2        85.53473 5.511218e-05 7.949124e-05   0.03326528    0.04889091
#> Slash.3.2        99.64373 5.803642e-05 7.844867e-05   0.03409559    0.05059663
#> Student-t.2.2    91.45294 6.000852e-05 1.002133e-04   0.03436868    0.04998156
#> Student-t.3.2    92.17506 6.402003e-05 1.035673e-04   0.03384386    0.05050587
#>               COLCAP.CoverageRate BOVESPA.CoverageRate
#> Gaussian.2.2                    1                    1
#> Gaussian.3.2                    1                    1
#> Laplace.2.2                     1                    1
#> Laplace.3.2                     1                    1
#> Slash.2.2                       1                    1
#> Slash.3.2                       1                    1
#> Student-t.2.2                   1                    1
#> Student-t.3.2                   1                    1

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar_grid(~ Bedon + LaPlata | Rainfall, data=riverflows,
                  row.names=Date, subset={Date<="2009-02-13"},dist="Laplace",
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=100,
                  n.sim=200, n.thin=2, plan_strategy="multisession")
oos2 <- out_of_sample(fit2, newdata=subset(riverflows, Date>"2009-02-13"),
                      n.ahead=60, by.component=TRUE, FUN=median)
oos2
#>             Log.Score Energy.Score Bedon.AE LaPlata.AE Bedon.APE LaPlata.APE
#> Laplace.2.1  5.586156     8.269101 1.491097   4.294235  13.08905    18.00154
#> Laplace.2.2  5.557013     7.850411 1.384967   3.765655  12.53073    16.49586
#> Laplace.2.3  5.600261     7.804707 1.345269   3.991300  11.89803    15.15582
#> Laplace.3.1  5.853372     7.289419 1.618987   3.760760  14.89064    13.42962
#> Laplace.3.2  5.792617     7.060740 1.728733   2.932512  15.33313    11.96654
#> Laplace.3.3  5.655782     7.128009 1.575800   4.439495  12.44571    13.23801
#>             Bedon.SE LaPlata.SE Bedon.Width LaPlata.Width Bedon.CoverageRate
#> Laplace.2.1 2.223432  18.505644    18.76921      45.75370                  1
#> Laplace.2.2 1.919104  14.181499    17.13280      47.25529                  1
#> Laplace.2.3 1.833734  15.935820    17.47320      45.05477                  1
#> Laplace.3.1 2.621146  14.165929    18.34683      41.25504                  1
#> Laplace.3.2 2.992894   8.599803    16.96140      42.21611                  1
#> Laplace.3.3 2.483151  19.749372    15.78817      38.72469                  1
#>             LaPlata.CoverageRate
#> Laplace.2.1                    1
#> Laplace.2.2                    1
#> Laplace.2.3                    1
#> Laplace.3.1                    1
#> Laplace.3.2                    1
#> Laplace.3.3                    1

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar_grid(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                  data=iceland.rf,subset={Date<="1974-11-06"},row.names=Date,
                  dist=c("Slash","Student-t"), nregim.min=1, nregim.max=2,
                  p.min=15, p.max=15, q.min=4, q.max=4, d.min=2, d.max=2,
                  n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
oos3 <- out_of_sample(fit3, newdata=subset(iceland.rf, Date>"1974-11-06"),
                      n.ahead=55, by.component=TRUE, FUN=median)
oos3
#>                    Log.Score Energy.Score Jokulsa.AE Vatnsdalsa.AE Jokulsa.APE
#> Slash.1.15.4.2      6.714648   255.236999 72.8948268     37.468252  289.265186
#> Slash.2.15.4.2      4.808630    37.251403 14.0707889     10.472950   53.451786
#> Student-t.1.15.4.2  5.123070     7.735019  1.0534973      1.133250    4.240350
#> Student-t.2.15.4.2  3.341546     2.072854  0.8765421      1.131395    3.281541
#>                    Vatnsdalsa.APE   Jokulsa.SE Vatnsdalsa.SE Jokulsa.Width
#> Slash.1.15.4.2          765.36115 5313.6557708   1403.869899   2805.607854
#> Slash.2.15.4.2          202.96416  197.9871005    109.682691    188.143183
#> Student-t.1.15.4.2       21.96222    1.1098565      1.284257     59.216128
#> Student-t.2.15.4.2       21.82269    0.7683261      1.280055      9.344743
#>                    Vatnsdalsa.Width Jokulsa.CoverageRate
#> Slash.1.15.4.2           330.760110                    1
#> Slash.2.15.4.2           181.387409                    1
#> Student-t.1.15.4.2        11.280355                    1
#> Student-t.2.15.4.2         7.687474                    1
#>                    Vatnsdalsa.CoverageRate
#> Slash.1.15.4.2                           1
#> Slash.2.15.4.2                           1
#> Student-t.1.15.4.2                       1
#> Student-t.2.15.4.2                       1

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=2, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
#> Error in getGlobalsAndPackages(expr, envir = envir, globals = globals): The total size of the 7 globals exported for future expression (‘FUN()’) is 642.47 MiB. This exceeds the maximum allowed size 500.00 MiB per plan() argument 'maxSizeOfObjects'. This limit is set to protect against transfering too large objects to parallel workers by mistake, which may not be intended and could be costly. See help("future.globals.maxSize", package = "future") for how to adjust or remove the default threshold via an R option The three largest globals are ‘FUN’ (642.24 MiB of class ‘function’), ‘mycall’ (240.07 KiB of class ‘call’) and ‘grid’ (767 bytes of class ‘list’)
oos4 <- out_of_sample(fit4, newdata=subset(US.returns, Date>"2025-11-28"),
                      n.ahead=100, by.component=TRUE, FUN=median)
#> Error: object 'fit4' not found
oos4
#> Error: object 'oos4' not found
# }

```
