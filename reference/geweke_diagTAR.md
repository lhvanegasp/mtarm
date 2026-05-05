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
#>                      
#> Threshold.1  -0.35978
#> Threshold.2 -37.37822
#> 
#> 
#> Autoregressive coefficients:
#>                         Regime 1 Regime 2 Regime 3
#> COLCAP:(Intercept)      0.060262 -13.1363 -33.7831
#> COLCAP:COLCAP.lag(1)   -0.581777   7.4341  -6.1860
#> COLCAP:COLCAP.lag(2)                       -1.9150
#> COLCAP:BOVESPA.lag(1)   2.777293  -5.4024  25.2406
#> COLCAP:BOVESPA.lag(2)                      -4.3625
#> BOVESPA:(Intercept)    -0.089603 -20.4861 -53.6402
#> BOVESPA:COLCAP.lag(1)  -0.765074   0.2372   2.9358
#> BOVESPA:COLCAP.lag(2)                       3.0233
#> BOVESPA:BOVESPA.lag(1)  1.798702   2.4687  16.4185
#> BOVESPA:BOVESPA.lag(2)                     -3.7740
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> COLCAP.COLCAP   -2.21786  -1.7697  -7.0250
#> COLCAP.BOVESPA  -2.26932  -4.2821   9.4271
#> BOVESPA.BOVESPA -0.63935  -2.6284   0.7364
#> 
#> 
#> Extra parameter:
#>            
#> nu -0.26433

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
#>                     
#> Threshold.1 0.021251
#> Threshold.2 0.802947
#> 
#> 
#> Autoregressive coefficients:
#>                         Regime 1   Regime 2 Regime 3
#> Bedon:(Intercept)       0.019333 -0.3881415 -0.18374
#> Bedon:Bedon.lag(1)      0.300817 -0.2710578 -0.47183
#> Bedon:Bedon.lag(2)      1.702843 -0.7863532  0.66096
#> Bedon:Bedon.lag(3)     -0.997590  1.7954193 -2.11369
#> Bedon:Bedon.lag(4)     -1.620658 -1.4046813 -0.23179
#> Bedon:Bedon.lag(5)      0.149792  1.4077845  2.21599
#> Bedon:LaPlata.lag(1)    0.376785  0.1902034  0.90451
#> Bedon:LaPlata.lag(2)   -1.022236  0.7208574 -1.82445
#> Bedon:LaPlata.lag(3)   -0.289026 -0.8539536  1.80699
#> Bedon:LaPlata.lag(4)    1.189220  0.2444805 -0.11205
#> Bedon:LaPlata.lag(5)   -0.331981 -0.7218961 -2.75583
#> LaPlata:(Intercept)     1.345367  0.0026177  0.12714
#> LaPlata:Bedon.lag(1)   -0.496262 -1.2010587 -1.37057
#> LaPlata:Bedon.lag(2)    1.842812  0.6300059  2.15110
#> LaPlata:Bedon.lag(3)    0.480667 -0.2440944 -0.82313
#> LaPlata:Bedon.lag(4)   -0.413600  0.9855953  0.54055
#> LaPlata:Bedon.lag(5)   -1.183054  0.3299143 -1.04271
#> LaPlata:LaPlata.lag(1) -0.155179 -1.5504613  1.64718
#> LaPlata:LaPlata.lag(2) -0.783521  1.2033004 -1.30689
#> LaPlata:LaPlata.lag(3) -1.112843  0.8135466  0.48101
#> LaPlata:LaPlata.lag(4) -0.194725 -0.5413638 -2.47123
#> LaPlata:LaPlata.lag(5)  1.696178 -0.5890843  0.63662
#> 
#> 
#> Scale parameter:
#>                 Regime 1 Regime 2 Regime 3
#> Bedon.Bedon     -0.52074  0.12714 -0.23312
#> Bedon.LaPlata   -0.18592 -0.14945 -0.50238
#> LaPlata.LaPlata -0.83240 -0.62363  0.24870

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
#>                 
#> threshold -3.187
#> 
#> 
#> Autoregressive coefficients:
#>                                  Regime 1  Regime 2
#> Jokulsa:(Intercept)              0.087434 -1.376142
#> Jokulsa:Jokulsa.lag( 1)         -0.184516  1.492467
#> Jokulsa:Jokulsa.lag( 2)          0.182617 -0.922736
#> Jokulsa:Jokulsa.lag( 3)          2.561747  0.059823
#> Jokulsa:Jokulsa.lag( 4)         -2.721328  0.893497
#> Jokulsa:Jokulsa.lag( 5)          1.562058 -1.615183
#> Jokulsa:Jokulsa.lag( 6)          0.743680  1.460952
#> Jokulsa:Jokulsa.lag( 7)         -1.377407 -1.573828
#> Jokulsa:Jokulsa.lag( 8)          0.588210  2.724603
#> Jokulsa:Jokulsa.lag( 9)          0.774146 -1.200808
#> Jokulsa:Jokulsa.lag(10)         -1.715997  0.246983
#> Jokulsa:Jokulsa.lag(11)         -0.027968  0.033549
#> Jokulsa:Jokulsa.lag(12)          0.115368  0.791122
#> Jokulsa:Jokulsa.lag(13)          0.853602  0.445864
#> Jokulsa:Jokulsa.lag(14)          0.090348 -0.710532
#> Jokulsa:Jokulsa.lag(15)         -0.903606 -0.397981
#> Jokulsa:Vatnsdalsa.lag( 1)      -0.158881  0.206553
#> Jokulsa:Vatnsdalsa.lag( 2)       0.640502 -1.025500
#> Jokulsa:Vatnsdalsa.lag( 3)      -1.079504  1.104314
#> Jokulsa:Vatnsdalsa.lag( 4)       2.630406 -0.450298
#> Jokulsa:Vatnsdalsa.lag( 5)      -1.874753  0.475230
#> Jokulsa:Vatnsdalsa.lag( 6)      -1.381708 -0.306878
#> Jokulsa:Vatnsdalsa.lag( 7)       2.218219  0.707640
#> Jokulsa:Vatnsdalsa.lag( 8)      -1.504508 -0.020807
#> Jokulsa:Vatnsdalsa.lag( 9)      -0.277030 -0.595226
#> Jokulsa:Vatnsdalsa.lag(10)       0.428438  0.016426
#> Jokulsa:Vatnsdalsa.lag(11)      -0.102885 -0.408353
#> Jokulsa:Vatnsdalsa.lag(12)       1.479239  0.461955
#> Jokulsa:Vatnsdalsa.lag(13)      -1.447200 -0.446141
#> Jokulsa:Vatnsdalsa.lag(14)       1.274740 -0.577451
#> Jokulsa:Vatnsdalsa.lag(15)      -0.672927  0.694008
#> Jokulsa:Precipitation.lag(1)    -0.207795 -0.549570
#> Jokulsa:Precipitation.lag(2)    -0.423008 -0.035882
#> Jokulsa:Precipitation.lag(3)    -0.622696  2.062098
#> Jokulsa:Precipitation.lag(4)    -0.860431  0.304218
#> Jokulsa:Temperature.lag(1)      -0.731693 -1.472169
#> Jokulsa:Temperature.lag(2)       0.810102 -0.879729
#> Vatnsdalsa:(Intercept)          -0.910269  0.399941
#> Vatnsdalsa:Jokulsa.lag( 1)       0.307951  1.551206
#> Vatnsdalsa:Jokulsa.lag( 2)      -0.522783 -0.041779
#> Vatnsdalsa:Jokulsa.lag( 3)       0.380960 -1.659369
#> Vatnsdalsa:Jokulsa.lag( 4)       1.440154  0.778297
#> Vatnsdalsa:Jokulsa.lag( 5)      -0.455920  1.453597
#> Vatnsdalsa:Jokulsa.lag( 6)      -0.024081 -1.889161
#> Vatnsdalsa:Jokulsa.lag( 7)      -0.313764 -0.641790
#> Vatnsdalsa:Jokulsa.lag( 8)       0.667477  1.158128
#> Vatnsdalsa:Jokulsa.lag( 9)       0.830399  1.341357
#> Vatnsdalsa:Jokulsa.lag(10)      -1.637595 -1.205664
#> Vatnsdalsa:Jokulsa.lag(11)       0.862729 -0.081614
#> Vatnsdalsa:Jokulsa.lag(12)      -1.227416  1.505665
#> Vatnsdalsa:Jokulsa.lag(13)       0.772078 -0.752769
#> Vatnsdalsa:Jokulsa.lag(14)      -0.482406  0.631753
#> Vatnsdalsa:Jokulsa.lag(15)      -0.186492 -1.381409
#> Vatnsdalsa:Vatnsdalsa.lag( 1)    0.513138  0.460540
#> Vatnsdalsa:Vatnsdalsa.lag( 2)   -0.581382 -2.044186
#> Vatnsdalsa:Vatnsdalsa.lag( 3)    0.763110  3.627909
#> Vatnsdalsa:Vatnsdalsa.lag( 4)   -1.217769 -2.489135
#> Vatnsdalsa:Vatnsdalsa.lag( 5)   -1.248413  0.768211
#> Vatnsdalsa:Vatnsdalsa.lag( 6)    1.617680 -0.413521
#> Vatnsdalsa:Vatnsdalsa.lag( 7)   -0.360838 -0.059376
#> Vatnsdalsa:Vatnsdalsa.lag( 8)   -0.452742  2.038749
#> Vatnsdalsa:Vatnsdalsa.lag( 9)   -1.265547 -1.893720
#> Vatnsdalsa:Vatnsdalsa.lag(10)    0.920001  0.137357
#> Vatnsdalsa:Vatnsdalsa.lag(11)   -1.211719 -0.529720
#> Vatnsdalsa:Vatnsdalsa.lag(12)    3.244522  0.591994
#> Vatnsdalsa:Vatnsdalsa.lag(13)   -1.700343  0.719881
#> Vatnsdalsa:Vatnsdalsa.lag(14)    0.949371 -1.600558
#> Vatnsdalsa:Vatnsdalsa.lag(15)    0.452245  2.373138
#> Vatnsdalsa:Precipitation.lag(1)  0.356456 -0.172930
#> Vatnsdalsa:Precipitation.lag(2) -0.054262  0.800311
#> Vatnsdalsa:Precipitation.lag(3) -0.515396  1.196943
#> Vatnsdalsa:Precipitation.lag(4)  0.090891  0.933792
#> Vatnsdalsa:Temperature.lag(1)    0.821603  1.339899
#> Vatnsdalsa:Temperature.lag(2)    0.010446 -1.985191
#> 
#> 
#> Scale parameter:
#>                       Regime 1 Regime 2
#> Jokulsa.Jokulsa        0.38603  0.67156
#> Jokulsa.Vatnsdalsa     0.54299  0.19078
#> Vatnsdalsa.Vatnsdalsa  0.42785  0.54607
#> 
#> 
#> Extra parameter:
#>           
#> nu 0.67831

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
#>                 
#> threshold 0.9828
#> 
#> 
#> Autoregressive coefficients:
#>                  Regime 1 Regime 2
#> CCR:(Intercept)  0.066476 -0.19005
#> CCR:CCR.lag(1)   0.592651 -1.09468
#> CCR:CCR.lag(2)   1.269941  0.88138
#> CCR:CCR.lag(3)   1.022132 -0.47098
#> CCR:dVIX.lag(1)  1.148626  1.26192
#> CCR:dVIX.lag(2)  1.029065 -0.42496
#> CCR:dVIX.lag(3) -1.661425 -0.26668
#> 
#> 
#> Scale parameter:
#>         Regime 1 Regime 2
#> CCR.CCR -0.18242   1.2913
#> 
#> 
#> Extra parameter:
#>             
#> nu -0.073213

# }
```
