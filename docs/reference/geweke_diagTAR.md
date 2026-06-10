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
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=1000, n.sim=2000,
             n.thin=2)
geweke_diagTAR(fit1)
#> 
#> Fraction in 1st window = 0.1
#> 
#> Fraction in 2nd window = 0.5
#> 
#> Thresholds:
#> Threshold.1 Threshold.2 
#>     48.4892     -1.3072 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                  COLCAP  BOVESPA
#> (Intercept)     46.9640  37.3045
#> COLCAP.lag(1)  -14.8952   1.3979
#> BOVESPA.lag(1)  -8.4002 -17.1136
#> 
#> 
#> Scale parameter:
#>          COLCAP  BOVESPA
#> COLCAP  -6.9084  2.52407
#> BOVESPA  2.5241 -0.25811
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                 COLCAP  BOVESPA
#> (Intercept)     1.6280  2.74581
#> COLCAP.lag(1)   4.1944  3.26263
#> BOVESPA.lag(1) -2.6842 -0.32884
#> 
#> 
#> Scale parameter:
#>          COLCAP BOVESPA
#> COLCAP  -1.1998 -7.6317
#> BOVESPA -7.6317 -5.1945
#> 
#> 
#> Regime 3
#> 
#> 
#> Autoregressive coefficients:
#>                  COLCAP  BOVESPA
#> (Intercept)    -1.85761 -1.39243
#> COLCAP.lag(1)  -4.66934 -0.57655
#> BOVESPA.lag(1)  1.76809  2.34450
#> COLCAP.lag(2)  -1.25575  0.25937
#> BOVESPA.lag(2)  0.21582 -0.75210
#> 
#> 
#> Scale parameter:
#>          COLCAP  BOVESPA
#> COLCAP  -2.5509  2.29627
#> BOVESPA  2.2963 -0.53619
#> 
#> 
#> Extra parameter:
#>     nu 
#> 1.0717 

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=1000, n.sim=2000, n.thin=2)
geweke_diagTAR(fit2)
#> 
#> Fraction in 1st window = 0.1
#> 
#> Fraction in 2nd window = 0.5
#> 
#> Thresholds:
#> Threshold.1 Threshold.2 
#>     -1.8288     -1.0046 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                   Bedon  LaPlata
#> (Intercept)     0.89838  0.67193
#> Bedon.lag(1)    1.43868 -1.43568
#> LaPlata.lag(1) -1.21022  0.71543
#> Bedon.lag(2)    1.45766  1.97642
#> LaPlata.lag(2) -1.01032 -0.74477
#> Bedon.lag(3)   -1.35910  0.11484
#> LaPlata.lag(3)  0.20186  0.14498
#> Bedon.lag(4)    0.64977 -0.23213
#> LaPlata.lag(4) -0.33080 -1.26847
#> Bedon.lag(5)   -1.92478 -0.59570
#> LaPlata.lag(5)  2.45990  0.57662
#> 
#> 
#> Scale parameter:
#>           Bedon LaPlata
#> Bedon   0.85566 1.11872
#> LaPlata 1.11872 0.90218
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                     Bedon  LaPlata
#> (Intercept)    -0.0043278  0.40544
#> Bedon.lag(1)    1.0629427  0.15110
#> LaPlata.lag(1) -1.0169426 -1.12749
#> Bedon.lag(2)    0.1745356  0.96738
#> LaPlata.lag(2)  0.0809904  1.92202
#> Bedon.lag(3)    0.6002723 -0.49278
#> LaPlata.lag(3) -0.9674039 -1.35889
#> Bedon.lag(4)   -0.2364553 -0.62205
#> LaPlata.lag(4) -0.1458464  0.18180
#> Bedon.lag(5)   -1.2038561  0.19573
#> LaPlata.lag(5)  0.1023600 -0.46895
#> 
#> 
#> Scale parameter:
#>            Bedon  LaPlata
#> Bedon   -1.71333 -0.53572
#> LaPlata -0.53572  0.38806
#> 
#> 
#> Regime 3
#> 
#> 
#> Autoregressive coefficients:
#>                   Bedon  LaPlata
#> (Intercept)    -0.24901 -2.01627
#> Bedon.lag(1)   -0.22949  0.32852
#> LaPlata.lag(1)  0.78228  0.78091
#> Bedon.lag(2)    0.20293  0.95669
#> LaPlata.lag(2) -0.24878 -0.15321
#> Bedon.lag(3)    1.08719  0.40322
#> LaPlata.lag(3) -0.33677 -1.21684
#> Bedon.lag(4)   -2.35231 -0.20611
#> LaPlata.lag(4)  0.49158  0.46275
#> Bedon.lag(5)    2.00119 -0.29961
#> LaPlata.lag(5) -1.49519 -0.96716
#> 
#> 
#> Scale parameter:
#>            Bedon LaPlata
#> Bedon   -0.77382 -1.5780
#> LaPlata -1.57796 -2.0381

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=1000, n.sim=2000,
             n.thin=2, dist="Slash")
geweke_diagTAR(fit3)
#> 
#> Fraction in 1st window = 0.1
#> 
#> Fraction in 2nd window = 0.5
#> 
#> Thresholds:
#> Threshold.1 
#>    -0.53199 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                         Jokulsa Vatnsdalsa
#> (Intercept)           0.0641969   0.683920
#> Jokulsa.lag( 1)       0.1254847  -1.563865
#> Vatnsdalsa.lag( 1)    2.7329344   0.292400
#> Jokulsa.lag( 2)       0.3895366   1.925758
#> Vatnsdalsa.lag( 2)   -2.4261226  -0.042650
#> Jokulsa.lag( 3)      -0.9447175  -0.228791
#> Vatnsdalsa.lag( 3)    1.8258624  -1.071415
#> Jokulsa.lag( 4)      -0.0267711  -0.322197
#> Vatnsdalsa.lag( 4)   -0.6205694   0.765933
#> Jokulsa.lag( 5)      -0.1474650   0.751996
#> Vatnsdalsa.lag( 5)   -0.6298460  -0.995021
#> Jokulsa.lag( 6)      -1.1199306  -0.359189
#> Vatnsdalsa.lag( 6)    1.8090908   0.464400
#> Jokulsa.lag( 7)       1.5832545  -0.018276
#> Vatnsdalsa.lag( 7)   -1.1098904  -0.084608
#> Jokulsa.lag( 8)      -2.0095213   0.750366
#> Vatnsdalsa.lag( 8)   -1.0766291   0.627621
#> Jokulsa.lag( 9)      -0.1219167  -0.633488
#> Vatnsdalsa.lag( 9)    1.6700995   0.133857
#> Jokulsa.lag(10)       1.6138559   1.524792
#> Vatnsdalsa.lag(10)    0.1989888   0.233072
#> Jokulsa.lag(11)      -0.0028032  -1.762253
#> Vatnsdalsa.lag(11)   -1.0345020  -0.013382
#> Jokulsa.lag(12)      -0.4785571   1.333607
#> Vatnsdalsa.lag(12)    0.4981224  -0.887956
#> Jokulsa.lag(13)       1.2504208  -1.456335
#> Vatnsdalsa.lag(13)   -1.7349193  -0.410224
#> Jokulsa.lag(14)       0.0656821  -0.011674
#> Vatnsdalsa.lag(14)    2.1560147   0.610565
#> Jokulsa.lag(15)      -0.0361220   0.709596
#> Vatnsdalsa.lag(15)   -2.6232022   0.118452
#> Precipitation.lag(1)  0.8026790   0.835285
#> Precipitation.lag(2) -0.1763028  -1.751319
#> Precipitation.lag(3)  0.0499741   0.216243
#> Precipitation.lag(4)  0.4221155   1.312038
#> Temperature.lag(1)    0.5911451  -0.836362
#> Temperature.lag(2)   -0.4025234   0.926685
#> 
#> 
#> Scale parameter:
#>            Jokulsa Vatnsdalsa
#> Jokulsa    -1.3698    -1.2497
#> Vatnsdalsa -1.2497    -0.9896
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                        Jokulsa  Vatnsdalsa
#> (Intercept)          -0.785129  0.12772020
#> Jokulsa.lag( 1)      -1.060537 -1.75436327
#> Vatnsdalsa.lag( 1)    1.517808  0.74382982
#> Jokulsa.lag( 2)       1.266692  1.77943027
#> Vatnsdalsa.lag( 2)   -1.216276  0.77359105
#> Jokulsa.lag( 3)      -0.696726 -1.11579596
#> Vatnsdalsa.lag( 3)    1.359344 -0.57947358
#> Jokulsa.lag( 4)      -0.503443  0.02441145
#> Vatnsdalsa.lag( 4)   -1.512764 -0.56458299
#> Jokulsa.lag( 5)       1.473663  2.12028873
#> Vatnsdalsa.lag( 5)    0.783079  0.51589701
#> Jokulsa.lag( 6)      -1.603112 -1.65012798
#> Vatnsdalsa.lag( 6)   -0.170987  0.47736117
#> Jokulsa.lag( 7)       1.137542  0.25242370
#> Vatnsdalsa.lag( 7)   -0.900175 -1.41711640
#> Jokulsa.lag( 8)      -1.344280  0.12769593
#> Vatnsdalsa.lag( 8)    0.235605  0.05669668
#> Jokulsa.lag( 9)       1.276786 -0.60571335
#> Vatnsdalsa.lag( 9)    0.756116  0.52705064
#> Jokulsa.lag(10)      -0.102376  0.16388244
#> Vatnsdalsa.lag(10)   -1.442310 -0.25328953
#> Jokulsa.lag(11)       1.167872  0.27433006
#> Vatnsdalsa.lag(11)    1.848884  0.00047906
#> Jokulsa.lag(12)      -2.188437  0.08392524
#> Vatnsdalsa.lag(12)   -0.819648 -0.24544167
#> Jokulsa.lag(13)      -0.192494 -0.17051750
#> Vatnsdalsa.lag(13)   -0.229789  0.21880882
#> Jokulsa.lag(14)       0.406604 -1.42382769
#> Vatnsdalsa.lag(14)    0.669013  0.01715964
#> Jokulsa.lag(15)       0.916516  1.99286880
#> Vatnsdalsa.lag(15)   -0.066901  0.08011243
#> Precipitation.lag(1)  0.102486  0.77203448
#> Precipitation.lag(2) -0.735141 -0.93926215
#> Precipitation.lag(3) -0.508273  1.03487068
#> Precipitation.lag(4)  1.412451  0.63617331
#> Temperature.lag(1)   -0.161098 -0.36232436
#> Temperature.lag(2)    0.540296  0.64819553
#> 
#> 
#> Scale parameter:
#>             Jokulsa Vatnsdalsa
#> Jokulsa    -0.22042  -0.196319
#> Vatnsdalsa -0.19632   0.056003
#> 
#> 
#> Extra parameter:
#>       nu 
#> -0.37975 

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=1000,
             n.sim=2000, n.thin=2, dist="Student-t")
geweke_diagTAR(fit4)
#> 
#> Fraction in 1st window = 0.1
#> 
#> Fraction in 2nd window = 0.5
#> 
#> Thresholds:
#> Threshold.1 
#>      1.8817 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                  CCR
#> (Intercept) -1.29097
#> CCR.lag(1)   2.57903
#> CCR.lag(2)   1.52438
#> CCR.lag(3)   0.49956
#> dVIX.lag(1)  1.81594
#> dVIX.lag(2)  0.88163
#> dVIX.lag(3)  0.80324
#> 
#> 
#> Scale parameter:
#>          CCR
#> CCR -0.82696
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                  CCR
#> (Intercept)  1.04782
#> CCR.lag(1)  -0.34451
#> CCR.lag(2)  -3.56713
#> CCR.lag(3)   1.97686
#> dVIX.lag(1) -4.91568
#> dVIX.lag(2)  1.14129
#> dVIX.lag(3)  0.77836
#> 
#> 
#> Scale parameter:
#>          CCR
#> CCR -0.31986
#> 
#> 
#> Extra parameter:
#>      nu 
#> -2.3581 

# }
```
