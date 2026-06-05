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
#>     0.84717     4.02627 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                 COLCAP BOVESPA
#> (Intercept)     1.1218  1.2128
#> COLCAP.lag(1)   4.4828 13.6557
#> BOVESPA.lag(1) 58.9096  4.4196
#> 
#> 
#> Scale parameter:
#>          COLCAP BOVESPA
#> COLCAP   6.0401  43.334
#> BOVESPA 43.3340  26.981
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                   COLCAP   BOVESPA
#> (Intercept)       5.1349    2.1494
#> COLCAP.lag(1)  1519.4574 1396.2732
#> BOVESPA.lag(1)  163.5625 1739.7830
#> 
#> 
#> Scale parameter:
#>          COLCAP BOVESPA
#> COLCAP  156.141  18.032
#> BOVESPA  18.032  39.752
#> 
#> 
#> Regime 3
#> 
#> 
#> Autoregressive coefficients:
#>                  COLCAP  BOVESPA
#> (Intercept)      21.874   14.667
#> COLCAP.lag(1)   989.006 1864.230
#> BOVESPA.lag(1)   44.539  158.761
#> COLCAP.lag(2)  1668.674 1488.340
#> BOVESPA.lag(2) 1072.583 1042.925
#> 
#> 
#> Scale parameter:
#>          COLCAP BOVESPA
#> COLCAP   462.62  1274.3
#> BOVESPA 1274.33  1086.8
#> 
#> 
#> Extra parameter:
#>     nu 
#> 165.69 

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=1000, n.sim=2000, n.thin=2)
effectiveSize_TAR(fit2)
#> Thresholds:
#> Threshold.1 Threshold.2 
#>        4.80      108.78 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                  Bedon LaPlata
#> (Intercept)    1138.99  971.22
#> Bedon.lag(1)    993.84  834.99
#> LaPlata.lag(1) 1147.99  851.63
#> Bedon.lag(2)    897.21  893.20
#> LaPlata.lag(2)  897.01  869.79
#> Bedon.lag(3)   1492.10 1190.43
#> LaPlata.lag(3)  915.32 1034.05
#> Bedon.lag(4)    959.00 1000.64
#> LaPlata.lag(4) 1020.62  759.98
#> Bedon.lag(5)    597.86 1016.20
#> LaPlata.lag(5)  943.82  724.75
#> 
#> 
#> Scale parameter:
#>          Bedon LaPlata
#> Bedon   1036.8  1331.0
#> LaPlata 1331.0  1070.5
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                  Bedon LaPlata
#> (Intercept)     737.95  694.61
#> Bedon.lag(1)    973.67  763.31
#> LaPlata.lag(1) 1198.49  968.96
#> Bedon.lag(2)    661.13 1147.67
#> LaPlata.lag(2)  738.13 1050.56
#> Bedon.lag(3)    611.41  997.93
#> LaPlata.lag(3)  821.61  841.68
#> Bedon.lag(4)    723.11  874.81
#> LaPlata.lag(4)  810.94  841.22
#> Bedon.lag(5)   1001.92 1039.61
#> LaPlata.lag(5) 1000.42  854.51
#> 
#> 
#> Scale parameter:
#>          Bedon LaPlata
#> Bedon   1219.3  1298.0
#> LaPlata 1298.0  1011.8
#> 
#> 
#> Regime 3
#> 
#> 
#> Autoregressive coefficients:
#>                 Bedon LaPlata
#> (Intercept)    823.85  900.61
#> Bedon.lag(1)   607.71  994.24
#> LaPlata.lag(1) 912.61  862.87
#> Bedon.lag(2)   734.82  940.74
#> LaPlata.lag(2) 938.03  952.75
#> Bedon.lag(3)   663.17 1146.92
#> LaPlata.lag(3) 916.65  844.58
#> Bedon.lag(4)   928.95  918.01
#> LaPlata.lag(4) 895.78  808.19
#> Bedon.lag(5)   821.92 1081.29
#> LaPlata.lag(5) 937.64 1082.19
#> 
#> 
#> Scale parameter:
#>          Bedon LaPlata
#> Bedon   1166.2  1243.7
#> LaPlata 1243.7  1028.6

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=1000, n.sim=2000,
             n.thin=2, dist="Slash")
effectiveSize_TAR(fit3)
#> Thresholds:
#> Threshold.1 
#>      198.82 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                      Jokulsa Vatnsdalsa
#> (Intercept)           280.82     514.35
#> Jokulsa.lag( 1)       264.16     447.84
#> Vatnsdalsa.lag( 1)    554.78     517.91
#> Jokulsa.lag( 2)       501.06     640.73
#> Vatnsdalsa.lag( 2)    453.42     427.77
#> Jokulsa.lag( 3)       737.44    1062.07
#> Vatnsdalsa.lag( 3)    822.63     637.86
#> Jokulsa.lag( 4)       524.47    1064.85
#> Vatnsdalsa.lag( 4)    774.09     658.89
#> Jokulsa.lag( 5)       445.33    1007.48
#> Vatnsdalsa.lag( 5)    971.07     931.70
#> Jokulsa.lag( 6)       453.75     724.53
#> Vatnsdalsa.lag( 6)    848.32    1491.14
#> Jokulsa.lag( 7)       848.79     867.64
#> Vatnsdalsa.lag( 7)   1253.98    1678.29
#> Jokulsa.lag( 8)       539.93    1016.78
#> Vatnsdalsa.lag( 8)   1392.85    1692.33
#> Jokulsa.lag( 9)       616.69     728.33
#> Vatnsdalsa.lag( 9)    832.94    1265.30
#> Jokulsa.lag(10)       966.89     921.15
#> Vatnsdalsa.lag(10)   1022.05    1140.16
#> Jokulsa.lag(11)      1170.37    1247.86
#> Vatnsdalsa.lag(11)   1214.23    1394.19
#> Jokulsa.lag(12)      1210.67     985.52
#> Vatnsdalsa.lag(12)   1579.42    1653.91
#> Jokulsa.lag(13)       591.23    1039.97
#> Vatnsdalsa.lag(13)   1375.49    1035.90
#> Jokulsa.lag(14)      1083.96    1089.33
#> Vatnsdalsa.lag(14)   1012.73    1234.03
#> Jokulsa.lag(15)       436.55     823.60
#> Vatnsdalsa.lag(15)   1044.13    1076.72
#> Precipitation.lag(1)  946.07    1239.61
#> Precipitation.lag(2) 1072.16    1183.20
#> Precipitation.lag(3) 1246.05    1105.55
#> Precipitation.lag(4) 1096.27    1134.13
#> Temperature.lag(1)   1074.28    1373.29
#> Temperature.lag(2)   1180.93    1112.54
#> 
#> 
#> Scale parameter:
#>            Jokulsa Vatnsdalsa
#> Jokulsa     185.22     372.15
#> Vatnsdalsa  372.15     186.16
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                      Jokulsa Vatnsdalsa
#> (Intercept)           964.69     775.15
#> Jokulsa.lag( 1)       618.38    1259.27
#> Vatnsdalsa.lag( 1)    536.07     683.67
#> Jokulsa.lag( 2)       444.75     613.29
#> Vatnsdalsa.lag( 2)    496.60     414.49
#> Jokulsa.lag( 3)       519.42     468.25
#> Vatnsdalsa.lag( 3)    439.61     397.54
#> Jokulsa.lag( 4)       963.37    1449.10
#> Vatnsdalsa.lag( 4)    903.13     224.84
#> Jokulsa.lag( 5)       637.80     544.97
#> Vatnsdalsa.lag( 5)    359.14     266.96
#> Jokulsa.lag( 6)       955.02     753.00
#> Vatnsdalsa.lag( 6)    515.57     284.83
#> Jokulsa.lag( 7)      1374.23    1347.74
#> Vatnsdalsa.lag( 7)    659.69     546.55
#> Jokulsa.lag( 8)      1353.76    1336.41
#> Vatnsdalsa.lag( 8)    664.87     492.96
#> Jokulsa.lag( 9)      1064.12     945.07
#> Vatnsdalsa.lag( 9)    729.63     357.15
#> Jokulsa.lag(10)       988.14    1039.86
#> Vatnsdalsa.lag(10)    220.51     207.14
#> Jokulsa.lag(11)      1087.91    1456.49
#> Vatnsdalsa.lag(11)    377.04     288.17
#> Jokulsa.lag(12)      1246.21    1558.94
#> Vatnsdalsa.lag(12)    521.19     534.82
#> Jokulsa.lag(13)       951.31    1305.53
#> Vatnsdalsa.lag(13)    486.75     422.51
#> Jokulsa.lag(14)       659.35    1012.15
#> Vatnsdalsa.lag(14)    557.75     462.44
#> Jokulsa.lag(15)       779.32     966.42
#> Vatnsdalsa.lag(15)    734.19     536.29
#> Precipitation.lag(1) 1274.21    1220.46
#> Precipitation.lag(2)  674.57     865.33
#> Precipitation.lag(3) 1036.42     659.75
#> Precipitation.lag(4)  808.54     699.31
#> Temperature.lag(1)   1331.03    1415.60
#> Temperature.lag(2)    889.16    1289.31
#> 
#> 
#> Scale parameter:
#>            Jokulsa Vatnsdalsa
#> Jokulsa     210.05     421.90
#> Vatnsdalsa  421.90     200.36
#> 
#> 
#> Extra parameter:
#>     nu 
#> 173.32 

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=1000,
             n.sim=2000, n.thin=2, dist="Student-t")
effectiveSize_TAR(fit4)
#> Thresholds:
#> Threshold.1 
#>      2.7021 
#> 
#> 
#> Regime 1
#> 
#> 
#> Autoregressive coefficients:
#>                CCR
#> (Intercept) 1200.1
#> CCR.lag(1)  1239.6
#> CCR.lag(2)  1170.5
#> CCR.lag(3)  1017.0
#> dVIX.lag(1) 1080.4
#> dVIX.lag(2) 1121.4
#> dVIX.lag(3) 1212.3
#> 
#> 
#> Scale parameter:
#>       CCR
#> CCR 118.7
#> 
#> 
#> Regime 2
#> 
#> 
#> Autoregressive coefficients:
#>                  CCR
#> (Intercept)  449.253
#> CCR.lag(1)   979.455
#> CCR.lag(2)   301.679
#> CCR.lag(3)  1127.826
#> dVIX.lag(1)   61.418
#> dVIX.lag(2) 1178.210
#> dVIX.lag(3)  147.493
#> 
#> 
#> Scale parameter:
#>        CCR
#> CCR 16.599
#> 
#> 
#> Extra parameter:
#>     nu 
#> 271.43 

# }

```
