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
                  p.max=2, n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
oos1 <- out_of_sample(fit1, newdata=subset(returns, Date>"2015-12-07"),
                      n.ahead=75, by.component=TRUE, FUN=median)
oos1
#>               Log.Score Energy.Score   COLCAP.AE  BOVESPA.AE COLCAP.APE
#> Gaussian.2.2  -6.226875   0.01552030 0.007717920 0.011131626   95.90766
#> Gaussian.3.2  -6.124864   0.01565017 0.006793891 0.010978636   98.10533
#> Laplace.2.2   -5.670169   0.01408780 0.006813352 0.010089918   90.25704
#> Laplace.3.2   -5.747092   0.01527967 0.007625978 0.009593400   94.85478
#> Slash.2.2     -6.053171   0.01542919 0.007764275 0.010639389   96.20311
#> Slash.3.2     -5.887472   0.01679612 0.007254826 0.010438511  104.37108
#> Student-t.2.2 -6.112132   0.01379612 0.007658257 0.009201493   90.97048
#> Student-t.3.2 -5.877000   0.01725542 0.007909789 0.009948189  102.41066
#>               BOVESPA.APE    COLCAP.SE   BOVESPA.SE COLCAP.Width BOVESPA.Width
#> Gaussian.2.2     94.27892 5.956629e-05 1.239131e-04   0.03390673    0.05032335
#> Gaussian.3.2     99.00561 4.615695e-05 1.205305e-04   0.03189945    0.04474107
#> Laplace.2.2      88.19335 4.642176e-05 1.018064e-04   0.03906628    0.05941255
#> Laplace.3.2      97.23826 5.815554e-05 9.203332e-05   0.03959374    0.05973224
#> Slash.2.2        91.21977 6.028397e-05 1.131966e-04   0.03361082    0.05186170
#> Slash.3.2       101.60222 5.263251e-05 1.089625e-04   0.03609082    0.05429425
#> Student-t.2.2    81.36168 5.864889e-05 8.466748e-05   0.03439811    0.05206089
#> Student-t.3.2   102.43311 6.256476e-05 9.896646e-05   0.03388750    0.04911387
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
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=1000,
                  n.sim=2000, n.thin=2, plan_strategy="multisession")
oos2 <- out_of_sample(fit2, newdata=subset(riverflows, Date>"2009-02-13"),
                      n.ahead=60, by.component=TRUE, FUN=median)
oos2
#>             Log.Score Energy.Score Bedon.AE LaPlata.AE Bedon.APE LaPlata.APE
#> Laplace.2.1  5.633622     7.710874 1.450859   3.449946  12.47431    14.26003
#> Laplace.2.2  5.592871     7.649081 1.242123   3.550583  10.97523    14.40979
#> Laplace.2.3  5.555361     7.435875 1.199638   3.459720  10.40259    14.22665
#> Laplace.3.1  5.746048     7.030784 1.642038   3.766321  16.07384    13.34697
#> Laplace.3.2  5.645763     7.128450 1.701558   3.621757  14.41214    13.22718
#> Laplace.3.3  5.659976     7.073041 1.643882   3.806657  13.96166    13.01085
#>             Bedon.SE LaPlata.SE Bedon.Width LaPlata.Width Bedon.CoverageRate
#> Laplace.2.1 2.108264   11.92247    18.82942      47.44300                  1
#> Laplace.2.2 1.545447   12.61963    17.98258      48.12098                  1
#> Laplace.2.3 1.440061   11.99074    17.18891      42.43325                  1
#> Laplace.3.1 2.698471   14.34173    17.82424      43.65371                  1
#> Laplace.3.2 2.898278   13.12047    17.05300      43.64200                  1
#> Laplace.3.3 2.708530   14.50621    16.78339      41.50737                  1
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
                  n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
oos3 <- out_of_sample(fit3, newdata=subset(iceland.rf, Date>"1974-11-06"),
                      n.ahead=55, by.component=TRUE, FUN=median)
oos3
#>                    Log.Score Energy.Score  Jokulsa.AE Vatnsdalsa.AE Jokulsa.APE
#> Slash.1.15.4.2      6.913333   405.123201 115.2853697     20.800799  440.020495
#> Slash.2.15.4.2      4.713869    54.527569  22.7377770     14.921332   90.271244
#> Student-t.1.15.4.2  5.198673     7.904724   0.8361602      1.087715    3.318096
#> Student-t.2.15.4.2  3.287238     2.085219   0.7173509      1.090049    2.656114
#>                    Vatnsdalsa.APE   Jokulsa.SE Vatnsdalsa.SE Jokulsa.Width
#> Slash.1.15.4.2          381.48446 1.329072e+04    432.673221   2207.565416
#> Slash.2.15.4.2          289.17311 5.170065e+02    222.646160    210.026813
#> Student-t.1.15.4.2       21.07975 6.991639e-01      1.183125     64.045443
#> Student-t.2.15.4.2       21.55404 5.145924e-01      1.188206      9.493279
#>                    Vatnsdalsa.Width Jokulsa.CoverageRate
#> Slash.1.15.4.2           441.307441                    1
#> Slash.2.15.4.2           247.401813                    1
#> Student-t.1.15.4.2        12.031766                    1
#> Student-t.2.15.4.2         8.728821                    1
#>                    Vatnsdalsa.CoverageRate
#> Slash.1.15.4.2                           1
#> Slash.2.15.4.2                           1
#> Student-t.1.15.4.2                       1
#> Student-t.2.15.4.2                       1

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=1, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
#> Error in getGlobalsAndPackages(expr, envir = envir, globals = globals): The total size of the 7 globals exported for future expression (‘FUN()’) is 984.49 MiB. This exceeds the maximum allowed size 500.00 MiB per plan() argument 'maxSizeOfObjects'. This limit is set to protect against transfering too large objects to parallel workers by mistake, which may not be intended and could be costly. See help("future.globals.maxSize", package = "future") for how to adjust or remove the default threshold via an R option The three largest globals are ‘FUN’ (984.25 MiB of class ‘function’), ‘mycall’ (240.07 KiB of class ‘call’) and ‘grid’ (895 bytes of class ‘list’)
oos4 <- out_of_sample(fit4, newdata=subset(US.returns, Date>"2025-11-28"),
                      n.ahead=100, by.component=TRUE, FUN=median)
#> Error: object 'fit4' not found
oos4
#> Error: object 'oos4' not found
# }

```
