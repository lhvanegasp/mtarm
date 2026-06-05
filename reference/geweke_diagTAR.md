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
#>    -0.35978   -37.37822 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                   COLCAP   BOVESPA
#> (Intercept)     0.060262 -0.089603
#> COLCAP.lag(1)  -0.581777 -0.765074
#> BOVESPA.lag(1)  2.777293  1.798702
#> 
#> 
#> Scale parameter:
#>          COLCAP  BOVESPA
#> COLCAP  -2.2179 -2.26932
#> BOVESPA -2.2693 -0.63935
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                  COLCAP  BOVESPA
#> (Intercept)    -13.1363 -20.4861
#> COLCAP.lag(1)    7.4341   0.2372
#> BOVESPA.lag(1)  -5.4024   2.4687
#> 
#> 
#> Scale parameter:
#>          COLCAP BOVESPA
#> COLCAP  -1.7697 -4.2821
#> BOVESPA -4.2821 -2.6284
#> 
#> 
#> Regime 3
#> 
#> 
#> Autoregressive coefficients:
#>                  COLCAP  BOVESPA
#> (Intercept)    -33.7831 -53.6402
#> COLCAP.lag(1)   -6.1860   2.9358
#> BOVESPA.lag(1)  25.2406  16.4185
#> COLCAP.lag(2)   -1.9150   3.0233
#> BOVESPA.lag(2)  -4.3625  -3.7740
#> 
#> 
#> Scale parameter:
#>          COLCAP BOVESPA
#> COLCAP  -7.0250  9.4271
#> BOVESPA  9.4271  0.7364
#> 
#> 
#> Extra parameter:
#>       nu 
#> -0.26433 

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
#>    0.021251    0.802947 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                    Bedon  LaPlata
#> (Intercept)     0.019333  1.34537
#> Bedon.lag(1)    0.300817 -0.49626
#> LaPlata.lag(1)  0.376785 -0.15518
#> Bedon.lag(2)    1.702843  1.84281
#> LaPlata.lag(2) -1.022236 -0.78352
#> Bedon.lag(3)   -0.997590  0.48067
#> LaPlata.lag(3) -0.289026 -1.11284
#> Bedon.lag(4)   -1.620658 -0.41360
#> LaPlata.lag(4)  1.189220 -0.19472
#> Bedon.lag(5)    0.149792 -1.18305
#> LaPlata.lag(5) -0.331981  1.69618
#> 
#> 
#> Scale parameter:
#>            Bedon  LaPlata
#> Bedon   -0.52074 -0.18592
#> LaPlata -0.18592 -0.83240
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                   Bedon    LaPlata
#> (Intercept)    -0.38814  0.0026177
#> Bedon.lag(1)   -0.27106 -1.2010587
#> LaPlata.lag(1)  0.19020 -1.5504613
#> Bedon.lag(2)   -0.78635  0.6300059
#> LaPlata.lag(2)  0.72086  1.2033004
#> Bedon.lag(3)    1.79542 -0.2440944
#> LaPlata.lag(3) -0.85395  0.8135466
#> Bedon.lag(4)   -1.40468  0.9855953
#> LaPlata.lag(4)  0.24448 -0.5413638
#> Bedon.lag(5)    1.40778  0.3299143
#> LaPlata.lag(5) -0.72190 -0.5890843
#> 
#> 
#> Scale parameter:
#>            Bedon  LaPlata
#> Bedon    0.12714 -0.14945
#> LaPlata -0.14945 -0.62363
#> 
#> 
#> Regime 3
#> 
#> 
#> Autoregressive coefficients:
#>                   Bedon  LaPlata
#> (Intercept)    -0.18374  0.12714
#> Bedon.lag(1)   -0.47183 -1.37057
#> LaPlata.lag(1)  0.90451  1.64718
#> Bedon.lag(2)    0.66096  2.15110
#> LaPlata.lag(2) -1.82445 -1.30689
#> Bedon.lag(3)   -2.11369 -0.82313
#> LaPlata.lag(3)  1.80699  0.48101
#> Bedon.lag(4)   -0.23179  0.54055
#> LaPlata.lag(4) -0.11205 -2.47123
#> Bedon.lag(5)    2.21599 -1.04271
#> LaPlata.lag(5) -2.75583  0.63662
#> 
#> 
#> Scale parameter:
#>            Bedon  LaPlata
#> Bedon   -0.23312 -0.50238
#> LaPlata -0.50238  0.24870

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
#>      -3.187 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                        Jokulsa Vatnsdalsa
#> (Intercept)           0.087434  -0.910269
#> Jokulsa.lag( 1)      -0.184516   0.307951
#> Vatnsdalsa.lag( 1)   -0.158881   0.513138
#> Jokulsa.lag( 2)       0.182617  -0.522783
#> Vatnsdalsa.lag( 2)    0.640502  -0.581382
#> Jokulsa.lag( 3)       2.561747   0.380960
#> Vatnsdalsa.lag( 3)   -1.079504   0.763110
#> Jokulsa.lag( 4)      -2.721328   1.440154
#> Vatnsdalsa.lag( 4)    2.630406  -1.217769
#> Jokulsa.lag( 5)       1.562058  -0.455920
#> Vatnsdalsa.lag( 5)   -1.874753  -1.248413
#> Jokulsa.lag( 6)       0.743680  -0.024081
#> Vatnsdalsa.lag( 6)   -1.381708   1.617680
#> Jokulsa.lag( 7)      -1.377407  -0.313764
#> Vatnsdalsa.lag( 7)    2.218219  -0.360838
#> Jokulsa.lag( 8)       0.588210   0.667477
#> Vatnsdalsa.lag( 8)   -1.504508  -0.452742
#> Jokulsa.lag( 9)       0.774146   0.830399
#> Vatnsdalsa.lag( 9)   -0.277030  -1.265547
#> Jokulsa.lag(10)      -1.715997  -1.637595
#> Vatnsdalsa.lag(10)    0.428438   0.920001
#> Jokulsa.lag(11)      -0.027968   0.862729
#> Vatnsdalsa.lag(11)   -0.102885  -1.211719
#> Jokulsa.lag(12)       0.115368  -1.227416
#> Vatnsdalsa.lag(12)    1.479239   3.244522
#> Jokulsa.lag(13)       0.853602   0.772078
#> Vatnsdalsa.lag(13)   -1.447200  -1.700343
#> Jokulsa.lag(14)       0.090348  -0.482406
#> Vatnsdalsa.lag(14)    1.274740   0.949371
#> Jokulsa.lag(15)      -0.903606  -0.186492
#> Vatnsdalsa.lag(15)   -0.672927   0.452245
#> Precipitation.lag(1) -0.207795   0.356456
#> Precipitation.lag(2) -0.423008  -0.054262
#> Precipitation.lag(3) -0.622696  -0.515396
#> Precipitation.lag(4) -0.860431   0.090891
#> Temperature.lag(1)   -0.731693   0.821603
#> Temperature.lag(2)    0.810102   0.010446
#> 
#> 
#> Scale parameter:
#>            Jokulsa Vatnsdalsa
#> Jokulsa    0.38603    0.54299
#> Vatnsdalsa 0.54299    0.42785
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                        Jokulsa Vatnsdalsa
#> (Intercept)          -1.376142   0.399941
#> Jokulsa.lag( 1)       1.492467   1.551206
#> Vatnsdalsa.lag( 1)    0.206553   0.460540
#> Jokulsa.lag( 2)      -0.922736  -0.041779
#> Vatnsdalsa.lag( 2)   -1.025500  -2.044186
#> Jokulsa.lag( 3)       0.059823  -1.659369
#> Vatnsdalsa.lag( 3)    1.104314   3.627909
#> Jokulsa.lag( 4)       0.893497   0.778297
#> Vatnsdalsa.lag( 4)   -0.450298  -2.489135
#> Jokulsa.lag( 5)      -1.615183   1.453597
#> Vatnsdalsa.lag( 5)    0.475230   0.768211
#> Jokulsa.lag( 6)       1.460952  -1.889161
#> Vatnsdalsa.lag( 6)   -0.306878  -0.413521
#> Jokulsa.lag( 7)      -1.573828  -0.641790
#> Vatnsdalsa.lag( 7)    0.707640  -0.059376
#> Jokulsa.lag( 8)       2.724603   1.158128
#> Vatnsdalsa.lag( 8)   -0.020807   2.038749
#> Jokulsa.lag( 9)      -1.200808   1.341357
#> Vatnsdalsa.lag( 9)   -0.595226  -1.893720
#> Jokulsa.lag(10)       0.246983  -1.205664
#> Vatnsdalsa.lag(10)    0.016426   0.137357
#> Jokulsa.lag(11)       0.033549  -0.081614
#> Vatnsdalsa.lag(11)   -0.408353  -0.529720
#> Jokulsa.lag(12)       0.791122   1.505665
#> Vatnsdalsa.lag(12)    0.461955   0.591994
#> Jokulsa.lag(13)       0.445864  -0.752769
#> Vatnsdalsa.lag(13)   -0.446141   0.719881
#> Jokulsa.lag(14)      -0.710532   0.631753
#> Vatnsdalsa.lag(14)   -0.577451  -1.600558
#> Jokulsa.lag(15)      -0.397981  -1.381409
#> Vatnsdalsa.lag(15)    0.694008   2.373138
#> Precipitation.lag(1) -0.549570  -0.172930
#> Precipitation.lag(2) -0.035882   0.800311
#> Precipitation.lag(3)  2.062098   1.196943
#> Precipitation.lag(4)  0.304218   0.933792
#> Temperature.lag(1)   -1.472169   1.339899
#> Temperature.lag(2)   -0.879729  -1.985191
#> 
#> 
#> Scale parameter:
#>            Jokulsa Vatnsdalsa
#> Jokulsa    0.67156    0.19078
#> Vatnsdalsa 0.19078    0.54607
#> 
#> 
#> Extra parameter:
#>      nu 
#> 0.67831 

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
#>      0.9828 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                   CCR
#> (Intercept)  0.066476
#> CCR.lag(1)   0.592651
#> CCR.lag(2)   1.269941
#> CCR.lag(3)   1.022132
#> dVIX.lag(1)  1.148626
#> dVIX.lag(2)  1.029065
#> dVIX.lag(3) -1.661425
#> 
#> 
#> Scale parameter:
#>          CCR
#> CCR -0.18242
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                  CCR
#> (Intercept) -0.19005
#> CCR.lag(1)  -1.09468
#> CCR.lag(2)   0.88138
#> CCR.lag(3)  -0.47098
#> dVIX.lag(1)  1.26192
#> dVIX.lag(2) -0.42496
#> dVIX.lag(3) -0.26668
#> 
#> 
#> Scale parameter:
#>        CCR
#> CCR 1.2913
#> 
#> 
#> Extra parameter:
#>        nu 
#> -0.073213 

# }
```
