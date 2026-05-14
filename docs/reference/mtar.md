# Bayesian estimation of a multivariate Threshold Autoregressive (TAR) model.

This function implements a Gibbs sampling algorithm to generate draws
from the posterior distribution of the parameters of a multivariate
Threshold Autoregressive (TAR) model, including special cases such as
SETAR and VAR models. The approach accommodates a wide range of noise
process distributions, including Gaussian, Student-\\t\\, Slash,
symmetric hyperbolic, contaminated normal, Laplace, skew-normal, and
skew-Student-\\t\\.

## Usage

``` r
mtar(
  formula,
  data,
  subset,
  Intercept = TRUE,
  trend = c("none", "linear", "quadratic"),
  nseason = NULL,
  ars = ars(),
  row.names,
  dist = c("Gaussian", "Student-t", "Hyperbolic", "Laplace", "Slash",
    "Contaminated normal", "Skew-Student-t", "Skew-normal"),
  prior = list(),
  n.sim = 500,
  n.burnin = 100,
  n.thin = 1,
  ssvs = FALSE,
  setar = NULL,
  progress = TRUE,
  ...
)
```

## Arguments

- formula:

  A three-part expression of class `Formula` describing the TAR model to
  be fitted. The first part specifies the variables in the multivariate
  output series, the second part defines the threshold series, and the
  third part specifies the variables in the multivariate exogenous
  series.

- data:

  A data frame containing the variables in the model. If not found in
  `data`, the variables are taken from `environment(formula)`, typically
  the environment from which
  [`mtar_grid()`](https://lhvanegasp.github.io/mtarm/reference/mtar_grid.md)
  is called.

- subset:

  An optional vector specifying a subset of observations to be used in
  the fitting process.

- Intercept:

  An optional logical indicating whether an intercept should be included
  within each regime.

- trend:

  An optional character string specifying the degree of deterministic
  time trend to be included in each regime. Available options are
  `"linear"`, `"quadratic"`, and `"none"`. By default, `trend` is set to
  `"none"`.

- nseason:

  An optional integer, greater than or equal to 2, specifying the number
  of seasonal periods. When provided, `nseason - 1` seasonal dummy
  variables are added to the regressors within each regime. By default,
  `nseason` is set to `NULL`, thereby indicating that the TAR model has
  no seasonal effects.

- ars:

  A list defining the autoregressive structure of the model. It contains
  four components: the number of regimes (`nregim`), the autoregressive
  order within each regime (`p`), and the maximum lags for the exogenous
  (`q`) and threshold (`d`) series in each regime. The object can be
  validated using the helper function
  [`ars()`](https://lhvanegasp.github.io/mtarm/reference/ars.md).

- row.names:

  An optional variable in `data` labelling the time points corresponding
  to each row of the data set.

- dist:

  A character string specifying the multivariate distributions used to
  model the noise process. Available options are `"Gaussian"`,
  `"Student-t"`, `"Slash"`, `"Hyperbolic"`, `"Laplace"`,
  `"Contaminated normal"`, `"Skew-normal"`, and `"Skew-Student-t"`. By
  default, `dist` is set to `"Gaussian"`.

- prior:

  An optional list specifying the hyperparameter values that define the
  prior distribution. This list can be validated using the
  [`priors()`](https://lhvanegasp.github.io/mtarm/reference/priors.md)
  function. By default, `prior` is set to an empty list, thereby
  indicating that the hyperparameter values should be set so that a
  non-informative prior distribution is obtained.

- n.sim:

  An optional positive integer specifying the number of simulation
  iterations after the burn-in period. By default, `n.sim` is set to
  `500`.

- n.burnin:

  An optional positive integer specifying the number of burn-in
  iterations. By default, `n.burnin` is set to `100`.

- n.thin:

  An optional positive integer specifying the thinning interval. By
  default, `n.thin` is set to `1`.

- ssvs:

  An optional logical indicating whether the Stochastic Search Variable
  Selection (SSVS) procedure should be applied to identify relevant lags
  of the output, exogenous, and threshold series. By default, `ssvs` is
  set to `FALSE`.

- setar:

  An optional positive integer indicating the component of the output
  series used as the threshold variable. By default, `setar` is set to
  `NULL`, indicating that the fitted model is not a SETAR model.

- progress:

  An optional logical indicating whether a progress bar should be
  displayed during execution. By default, `progress` is set to `TRUE`.

- ...:

  further arguments passed to or from other methods.

## Value

an object of class *mtar* in which the main results of the model fitted
to the data are stored, i.e., a list with components including

|  |  |
|----|----|
| `chains` | list with several arrays, which store the values of each model parameter in each iteration of the simulation, |
|  |  |
| `n.sim` | number of iterations of the simulation after the burn-in period, |
|  |  |
| `n.burnin` | number of burn-in iterations in the simulation, |
|  |  |
| `n.thin` | thinning interval in the simulation, |
|  |  |
| `ars` | list composed of four objects, namely: `nregim`, `p`, `q` and `d`, each of which corresponds to a vector of non-negative integers with as many elements as there are regimes in the fitted TAR model, |
|  |  |
| `dist` | name of the multivariate distribution used to describe the behavior of the noise process, |
|  |  |
| `threshold.series` | vector with the values of the threshold series, |
|  |  |
| `output.series` | matrix with the values of the output series, |
|  |  |
| `exogenous.series` | matrix with the values of the exogenous series, |
|  |  |
| `Intercept` | If `TRUE`, then the model included an intercept term in each regime, |
|  |  |
| `trend` | the degree of the deterministic time trend, if any, |
|  |  |
| `nseason` | the number of seasonal periods, if any, |
|  |  |
| `formula` | the formula, |
|  |  |
| `call` | the original function call. |

## References

Nieto, F.H. (2005) Modeling Bivariate Threshold Autoregressive Processes
in the Presence of Missing Data. Communications in Statistics - Theory
and Methods, 34, 905-930.

Romero, L.V. and Calderon, S.A. (2021) Bayesian estimation of a
multivariate TAR model when the noise process follows a Student-t
distribution. Communications in Statistics - Theory and Methods, 50,
2508-2530.

Calderon, S.A. and Nieto, F.H. (2017) Bayesian analysis of multivariate
threshold autoregressive models with missing data. Communications in
Statistics - Theory and Methods, 46, 296-318.

Vanegas, L.H. and Calderón, S.A. and Rondón, L.M. (2025) Bayesian
estimation of a multivariate tar model when the noise process
distribution belongs to the class of gaussian variance mixtures.
International Journal of Forecasting.

## See also

[DIC](https://lhvanegasp.github.io/mtarm/reference/DIC.md),
[WAIC](https://lhvanegasp.github.io/mtarm/reference/WAIC.md)

## Examples

``` r
# \donttest{
###### Example 1: Returns of the closing prices of three financial indexes
data(returns)
fit1 <- mtar(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
             subset={Date<="2015-12-07"}, dist="Student-t",
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=100, n.sim=200,
             n.thin=2)
summary(fit1)
#> 
#> 
#> Sample size          :1427 time points (2010-02-04 to 2015-12-07)
#> 
#> Output Series        :COLCAP    |    BOVESPA
#> 
#> Threshold Series     :SP500 with a estimated delay equal to 0
#> 
#> Error Distribution   :Student-t
#> 
#> Number of regimes    :3
#> 
#> Deterministics       :Intercept  
#> 
#> Autoregressive orders:1, 1, 2
#> 
#> 
#> 
#> Thresholds (Mean, HDI.Lower, HDI.Upper)
#>                                                                  
#> Regime 1    (-Inf,-0.00152]    (-Inf,-0.00204]    (-Inf,-0.00125]
#> Regime 2 (-0.00152,0.00892] (-0.00204,0.00686] (-0.00125,0.00958]
#> Regime 3      (0.00892,Inf)      (0.00686,Inf)      (0.00958,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)    -0.00302     1e-05  -0.00394  -0.00230    |    -0.00754
#> COLCAP.lag(1)   0.13594     1e-02   0.04049   0.22641    |     0.01290
#> BOVESPA.lag(1)  0.07936     1e-02   0.02013   0.13868    |     0.00778
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001  -0.00870  -0.00645
#> COLCAP.lag(1)    0.87000  -0.11076   0.15017
#> BOVESPA.lag(1)   0.94000  -0.06999   0.10239
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   6e-05 0.00003    .  5e-05 0.00002    .  7e-05 0.00004
#> BOVESPA  3e-05 0.00013    .  2e-05 0.00011    .  4e-05 0.00015
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                   Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean  2(1-PD) 
#> (Intercept)    0.00052     6e-02   0.00009   0.00113    |     0.00093      0.04
#> COLCAP.lag(1)  0.06399     2e-02   0.01071   0.12243    |     0.04267      0.34
#> BOVESPA.lag(1) 0.08466     1e-05   0.04137   0.12116    |    -0.04105      0.12
#>                HDI.Lower HDI.Upper
#> (Intercept)      0.00012   0.00167
#> COLCAP.lag(1)   -0.04113   0.12167
#> BOVESPA.lag(1)  -0.08902   0.00959
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   4e-05   1e-05    .  4e-05   1e-05    .  5e-05   2e-05
#> BOVESPA  1e-05   8e-05    .  1e-05   7e-05    .  2e-05   9e-05
#> 
#> 
#> Regime3:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)     0.00533   0.00001   0.00382   0.00661    |     0.01242
#> COLCAP.lag(1)   0.05001   0.45000  -0.05055   0.17135    |     0.14672
#> BOVESPA.lag(1)  0.05843   0.19000  -0.01922   0.15954    |    -0.12672
#> COLCAP.lag(2)   0.10214   0.08000  -0.00957   0.20267    |    -0.02289
#> BOVESPA.lag(2) -0.09424   0.01000  -0.18375  -0.02662    |    -0.08884
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001   0.00986   0.01472
#> COLCAP.lag(1)    0.12000  -0.03675   0.33298
#> BOVESPA.lag(1)   0.10000  -0.28116   0.00284
#> COLCAP.lag(2)    0.80000  -0.21772   0.14691
#> BOVESPA.lag(2)   0.19000  -0.22615   0.02050
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   5e-05 0.00002    .  4e-05   1e-05    .  7e-05 0.00004
#> BOVESPA  2e-05 0.00013    .  1e-05   1e-04    .  4e-05 0.00016
#> 
#> 
#> Extra parameter
#>                   Mean  2(1-PD)  HDI.Lower HDI.Upper
#> nu             5.82239      .      4.64972   6.78059
#> 
#> 
DIC(fit1)
#>           DIC
#> fit1 -18243.3
WAIC(fit1)
#>           WAIC
#> fit1 -18210.34

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=100, n.sim=200, n.thin=2)
summary(fit2)
#> 
#> 
#> Sample size          :1135 time points (2006-01-06 to 2009-02-13)
#> 
#> Output Series        :Bedon    |    LaPlata
#> 
#> Threshold Series     :Rainfall with a estimated delay equal to 0
#> 
#> Error Distribution   :Laplace
#> 
#> Number of regimes    :3
#> 
#> Deterministics       :Intercept  
#> 
#> Autoregressive orders:5 in each regime
#> 
#> 
#> 
#> Thresholds (Mean, HDI.Lower, HDI.Upper)
#>                                                        
#> Regime 1     (-Inf,3.03818] (-Inf,3]     (-Inf,3.14866]
#> Regime 2 (3.03818,10.00933]   (3,10] (3.14866,10.01636]
#> Regime 3     (10.00933,Inf) (10,Inf)     (10.01636,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)     1.32209   0.00001   1.05594   1.51770    |     3.40013
#> Bedon.lag(1)    0.55870   0.00001   0.48296   0.63730    |     0.14191
#> LaPlata.lag(1)  0.04689   0.00001   0.02065   0.07072    |     0.64323
#> Bedon.lag(2)    0.05549   0.17000  -0.01873   0.11602    |    -0.04758
#> LaPlata.lag(2) -0.02217   0.04000  -0.04787  -0.00255    |    -0.07636
#> Bedon.lag(3)    0.02227   0.36000  -0.03342   0.07743    |     0.02332
#> LaPlata.lag(3)  0.00560   0.56000  -0.01657   0.02108    |     0.07059
#> Bedon.lag(4)    0.03506   0.21000  -0.01785   0.09806    |    -0.08161
#> LaPlata.lag(4) -0.01592   0.05000  -0.02977   0.00143    |     0.00664
#> Bedon.lag(5)    0.08702   0.00001   0.03774   0.14396    |     0.15150
#> LaPlata.lag(5) -0.00767   0.27000  -0.02053   0.00412    |     0.02200
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001   2.81289   3.97612
#> Bedon.lag(1)     0.19000  -0.06874   0.32894
#> LaPlata.lag(1)   0.00001   0.55967   0.71816
#> Bedon.lag(2)     0.55000  -0.19029   0.15385
#> LaPlata.lag(2)   0.03000  -0.13943  -0.01117
#> Bedon.lag(3)     0.72000  -0.12503   0.17047
#> LaPlata.lag(3)   0.02000   0.02766   0.12103
#> Bedon.lag(4)     0.28000  -0.24015   0.06965
#> LaPlata.lag(4)   0.81000  -0.04849   0.05180
#> Bedon.lag(5)     0.02000   0.04656   0.29603
#> LaPlata.lag(5)   0.29000  -0.01891   0.05739
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>           Bedon LaPlata        Bedon LaPlata        Bedon LaPlata
#> Bedon   0.32964 0.37489    . 0.27505 0.26704    . 0.38578 0.47842
#> LaPlata 0.37489 2.35818    . 0.26704 1.89033    . 0.47842 2.77670
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)     2.26994   0.00001   1.50592   3.03276    |     7.18822
#> Bedon.lag(1)    0.58981   0.00001   0.51279   0.66750    |     0.14703
#> LaPlata.lag(1)  0.01974   0.13000  -0.00503   0.04347    |     0.52465
#> Bedon.lag(2)    0.08305   0.23000  -0.04822   0.21313    |    -0.01196
#> LaPlata.lag(2) -0.01563   0.39000  -0.05552   0.01647    |     0.03616
#> Bedon.lag(3)   -0.02530   0.68000  -0.11356   0.08146    |    -0.06016
#> LaPlata.lag(3) -0.01119   0.40000  -0.04366   0.01430    |     0.03719
#> Bedon.lag(4)    0.09374   0.12000  -0.01177   0.21184    |     0.23011
#> LaPlata.lag(4)  0.00813   0.55000  -0.02252   0.03452    |    -0.04519
#> Bedon.lag(5)    0.03147   0.40000  -0.04926   0.10812    |    -0.26456
#> LaPlata.lag(5)  0.00345   0.77000  -0.02208   0.02892    |     0.11554
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001   5.45945   9.29524
#> Bedon.lag(1)     0.21000  -0.01996   0.37878
#> LaPlata.lag(1)   0.00001   0.46118   0.59968
#> Bedon.lag(2)     0.93000  -0.26299   0.22335
#> LaPlata.lag(2)   0.33000  -0.05000   0.09806
#> Bedon.lag(3)     0.57000  -0.28721   0.17612
#> LaPlata.lag(3)   0.31000  -0.02712   0.10755
#> Bedon.lag(4)     0.10000  -0.02083   0.51763
#> LaPlata.lag(4)   0.37000  -0.12449   0.04898
#> Bedon.lag(5)     0.01000  -0.43594  -0.01945
#> LaPlata.lag(5)   0.00001   0.03152   0.18364
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>           Bedon LaPlata        Bedon LaPlata        Bedon LaPlata
#> Bedon   1.09098 1.31754    . 0.85870 0.92642    . 1.27424 1.65052
#> LaPlata 1.31754 6.47594    . 0.92642 5.18293    . 1.65052 7.68626
#> 
#> 
#> Regime3:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)     5.65600   0.00001   4.26918   7.41032    |    17.49346
#> Bedon.lag(1)    0.46937   0.00001   0.30395   0.64870    |     0.51094
#> LaPlata.lag(1)  0.04609   0.01000   0.01131   0.08032    |     0.33986
#> Bedon.lag(2)    0.07206   0.39000  -0.07922   0.21348    |    -0.65192
#> LaPlata.lag(2) -0.00026   0.99000  -0.03182   0.03121    |     0.13463
#> Bedon.lag(3)   -0.09275   0.17000  -0.21070   0.03245    |    -0.53785
#> LaPlata.lag(3)  0.03356   0.09000  -0.00704   0.06357    |     0.29271
#> Bedon.lag(4)    0.00965   0.86000  -0.14820   0.12969    |     0.01497
#> LaPlata.lag(4) -0.00266   0.90000  -0.03985   0.03601    |    -0.02605
#> Bedon.lag(5)    0.17944   0.01000   0.02972   0.30166    |     0.30934
#> LaPlata.lag(5) -0.01150   0.52000  -0.05409   0.02270    |     0.06851
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001  11.84501  23.30991
#> Bedon.lag(1)     0.05000   0.00780   0.98778
#> LaPlata.lag(1)   0.00001   0.20504   0.44266
#> Bedon.lag(2)     0.02000  -1.13823  -0.08443
#> LaPlata.lag(2)   0.04000   0.02108   0.27133
#> Bedon.lag(3)     0.02000  -0.93196  -0.06657
#> LaPlata.lag(3)   0.00001   0.15843   0.46897
#> Bedon.lag(4)     1.00000  -0.44475   0.49058
#> LaPlata.lag(4)   0.77000  -0.19314   0.09854
#> Bedon.lag(5)     0.30000  -0.14752   0.80064
#> LaPlata.lag(5)   0.35000  -0.06987   0.22833
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>           Bedon  LaPlata        Bedon  LaPlata        Bedon  LaPlata
#> Bedon   2.83482  7.31792    . 2.24700  5.38749    . 3.41313  9.20141
#> LaPlata 7.31792 43.06954    . 5.38749 34.07359    . 9.20141 52.42954
#> 
#> 
DIC(fit2)
#>           DIC
#> fit2 12932.92
WAIC(fit2)
#>          WAIC
#> fit2 12974.95

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=100, n.sim=200,
             n.thin=2, dist="Slash")
summary(fit3)
#> 
#> 
#> Sample size          :1026 time points (1972-01-16 to 1974-11-06)
#> 
#> Output Series        :Jokulsa    |    Vatnsdalsa
#> 
#> Threshold Series (TS):Temperature with a estimated delay equal to 0
#> 
#> Exogenous Series (ES):Precipitation
#> 
#> Error Distribution   :Slash
#> 
#> Number of regimes    :2
#> 
#> Deterministics       :Intercept  
#> 
#> Autoregressive orders:15 in each regime
#> 
#> Maximum lags for ES  :4 in each regime
#> 
#> Maximum lags for TS  :2 in each regime
#> 
#> 
#> 
#> Thresholds (Mean, HDI.Lower, HDI.Upper)
#>                                                      
#> Regime 1 (-Inf,0.75299] (-Inf,0.60117] (-Inf,1.06955]
#> Regime 2  (0.75299,Inf)  (0.60117,Inf)  (1.06955,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                          Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)           3.36671   0.00001   2.67869   3.93514    |     0.71384
#> Jokulsa.lag( 1)       0.87366   0.00001   0.80282   0.92918    |    -0.05193
#> Vatnsdalsa.lag( 1)    0.23973   0.00001   0.12442   0.35384    |     1.16746
#> Jokulsa.lag( 2)      -0.05686   0.01000  -0.09865  -0.00505    |     0.04642
#> Vatnsdalsa.lag( 2)   -0.22799   0.00001  -0.35510  -0.08252    |    -0.31532
#> Jokulsa.lag( 3)       0.00135   0.88000  -0.03606   0.04026    |    -0.02760
#> Vatnsdalsa.lag( 3)    0.07228   0.14000  -0.02673   0.17081    |     0.06451
#> Jokulsa.lag( 4)      -0.00490   0.86000  -0.05023   0.03581    |     0.01289
#> Vatnsdalsa.lag( 4)   -0.00872   0.95000  -0.09689   0.06243    |    -0.02257
#> Jokulsa.lag( 5)       0.00123   0.88000  -0.05450   0.04558    |     0.00842
#> Vatnsdalsa.lag( 5)   -0.03229   0.36000  -0.10582   0.02767    |    -0.00523
#> Jokulsa.lag( 6)       0.01509   0.63000  -0.03523   0.07363    |     0.00175
#> Vatnsdalsa.lag( 6)   -0.02521   0.53000  -0.09997   0.05367    |    -0.01493
#> Jokulsa.lag( 7)       0.00843   0.77000  -0.04266   0.05585    |     0.00268
#> Vatnsdalsa.lag( 7)    0.02163   0.43000  -0.04762   0.08974    |     0.01522
#> Jokulsa.lag( 8)      -0.00184   0.97000  -0.05488   0.03634    |    -0.01531
#> Vatnsdalsa.lag( 8)   -0.00672   0.77000  -0.05379   0.06063    |     0.01035
#> Jokulsa.lag( 9)       0.00022   0.94000  -0.03633   0.04632    |     0.02187
#> Vatnsdalsa.lag( 9)   -0.01433   0.62000  -0.07158   0.05909    |    -0.00076
#> Jokulsa.lag(10)       0.01806   0.39000  -0.02265   0.05054    |    -0.01643
#> Vatnsdalsa.lag(10)    0.02586   0.42000  -0.02664   0.08515    |     0.01338
#> Jokulsa.lag(11)      -0.01092   0.49000  -0.04193   0.02038    |     0.01138
#> Vatnsdalsa.lag(11)   -0.01085   0.68000  -0.06990   0.04984    |    -0.00184
#> Jokulsa.lag(12)       0.00731   0.53000  -0.02163   0.03881    |    -0.01228
#> Vatnsdalsa.lag(12)    0.00340   0.90000  -0.04638   0.04807    |    -0.00378
#> Jokulsa.lag(13)      -0.01081   0.59000  -0.04189   0.02747    |     0.00777
#> Vatnsdalsa.lag(13)   -0.01618   0.48000  -0.06200   0.04283    |    -0.02216
#> Jokulsa.lag(14)       0.00047   0.97000  -0.03014   0.03262    |    -0.00882
#> Vatnsdalsa.lag(14)    0.00896   0.73000  -0.04551   0.05523    |     0.03871
#> Jokulsa.lag(15)       0.01925   0.18000  -0.00947   0.04323    |     0.00489
#> Vatnsdalsa.lag(15)   -0.01469   0.45000  -0.05783   0.02394    |     0.00256
#> Precipitation.lag(1)  0.00454   0.61000  -0.01247   0.01995    |     0.00304
#> Precipitation.lag(2)  0.00610   0.39000  -0.00868   0.02065    |     0.00169
#> Precipitation.lag(3) -0.01181   0.08000  -0.02241   0.00063    |    -0.00388
#> Precipitation.lag(4)  0.01906   0.01000   0.00486   0.02831    |     0.00517
#> Temperature.lag(1)    0.01486   0.16000  -0.00342   0.03453    |    -0.00032
#> Temperature.lag(2)   -0.03208   0.00001  -0.05369  -0.01316    |    -0.01122
#>                       2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)            0.00001   0.35476   1.08907
#> Jokulsa.lag( 1)        0.00001  -0.08197  -0.01558
#> Vatnsdalsa.lag( 1)     0.00001   1.07855   1.23991
#> Jokulsa.lag( 2)        0.01000   0.01788   0.07691
#> Vatnsdalsa.lag( 2)     0.00001  -0.41099  -0.21871
#> Jokulsa.lag( 3)        0.04000  -0.04998   0.00027
#> Vatnsdalsa.lag( 3)     0.10000  -0.01092   0.14469
#> Jokulsa.lag( 4)        0.32000  -0.00934   0.03569
#> Vatnsdalsa.lag( 4)     0.60000  -0.09424   0.03454
#> Jokulsa.lag( 5)        0.63000  -0.01953   0.03350
#> Vatnsdalsa.lag( 5)     0.85000  -0.04906   0.03102
#> Jokulsa.lag( 6)        0.87000  -0.03392   0.02576
#> Vatnsdalsa.lag( 6)     0.55000  -0.06162   0.03655
#> Jokulsa.lag( 7)        0.88000  -0.02342   0.03698
#> Vatnsdalsa.lag( 7)     0.46000  -0.02567   0.05422
#> Jokulsa.lag( 8)        0.21000  -0.04069   0.00741
#> Vatnsdalsa.lag( 8)     0.61000  -0.02406   0.04363
#> Jokulsa.lag( 9)        0.10000  -0.00470   0.04799
#> Vatnsdalsa.lag( 9)     0.99000  -0.03436   0.03887
#> Jokulsa.lag(10)        0.13000  -0.03758   0.00561
#> Vatnsdalsa.lag(10)     0.47000  -0.02332   0.05400
#> Jokulsa.lag(11)        0.16000  -0.00265   0.03421
#> Vatnsdalsa.lag(11)     0.87000  -0.03986   0.03128
#> Jokulsa.lag(12)        0.21000  -0.03002   0.00835
#> Vatnsdalsa.lag(12)     0.77000  -0.03976   0.02269
#> Jokulsa.lag(13)        0.47000  -0.01056   0.02519
#> Vatnsdalsa.lag(13)     0.26000  -0.05937   0.01634
#> Jokulsa.lag(14)        0.33000  -0.02698   0.00493
#> Vatnsdalsa.lag(14)     0.02000   0.00352   0.07542
#> Jokulsa.lag(15)        0.57000  -0.00919   0.01785
#> Vatnsdalsa.lag(15)     0.87000  -0.03224   0.02974
#> Precipitation.lag(1)   0.58000  -0.00800   0.01300
#> Precipitation.lag(2)   0.70000  -0.00570   0.01021
#> Precipitation.lag(3)   0.34000  -0.01170   0.00369
#> Precipitation.lag(4)   0.23000  -0.00283   0.01408
#> Temperature.lag(1)     0.89000  -0.01299   0.01132
#> Temperature.lag(2)     0.10000  -0.02618   0.00055
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>            Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa
#> Jokulsa    0.06432    0.01026    . 0.04639    0.00543    . 0.07974    0.01652
#> Vatnsdalsa 0.01026    0.02713    . 0.00543    0.01977    . 0.01652    0.03566
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                          Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)          -0.23993   0.68000  -1.58132   1.14630    |     0.50471
#> Jokulsa.lag( 1)       1.01924   0.00001   0.93464   1.08523    |    -0.00450
#> Vatnsdalsa.lag( 1)    0.90531   0.00001   0.55197   1.29213    |     1.19336
#> Jokulsa.lag( 2)      -0.15656   0.01000  -0.28493  -0.02682    |     0.01487
#> Vatnsdalsa.lag( 2)   -0.46779   0.10000  -1.02082   0.07178    |    -0.32620
#> Jokulsa.lag( 3)       0.00303   0.99000  -0.10316   0.10983    |    -0.01568
#> Vatnsdalsa.lag( 3)    0.06685   0.77000  -0.56479   0.54546    |     0.16502
#> Jokulsa.lag( 4)      -0.07349   0.07000  -0.14528   0.03519    |     0.00606
#> Vatnsdalsa.lag( 4)   -0.16071   0.44000  -0.55856   0.18919    |    -0.08911
#> Jokulsa.lag( 5)       0.03773   0.37000  -0.03096   0.11767    |    -0.00422
#> Vatnsdalsa.lag( 5)    0.17123   0.44000  -0.29472   0.61673    |    -0.01669
#> Jokulsa.lag( 6)      -0.04425   0.22000  -0.10553   0.01684    |     0.00438
#> Vatnsdalsa.lag( 6)   -0.13900   0.54000  -0.57298   0.28754    |     0.04836
#> Jokulsa.lag( 7)      -0.00332   0.94000  -0.05574   0.04108    |    -0.00596
#> Vatnsdalsa.lag( 7)    0.18870   0.40000  -0.24263   0.56881    |    -0.04991
#> Jokulsa.lag( 8)       0.02544   0.38000  -0.02157   0.07323    |     0.00383
#> Vatnsdalsa.lag( 8)   -0.25924   0.11000  -0.59942   0.04537    |    -0.07401
#> Jokulsa.lag( 9)       0.03581   0.23000  -0.03161   0.08976    |    -0.00325
#> Vatnsdalsa.lag( 9)    0.12580   0.57000  -0.18042   0.47747    |     0.11770
#> Jokulsa.lag(10)      -0.01793   0.64000  -0.09606   0.06502    |     0.00448
#> Vatnsdalsa.lag(10)   -0.04251   0.81000  -0.45637   0.31315    |    -0.07082
#> Jokulsa.lag(11)      -0.01510   0.72000  -0.09850   0.05960    |    -0.00749
#> Vatnsdalsa.lag(11)    0.08872   0.73000  -0.40354   0.56917    |     0.06228
#> Jokulsa.lag(12)       0.00576   0.87000  -0.06490   0.07046    |     0.01021
#> Vatnsdalsa.lag(12)    0.02546   1.00000  -0.42031   0.54815    |    -0.06706
#> Jokulsa.lag(13)       0.00097   0.98000  -0.07020   0.07278    |    -0.00686
#> Vatnsdalsa.lag(13)    0.24192   0.40000  -0.26259   0.66652    |     0.14783
#> Jokulsa.lag(14)      -0.01484   0.74000  -0.08408   0.06538    |    -0.00309
#> Vatnsdalsa.lag(14)    0.24432   0.19000  -0.10216   0.60406    |    -0.03042
#> Jokulsa.lag(15)       0.04947   0.04000   0.01419   0.10280    |     0.00269
#> Vatnsdalsa.lag(15)   -0.43494   0.00001  -0.68557  -0.17922    |    -0.04312
#> Precipitation.lag(1) -0.11670   0.00001  -0.18818  -0.03515    |    -0.00084
#> Precipitation.lag(2)  0.01597   0.83000  -0.08666   0.14361    |    -0.00609
#> Precipitation.lag(3)  0.04197   0.19000  -0.02346   0.11535    |     0.00547
#> Precipitation.lag(4)  0.02537   0.51000  -0.03824   0.09861    |     0.00518
#> Temperature.lag(1)    1.08361   0.00001   0.91657   1.30141    |     0.03373
#> Temperature.lag(2)   -0.54855   0.00001  -0.71188  -0.33085    |    -0.04131
#>                       2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)            0.00001   0.35250   0.68442
#> Jokulsa.lag( 1)        0.32000  -0.01204   0.00797
#> Vatnsdalsa.lag( 1)     0.00001   1.12254   1.24689
#> Jokulsa.lag( 2)        0.04000  -0.00034   0.02568
#> Vatnsdalsa.lag( 2)     0.00001  -0.41398  -0.25311
#> Jokulsa.lag( 3)        0.02000  -0.02807  -0.00294
#> Vatnsdalsa.lag( 3)     0.00001   0.08229   0.25031
#> Jokulsa.lag( 4)        0.30000  -0.00472   0.01629
#> Vatnsdalsa.lag( 4)     0.06000  -0.16365  -0.02013
#> Jokulsa.lag( 5)        0.41000  -0.01274   0.00689
#> Vatnsdalsa.lag( 5)     0.71000  -0.09868   0.08093
#> Jokulsa.lag( 6)        0.23000  -0.00399   0.01174
#> Vatnsdalsa.lag( 6)     0.35000  -0.04999   0.12532
#> Jokulsa.lag( 7)        0.14000  -0.01346   0.00135
#> Vatnsdalsa.lag( 7)     0.16000  -0.11740   0.01166
#> Jokulsa.lag( 8)        0.33000  -0.00344   0.00990
#> Vatnsdalsa.lag( 8)     0.04000  -0.13630   0.00055
#> Jokulsa.lag( 9)        0.47000  -0.01164   0.00442
#> Vatnsdalsa.lag( 9)     0.00001   0.03978   0.18979
#> Jokulsa.lag(10)        0.40000  -0.00779   0.01356
#> Vatnsdalsa.lag(10)     0.07000  -0.12590   0.00220
#> Jokulsa.lag(11)        0.15000  -0.01716   0.00373
#> Vatnsdalsa.lag(11)     0.09000   0.01006   0.13181
#> Jokulsa.lag(12)        0.05000  -0.00099   0.01837
#> Vatnsdalsa.lag(12)     0.01000  -0.11930  -0.00677
#> Jokulsa.lag(13)        0.17000  -0.01510   0.00220
#> Vatnsdalsa.lag(13)     0.00001   0.07777   0.20435
#> Jokulsa.lag(14)        0.49000  -0.01286   0.00471
#> Vatnsdalsa.lag(14)     0.35000  -0.10950   0.02354
#> Jokulsa.lag(15)        0.34000  -0.00395   0.00816
#> Vatnsdalsa.lag(15)     0.14000  -0.09290   0.00480
#> Precipitation.lag(1)   0.90000  -0.01102   0.01282
#> Precipitation.lag(2)   0.37000  -0.02135   0.00911
#> Precipitation.lag(3)   0.34000  -0.00469   0.01587
#> Precipitation.lag(4)   0.20000  -0.00265   0.01363
#> Temperature.lag(1)     0.04000   0.00265   0.06552
#> Temperature.lag(2)     0.00001  -0.07188  -0.01092
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>            Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa
#> Jokulsa    1.41842    0.04830    . 1.01213    0.02588    . 1.90647    0.07318
#> Vatnsdalsa 0.04830    0.02934    . 0.02588    0.01718    . 0.07318    0.03900
#> 
#> 
#> Extra parameter
#>                         Mean  2(1-PD)  HDI.Lower HDI.Upper
#> nu                   0.83577      .      0.75612   0.90766
#> 
#> 
DIC(fit3)
#>           DIC
#> fit3 7486.119
WAIC(fit3)
#>          WAIC
#> fit3 7691.645

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=100,
             n.sim=200, n.thin=2, dist="Student-t")
summary(fit4)
#> 
#> 
#> Sample size          :5317 time points (2005-01-10 to 2025-11-28)
#> 
#> Output Series        :CCR
#> 
#> Threshold Series (TS):dVIX with a estimated delay equal to 0
#> 
#> Error Distribution   :Student-t
#> 
#> Number of regimes    :2
#> 
#> Deterministics       :Intercept  
#> 
#> Autoregressive orders:3 in each regime
#> 
#> Maximum lags for TS  :3 in each regime
#> 
#> 
#> 
#> Thresholds (Mean, HDI.Lower, HDI.Upper)
#>                                                      
#> Regime 1 (-Inf,1.19593] (-Inf,1.15056] (-Inf,1.26059]
#> Regime 2  (1.19593,Inf)  (1.15056,Inf)  (1.26059,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                 Mean  2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)  0.09067   0.00001   0.06655   0.11184
#> CCR.lag(1)  -0.04874   0.00001  -0.08055  -0.01802
#> CCR.lag(2)  -0.03631   0.10000  -0.08224   0.00348
#> CCR.lag(3)  -0.02223   0.30000  -0.07030   0.02284
#> dVIX.lag(1) -0.03363   0.01000  -0.06036  -0.00783
#> dVIX.lag(2) -0.02068   0.11000  -0.04622   0.00329
#> dVIX.lag(3)  0.01715   0.05000  -0.00036   0.03080
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         CCR          CCR          CCR
#> CCR 0.34972    . 0.32421    . 0.37056
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                 Mean  2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)  0.09657      0.26  -0.06366   0.23483
#> CCR.lag(1)  -0.06781      0.17  -0.15716   0.03509
#> CCR.lag(2)  -0.02496      0.72  -0.20190   0.11530
#> CCR.lag(3)   0.04165      0.48  -0.07354   0.16204
#> dVIX.lag(1) -0.01247      0.82  -0.10145   0.09630
#> dVIX.lag(2)  0.00204      0.97  -0.07494   0.06685
#> dVIX.lag(3)  0.03658      0.16  -0.00982   0.08053
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         CCR          CCR          CCR
#> CCR 0.83209    . 0.70535    . 0.95972
#> 
#> 
#> Extra parameter
#>                Mean  2(1-PD)  HDI.Lower HDI.Upper
#> nu           2.3994      .       2.2204    2.5439
#> 
#> 
DIC(fit4)
#>           DIC
#> fit4 14939.16
WAIC(fit4)
#>          WAIC
#> fit4 14952.88
# }

```
