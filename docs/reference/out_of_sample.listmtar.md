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
  FUN = mean,
  rolling = NULL,
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

- FUN:

  An optional function used to summarize the `n.ahead` values computed
  for each predictive accuracy measure. By default, `FUN` is set to
  `mean`.

- rolling:

  An optional positive integer specifying the rolling-window size used
  for forecasting. By default, `rolling = NULL`, indicating that
  rolling-window forecasting is not performed.

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
                      n.ahead=75, FUN=median)
oos1
#>               Log.Score Energy.Score   COLCAP.AE  BOVESPA.AE COLCAP.APE
#> Gaussian.2.2  -6.130904   0.01496001 0.007919267 0.010505789   97.80278
#> Gaussian.3.2  -6.074644   0.01556491 0.007192457 0.010703096   98.52329
#> Laplace.2.2   -5.878923   0.01444653 0.007764034 0.010482989   92.83335
#> Laplace.3.2   -5.634518   0.01570581 0.007168346 0.008288826   92.92772
#> Slash.2.2     -6.069461   0.01510325 0.007964202 0.010521440   95.31498
#> Slash.3.2     -5.903969   0.01530790 0.007443842 0.010730346  100.99083
#> Student-t.2.2 -6.112259   0.01413215 0.007299921 0.008806815   91.91274
#> Student-t.3.2 -5.949522   0.01552589 0.006565879 0.009718477   96.94343
#>               BOVESPA.APE    COLCAP.SE   BOVESPA.SE COLCAP.Width BOVESPA.Width
#> Gaussian.2.2     88.97881 6.271478e-05 1.103716e-04   0.03375326    0.04977947
#> Gaussian.3.2     99.56912 5.173144e-05 1.145563e-04   0.03185595    0.04477661
#> Laplace.2.2      86.32928 6.028022e-05 1.098931e-04   0.03808041    0.05841364
#> Laplace.3.2     100.07927 5.138519e-05 6.870464e-05   0.03855147    0.06100154
#> Slash.2.2        91.02511 6.342851e-05 1.107007e-04   0.03367588    0.05144276
#> Slash.3.2        99.27615 5.541079e-05 1.151403e-04   0.03414189    0.05208692
#> Student-t.2.2    81.32959 5.328884e-05 7.756000e-05   0.03448157    0.05213710
#> Student-t.3.2    91.57282 4.311076e-05 9.444879e-05   0.03495580    0.05120236
#>               COLCAP.CR BOVESPA.CR
#> Gaussian.2.2          1          1
#> Gaussian.3.2          1          1
#> Laplace.2.2           1          1
#> Laplace.3.2           1          1
#> Slash.2.2             1          1
#> Slash.3.2             1          1
#> Student-t.2.2         1          1
#> Student-t.3.2         1          1

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar_grid(~ Bedon + LaPlata | Rainfall, data=riverflows,
                  row.names=Date, subset={Date<="2009-02-13"},dist="Laplace",
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=1000,
                  n.sim=2000, n.thin=2, plan_strategy="multisession")
oos2 <- out_of_sample(fit2, newdata=subset(riverflows, Date>"2009-02-13"),
                      n.ahead=60, FUN=median)
oos2
#>             Log.Score Energy.Score Bedon.AE LaPlata.AE Bedon.APE LaPlata.APE
#> Laplace.2.1  5.608438     7.739133 1.385735   3.504505  12.04234    14.59884
#> Laplace.2.2  5.571232     7.564504 1.149434   3.515063  11.78286    13.52207
#> Laplace.2.3  5.521728     7.349536 1.226071   3.736939  11.13603    14.78138
#> Laplace.3.1  5.775721     7.062338 1.672790   3.778881  15.59865    13.87415
#> Laplace.3.2  5.736751     7.039516 1.625449   3.742622  15.01475    12.27413
#> Laplace.3.3  5.677089     6.876153 1.590267   3.687293  13.94798    13.89481
#>             Bedon.SE LaPlata.SE Bedon.Width LaPlata.Width Bedon.CR LaPlata.CR
#> Laplace.2.1 1.920465   12.31697    18.96394      47.00470        1          1
#> Laplace.2.2 1.321237   12.36404    17.81186      46.39140        1          1
#> Laplace.2.3 1.503563   14.03610    17.21209      43.54787        1          1
#> Laplace.3.1 2.799055   14.40297    17.54845      41.77266        1          1
#> Laplace.3.2 2.642367   14.03502    17.23354      43.22075        1          1
#> Laplace.3.3 2.529923   13.59662    16.65226      41.32513        1          1

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar_grid(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                  data=iceland.rf,subset={Date<="1974-11-06"},row.names=Date,
                  dist=c("Slash","Student-t"), nregim.min=1, nregim.max=2,
                  p.min=15, p.max=15, q.min=4, q.max=4, d.min=2, d.max=2,
                  n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
oos3 <- out_of_sample(fit3, newdata=subset(iceland.rf, Date>"1974-11-06"),
                      n.ahead=55, FUN=median)
oos3
#>                    Log.Score Energy.Score  Jokulsa.AE Vatnsdalsa.AE Jokulsa.APE
#> Slash.1.15.4.2      6.785082   496.798458 288.2535467    61.9712917 1143.863281
#> Slash.2.15.4.2      4.656451    74.266954  34.9573021    18.9198753  130.926225
#> Student-t.1.15.4.2  5.211732     7.914245   0.8534684     0.9519004    3.367734
#> Student-t.2.15.4.2  3.269521     2.047613   0.7079423     1.0549056    2.651469
#>                    Vatnsdalsa.APE   Jokulsa.SE Vatnsdalsa.SE Jokulsa.Width
#> Slash.1.15.4.2         1244.71393 8.309011e+04  3840.4410011    1755.93727
#> Slash.2.15.4.2          397.21835 1.222013e+03   357.9616806     240.61380
#> Student-t.1.15.4.2       18.44768 7.284084e-01     0.9061143      64.95589
#> Student-t.2.15.4.2       20.18537 5.011823e-01     1.1128257       9.51069
#>                    Vatnsdalsa.Width Jokulsa.CR Vatnsdalsa.CR
#> Slash.1.15.4.2           394.356786          1             1
#> Slash.2.15.4.2           285.418884          1             1
#> Student-t.1.15.4.2        11.916161          1             1
#> Student-t.2.15.4.2         8.392408          1             1

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=2, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=1000, n.sim=2000, n.thin=2,
                  plan_strategy="multisession")
oos4 <- out_of_sample(fit4, newdata=subset(US.returns, Date>"2025-11-28"),
                      n.ahead=100, FUN=median)
oos4
#>                 Log.Score Energy.Score    CCR.AE  CCR.APE    CCR.SE CCR.Width
#> Laplace.2.3.3   1.1091060    0.6201486 0.5045414 101.9969 0.2548327  4.224899
#> Slash.2.3.3     0.9749196    0.6376509 0.5188161 103.3436 0.2694498  4.333001
#> Student-t.2.3.3 1.0024922    0.6292736 0.5360405 100.1831 0.2873423  4.306529
#>                 CCR.CR
#> Laplace.2.3.3        1
#> Slash.2.3.3          1
#> Student-t.2.3.3      1
# }

```
