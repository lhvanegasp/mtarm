# Geweke's convergence diagnostic for `mtar` objects

This function computes Geweke's convergence diagnostic for Markov chain
Monte Carlo (MCMC) output obtained from Bayesian estimation of
multivariate TAR models. It is a wrapper around `geweke.diag()` that
applies the diagnostic to the posterior chains returned by a call to
[`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md).

## Usage

``` r
geweke_diagTAR(x, frac1 = 0.1, frac2 = 0.5)
```

## Arguments

- x:

  An object of class `mtar` returned by the function
  [`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md).

- frac1:

  A numeric value in \\(0,1)\\ specifying the fraction of the initial
  part of each chain to be used in the diagnostic.

- frac2:

  A numeric value in \\(0,1)\\ specifying the fraction of the final part
  of each chain to be used in the diagnostic.

## Value

A list containing the Geweke z-scores for the parameters of the `mtar`
model.

## See also

[`geweke.diag`](https://rdrr.io/pkg/coda/man/geweke.diag.html)

## Examples

``` r
# \donttest{
###### Example 1: Returns of the closing prices of three financial indexes
data(returns)
fit1 <- mtar(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
             subset={Date<="2015-12-07"}, dist="Student-t",
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=100, n.sim=200,
             n.thin=2)
geweke_diagTAR(fit1)
#> 
#> Fraction in 1st window = 0.1
#> 
#> Fraction in 2nd window = 0.5
#> 
#> Thresholds:
#>                      
#> Threshold.1   -12.755
#> Threshold.2 -1932.345
#> 
#> 
#> Autoregressive coefficients:
#>                        Regime 1 Regime 2  Regime 3
#> COLCAP:(Intercept)     -3.73562  -3.7340 -10.08454
#> COLCAP:COLCAP.lag(1)    3.78757   5.0767  -3.54147
#> COLCAP:COLCAP.lag(2)                      -2.25964
#> COLCAP:BOVESPA.lag(1)  -4.69816  -1.1253   7.85312
#> COLCAP:BOVESPA.lag(2)                      0.85684
#> BOVESPA:(Intercept)    -6.77853 -12.5286 -23.86336
#> BOVESPA:COLCAP.lag(1)   1.97562   2.4524   1.84496
#> BOVESPA:COLCAP.lag(2)                     -0.32679
#> BOVESPA:BOVESPA.lag(1) -0.75807  -1.8772   6.14604
#> BOVESPA:BOVESPA.lag(2)                    -0.63861
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> COLCAP.COLCAP    -2.8169  0.75352 -8.68604
#> COLCAP.BOVESPA   -2.2947  1.09361  0.61392
#> BOVESPA.BOVESPA  -2.4997  0.20139 -0.79342
#> 
#> 
#> Extra parameter:
#>          
#> nu -3.403

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=100, n.sim=200, n.thin=2)
geweke_diagTAR(fit2)
#> 
#> Fraction in 1st window = 0.1
#> 
#> Fraction in 2nd window = 0.5
#> 
#> Thresholds:
#>                     
#> Threshold.1 -1.08792
#> Threshold.2  0.64874
#> 
#> 
#> Autoregressive coefficients:
#>                         Regime 1 Regime 2    Regime 3
#> Bedon:(Intercept)      -0.864763  0.74535 -1.96286726
#> Bedon:Bedon.lag(1)     -0.582689 -0.10998 -1.30797957
#> Bedon:Bedon.lag(2)     -3.610993  0.69118  0.53824018
#> Bedon:Bedon.lag(3)     -0.927012 -0.22136  0.96076771
#> Bedon:Bedon.lag(4)      1.860553 -0.97593  0.34146561
#> Bedon:Bedon.lag(5)      0.156615  0.44879  0.98159261
#> Bedon:LaPlata.lag(1)    1.858798  0.60919  1.45352087
#> Bedon:LaPlata.lag(2)    0.623685 -0.58143  0.48638180
#> Bedon:LaPlata.lag(3)    1.939665 -0.67322 -1.50332612
#> Bedon:LaPlata.lag(4)   -2.276133  0.35789  0.00059633
#> Bedon:LaPlata.lag(5)   -2.275783  0.68684  0.34626837
#> LaPlata:(Intercept)    -0.692022  3.75559 -0.79682674
#> LaPlata:Bedon.lag(1)    0.701833 -2.07237 -0.16818001
#> LaPlata:Bedon.lag(2)   -2.123179  2.42865  0.13956516
#> LaPlata:Bedon.lag(3)   -2.074610 -0.36530  1.54784061
#> LaPlata:Bedon.lag(4)    2.045705 -1.67051  0.86998688
#> LaPlata:Bedon.lag(5)   -0.124889 -1.78319 -0.91321383
#> LaPlata:LaPlata.lag(1) -0.015995 -1.25344  0.18062108
#> LaPlata:LaPlata.lag(2)  0.340644 -1.26195 -0.09998359
#> LaPlata:LaPlata.lag(3)  2.386057  0.66568 -1.00372026
#> LaPlata:LaPlata.lag(4)  0.204346 -0.60243 -0.60464445
#> LaPlata:LaPlata.lag(5) -0.320024  3.43216  1.56134824
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> Bedon.Bedon      1.16405  0.79804 1.919207
#> Bedon.LaPlata    1.48468 -0.54753 1.422401
#> LaPlata.LaPlata  0.38972  0.19599 0.044936

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=100, n.sim=200,
             n.thin=2, dist="Slash")
geweke_diagTAR(fit3)
#> 
#> Fraction in 1st window = 0.1
#> 
#> Fraction in 2nd window = 0.5
#> 
#> Thresholds:
#>                  
#> threshold -7.6187
#> 
#> 
#> Autoregressive coefficients:
#>                                   Regime 1  Regime 2
#> Jokulsa:(Intercept)             -4.2628614  1.717877
#> Jokulsa:Jokulsa.lag( 1)          0.9156512 -1.952927
#> Jokulsa:Jokulsa.lag( 2)         -2.7709048  0.993795
#> Jokulsa:Jokulsa.lag( 3)          1.8547001 -0.663068
#> Jokulsa:Jokulsa.lag( 4)          1.3246876  0.761879
#> Jokulsa:Jokulsa.lag( 5)         -2.7658507  0.294324
#> Jokulsa:Jokulsa.lag( 6)         -0.2546744 -0.301924
#> Jokulsa:Jokulsa.lag( 7)          6.5174166 -1.779083
#> Jokulsa:Jokulsa.lag( 8)         -0.4061863  1.893591
#> Jokulsa:Jokulsa.lag( 9)          2.9979085 -0.101026
#> Jokulsa:Jokulsa.lag(10)         -3.9350067  1.162109
#> Jokulsa:Jokulsa.lag(11)          0.4259289 -3.630674
#> Jokulsa:Jokulsa.lag(12)         -0.3925552  3.645303
#> Jokulsa:Jokulsa.lag(13)          0.0652992 -1.165264
#> Jokulsa:Jokulsa.lag(14)          0.1704909  0.504291
#> Jokulsa:Jokulsa.lag(15)         -1.3162742 -0.597820
#> Jokulsa:Vatnsdalsa.lag( 1)       2.6015848 -2.231870
#> Jokulsa:Vatnsdalsa.lag( 2)      -0.0094663  1.437377
#> Jokulsa:Vatnsdalsa.lag( 3)       0.8958806  1.479311
#> Jokulsa:Vatnsdalsa.lag( 4)      -1.9207465 -0.316161
#> Jokulsa:Vatnsdalsa.lag( 5)       0.7458013 -3.036070
#> Jokulsa:Vatnsdalsa.lag( 6)       0.4151011  1.671687
#> Jokulsa:Vatnsdalsa.lag( 7)      -3.2048588 -0.578230
#> Jokulsa:Vatnsdalsa.lag( 8)       0.7413307  1.393763
#> Jokulsa:Vatnsdalsa.lag( 9)      -3.9493474  0.249534
#> Jokulsa:Vatnsdalsa.lag(10)       2.4811949 -1.833417
#> Jokulsa:Vatnsdalsa.lag(11)       0.3486039  1.506276
#> Jokulsa:Vatnsdalsa.lag(12)       0.9731873 -0.216660
#> Jokulsa:Vatnsdalsa.lag(13)      -1.5341411 -0.433283
#> Jokulsa:Vatnsdalsa.lag(14)      -0.1330807  1.584939
#> Jokulsa:Vatnsdalsa.lag(15)       0.7112724 -0.139897
#> Jokulsa:Precipitation.lag(1)    -1.4812140  1.667050
#> Jokulsa:Precipitation.lag(2)     0.4387917 -0.999696
#> Jokulsa:Precipitation.lag(3)    -2.2682349  2.444404
#> Jokulsa:Precipitation.lag(4)     1.8381037  0.625296
#> Jokulsa:Temperature.lag(1)       0.6247307 -1.486973
#> Jokulsa:Temperature.lag(2)       1.1339310  1.187752
#> Vatnsdalsa:(Intercept)          -4.4532773 -2.106401
#> Vatnsdalsa:Jokulsa.lag( 1)       2.2858952  0.190014
#> Vatnsdalsa:Jokulsa.lag( 2)      -1.8002997 -0.032251
#> Vatnsdalsa:Jokulsa.lag( 3)       1.6962950 -0.339721
#> Vatnsdalsa:Jokulsa.lag( 4)      -1.4118270  1.075601
#> Vatnsdalsa:Jokulsa.lag( 5)      -1.2706540 -1.382557
#> Vatnsdalsa:Jokulsa.lag( 6)      -1.1860273 -0.052832
#> Vatnsdalsa:Jokulsa.lag( 7)       3.5454433  2.170683
#> Vatnsdalsa:Jokulsa.lag( 8)      -1.2096175 -0.815453
#> Vatnsdalsa:Jokulsa.lag( 9)       2.1562571 -4.321723
#> Vatnsdalsa:Jokulsa.lag(10)      -2.7161129  3.464789
#> Vatnsdalsa:Jokulsa.lag(11)      -1.1623634 -0.225016
#> Vatnsdalsa:Jokulsa.lag(12)       1.2312270  2.699879
#> Vatnsdalsa:Jokulsa.lag(13)      -1.2460385 -2.830888
#> Vatnsdalsa:Jokulsa.lag(14)       1.8026396 -0.864022
#> Vatnsdalsa:Jokulsa.lag(15)      -0.6058112  2.937705
#> Vatnsdalsa:Vatnsdalsa.lag( 1)   -0.7000486  1.027186
#> Vatnsdalsa:Vatnsdalsa.lag( 2)    0.4927592 -0.877374
#> Vatnsdalsa:Vatnsdalsa.lag( 3)    0.9049105 -3.149685
#> Vatnsdalsa:Vatnsdalsa.lag( 4)   -1.0004710  3.996735
#> Vatnsdalsa:Vatnsdalsa.lag( 5)    0.1151898  0.056731
#> Vatnsdalsa:Vatnsdalsa.lag( 6)    1.5881381 -0.766428
#> Vatnsdalsa:Vatnsdalsa.lag( 7)   -0.7580009  0.978554
#> Vatnsdalsa:Vatnsdalsa.lag( 8)    0.5192814 -1.112712
#> Vatnsdalsa:Vatnsdalsa.lag( 9)   -2.8474308  1.019332
#> Vatnsdalsa:Vatnsdalsa.lag(10)    2.7349594  1.144182
#> Vatnsdalsa:Vatnsdalsa.lag(11)   -1.2979299 -1.107577
#> Vatnsdalsa:Vatnsdalsa.lag(12)    0.5772628 -0.329027
#> Vatnsdalsa:Vatnsdalsa.lag(13)   -1.4238515  0.643480
#> Vatnsdalsa:Vatnsdalsa.lag(14)   -0.1377079  0.890446
#> Vatnsdalsa:Vatnsdalsa.lag(15)    0.1170764 -0.566757
#> Vatnsdalsa:Precipitation.lag(1)  1.8390950 -0.514298
#> Vatnsdalsa:Precipitation.lag(2)  1.7462198 -2.224164
#> Vatnsdalsa:Precipitation.lag(3)  0.2126167  0.927549
#> Vatnsdalsa:Precipitation.lag(4)  3.4781049 -0.841094
#> Vatnsdalsa:Temperature.lag(1)   -1.3621307  1.646629
#> Vatnsdalsa:Temperature.lag(2)   -1.6752966 -1.512088
#> 
#> 
#> Scale parameter:
#>                       Regime 1 Regime 2
#> Jokulsa.Jokulsa        -2.6379 -0.73931
#> Jokulsa.Vatnsdalsa     -2.1981 -2.16269
#> Vatnsdalsa.Vatnsdalsa  -2.3184  0.86459
#> 
#> 
#> Extra parameter:
#>           
#> nu -1.1107

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=100,
             n.sim=200, n.thin=2, dist="Student-t")
geweke_diagTAR(fit4)
#> 
#> Fraction in 1st window = 0.1
#> 
#> Fraction in 2nd window = 0.5
#> 
#> Thresholds:
#>                   
#> threshold -0.48268
#> 
#> 
#> Autoregressive coefficients:
#>                 Regime 1 Regime 2
#> CCR:(Intercept) -2.55605  0.44174
#> CCR:CCR.lag(1)   1.44889  0.41160
#> CCR:CCR.lag(2)   0.91314 -0.88590
#> CCR:CCR.lag(3)  -0.14416 -1.06824
#> CCR:dVIX.lag(1)  0.25467 -0.28514
#> CCR:dVIX.lag(2)  0.92212 -0.56608
#> CCR:dVIX.lag(3)  0.44079  0.11463
#> 
#> 
#> Scale parameter:
#>         Regime 1 Regime 2
#> CCR.CCR  -1.5763  0.39228
#> 
#> 
#> Extra parameter:
#>           
#> nu -1.5317

# }
```
