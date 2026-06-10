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
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=1000, n.sim=2000,
             n.thin=2)
effectiveSize_TAR(fit1)
#> Thresholds:
#> Threshold.1 Threshold.2 
#>      1.2342      2.0274 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                 COLCAP  BOVESPA
#> (Intercept)     2.7333   3.3358
#> COLCAP.lag(1)  21.6432 527.8522
#> BOVESPA.lag(1) 79.3678  14.8757
#> 
#> 
#> Scale parameter:
#>          COLCAP BOVESPA
#> COLCAP   178.39 1738.88
#> BOVESPA 1738.88  719.19
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                 COLCAP  BOVESPA
#> (Intercept)     116.32   22.774
#> COLCAP.lag(1)   197.19 1620.323
#> BOVESPA.lag(1) 1624.43 1581.051
#> 
#> 
#> Scale parameter:
#>          COLCAP BOVESPA
#> COLCAP  466.808  90.252
#> BOVESPA  90.252 253.378
#> 
#> 
#> Regime 3
#> 
#> 
#> Autoregressive coefficients:
#>                  COLCAP   BOVESPA
#> (Intercept)      4.5064    4.7917
#> COLCAP.lag(1)  606.5935 1853.9254
#> BOVESPA.lag(1)   7.9509   32.8775
#> COLCAP.lag(2)  324.4990  511.4023
#> BOVESPA.lag(2) 525.6385  334.7090
#> 
#> 
#> Scale parameter:
#>         COLCAP BOVESPA
#> COLCAP  316.69  387.41
#> BOVESPA 387.41 1057.73
#> 
#> 
#> Extra parameter:
#>     nu 
#> 174.35 

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=1000, n.sim=2000, n.thin=2)
effectiveSize_TAR(fit2)
#> Thresholds:
#> Threshold.1 Threshold.2 
#>      23.763      61.558 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                  Bedon LaPlata
#> (Intercept)    1124.08 1032.04
#> Bedon.lag(1)    857.57  863.34
#> LaPlata.lag(1)  972.31  835.57
#> Bedon.lag(2)    948.30  995.92
#> LaPlata.lag(2)  984.75  809.13
#> Bedon.lag(3)    800.71 1026.22
#> LaPlata.lag(3)  811.96  846.13
#> Bedon.lag(4)    848.92  859.31
#> LaPlata.lag(4) 1037.74  771.12
#> Bedon.lag(5)    641.81  897.97
#> LaPlata.lag(5) 1072.74  820.13
#> 
#> 
#> Scale parameter:
#>          Bedon LaPlata
#> Bedon   1111.9  1435.3
#> LaPlata 1435.3  1072.9
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                  Bedon LaPlata
#> (Intercept)     675.12  642.85
#> Bedon.lag(1)    911.69  776.10
#> LaPlata.lag(1) 1086.46  862.19
#> Bedon.lag(2)    598.69 1095.92
#> LaPlata.lag(2)  682.80 1012.24
#> Bedon.lag(3)    746.36 1019.38
#> LaPlata.lag(3)  846.51  909.56
#> Bedon.lag(4)    643.23  858.71
#> LaPlata.lag(4)  753.95  815.91
#> Bedon.lag(5)    908.48 1006.91
#> LaPlata.lag(5)  903.60  803.88
#> 
#> 
#> Scale parameter:
#>          Bedon LaPlata
#> Bedon   1243.5  1477.5
#> LaPlata 1477.5  1156.0
#> 
#> 
#> Regime 3
#> 
#> 
#> Autoregressive coefficients:
#>                  Bedon LaPlata
#> (Intercept)     734.43  723.54
#> Bedon.lag(1)    549.53  794.86
#> LaPlata.lag(1)  796.68  948.21
#> Bedon.lag(2)    792.12  920.77
#> LaPlata.lag(2) 1124.79 1112.66
#> Bedon.lag(3)    928.39 1047.37
#> LaPlata.lag(3) 1007.79  906.54
#> Bedon.lag(4)    971.52 1052.25
#> LaPlata.lag(4)  910.29 1024.75
#> Bedon.lag(5)    845.09 1001.17
#> LaPlata.lag(5)  930.10 1147.23
#> 
#> 
#> Scale parameter:
#>          Bedon LaPlata
#> Bedon   1151.6  1289.9
#> LaPlata 1289.9  1137.8

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=1000, n.sim=2000,
             n.thin=2, dist="Slash")
effectiveSize_TAR(fit3)
#> Thresholds:
#> Threshold.1 
#>      42.472 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                      Jokulsa Vatnsdalsa
#> (Intercept)           318.89     538.63
#> Jokulsa.lag( 1)       229.61     456.37
#> Vatnsdalsa.lag( 1)    770.58     532.25
#> Jokulsa.lag( 2)       577.16     766.01
#> Vatnsdalsa.lag( 2)    504.73     563.19
#> Jokulsa.lag( 3)       406.68     687.18
#> Vatnsdalsa.lag( 3)    776.10     771.20
#> Jokulsa.lag( 4)       563.71    1022.66
#> Vatnsdalsa.lag( 4)    895.44     781.37
#> Jokulsa.lag( 5)       450.48    1057.43
#> Vatnsdalsa.lag( 5)    945.88    1172.58
#> Jokulsa.lag( 6)       441.39     840.33
#> Vatnsdalsa.lag( 6)   1175.21     769.45
#> Jokulsa.lag( 7)       929.38     932.16
#> Vatnsdalsa.lag( 7)   1435.50    1052.56
#> Jokulsa.lag( 8)       661.46    1072.00
#> Vatnsdalsa.lag( 8)   1526.12    1610.98
#> Jokulsa.lag( 9)       592.55     581.69
#> Vatnsdalsa.lag( 9)    637.04    1053.56
#> Jokulsa.lag(10)       973.73     615.43
#> Vatnsdalsa.lag(10)   1275.21    1013.70
#> Jokulsa.lag(11)      1158.34    1352.54
#> Vatnsdalsa.lag(11)   1396.29     971.21
#> Jokulsa.lag(12)      1175.44    1311.33
#> Vatnsdalsa.lag(12)   1710.23    1651.76
#> Jokulsa.lag(13)       594.89     961.94
#> Vatnsdalsa.lag(13)   1616.64    1040.58
#> Jokulsa.lag(14)      1003.25    1357.74
#> Vatnsdalsa.lag(14)   1241.84    1148.28
#> Jokulsa.lag(15)       375.27     623.18
#> Vatnsdalsa.lag(15)    779.91     890.91
#> Precipitation.lag(1)  960.48    1146.08
#> Precipitation.lag(2) 1000.09     892.62
#> Precipitation.lag(3)  887.45     717.24
#> Precipitation.lag(4) 1327.73    1040.13
#> Temperature.lag(1)   1195.31     940.66
#> Temperature.lag(2)   1157.62    1044.35
#> 
#> 
#> Scale parameter:
#>            Jokulsa Vatnsdalsa
#> Jokulsa     132.11     264.94
#> Vatnsdalsa  264.94     139.56
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                      Jokulsa Vatnsdalsa
#> (Intercept)           842.71     584.62
#> Jokulsa.lag( 1)       517.25    1125.97
#> Vatnsdalsa.lag( 1)    598.86     572.75
#> Jokulsa.lag( 2)       431.82     939.29
#> Vatnsdalsa.lag( 2)    478.15     551.35
#> Jokulsa.lag( 3)       533.33     651.83
#> Vatnsdalsa.lag( 3)    486.47     666.69
#> Jokulsa.lag( 4)       930.25    1392.08
#> Vatnsdalsa.lag( 4)    837.70     357.16
#> Jokulsa.lag( 5)       771.17     699.17
#> Vatnsdalsa.lag( 5)    416.99     356.45
#> Jokulsa.lag( 6)       860.16    1075.22
#> Vatnsdalsa.lag( 6)    476.38     253.87
#> Jokulsa.lag( 7)      1465.42    1136.41
#> Vatnsdalsa.lag( 7)    553.80     358.01
#> Jokulsa.lag( 8)      1158.40    1330.90
#> Vatnsdalsa.lag( 8)    678.50     508.73
#> Jokulsa.lag( 9)      1150.71     984.02
#> Vatnsdalsa.lag( 9)    742.46     324.52
#> Jokulsa.lag(10)      1059.66    1177.76
#> Vatnsdalsa.lag(10)    318.95     348.15
#> Jokulsa.lag(11)      1082.10    1315.99
#> Vatnsdalsa.lag(11)    333.03     443.15
#> Jokulsa.lag(12)      1226.69    1029.11
#> Vatnsdalsa.lag(12)    646.38     542.42
#> Jokulsa.lag(13)       761.69    1246.14
#> Vatnsdalsa.lag(13)    647.72     553.76
#> Jokulsa.lag(14)       666.70    1133.20
#> Vatnsdalsa.lag(14)    615.22     502.24
#> Jokulsa.lag(15)       922.29    1129.44
#> Vatnsdalsa.lag(15)    781.75     485.63
#> Precipitation.lag(1) 1122.06    1236.44
#> Precipitation.lag(2)  617.82     776.59
#> Precipitation.lag(3)  876.74     660.00
#> Precipitation.lag(4) 1162.44     808.55
#> Temperature.lag(1)   1306.18    1256.52
#> Temperature.lag(2)    982.50    1102.33
#> 
#> 
#> Scale parameter:
#>            Jokulsa Vatnsdalsa
#> Jokulsa     178.03     553.43
#> Vatnsdalsa  553.43     142.80
#> 
#> 
#> Extra parameter:
#>     nu 
#> 151.65 

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=1000,
             n.sim=2000, n.thin=2, dist="Student-t")
effectiveSize_TAR(fit4)
#> Thresholds:
#> Threshold.1 
#>      7.2007 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                CCR
#> (Intercept) 1465.9
#> CCR.lag(1)  1352.4
#> CCR.lag(2)  1160.9
#> CCR.lag(3)  1066.2
#> dVIX.lag(1) 1201.3
#> dVIX.lag(2) 1168.4
#> dVIX.lag(3)  903.3
#> 
#> 
#> Scale parameter:
#>        CCR
#> CCR 166.93
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                CCR
#> (Intercept) 139.74
#> CCR.lag(1)  230.99
#> CCR.lag(2)  648.13
#> CCR.lag(3)  424.03
#> dVIX.lag(1) 154.44
#> dVIX.lag(2) 738.88
#> dVIX.lag(3) 656.37
#> 
#> 
#> Scale parameter:
#>       CCR
#> CCR 26.84
#> 
#> 
#> Extra parameter:
#>     nu 
#> 286.66 

# }

```
