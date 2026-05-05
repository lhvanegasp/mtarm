# Bayesian estimation of a multivariate Threshold Autoregressive (TAR) model.

This function implements a Gibbs sampling algorithm to draw samples from
the posterior distribution of the parameters of a multivariate Threshold
Autoregressive (TAR) model and its special cases as SETAR and VAR
models. The procedure accommodates a wide range of noise process
distributions, including Gaussian, Student-\\t\\, Slash, Symmetric
Hyperbolic, Contaminated normal, Laplace, Skew-normal, and
Skew-Student-\\t\\.

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
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=1000, n.sim=2000,
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
#> Thresholds (Mean, HDI_low, HDI_high)
#>                                                                  
#> Regime 1    (-Inf,-0.00632]    (-Inf,-0.00675]    (-Inf,-0.00515]
#> Regime 2 (-0.00632,0.01006] (-0.00675,0.00766] (-0.00515,0.01104]
#> Regime 3      (0.01006,Inf)      (0.00766,Inf)      (0.01104,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)    -0.00582   0.00001 -0.00716 -0.00454    |    -0.01198   0.00001
#> COLCAP.lag(1)   0.19945   0.01500  0.03838  0.33862    |    -0.07778   0.44100
#> BOVESPA.lag(1)  0.08901   0.07500 -0.00384  0.18230    |     0.04848   0.48000
#>                 HDI_low HDI_high
#> (Intercept)    -0.01380 -0.01025
#> COLCAP.lag(1)  -0.27638  0.12791
#> BOVESPA.lag(1) -0.08542  0.18492
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   7e-05 0.00004    .  6e-05 0.00002    .  9e-05 0.00006
#> BOVESPA  4e-05 0.00015    .  2e-05 0.00012    .  6e-05 0.00018
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                   Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)    0.00025   0.31900 -0.00023  0.00076    |    -0.00012     0.805
#> COLCAP.lag(1)  0.06824   0.02800  0.00692  0.12650    |     0.06535     0.110
#> BOVESPA.lag(1) 0.07848   0.00001  0.04391  0.11674    |    -0.04517     0.102
#>                 HDI_low HDI_high
#> (Intercept)    -0.00094  0.00066
#> COLCAP.lag(1)  -0.01508  0.14441
#> BOVESPA.lag(1) -0.10037  0.00693
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   4e-05   1e-05    .  4e-05   1e-05    .  5e-05   2e-05
#> BOVESPA  1e-05   9e-05    .  1e-05   8e-05    .  2e-05   1e-04
#> 
#> 
#> Regime3:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)     0.00631   0.00001  0.00420  0.00797    |     0.01440   0.00001
#> COLCAP.lag(1)   0.07935   0.27200 -0.05357  0.22234    |     0.15600   0.12600
#> BOVESPA.lag(1) -0.00454   0.93000 -0.13338  0.12069    |    -0.19440   0.02400
#> COLCAP.lag(2)   0.06576   0.31300 -0.06714  0.19769    |    -0.07022   0.47900
#> BOVESPA.lag(2) -0.06115   0.23900 -0.16038  0.03701    |    -0.03683   0.60000
#>                 HDI_low HDI_high
#> (Intercept)     0.01062  0.01742
#> COLCAP.lag(1)  -0.04119  0.35994
#> BOVESPA.lag(1) -0.36899 -0.02604
#> COLCAP.lag(2)  -0.27017  0.12001
#> BOVESPA.lag(2) -0.17876  0.11750
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   6e-05 0.00002    .  4e-05   1e-05    .  7e-05 0.00004
#> BOVESPA  2e-05 0.00013    .  1e-05   1e-04    .  4e-05 0.00017
#> 
#> 
#> Extra parameter
#>                   Mean  2(1-PD)  HDI_low HDI_high
#> nu             6.18345      .    4.89576  7.75856
#> 
#> 
DIC(fit1)
#>            DIC
#> fit1 -18314.32
WAIC(fit1)
#>           WAIC
#> fit1 -18257.84

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=1000, n.sim=2000, n.thin=2)
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
#> Thresholds (Mean, HDI_low, HDI_high)
#>                                                                  
#> Regime 1     (-Inf,3.56601]     (-Inf,3.05835]     (-Inf,3.97462]
#> Regime 2 (3.56601,10.00948] (3.05835,10.00017] (3.97462,10.01585]
#> Regime 3     (10.00948,Inf)     (10.00017,Inf)     (10.01585,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)     1.32270   0.00001  1.10840  1.53769    |     3.44215   0.00001
#> Bedon.lag(1)    0.56779   0.00001  0.48674  0.63865    |     0.15306   0.16100
#> LaPlata.lag(1)  0.04606   0.00001  0.01783  0.07252    |     0.63452   0.00001
#> Bedon.lag(2)    0.04913   0.17600 -0.02108  0.11760    |    -0.04933   0.59300
#> LaPlata.lag(2) -0.02122   0.09500 -0.04472  0.00348    |    -0.07052   0.04500
#> Bedon.lag(3)    0.02670   0.38000 -0.02930  0.09340    |     0.02802   0.70700
#> LaPlata.lag(3)  0.00382   0.73500 -0.01660  0.02593    |     0.06689   0.01300
#> Bedon.lag(4)    0.03433   0.27100 -0.02619  0.09564    |    -0.09043   0.27800
#> LaPlata.lag(4) -0.01488   0.08800 -0.03242  0.00125    |     0.00892   0.73200
#> Bedon.lag(5)    0.08104   0.00100  0.02832  0.13178    |     0.14733   0.01900
#> LaPlata.lag(5) -0.00696   0.32100 -0.02195  0.00594    |     0.02447   0.27100
#>                 HDI_low HDI_high
#> (Intercept)     2.84277  4.07806
#> Bedon.lag(1)   -0.05636  0.36727
#> LaPlata.lag(1)  0.55429  0.71943
#> Bedon.lag(2)   -0.24435  0.13300
#> LaPlata.lag(2) -0.14001 -0.00314
#> Bedon.lag(3)   -0.12634  0.16055
#> LaPlata.lag(3)  0.01315  0.11782
#> Bedon.lag(4)   -0.25017  0.06800
#> LaPlata.lag(4) -0.04320  0.05970
#> Bedon.lag(5)    0.03063  0.27978
#> LaPlata.lag(5) -0.01913  0.06635
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>           Bedon LaPlata        Bedon LaPlata        Bedon LaPlata
#> Bedon   0.32965 0.37032    . 0.26658 0.26189    . 0.39270 0.50269
#> LaPlata 0.37032 2.33134    . 0.26189 1.87596    . 0.50269 2.77942
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)     2.16206   0.00001  1.35707  3.02750    |     6.99793   0.00001
#> Bedon.lag(1)    0.58563   0.00001  0.49891  0.67580    |     0.14497   0.21200
#> LaPlata.lag(1)  0.02201   0.10200 -0.00363  0.05119    |     0.52630   0.00001
#> Bedon.lag(2)    0.09688   0.12800 -0.02828  0.21426    |    -0.00237   0.99200
#> LaPlata.lag(2) -0.02007   0.23300 -0.05446  0.01355    |     0.03353   0.38400
#> Bedon.lag(3)   -0.03512   0.55200 -0.14647  0.07395    |    -0.06173   0.59000
#> LaPlata.lag(3) -0.00713   0.67100 -0.03772  0.02401    |     0.04288   0.25800
#> Bedon.lag(4)    0.09802   0.12500 -0.02663  0.21782    |     0.21898   0.10300
#> LaPlata.lag(4)  0.00786   0.65700 -0.02382  0.04139    |    -0.04288   0.30700
#> Bedon.lag(5)    0.02923   0.50100 -0.05058  0.12382    |    -0.26840   0.01500
#> LaPlata.lag(5)  0.00360   0.82300 -0.02547  0.03502    |     0.11670   0.00300
#>                 HDI_low HDI_high
#> (Intercept)     4.94275  9.10715
#> Bedon.lag(1)   -0.07875  0.37675
#> LaPlata.lag(1)  0.44707  0.60523
#> Bedon.lag(2)   -0.23101  0.24794
#> LaPlata.lag(2) -0.04716  0.10488
#> Bedon.lag(3)   -0.28219  0.18169
#> LaPlata.lag(3) -0.02779  0.11153
#> Bedon.lag(4)   -0.04063  0.48358
#> LaPlata.lag(4) -0.12166  0.03660
#> Bedon.lag(5)   -0.48299 -0.06350
#> LaPlata.lag(5)  0.04428  0.19462
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>           Bedon LaPlata        Bedon LaPlata        Bedon LaPlata
#> Bedon   1.08702 1.32135    . 0.86803 0.95479    . 1.28503 1.69153
#> LaPlata 1.32135 6.49782    . 0.95479 5.29723    . 1.69153 7.72855
#> 
#> 
#> Regime3:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)     5.54232   0.00001  3.95604  7.10331    |    16.97342   0.00001
#> Bedon.lag(1)    0.47503   0.00001  0.30809  0.65025    |     0.55576   0.03000
#> LaPlata.lag(1)  0.04369   0.01800  0.00732  0.07755    |     0.32200   0.00001
#> Bedon.lag(2)    0.08219   0.27700 -0.06799  0.23009    |    -0.56479   0.04200
#> LaPlata.lag(2) -0.00346   0.82300 -0.03463  0.03605    |     0.12032   0.06100
#> Bedon.lag(3)   -0.09216   0.17500 -0.21436  0.04701    |    -0.57825   0.01700
#> LaPlata.lag(3)  0.03429   0.07700 -0.00179  0.07014    |     0.28292   0.00001
#> Bedon.lag(4)    0.00065   0.97800 -0.15412  0.13770    |     0.02933   0.94900
#> LaPlata.lag(4)  0.00412   0.86100 -0.03739  0.04583    |    -0.00476   0.93200
#> Bedon.lag(5)    0.17995   0.00800  0.03964  0.31051    |     0.28306   0.27400
#> LaPlata.lag(5) -0.01420   0.41200 -0.04734  0.02338    |     0.06208   0.34200
#>                 HDI_low HDI_high
#> (Intercept)    11.33475 22.78460
#> Bedon.lag(1)    0.08824  1.08182
#> LaPlata.lag(1)  0.20162  0.44473
#> Bedon.lag(2)   -1.09287  0.01191
#> LaPlata.lag(2) -0.02109  0.25281
#> Bedon.lag(3)   -1.06910 -0.12542
#> LaPlata.lag(3)  0.13351  0.43195
#> Bedon.lag(4)   -0.51977  0.58427
#> LaPlata.lag(4) -0.16977  0.15009
#> Bedon.lag(5)   -0.17852  0.78211
#> LaPlata.lag(5) -0.06591  0.19247
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>           Bedon  LaPlata        Bedon  LaPlata        Bedon  LaPlata
#> Bedon   2.79140  7.19892    . 2.23988  5.49716    . 3.39125  8.97411
#> LaPlata 7.19892 43.17947    . 5.49716 35.03210    . 8.97411 52.40166
#> 
#> 
DIC(fit2)
#>           DIC
#> fit2 12932.79
WAIC(fit2)
#>          WAIC
#> fit2 12976.94

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=1000, n.sim=2000,
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
#> Thresholds (Mean, HDI_low, HDI_high)
#>                                                     
#> Regime 1 (-Inf,1.14532] (-Inf,1.0862] (-Inf,1.19945]
#> Regime 2  (1.14532,Inf)  (1.0862,Inf)  (1.19945,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                          Mean  2(1-PD)   HDI_low HDI_high             Mean
#> (Intercept)           3.63294   0.00001  2.97466  4.34933    |     0.81526
#> Jokulsa.lag( 1)       0.85188   0.00001  0.77385  0.91445    |    -0.06162
#> Vatnsdalsa.lag( 1)    0.21030   0.00001  0.10809  0.33762    |     1.16550
#> Jokulsa.lag( 2)      -0.05059   0.05800 -0.09478  0.00089    |     0.04897
#> Vatnsdalsa.lag( 2)   -0.17649   0.00100 -0.30921 -0.05329    |    -0.29685
#> Jokulsa.lag( 3)       0.00426   0.77500 -0.03573  0.03712    |    -0.02393
#> Vatnsdalsa.lag( 3)    0.03440   0.29000 -0.03268  0.09922    |     0.02957
#> Jokulsa.lag( 4)      -0.00106   0.91700 -0.04628  0.04281    |     0.01424
#> Vatnsdalsa.lag( 4)    0.00964   0.80800 -0.06528  0.08696    |     0.00212
#> Jokulsa.lag( 5)       0.00392   0.82600 -0.04998  0.05222    |     0.00608
#> Vatnsdalsa.lag( 5)   -0.03865   0.24000 -0.10342  0.02761    |    -0.01691
#> Jokulsa.lag( 6)       0.02027   0.46300 -0.03561  0.07004    |     0.00477
#> Vatnsdalsa.lag( 6)   -0.02155   0.48200 -0.08682  0.04272    |     0.00096
#> Jokulsa.lag( 7)      -0.00008   1.00000 -0.05288  0.05074    |    -0.00265
#> Vatnsdalsa.lag( 7)    0.01635   0.57300 -0.04399  0.07794    |     0.00803
#> Jokulsa.lag( 8)       0.00018   0.97600 -0.04888  0.05050    |    -0.00846
#> Vatnsdalsa.lag( 8)   -0.00468   0.88800 -0.05887  0.05522    |     0.00605
#> Jokulsa.lag( 9)      -0.01041   0.64200 -0.05693  0.03076    |     0.01874
#> Vatnsdalsa.lag( 9)   -0.00765   0.77200 -0.06723  0.06685    |    -0.00110
#> Jokulsa.lag(10)       0.02759   0.11500 -0.00648  0.05942    |    -0.01413
#> Vatnsdalsa.lag(10)    0.02362   0.44700 -0.03799  0.08990    |     0.01904
#> Jokulsa.lag(11)      -0.01440   0.33400 -0.04454  0.01416    |     0.00991
#> Vatnsdalsa.lag(11)   -0.01673   0.55200 -0.07696  0.03764    |    -0.00767
#> Jokulsa.lag(12)       0.00948   0.53500 -0.02056  0.03995    |    -0.00919
#> Vatnsdalsa.lag(12)    0.00868   0.74800 -0.04032  0.05856    |    -0.00269
#> Jokulsa.lag(13)      -0.01826   0.32900 -0.05295  0.01497    |     0.00306
#> Vatnsdalsa.lag(13)   -0.01317   0.62200 -0.06959  0.03726    |    -0.01980
#> Jokulsa.lag(14)       0.00539   0.68200 -0.02048  0.03325    |    -0.00520
#> Vatnsdalsa.lag(14)    0.00539   0.84400 -0.04559  0.06279    |     0.03477
#> Jokulsa.lag(15)       0.02114   0.13500 -0.00451  0.04996    |     0.00191
#> Vatnsdalsa.lag(15)   -0.01246   0.54600 -0.05115  0.02578    |     0.00519
#> Precipitation.lag(1)  0.00675   0.44400 -0.01097  0.02422    |     0.00504
#> Precipitation.lag(2)  0.00586   0.36800 -0.00889  0.01801    |     0.00042
#> Precipitation.lag(3) -0.01242   0.03700 -0.02305 -0.00094    |    -0.00406
#> Precipitation.lag(4)  0.01930   0.00300  0.00485  0.03247    |     0.00455
#> Temperature.lag(1)    0.02202   0.02900  0.00153  0.04285    |     0.00219
#> Temperature.lag(2)   -0.03840   0.00001 -0.05960 -0.01711    |    -0.01169
#>                       2(1-PD)   HDI_low HDI_high
#> (Intercept)            0.00001  0.41053  1.20952
#> Jokulsa.lag( 1)        0.00001 -0.10270 -0.02642
#> Vatnsdalsa.lag( 1)     0.00001  1.08072  1.24207
#> Jokulsa.lag( 2)        0.00100  0.01677  0.07998
#> Vatnsdalsa.lag( 2)     0.00001 -0.38384 -0.21349
#> Jokulsa.lag( 3)        0.05300 -0.04832 -0.00001
#> Vatnsdalsa.lag( 3)     0.19200 -0.02128  0.07596
#> Jokulsa.lag( 4)        0.26100 -0.01029  0.03960
#> Vatnsdalsa.lag( 4)     0.91700 -0.05580  0.05232
#> Jokulsa.lag( 5)        0.71200 -0.02309  0.03594
#> Vatnsdalsa.lag( 5)     0.44800 -0.06359  0.02972
#> Jokulsa.lag( 6)        0.74100 -0.02520  0.03401
#> Vatnsdalsa.lag( 6)     0.95900 -0.03767  0.04051
#> Jokulsa.lag( 7)        0.86600 -0.03201  0.02547
#> Vatnsdalsa.lag( 7)     0.64700 -0.02829  0.04465
#> Jokulsa.lag( 8)        0.51700 -0.03652  0.01486
#> Vatnsdalsa.lag( 8)     0.73300 -0.03334  0.04000
#> Jokulsa.lag( 9)        0.21400 -0.01004  0.04794
#> Vatnsdalsa.lag( 9)     0.98800 -0.03964  0.03884
#> Jokulsa.lag(10)        0.20400 -0.03868  0.00659
#> Vatnsdalsa.lag(10)     0.38300 -0.02313  0.06121
#> Jokulsa.lag(11)        0.25500 -0.00715  0.02883
#> Vatnsdalsa.lag(11)     0.64900 -0.04335  0.03271
#> Jokulsa.lag(12)        0.33500 -0.02867  0.00978
#> Vatnsdalsa.lag(12)     0.89000 -0.03685  0.03392
#> Jokulsa.lag(13)        0.79000 -0.01524  0.02419
#> Vatnsdalsa.lag(13)     0.35000 -0.06181  0.01993
#> Jokulsa.lag(14)        0.55700 -0.02319  0.01234
#> Vatnsdalsa.lag(14)     0.03200  0.00083  0.07385
#> Jokulsa.lag(15)        0.78500 -0.01207  0.01672
#> Vatnsdalsa.lag(15)     0.70800 -0.02272  0.03127
#> Precipitation.lag(1)   0.35200 -0.00606  0.01584
#> Precipitation.lag(2)   0.95300 -0.00803  0.00961
#> Precipitation.lag(3)   0.29000 -0.01217  0.00321
#> Precipitation.lag(4)   0.34900 -0.00589  0.01325
#> Temperature.lag(1)     0.77100 -0.01174  0.01449
#> Temperature.lag(2)     0.09300 -0.02493  0.00155
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>            Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa
#> Jokulsa    0.06439    0.01086    . 0.04655    0.00561    . 0.08306    0.01667
#> Vatnsdalsa 0.01086    0.02807    . 0.00561    0.02005    . 0.01667    0.03553
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                          Mean  2(1-PD)   HDI_low HDI_high             Mean
#> (Intercept)          -0.27205   0.70500 -1.67284  1.03896    |     0.49374
#> Jokulsa.lag( 1)       1.01663   0.00001  0.94916  1.08946    |    -0.00269
#> Vatnsdalsa.lag( 1)    0.91827   0.00001  0.47599  1.41071    |     1.18072
#> Jokulsa.lag( 2)      -0.17204   0.00500 -0.30816 -0.05138    |     0.01003
#> Vatnsdalsa.lag( 2)   -0.42848   0.21000 -1.12625  0.25481    |    -0.34378
#> Jokulsa.lag( 3)       0.01099   0.88600 -0.10102  0.12454    |    -0.01244
#> Vatnsdalsa.lag( 3)    0.07418   0.77700 -0.57144  0.71416    |     0.19380
#> Jokulsa.lag( 4)      -0.07408   0.06800 -0.15864  0.00510    |     0.00602
#> Vatnsdalsa.lag( 4)   -0.17765   0.42200 -0.60842  0.29338    |    -0.08977
#> Jokulsa.lag( 5)       0.03643   0.37400 -0.04378  0.11497    |    -0.00483
#> Vatnsdalsa.lag( 5)    0.02699   0.87700 -0.59226  0.63584    |     0.00744
#> Jokulsa.lag( 6)      -0.03935   0.24300 -0.10389  0.02883    |     0.00396
#> Vatnsdalsa.lag( 6)    0.07392   0.83600 -0.57602  0.63660    |     0.02635
#> Jokulsa.lag( 7)       0.00241   0.92700 -0.05779  0.06038    |    -0.00592
#> Vatnsdalsa.lag( 7)    0.09012   0.70400 -0.35365  0.56357    |    -0.05653
#> Jokulsa.lag( 8)       0.01617   0.56400 -0.04213  0.07590    |     0.00421
#> Vatnsdalsa.lag( 8)   -0.22535   0.34000 -0.68732  0.19665    |    -0.04213
#> Jokulsa.lag( 9)       0.03546   0.26300 -0.02754  0.09769    |    -0.00156
#> Vatnsdalsa.lag( 9)    0.14357   0.51800 -0.27998  0.60062    |     0.08788
#> Jokulsa.lag(10)      -0.01705   0.62100 -0.10468  0.06421    |     0.00322
#> Vatnsdalsa.lag(10)   -0.01324   0.98600 -0.39794  0.38217    |    -0.07449
#> Jokulsa.lag(11)      -0.00534   0.90500 -0.08682  0.07351    |    -0.00723
#> Vatnsdalsa.lag(11)   -0.01040   0.94000 -0.50809  0.56351    |     0.08404
#> Jokulsa.lag(12)      -0.00361   0.90900 -0.07552  0.07630    |     0.00934
#> Vatnsdalsa.lag(12)   -0.00234   0.97300 -0.50357  0.45003    |    -0.08372
#> Jokulsa.lag(13)      -0.00557   0.87600 -0.08430  0.07241    |    -0.00629
#> Vatnsdalsa.lag(13)    0.43364   0.10000 -0.08748  0.89885    |     0.15016
#> Jokulsa.lag(14)      -0.00123   0.97900 -0.08652  0.07496    |    -0.00168
#> Vatnsdalsa.lag(14)    0.10011   0.70600 -0.40577  0.69838    |    -0.05554
#> Jokulsa.lag(15)       0.04489   0.04800  0.00233  0.09060    |     0.00117
#> Vatnsdalsa.lag(15)   -0.42299   0.02000 -0.72012 -0.09097    |    -0.01678
#> Precipitation.lag(1) -0.11792   0.00300 -0.19322 -0.04190    |    -0.00309
#> Precipitation.lag(2)  0.03007   0.66400 -0.09238  0.16621    |    -0.00174
#> Precipitation.lag(3)  0.04946   0.13800 -0.00866  0.12009    |     0.00609
#> Precipitation.lag(4)  0.02673   0.41600 -0.04811  0.08707    |     0.00297
#> Temperature.lag(1)    1.12313   0.00001  0.93373  1.30971    |     0.01964
#> Temperature.lag(2)   -0.56734   0.00001 -0.76727 -0.37004    |    -0.02473
#>                       2(1-PD)   HDI_low HDI_high
#> (Intercept)            0.00001  0.28057  0.66764
#> Jokulsa.lag( 1)        0.46900 -0.01003  0.00443
#> Vatnsdalsa.lag( 1)     0.00001  1.11666  1.24579
#> Jokulsa.lag( 2)        0.10600 -0.00292  0.02078
#> Vatnsdalsa.lag( 2)     0.00001 -0.43757 -0.24585
#> Jokulsa.lag( 3)        0.05200 -0.02587 -0.00060
#> Vatnsdalsa.lag( 3)     0.00001  0.10983  0.27734
#> Jokulsa.lag( 4)        0.20400 -0.00338  0.01519
#> Vatnsdalsa.lag( 4)     0.06500 -0.16454 -0.00524
#> Jokulsa.lag( 5)        0.33300 -0.01424  0.00493
#> Vatnsdalsa.lag( 5)     0.87100 -0.08223  0.11565
#> Jokulsa.lag( 6)        0.35000 -0.00393  0.01225
#> Vatnsdalsa.lag( 6)     0.61100 -0.06837  0.12190
#> Jokulsa.lag( 7)        0.16800 -0.01463  0.00202
#> Vatnsdalsa.lag( 7)     0.10500 -0.12211  0.00844
#> Jokulsa.lag( 8)        0.29000 -0.00292  0.01273
#> Vatnsdalsa.lag( 8)     0.21400 -0.11503  0.02105
#> Jokulsa.lag( 9)        0.71500 -0.01029  0.00625
#> Vatnsdalsa.lag( 9)     0.04000  0.01493  0.16679
#> Jokulsa.lag(10)        0.53000 -0.00656  0.01224
#> Vatnsdalsa.lag(10)     0.02200 -0.12890 -0.01198
#> Jokulsa.lag(11)        0.12800 -0.01646  0.00184
#> Vatnsdalsa.lag(11)     0.03100  0.00709  0.14695
#> Jokulsa.lag(12)        0.03400  0.00096  0.01786
#> Vatnsdalsa.lag(12)     0.00700 -0.14092 -0.02367
#> Jokulsa.lag(13)        0.15000 -0.01419  0.00274
#> Vatnsdalsa.lag(13)     0.00001  0.08721  0.22495
#> Jokulsa.lag(14)        0.74100 -0.01025  0.00712
#> Vatnsdalsa.lag(14)     0.16200 -0.13787  0.01897
#> Jokulsa.lag(15)        0.70900 -0.00460  0.00712
#> Vatnsdalsa.lag(15)     0.49900 -0.06459  0.03233
#> Precipitation.lag(1)   0.55600 -0.01327  0.00682
#> Precipitation.lag(2)   0.79500 -0.01603  0.01102
#> Precipitation.lag(3)   0.24100 -0.00359  0.01619
#> Precipitation.lag(4)   0.48900 -0.00607  0.01146
#> Temperature.lag(1)     0.13100 -0.00560  0.04332
#> Temperature.lag(2)     0.06000 -0.04913  0.00125
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>            Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa
#> Jokulsa    1.33928    0.04596    . 0.90446    0.02454    . 1.73477     0.0720
#> Vatnsdalsa 0.04596    0.02294    . 0.02454    0.01619    . 0.07200     0.0313
#> 
#> 
#> Extra parameter
#>                         Mean  2(1-PD)  HDI_low HDI_high
#> nu                   0.81198      .    0.73347   0.8942
#> 
#> 
DIC(fit3)
#>           DIC
#> fit3 7470.261
WAIC(fit3)
#>          WAIC
#> fit3 7633.301

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=1000,
             n.sim=2000, n.thin=2, dist="Student-t")
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
#> Thresholds (Mean, HDI_low, HDI_high)
#>                                                      
#> Regime 1 (-Inf,0.93084] (-Inf,0.88273] (-Inf,1.01333]
#> Regime 2  (0.93084,Inf)  (0.88273,Inf)  (1.01333,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                 Mean  2(1-PD)   HDI_low HDI_high
#> (Intercept)  0.09277   0.00001  0.06804  0.11900
#> CCR.lag(1)  -0.05054   0.00100 -0.08189 -0.02091
#> CCR.lag(2)  -0.03725   0.10800 -0.08233  0.00354
#> CCR.lag(3)  -0.03059   0.21100 -0.07478  0.01763
#> dVIX.lag(1) -0.03964   0.00900 -0.06630 -0.01105
#> dVIX.lag(2) -0.02305   0.12000 -0.04867  0.00646
#> dVIX.lag(3)  0.01727   0.04500  0.00047  0.03302
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         CCR          CCR          CCR
#> CCR 0.34698    . 0.31843    . 0.37647
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                 Mean  2(1-PD)   HDI_low HDI_high
#> (Intercept)  0.02850     0.637 -0.08887  0.15713
#> CCR.lag(1)  -0.10024     0.011 -0.18052 -0.01995
#> CCR.lag(2)   0.00411     0.955 -0.13086  0.14941
#> CCR.lag(3)   0.05827     0.314 -0.04916  0.17171
#> dVIX.lag(1)  0.03139     0.537 -0.07249  0.13252
#> dVIX.lag(2)  0.00543     0.887 -0.05975  0.07936
#> dVIX.lag(3)  0.03251     0.158 -0.01434  0.07655
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         CCR          CCR          CCR
#> CCR 0.75551    . 0.64493    . 0.87001
#> 
#> 
#> Extra parameter
#>                Mean  2(1-PD)  HDI_low HDI_high
#> nu          2.42924      .     2.2107   2.6125
#> 
#> 
DIC(fit4)
#>           DIC
#> fit4 14926.13
WAIC(fit4)
#>          WAIC
#> fit4 14949.43
# }

```
