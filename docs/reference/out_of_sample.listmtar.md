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
#> Gaussian.2.2  -6.144724   0.01500257 0.007099054 0.010977199   96.07562
#> Gaussian.3.2  -6.057795   0.01586821 0.007174719 0.010421627  100.75109
#> Laplace.2.2   -5.687330   0.01403703 0.007263663 0.009850417   92.66917
#> Laplace.3.2   -5.637864   0.01698696 0.007202498 0.007539652   89.80717
#> Slash.2.2     -6.038833   0.01524134 0.007792288 0.009588171   95.50496
#> Slash.3.2     -5.880469   0.01669986 0.007373231 0.009580830   93.76963
#> Student-t.2.2 -6.091524   0.01367888 0.007593864 0.008250313   91.98190
#> Student-t.3.2 -5.866601   0.01566589 0.007976754 0.007967491   93.20596
#>               BOVESPA.APE    COLCAP.SE   BOVESPA.SE COLCAP.Width BOVESPA.Width
#> Gaussian.2.2     89.25378 5.039656e-05 1.204989e-04   0.03328825    0.04839611
#> Gaussian.3.2     98.27430 5.147660e-05 1.086103e-04   0.03459825    0.04852131
#> Laplace.2.2      88.10522 5.276080e-05 9.703072e-05   0.03805928    0.05535933
#> Laplace.3.2      90.89060 5.187598e-05 5.684636e-05   0.03677038    0.05363171
#> Slash.2.2        90.69596 6.071975e-05 9.193302e-05   0.03245197    0.05038909
#> Slash.3.2        99.47798 5.436453e-05 9.179230e-05   0.03445020    0.05062111
#> Student-t.2.2    83.06730 5.766677e-05 6.806766e-05   0.03384250    0.04970844
#> Student-t.3.2    99.46147 6.362860e-05 6.348091e-05   0.03426644    0.05146244
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
#> Laplace.2.1  5.636534     7.790953 1.541297   3.695852  13.78920    14.76937
#> Laplace.2.2  5.555660     7.976212 1.422329   3.811800  12.61733    15.51428
#> Laplace.2.3  5.550029     7.370440 1.328475   3.771786  11.39065    15.66264
#> Laplace.3.1  5.839746     7.242761 1.629533   4.113777  15.36016    13.81733
#> Laplace.3.2  5.687286     7.127679 1.631979   3.225435  14.67574    12.63648
#> Laplace.3.3  5.618677     6.793661 1.596158   3.748288  13.73050    12.58661
#>             Bedon.SE LaPlata.SE Bedon.Width LaPlata.Width Bedon.CoverageRate
#> Laplace.2.1 2.378089   13.68220    17.32064      44.63692                  1
#> Laplace.2.2 2.026536   14.53442    18.90253      51.54226                  1
#> Laplace.2.3 1.764871   14.28082    16.29107      43.12204                  1
#> Laplace.3.1 2.655459   16.93987    17.31454      39.39744                  1
#> Laplace.3.2 2.663523   10.40468    16.37719      40.04661                  1
#> Laplace.3.3 2.548405   14.05141    15.50693      38.67365                  1
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
#>                    Log.Score Energy.Score  Jokulsa.AE Vatnsdalsa.AE Jokulsa.APE
#> Slash.1.15.4.2      6.796742   821.400430 602.7580114   879.0364044 2450.235819
#> Slash.2.15.4.2      4.710491    29.174435   7.7443467    11.9587534   31.481084
#> Student-t.1.15.4.2  5.134296     7.278743   0.5953246     0.9862852    2.316438
#> Student-t.2.15.4.2  3.298918     2.097893   0.8306326     1.1998839    3.271454
#>                    Vatnsdalsa.APE   Jokulsa.SE Vatnsdalsa.SE Jokulsa.Width
#> Slash.1.15.4.2        17035.58923 3.633172e+05  7.727050e+05   2758.054047
#> Slash.2.15.4.2          231.75879 5.997491e+01  1.430118e+02    187.435548
#> Student-t.1.15.4.2       18.74762 3.544114e-01  9.727585e-01     54.913110
#> Student-t.2.15.4.2       23.25356 6.899505e-01  1.439721e+00      9.516353
#>                    Vatnsdalsa.Width Jokulsa.CoverageRate
#> Slash.1.15.4.2           571.044467                    1
#> Slash.2.15.4.2           187.107918                    1
#> Student-t.1.15.4.2        11.092956                    1
#> Student-t.2.15.4.2         8.119159                    1
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
oos4 <- out_of_sample(fit4, newdata=subset(US.returns, Date>"2025-11-28"),
                      n.ahead=100, by.component=TRUE, FUN=median)
oos4
#>                 Log.Score Energy.Score    CCR.AE  CCR.APE    CCR.SE CCR.Width
#> Laplace.2.3.3   1.1051268    0.6430635 0.5076177 100.6576 0.2576781  4.036863
#> Slash.2.3.3     0.9685931    0.6381611 0.4909076 100.2932 0.2409913  4.193680
#> Student-t.2.3.3 1.0131798    0.6080117 0.5037952 100.8075 0.2538387  3.986395
#>                 CCR.CoverageRate
#> Laplace.2.3.3                  1
#> Slash.2.3.3                    1
#> Student-t.2.3.3                1
# }

```
