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
#> Threshold.1 2.4214
#> Threshold.2 1.1597
#> 
#> 
#> Autoregressive coefficients:
#>                        Regime 1 Regime 2 Regime 3
#> COLCAP:(Intercept)       11.656   7.4179   2.2602
#> COLCAP:COLCAP.lag(1)    162.378  16.1602  36.5935
#> COLCAP:COLCAP.lag(2)                     200.0000
#> COLCAP:BOVESPA.lag(1)   154.235 200.0000  74.2236
#> COLCAP:BOVESPA.lag(2)                    200.0000
#> BOVESPA:(Intercept)      21.823  12.0798   1.6371
#> BOVESPA:COLCAP.lag(1)   200.000  46.1487  88.2264
#> BOVESPA:COLCAP.lag(2)                    147.4864
#> BOVESPA:BOVESPA.lag(1)  200.000  65.9495  39.2059
#> BOVESPA:BOVESPA.lag(2)                    24.4224
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> COLCAP.COLCAP    110.162   9.0389   96.293
#> COLCAP.BOVESPA   150.729  15.0427  200.000
#> BOVESPA.BOVESPA   50.612  15.4202   47.325
#> 
#> 
#> Extra parameter:
#>          
#> nu 22.326

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=100, n.sim=200, n.thin=2)
effectiveSize_TAR(fit2)
#> Thresholds:
#>                    
#> Threshold.1  1.8662
#> Threshold.2 33.7245
#> 
#> 
#> Autoregressive coefficients:
#>                        Regime 1 Regime 2 Regime 3
#> Bedon:(Intercept)       126.430  124.755   82.514
#> Bedon:Bedon.lag(1)       78.055  106.911   74.776
#> Bedon:Bedon.lag(2)      100.921   80.493   83.908
#> Bedon:Bedon.lag(3)       92.497   73.183   89.587
#> Bedon:Bedon.lag(4)      103.667   73.872  101.770
#> Bedon:Bedon.lag(5)       65.919   92.616  123.722
#> Bedon:LaPlata.lag(1)    108.492  119.532  113.718
#> Bedon:LaPlata.lag(2)    113.016   67.160  136.651
#> Bedon:LaPlata.lag(3)     78.653   75.886  123.799
#> Bedon:LaPlata.lag(4)    136.038   81.702   97.235
#> Bedon:LaPlata.lag(5)    116.760  100.040   83.779
#> LaPlata:(Intercept)      83.907  106.602   77.122
#> LaPlata:Bedon.lag(1)    134.861   93.099  103.715
#> LaPlata:Bedon.lag(2)     92.990  115.051  127.126
#> LaPlata:Bedon.lag(3)     97.143   84.841  498.472
#> LaPlata:Bedon.lag(4)     89.707   90.693  171.373
#> LaPlata:Bedon.lag(5)     73.659   99.569   98.556
#> LaPlata:LaPlata.lag(1)   99.662   96.481  105.455
#> LaPlata:LaPlata.lag(2)   75.645  116.419  200.000
#> LaPlata:LaPlata.lag(3)  100.883   79.307  109.032
#> LaPlata:LaPlata.lag(4)   78.794   85.061  102.308
#> LaPlata:LaPlata.lag(5)   68.638   90.623   89.520
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> Bedon.Bedon       105.74   97.772   135.45
#> Bedon.LaPlata     108.15  554.594   155.09
#> LaPlata.LaPlata   129.08  107.707   126.68

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=100, n.sim=200,
             n.thin=2, dist="Slash")
effectiveSize_TAR(fit3)
#> Thresholds:
#>                 
#> threshold 7.2894
#> 
#> 
#> Autoregressive coefficients:
#>                                 Regime 1 Regime 2
#> Jokulsa:(Intercept)               56.938  112.549
#> Jokulsa:Jokulsa.lag( 1)           57.528   60.095
#> Jokulsa:Jokulsa.lag( 2)          100.456   73.768
#> Jokulsa:Jokulsa.lag( 3)           68.462   93.074
#> Jokulsa:Jokulsa.lag( 4)           66.175   98.564
#> Jokulsa:Jokulsa.lag( 5)           66.514   91.210
#> Jokulsa:Jokulsa.lag( 6)           79.013  109.946
#> Jokulsa:Jokulsa.lag( 7)           88.201  146.628
#> Jokulsa:Jokulsa.lag( 8)           65.806  150.856
#> Jokulsa:Jokulsa.lag( 9)           35.850  153.653
#> Jokulsa:Jokulsa.lag(10)          119.382  136.112
#> Jokulsa:Jokulsa.lag(11)          200.000  200.000
#> Jokulsa:Jokulsa.lag(12)          214.528  161.191
#> Jokulsa:Jokulsa.lag(13)           54.056   88.863
#> Jokulsa:Jokulsa.lag(14)          118.133   84.732
#> Jokulsa:Jokulsa.lag(15)           34.745   68.039
#> Jokulsa:Vatnsdalsa.lag( 1)        69.430   67.659
#> Jokulsa:Vatnsdalsa.lag( 2)        30.241   44.744
#> Jokulsa:Vatnsdalsa.lag( 3)        31.701   44.401
#> Jokulsa:Vatnsdalsa.lag( 4)        55.507  127.057
#> Jokulsa:Vatnsdalsa.lag( 5)        63.180   30.829
#> Jokulsa:Vatnsdalsa.lag( 6)        96.712   21.474
#> Jokulsa:Vatnsdalsa.lag( 7)       150.276   46.302
#> Jokulsa:Vatnsdalsa.lag( 8)       150.092  121.650
#> Jokulsa:Vatnsdalsa.lag( 9)       122.888  105.857
#> Jokulsa:Vatnsdalsa.lag(10)       144.445   77.013
#> Jokulsa:Vatnsdalsa.lag(11)       370.829   30.754
#> Jokulsa:Vatnsdalsa.lag(12)       257.169   18.096
#> Jokulsa:Vatnsdalsa.lag(13)       153.446   41.334
#> Jokulsa:Vatnsdalsa.lag(14)       125.189  100.907
#> Jokulsa:Vatnsdalsa.lag(15)       117.680   61.902
#> Jokulsa:Precipitation.lag(1)     123.996  135.135
#> Jokulsa:Precipitation.lag(2)     144.510   72.709
#> Jokulsa:Precipitation.lag(3)     107.450  156.592
#> Jokulsa:Precipitation.lag(4)      94.845  107.361
#> Jokulsa:Temperature.lag(1)        91.852  134.663
#> Jokulsa:Temperature.lag(2)        35.327  118.196
#> Vatnsdalsa:(Intercept)            46.331  120.018
#> Vatnsdalsa:Jokulsa.lag( 1)        38.310  126.835
#> Vatnsdalsa:Jokulsa.lag( 2)       148.336  154.058
#> Vatnsdalsa:Jokulsa.lag( 3)        94.091  200.000
#> Vatnsdalsa:Jokulsa.lag( 4)        59.057  200.000
#> Vatnsdalsa:Jokulsa.lag( 5)        92.359  155.977
#> Vatnsdalsa:Jokulsa.lag( 6)       111.417  200.000
#> Vatnsdalsa:Jokulsa.lag( 7)       176.801   73.872
#> Vatnsdalsa:Jokulsa.lag( 8)       143.753   97.478
#> Vatnsdalsa:Jokulsa.lag( 9)        71.521  107.737
#> Vatnsdalsa:Jokulsa.lag(10)       132.079  135.336
#> Vatnsdalsa:Jokulsa.lag(11)       155.512  147.279
#> Vatnsdalsa:Jokulsa.lag(12)        98.311  150.918
#> Vatnsdalsa:Jokulsa.lag(13)        89.061  136.143
#> Vatnsdalsa:Jokulsa.lag(14)       139.532  124.345
#> Vatnsdalsa:Jokulsa.lag(15)        59.363   28.465
#> Vatnsdalsa:Vatnsdalsa.lag( 1)     50.504   61.489
#> Vatnsdalsa:Vatnsdalsa.lag( 2)     56.265   42.535
#> Vatnsdalsa:Vatnsdalsa.lag( 3)     52.346   63.765
#> Vatnsdalsa:Vatnsdalsa.lag( 4)     38.051   92.552
#> Vatnsdalsa:Vatnsdalsa.lag( 5)     53.575   16.852
#> Vatnsdalsa:Vatnsdalsa.lag( 6)     99.309   11.125
#> Vatnsdalsa:Vatnsdalsa.lag( 7)    120.766   68.020
#> Vatnsdalsa:Vatnsdalsa.lag( 8)    107.518   25.032
#> Vatnsdalsa:Vatnsdalsa.lag( 9)    200.000   31.321
#> Vatnsdalsa:Vatnsdalsa.lag(10)    127.131   65.781
#> Vatnsdalsa:Vatnsdalsa.lag(11)    131.033   41.634
#> Vatnsdalsa:Vatnsdalsa.lag(12)    364.238   91.759
#> Vatnsdalsa:Vatnsdalsa.lag(13)    141.604  110.756
#> Vatnsdalsa:Vatnsdalsa.lag(14)    130.625   61.068
#> Vatnsdalsa:Vatnsdalsa.lag(15)    158.985   39.898
#> Vatnsdalsa:Precipitation.lag(1)  200.000  104.555
#> Vatnsdalsa:Precipitation.lag(2)  106.080  105.898
#> Vatnsdalsa:Precipitation.lag(3)  129.596  131.656
#> Vatnsdalsa:Precipitation.lag(4)   81.628  100.551
#> Vatnsdalsa:Temperature.lag(1)    109.609  108.672
#> Vatnsdalsa:Temperature.lag(2)     94.988  115.144
#> 
#> 
#> Scale parameter:
#>                       Regime 1 Regime 2
#> Jokulsa.Jokulsa         44.857   26.888
#> Jokulsa.Vatnsdalsa      84.855  124.102
#> Vatnsdalsa.Vatnsdalsa   36.087   14.395
#> 
#> 
#> Extra parameter:
#>          
#> nu 36.867

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=100,
             n.sim=200, n.thin=2, dist="Student-t")
effectiveSize_TAR(fit4)
#> Thresholds:
#>                 
#> threshold 1.5827
#> 
#> 
#> Autoregressive coefficients:
#>                 Regime 1 Regime 2
#> CCR:(Intercept)   145.01   29.947
#> CCR:CCR.lag(1)    141.46   42.178
#> CCR:CCR.lag(2)    132.88  107.414
#> CCR:CCR.lag(3)     91.98   90.675
#> CCR:dVIX.lag(1)   125.25  146.340
#> CCR:dVIX.lag(2)   101.50   76.831
#> CCR:dVIX.lag(3)   109.20  114.224
#> 
#> 
#> Scale parameter:
#>         Regime 1 Regime 2
#> CCR.CCR   37.252    77.68
#> 
#> 
#> Extra parameter:
#>          
#> nu 25.547

# }

```
