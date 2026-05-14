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
#> Threshold.1  0.11356
#> Threshold.2 -2.70536
#> 
#> 
#> Autoregressive coefficients:
#>                         Regime 1 Regime 2  Regime 3
#> COLCAP:(Intercept)      1.745416 -0.30833  3.375604
#> COLCAP:COLCAP.lag(1)    1.038377 -0.66840 -0.270495
#> COLCAP:COLCAP.lag(2)                      -0.656604
#> COLCAP:BOVESPA.lag(1)  -0.064165  0.12503  1.845537
#> COLCAP:BOVESPA.lag(2)                      1.567525
#> BOVESPA:(Intercept)    -0.214358 -0.20241 -0.755315
#> BOVESPA:COLCAP.lag(1)  -0.093370 -1.40943  0.033879
#> BOVESPA:COLCAP.lag(2)                     -0.263949
#> BOVESPA:BOVESPA.lag(1) -2.266093  1.44166  0.206484
#> BOVESPA:BOVESPA.lag(2)                     0.203798
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> COLCAP.COLCAP    -1.6540  -3.6273 -1.47561
#> COLCAP.BOVESPA   -2.0927  -3.0546 -2.26107
#> BOVESPA.BOVESPA  -4.0079  -4.2834 -0.99057
#> 
#> 
#> Extra parameter:
#>           
#> nu -1.9409

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
#> Threshold.1 -6.6118
#> Threshold.2 -3.2370
#> 
#> 
#> Autoregressive coefficients:
#>                         Regime 1  Regime 2  Regime 3
#> Bedon:(Intercept)       0.609746 -0.194415 -0.068429
#> Bedon:Bedon.lag(1)      0.259699 -0.930640  1.458702
#> Bedon:Bedon.lag(2)     -0.457895 -0.077164 -1.394193
#> Bedon:Bedon.lag(3)      1.008299 -0.985041 -1.757549
#> Bedon:Bedon.lag(4)     -0.045598  1.998524  0.674293
#> Bedon:Bedon.lag(5)      0.322967 -1.137978 -0.319331
#> Bedon:LaPlata.lag(1)   -3.763417  2.155283 -0.047187
#> Bedon:LaPlata.lag(2)    5.437253  0.003872 -0.678272
#> Bedon:LaPlata.lag(3)   -2.152364  0.906505  0.071907
#> Bedon:LaPlata.lag(4)    0.397025 -0.982121  0.818494
#> Bedon:LaPlata.lag(5)    0.693351 -1.374299 -0.495198
#> LaPlata:(Intercept)     1.519028  0.730821 -1.933477
#> LaPlata:Bedon.lag(1)   -0.350597 -0.802083 -0.070297
#> LaPlata:Bedon.lag(2)    0.174449 -1.138485  0.959153
#> LaPlata:Bedon.lag(3)   -0.248497  0.826379  1.056641
#> LaPlata:Bedon.lag(4)   -0.657543  1.880109 -0.250346
#> LaPlata:Bedon.lag(5)    0.498356 -0.702740 -1.698729
#> LaPlata:LaPlata.lag(1) -2.534480  1.804981  1.132650
#> LaPlata:LaPlata.lag(2)  2.234200  0.373357 -0.788856
#> LaPlata:LaPlata.lag(3)  0.422239  0.670537 -0.321663
#> LaPlata:LaPlata.lag(4) -1.506449  0.817669  0.025015
#> LaPlata:LaPlata.lag(5)  1.493079 -2.927121  0.329010
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> Bedon.Bedon     -0.72568  0.51171   2.6814
#> Bedon.LaPlata   -0.59744 -0.26023   1.7902
#> LaPlata.LaPlata  0.64288  0.52904   1.2831

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
#> threshold -1.1574
#> 
#> 
#> Autoregressive coefficients:
#>                                  Regime 1   Regime 2
#> Jokulsa:(Intercept)             -0.823862  0.6109322
#> Jokulsa:Jokulsa.lag( 1)          1.094004  1.0780484
#> Jokulsa:Jokulsa.lag( 2)          0.277770 -1.0066175
#> Jokulsa:Jokulsa.lag( 3)         -0.351499  1.0995278
#> Jokulsa:Jokulsa.lag( 4)         -0.371079 -0.1728502
#> Jokulsa:Jokulsa.lag( 5)         -0.287541 -0.2688228
#> Jokulsa:Jokulsa.lag( 6)         -0.349590 -0.0071128
#> Jokulsa:Jokulsa.lag( 7)          0.925982 -0.7064158
#> Jokulsa:Jokulsa.lag( 8)         -0.761811  1.4911937
#> Jokulsa:Jokulsa.lag( 9)         -0.371536 -1.3739013
#> Jokulsa:Jokulsa.lag(10)          0.538585  1.8168860
#> Jokulsa:Jokulsa.lag(11)          0.421276 -2.3095396
#> Jokulsa:Jokulsa.lag(12)          0.034378  1.8729635
#> Jokulsa:Jokulsa.lag(13)          3.008883 -0.7532789
#> Jokulsa:Jokulsa.lag(14)         -0.834252  0.5970718
#> Jokulsa:Jokulsa.lag(15)         -1.858247 -0.9083479
#> Jokulsa:Vatnsdalsa.lag( 1)       2.936426 -2.0035680
#> Jokulsa:Vatnsdalsa.lag( 2)      -2.126379  0.6507942
#> Jokulsa:Vatnsdalsa.lag( 3)      -0.604717 -0.5851513
#> Jokulsa:Vatnsdalsa.lag( 4)       1.131303 -1.7071196
#> Jokulsa:Vatnsdalsa.lag( 5)      -0.045075  1.4530296
#> Jokulsa:Vatnsdalsa.lag( 6)      -1.108380 -1.8760778
#> Jokulsa:Vatnsdalsa.lag( 7)       1.398213  1.6066348
#> Jokulsa:Vatnsdalsa.lag( 8)      -1.631388 -1.0361706
#> Jokulsa:Vatnsdalsa.lag( 9)       1.662547  0.8162786
#> Jokulsa:Vatnsdalsa.lag(10)       0.034633 -0.1567618
#> Jokulsa:Vatnsdalsa.lag(11)      -2.153253 -0.7390121
#> Jokulsa:Vatnsdalsa.lag(12)      -0.773510  3.0732424
#> Jokulsa:Vatnsdalsa.lag(13)      -0.636791 -1.0879242
#> Jokulsa:Vatnsdalsa.lag(14)       0.558124  1.2203508
#> Jokulsa:Vatnsdalsa.lag(15)      -0.677028  0.0057302
#> Jokulsa:Precipitation.lag(1)     0.284061 -0.8269849
#> Jokulsa:Precipitation.lag(2)    -1.101944  0.8863884
#> Jokulsa:Precipitation.lag(3)     0.135629 -1.0898838
#> Jokulsa:Precipitation.lag(4)    -0.710571  1.0781812
#> Jokulsa:Temperature.lag(1)      -0.537702  0.3180306
#> Jokulsa:Temperature.lag(2)       1.370769  0.0144458
#> Vatnsdalsa:(Intercept)          -3.160850  0.3567473
#> Vatnsdalsa:Jokulsa.lag( 1)       2.379660 -0.3912094
#> Vatnsdalsa:Jokulsa.lag( 2)       2.851764  0.3266082
#> Vatnsdalsa:Jokulsa.lag( 3)      -5.677851 -0.3162113
#> Vatnsdalsa:Jokulsa.lag( 4)       0.542770  1.5621443
#> Vatnsdalsa:Jokulsa.lag( 5)       0.591480  0.2846014
#> Vatnsdalsa:Jokulsa.lag( 6)      -0.122440 -1.6729661
#> Vatnsdalsa:Jokulsa.lag( 7)      -1.003503  0.4233115
#> Vatnsdalsa:Jokulsa.lag( 8)       0.455903 -0.1289307
#> Vatnsdalsa:Jokulsa.lag( 9)      -0.513075  1.1017728
#> Vatnsdalsa:Jokulsa.lag(10)       0.469645  0.4894130
#> Vatnsdalsa:Jokulsa.lag(11)       0.443964 -0.6360787
#> Vatnsdalsa:Jokulsa.lag(12)       0.033230  0.7120535
#> Vatnsdalsa:Jokulsa.lag(13)       0.728990 -0.5998214
#> Vatnsdalsa:Jokulsa.lag(14)      -0.989275 -0.7326892
#> Vatnsdalsa:Jokulsa.lag(15)      -0.462880  0.7901889
#> Vatnsdalsa:Vatnsdalsa.lag( 1)    3.748639  0.8593586
#> Vatnsdalsa:Vatnsdalsa.lag( 2)   -3.704252 -0.8872188
#> Vatnsdalsa:Vatnsdalsa.lag( 3)   -0.436174 -1.8864874
#> Vatnsdalsa:Vatnsdalsa.lag( 4)    1.974799  0.9302210
#> Vatnsdalsa:Vatnsdalsa.lag( 5)   -0.784182 -3.3513613
#> Vatnsdalsa:Vatnsdalsa.lag( 6)   -1.679059  2.1958604
#> Vatnsdalsa:Vatnsdalsa.lag( 7)    2.155702 -0.9034269
#> Vatnsdalsa:Vatnsdalsa.lag( 8)   -0.753057 -2.2526170
#> Vatnsdalsa:Vatnsdalsa.lag( 9)    1.245222  1.3710749
#> Vatnsdalsa:Vatnsdalsa.lag(10)   -0.812394 -0.6941822
#> Vatnsdalsa:Vatnsdalsa.lag(11)   -2.040300  0.2606420
#> Vatnsdalsa:Vatnsdalsa.lag(12)   -1.284146  1.3577733
#> Vatnsdalsa:Vatnsdalsa.lag(13)    0.806696 -0.7685607
#> Vatnsdalsa:Vatnsdalsa.lag(14)    0.079522  0.1060577
#> Vatnsdalsa:Vatnsdalsa.lag(15)    0.731686 -0.4813458
#> Vatnsdalsa:Precipitation.lag(1) -1.559372  0.8548126
#> Vatnsdalsa:Precipitation.lag(2) -0.942670  0.2470207
#> Vatnsdalsa:Precipitation.lag(3)  3.131694 -2.0528026
#> Vatnsdalsa:Precipitation.lag(4)  0.820011  1.1571862
#> Vatnsdalsa:Temperature.lag(1)   -2.945585  3.4123432
#> Vatnsdalsa:Temperature.lag(2)    1.979369 -2.0061832
#> 
#> 
#> Scale parameter:
#>                       Regime 1 Regime 2
#> Jokulsa.Jokulsa        -4.2318   2.1207
#> Jokulsa.Vatnsdalsa     -2.3976   1.6985
#> Vatnsdalsa.Vatnsdalsa  -2.9155   2.1476
#> 
#> 
#> Extra parameter:
#>         
#> nu -1.06

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
#> threshold 0.41314
#> 
#> 
#> Autoregressive coefficients:
#>                 Regime 1 Regime 2
#> CCR:(Intercept)  2.14097  0.91414
#> CCR:CCR.lag(1)   0.45316  0.25510
#> CCR:CCR.lag(2)  -2.38108  1.97836
#> CCR:CCR.lag(3)  -1.41131 -0.89380
#> CCR:dVIX.lag(1) -1.68308  2.92253
#> CCR:dVIX.lag(2) -1.02757 -2.89144
#> CCR:dVIX.lag(3)  0.43897  0.75047
#> 
#> 
#> Scale parameter:
#>         Regime 1 Regime 2
#> CCR.CCR    1.333  0.85975
#> 
#> 
#> Extra parameter:
#>          
#> nu 1.1756

# }
```
