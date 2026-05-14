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
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=100, n.sim=200,
             n.thin=2)
effectiveSize_TAR(fit1)
#> Thresholds:
#>                   
#> Threshold.1 9.5592
#> Threshold.2 1.9949
#> 
#> 
#> Autoregressive coefficients:
#>                        Regime 1 Regime 2 Regime 3
#> COLCAP:(Intercept)       200.00   154.80   200.00
#> COLCAP:COLCAP.lag(1)     185.86   200.00   200.00
#> COLCAP:COLCAP.lag(2)                       170.94
#> COLCAP:BOVESPA.lag(1)    200.00   200.00   161.76
#> COLCAP:BOVESPA.lag(2)                      200.00
#> BOVESPA:(Intercept)      200.00   200.00   107.85
#> BOVESPA:COLCAP.lag(1)    141.02   160.67   200.00
#> BOVESPA:COLCAP.lag(2)                      350.08
#> BOVESPA:BOVESPA.lag(1)   200.00   153.57   149.84
#> BOVESPA:BOVESPA.lag(2)                     160.65
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> COLCAP.COLCAP     103.87   106.84   200.00
#> COLCAP.BOVESPA    109.34   200.00   136.30
#> BOVESPA.BOVESPA   105.00   103.23   146.95
#> 
#> 
#> Extra parameter:
#>          
#> nu 25.007

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=100, n.sim=200, n.thin=2)
effectiveSize_TAR(fit2)
#> Thresholds:
#>                   
#> Threshold.1 2.1775
#> Threshold.2 3.7982
#> 
#> 
#> Autoregressive coefficients:
#>                        Regime 1 Regime 2 Regime 3
#> Bedon:(Intercept)       131.632   73.907   69.621
#> Bedon:Bedon.lag(1)       45.747   87.809   65.008
#> Bedon:Bedon.lag(2)      106.363   65.598  104.533
#> Bedon:Bedon.lag(3)       94.695   73.122  112.791
#> Bedon:Bedon.lag(4)       63.189   52.081   90.252
#> Bedon:Bedon.lag(5)      119.323   82.708   85.234
#> Bedon:LaPlata.lag(1)    111.322  152.102   83.797
#> Bedon:LaPlata.lag(2)    122.614   78.559  108.676
#> Bedon:LaPlata.lag(3)     99.508   69.338  100.341
#> Bedon:LaPlata.lag(4)    110.962   95.440   94.710
#> Bedon:LaPlata.lag(5)     78.839   68.139  139.877
#> LaPlata:(Intercept)      86.705   63.164   84.790
#> LaPlata:Bedon.lag(1)     98.147   88.650   83.246
#> LaPlata:Bedon.lag(2)    119.332   80.562  131.717
#> LaPlata:Bedon.lag(3)    140.275  104.014  158.235
#> LaPlata:Bedon.lag(4)    107.452   82.790   87.551
#> LaPlata:Bedon.lag(5)     92.370   83.929  115.420
#> LaPlata:LaPlata.lag(1)   99.631  125.995  170.664
#> LaPlata:LaPlata.lag(2)  109.163   80.270   90.364
#> LaPlata:LaPlata.lag(3)  113.339   92.114  164.834
#> LaPlata:LaPlata.lag(4)  109.337   83.272  108.607
#> LaPlata:LaPlata.lag(5)   81.994   89.997  129.032
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> Bedon.Bedon       200.00   128.52   112.22
#> Bedon.LaPlata     159.83   145.19   136.60
#> LaPlata.LaPlata   116.37   401.35   133.43

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=100, n.sim=200,
             n.thin=2, dist="Slash")
effectiveSize_TAR(fit3)
#> Thresholds:
#>                 
#> threshold 3.9387
#> 
#> 
#> Autoregressive coefficients:
#>                                 Regime 1 Regime 2
#> Jokulsa:(Intercept)               94.367  100.200
#> Jokulsa:Jokulsa.lag( 1)           42.852   55.797
#> Jokulsa:Jokulsa.lag( 2)           64.175   47.173
#> Jokulsa:Jokulsa.lag( 3)           70.163   86.668
#> Jokulsa:Jokulsa.lag( 4)           35.747  104.423
#> Jokulsa:Jokulsa.lag( 5)           31.512  116.652
#> Jokulsa:Jokulsa.lag( 6)           18.939  140.411
#> Jokulsa:Jokulsa.lag( 7)           29.574   78.519
#> Jokulsa:Jokulsa.lag( 8)           32.732  136.205
#> Jokulsa:Jokulsa.lag( 9)           66.745  151.320
#> Jokulsa:Jokulsa.lag(10)          200.000  271.971
#> Jokulsa:Jokulsa.lag(11)          125.836  114.527
#> Jokulsa:Jokulsa.lag(12)          114.003  144.682
#> Jokulsa:Jokulsa.lag(13)           40.341  101.797
#> Jokulsa:Jokulsa.lag(14)           75.769   31.715
#> Jokulsa:Jokulsa.lag(15)           12.489  108.122
#> Jokulsa:Vatnsdalsa.lag( 1)        64.833   73.252
#> Jokulsa:Vatnsdalsa.lag( 2)        57.734   79.233
#> Jokulsa:Vatnsdalsa.lag( 3)        30.584   61.819
#> Jokulsa:Vatnsdalsa.lag( 4)        34.356  177.847
#> Jokulsa:Vatnsdalsa.lag( 5)       110.323   51.043
#> Jokulsa:Vatnsdalsa.lag( 6)        85.861   38.094
#> Jokulsa:Vatnsdalsa.lag( 7)       103.700   66.691
#> Jokulsa:Vatnsdalsa.lag( 8)       131.287   99.230
#> Jokulsa:Vatnsdalsa.lag( 9)       138.581   67.657
#> Jokulsa:Vatnsdalsa.lag(10)       158.157   50.973
#> Jokulsa:Vatnsdalsa.lag(11)       200.000   47.377
#> Jokulsa:Vatnsdalsa.lag(12)       200.000   50.928
#> Jokulsa:Vatnsdalsa.lag(13)       126.050   41.205
#> Jokulsa:Vatnsdalsa.lag(14)       118.813   79.054
#> Jokulsa:Vatnsdalsa.lag(15)       115.744   76.437
#> Jokulsa:Precipitation.lag(1)      95.639  106.574
#> Jokulsa:Precipitation.lag(2)     200.000   86.488
#> Jokulsa:Precipitation.lag(3)     156.916  158.826
#> Jokulsa:Precipitation.lag(4)      64.847   97.556
#> Jokulsa:Temperature.lag(1)       330.231   80.202
#> Jokulsa:Temperature.lag(2)       345.012   63.792
#> Vatnsdalsa:(Intercept)           111.818   86.962
#> Vatnsdalsa:Jokulsa.lag( 1)        86.702  145.821
#> Vatnsdalsa:Jokulsa.lag( 2)        38.782  153.123
#> Vatnsdalsa:Jokulsa.lag( 3)       108.596  146.713
#> Vatnsdalsa:Jokulsa.lag( 4)        94.824  149.421
#> Vatnsdalsa:Jokulsa.lag( 5)       100.900  103.723
#> Vatnsdalsa:Jokulsa.lag( 6)        69.261  217.992
#> Vatnsdalsa:Jokulsa.lag( 7)        22.207  113.211
#> Vatnsdalsa:Jokulsa.lag( 8)        61.685  131.621
#> Vatnsdalsa:Jokulsa.lag( 9)       125.051  116.786
#> Vatnsdalsa:Jokulsa.lag(10)        84.424  107.136
#> Vatnsdalsa:Jokulsa.lag(11)        91.298  130.204
#> Vatnsdalsa:Jokulsa.lag(12)       124.199  112.888
#> Vatnsdalsa:Jokulsa.lag(13)       105.712  103.219
#> Vatnsdalsa:Jokulsa.lag(14)        91.513  153.882
#> Vatnsdalsa:Jokulsa.lag(15)        84.091  101.509
#> Vatnsdalsa:Vatnsdalsa.lag( 1)     33.952   71.378
#> Vatnsdalsa:Vatnsdalsa.lag( 2)     56.436   42.485
#> Vatnsdalsa:Vatnsdalsa.lag( 3)     25.085   77.184
#> Vatnsdalsa:Vatnsdalsa.lag( 4)     29.254   78.553
#> Vatnsdalsa:Vatnsdalsa.lag( 5)     56.815   63.082
#> Vatnsdalsa:Vatnsdalsa.lag( 6)    125.360   42.795
#> Vatnsdalsa:Vatnsdalsa.lag( 7)    144.527   40.652
#> Vatnsdalsa:Vatnsdalsa.lag( 8)    200.000   44.292
#> Vatnsdalsa:Vatnsdalsa.lag( 9)    200.000   36.999
#> Vatnsdalsa:Vatnsdalsa.lag(10)    143.497   80.069
#> Vatnsdalsa:Vatnsdalsa.lag(11)    117.949   50.662
#> Vatnsdalsa:Vatnsdalsa.lag(12)    200.000   80.479
#> Vatnsdalsa:Vatnsdalsa.lag(13)    115.912   99.480
#> Vatnsdalsa:Vatnsdalsa.lag(14)    142.429   81.439
#> Vatnsdalsa:Vatnsdalsa.lag(15)    148.675   42.019
#> Vatnsdalsa:Precipitation.lag(1)  134.070  107.325
#> Vatnsdalsa:Precipitation.lag(2)  121.245   65.452
#> Vatnsdalsa:Precipitation.lag(3)  134.597  100.484
#> Vatnsdalsa:Precipitation.lag(4)   74.413  154.051
#> Vatnsdalsa:Temperature.lag(1)    125.790   93.908
#> Vatnsdalsa:Temperature.lag(2)     94.328   92.488
#> 
#> 
#> Scale parameter:
#>                       Regime 1 Regime 2
#> Jokulsa.Jokulsa         15.925   20.378
#> Jokulsa.Vatnsdalsa      41.806   58.128
#> Vatnsdalsa.Vatnsdalsa   35.704   21.968
#> 
#> 
#> Extra parameter:
#>          
#> nu 41.925

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=100,
             n.sim=200, n.thin=2, dist="Student-t")
effectiveSize_TAR(fit4)
#> Thresholds:
#>                 
#> threshold 3.4869
#> 
#> 
#> Autoregressive coefficients:
#>                 Regime 1 Regime 2
#> CCR:(Intercept)   137.98  134.743
#> CCR:CCR.lag(1)    133.20  108.034
#> CCR:CCR.lag(2)    137.42  141.327
#> CCR:CCR.lag(3)    161.31   89.226
#> CCR:dVIX.lag(1)   125.78  200.000
#> CCR:dVIX.lag(2)   200.00  107.326
#> CCR:dVIX.lag(3)   196.72   85.211
#> 
#> 
#> Scale parameter:
#>         Regime 1 Regime 2
#> CCR.CCR   63.198   105.26
#> 
#> 
#> Extra parameter:
#>          
#> nu 33.028

# }

```
