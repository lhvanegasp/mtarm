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
             ars=ars(nregim=3,p=c(1,1,2)), n.burnin=1000, n.sim=2000,
             n.thin=2)
summary(fit1)
#> 
#> 
#> Sample size          : 1427 time points (2010-02-04 to 2015-12-07)
#> 
#> Output Series        : COLCAP    |    BOVESPA
#> 
#> Threshold Series     : SP500 with a estimated delay equal to 0
#> 
#> Error Distribution   : Student-t
#> 
#> Number of regimes    : 3
#> 
#> Deterministics       : Intercept  
#> 
#> Autoregressive orders: 1, 1, 2
#> 
#> 
#> 
#> Thresholds (Mean, HDI.Lower, HDI.Upper)
#>                                                                  
#> Regime 1    (-Inf,-0.00873]    (-Inf,-0.01054]    (-Inf,-0.00635]
#> Regime 2 (-0.00873,0.00882] (-0.01054,0.00754] (-0.00635,0.01099]
#> Regime 3      (0.00882,Inf)      (0.00754,Inf)      (0.01099,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)    -0.00725   0.00001  -0.00940  -0.00491    |    -0.01408
#> COLCAP.lag(1)   0.26154   0.00100   0.04513   0.45550    |    -0.09202
#> BOVESPA.lag(1)  0.11626   0.06900  -0.00614   0.25309    |     0.11574
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001  -0.01711  -0.01069
#> COLCAP.lag(1)    0.43700  -0.34150   0.12546
#> BOVESPA.lag(1)   0.25200  -0.05912   0.33063
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   8e-05 0.00004    .  6e-05 0.00002    .  1e-04 0.00006
#> BOVESPA  4e-05 0.00015    .  2e-05 0.00011    .  6e-05 0.00019
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                   Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean  2(1-PD) 
#> (Intercept)    0.00003   0.92700  -0.00049   0.00046    |    -0.00063     0.090
#> COLCAP.lag(1)  0.07260   0.01200   0.01594   0.13200    |     0.05586     0.189
#> BOVESPA.lag(1) 0.07491   0.00001   0.04141   0.11573    |    -0.03851     0.154
#>                HDI.Lower HDI.Upper
#> (Intercept)     -0.00142   0.00011
#> COLCAP.lag(1)   -0.02327   0.14095
#> BOVESPA.lag(1)  -0.09501   0.01089
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   4e-05   1e-05    .  4e-05   1e-05    .  5e-05   2e-05
#> BOVESPA  1e-05   9e-05    .  1e-05   8e-05    .  2e-05   1e-04
#> 
#> 
#> Regime3:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)     0.00554   0.00001   0.00395   0.00753    |     0.01286
#> COLCAP.lag(1)   0.06224   0.34200  -0.07117   0.19397    |     0.15778
#> BOVESPA.lag(1)  0.03778   0.53100  -0.09587   0.15702    |    -0.14836
#> COLCAP.lag(2)   0.06449   0.32200  -0.06180   0.19018    |    -0.06055
#> BOVESPA.lag(2) -0.06843   0.12300  -0.15738   0.02002    |    -0.05214
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001   0.01007   0.01704
#> COLCAP.lag(1)    0.10500  -0.03733   0.34332
#> BOVESPA.lag(1)   0.07100  -0.33639   0.00736
#> COLCAP.lag(2)    0.51400  -0.25354   0.12653
#> BOVESPA.lag(2)   0.43100  -0.19946   0.07787
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   6e-05 0.00002    .  4e-05   1e-05    .  7e-05 0.00004
#> BOVESPA  2e-05 0.00013    .  1e-05   1e-04    .  4e-05 0.00016
#> 
#> 
#> Extra parameter
#>                   Mean  2(1-PD)  HDI.Lower HDI.Upper
#> nu             5.96907      .      4.67034   7.29723
#> 
#> 
DIC(fit1)
#>           DIC
#> fit1 -18327.9
WAIC(fit1)
#>           WAIC
#> fit1 -18237.06

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
             subset={Date<="2009-02-13"}, dist="Laplace",
             ars=ars(nregim=3,p=5), n.burnin=1000, n.sim=2000, n.thin=2)
summary(fit2)
#> 
#> 
#> Sample size          : 1135 time points (2006-01-06 to 2009-02-13)
#> 
#> Output Series        : Bedon    |    LaPlata
#> 
#> Threshold Series     : Rainfall with a estimated delay equal to 0
#> 
#> Error Distribution   : Laplace
#> 
#> Number of regimes    : 3
#> 
#> Deterministics       : Intercept  
#> 
#> Autoregressive orders: 5 in each regime
#> 
#> 
#> 
#> Thresholds (Mean, HDI.Lower, HDI.Upper)
#>                                                                  
#> Regime 1     (-Inf,3.38481]     (-Inf,3.03054]     (-Inf,3.94628]
#> Regime 2 (3.38481,10.01528] (3.03054,10.00015] (3.94628,10.01492]
#> Regime 3     (10.01528,Inf)     (10.00015,Inf)     (10.01492,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)     1.33009   0.00001   1.09557   1.53952    |     3.43832
#> Bedon.lag(1)    0.56483   0.00001   0.48897   0.64354    |     0.15357
#> LaPlata.lag(1)  0.04643   0.00001   0.01420   0.07469    |     0.63513
#> Bedon.lag(2)    0.05321   0.13300  -0.01232   0.13165    |    -0.04082
#> LaPlata.lag(2) -0.02231   0.08900  -0.04702   0.00362    |    -0.07287
#> Bedon.lag(3)    0.02684   0.36400  -0.03514   0.08120    |     0.02454
#> LaPlata.lag(3)  0.00343   0.75600  -0.01878   0.02399    |     0.06666
#> Bedon.lag(4)    0.03251   0.28500  -0.02796   0.09015    |    -0.09581
#> LaPlata.lag(4) -0.01492   0.08300  -0.03265   0.00130    |     0.01004
#> Bedon.lag(5)    0.08272   0.00001   0.02882   0.12992    |     0.15153
#> LaPlata.lag(5) -0.00672   0.32300  -0.02048   0.00588    |     0.02375
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001   2.80227   4.02312
#> Bedon.lag(1)     0.16700  -0.06465   0.37228
#> LaPlata.lag(1)   0.00001   0.55973   0.72714
#> Bedon.lag(2)     0.65800  -0.23458   0.14470
#> LaPlata.lag(2)   0.05100  -0.13873   0.00351
#> Bedon.lag(3)     0.74600  -0.11874   0.17026
#> LaPlata.lag(3)   0.02100   0.01020   0.11792
#> Bedon.lag(4)     0.24600  -0.25654   0.07884
#> LaPlata.lag(4)   0.72300  -0.04139   0.06533
#> Bedon.lag(5)     0.02300   0.02646   0.27862
#> LaPlata.lag(5)   0.28500  -0.02017   0.06757
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>           Bedon LaPlata        Bedon LaPlata        Bedon LaPlata
#> Bedon   0.32902 0.37083    . 0.26733 0.25761    . 0.39264 0.48484
#> LaPlata 0.37083 2.33224    . 0.25761 1.91561    . 0.48484 2.80108
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)     2.12531   0.00001   1.29059   2.90177    |     6.96312
#> Bedon.lag(1)    0.58671   0.00001   0.49759   0.67394    |     0.15115
#> LaPlata.lag(1)  0.02195   0.09800  -0.00394   0.04891    |     0.52599
#> Bedon.lag(2)    0.09387   0.12500  -0.01842   0.21866    |    -0.00038
#> LaPlata.lag(2) -0.01939   0.27300  -0.05543   0.01330    |     0.03241
#> Bedon.lag(3)   -0.03731   0.51600  -0.14984   0.07174    |    -0.07488
#> LaPlata.lag(3) -0.00691   0.67400  -0.03666   0.02257    |     0.04425
#> Bedon.lag(4)    0.10320   0.09200  -0.01578   0.21923    |     0.22853
#> LaPlata.lag(4)  0.00746   0.64300  -0.02742   0.03770    |    -0.04357
#> Bedon.lag(5)    0.02861   0.47700  -0.05273   0.10825    |    -0.27158
#> LaPlata.lag(5)  0.00414   0.79100  -0.02533   0.03318    |     0.11853
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001   4.81388   9.00301
#> Bedon.lag(1)     0.19700  -0.07044   0.39055
#> LaPlata.lag(1)   0.00001   0.44767   0.60378
#> Bedon.lag(2)     0.99200  -0.22237   0.27318
#> LaPlata.lag(2)   0.40600  -0.04334   0.10237
#> Bedon.lag(3)     0.52700  -0.30074   0.17061
#> LaPlata.lag(3)   0.21100  -0.02292   0.11145
#> Bedon.lag(4)     0.09000  -0.02672   0.47972
#> LaPlata.lag(4)   0.29000  -0.11668   0.04471
#> Bedon.lag(5)     0.00800  -0.48422  -0.07190
#> LaPlata.lag(5)   0.00200   0.03660   0.19853
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>           Bedon LaPlata        Bedon LaPlata        Bedon LaPlata
#> Bedon   1.08667 1.32717    . 0.89417 0.97258    . 1.30700 1.69886
#> LaPlata 1.32717 6.50877    . 0.97258 5.33759    . 1.69886 7.85858
#> 
#> 
#> Regime3:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)     5.59571   0.00001   4.09094   7.17523    |    17.07178
#> Bedon.lag(1)    0.46845   0.00001   0.30024   0.62905    |     0.53354
#> LaPlata.lag(1)  0.04479   0.01300   0.00844   0.07844    |     0.33063
#> Bedon.lag(2)    0.08572   0.23900  -0.04638   0.23799    |    -0.56098
#> LaPlata.lag(2) -0.00311   0.82900  -0.03470   0.03097    |     0.11756
#> Bedon.lag(3)   -0.09636   0.17300  -0.21723   0.05544    |    -0.58595
#> LaPlata.lag(3)  0.03377   0.09700  -0.00613   0.07014    |     0.28701
#> Bedon.lag(4)    0.00504   0.94200  -0.14769   0.15111    |     0.04545
#> LaPlata.lag(4)  0.00424   0.86800  -0.03638   0.04551    |    -0.01004
#> Bedon.lag(5)    0.17726   0.00900   0.03771   0.31098    |     0.28121
#> LaPlata.lag(5) -0.01373   0.41200  -0.04791   0.02298    |     0.06264
#>                 2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)      0.00001  11.32080  22.92139
#> Bedon.lag(1)     0.05100  -0.03515   1.00640
#> LaPlata.lag(1)   0.00001   0.20744   0.46923
#> Bedon.lag(2)     0.04100  -1.06901  -0.00397
#> LaPlata.lag(2)   0.07800  -0.00909   0.26180
#> Bedon.lag(3)     0.02000  -1.04821  -0.11833
#> LaPlata.lag(3)   0.00001   0.12693   0.43311
#> Bedon.lag(4)     0.90000  -0.52190   0.64787
#> LaPlata.lag(4)   0.87900  -0.16064   0.13955
#> Bedon.lag(5)     0.27400  -0.21956   0.74546
#> LaPlata.lag(5)   0.32400  -0.06354   0.19611
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>           Bedon  LaPlata        Bedon  LaPlata        Bedon  LaPlata
#> Bedon   2.77922  7.19378    . 2.19919  5.34573    . 3.33842  8.94021
#> LaPlata 7.19378 43.17053    . 5.34573 34.51030    . 8.94021 52.17702
#> 
#> 
DIC(fit2)
#>           DIC
#> fit2 12934.62
WAIC(fit2)
#>         WAIC
#> fit2 12978.6

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
             data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
             ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=1000, n.sim=2000,
             n.thin=2, dist="Slash")
summary(fit3)
#> 
#> 
#> Sample size          : 1026 time points (1972-01-16 to 1974-11-06)
#> 
#> Output Series        : Jokulsa    |    Vatnsdalsa
#> 
#> Threshold Series (TS): Temperature with a estimated delay equal to 0
#> 
#> Exogenous Series (ES): Precipitation
#> 
#> Error Distribution   : Slash
#> 
#> Number of regimes    : 2
#> 
#> Deterministics       : Intercept  
#> 
#> Autoregressive orders: 15 in each regime
#> 
#> Maximum lags for ES  : 4 in each regime
#> 
#> Maximum lags for TS  : 2 in each regime
#> 
#> 
#> 
#> Thresholds (Mean, HDI.Lower, HDI.Upper)
#>                                                      
#> Regime 1 (-Inf,1.14536] (-Inf,1.03726] (-Inf,1.20261]
#> Regime 2  (1.14536,Inf)  (1.03726,Inf)  (1.20261,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                          Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)           3.69560   0.00001   2.98018   4.39992    |     0.83739
#> Jokulsa.lag( 1)       0.84720   0.00001   0.76666   0.91397    |    -0.06368
#> Vatnsdalsa.lag( 1)    0.20116   0.00100   0.09175   0.31504    |     1.16135
#> Jokulsa.lag( 2)      -0.05039   0.04300  -0.09422  -0.00295    |     0.04984
#> Vatnsdalsa.lag( 2)   -0.16587   0.00300  -0.30917  -0.05154    |    -0.29270
#> Jokulsa.lag( 3)       0.00521   0.78600  -0.03570   0.04122    |    -0.02393
#> Vatnsdalsa.lag( 3)    0.03169   0.35800  -0.03645   0.09987    |     0.02809
#> Jokulsa.lag( 4)      -0.00064   0.96200  -0.04983   0.04809    |     0.01428
#> Vatnsdalsa.lag( 4)    0.01109   0.77200  -0.07437   0.08655    |     0.00303
#> Jokulsa.lag( 5)       0.00384   0.82900  -0.04932   0.06058    |     0.00646
#> Vatnsdalsa.lag( 5)   -0.03961   0.24400  -0.10673   0.02963    |    -0.01736
#> Jokulsa.lag( 6)       0.02202   0.40700  -0.02911   0.07478    |     0.00540
#> Vatnsdalsa.lag( 6)   -0.02234   0.44700  -0.08212   0.03941    |     0.00045
#> Jokulsa.lag( 7)      -0.00179   0.91600  -0.05056   0.04945    |    -0.00318
#> Vatnsdalsa.lag( 7)    0.01697   0.54800  -0.03818   0.08045    |     0.00771
#> Jokulsa.lag( 8)       0.00043   0.95000  -0.05184   0.05081    |    -0.00937
#> Vatnsdalsa.lag( 8)   -0.00361   0.91500  -0.06207   0.05483    |     0.00693
#> Jokulsa.lag( 9)      -0.01001   0.67500  -0.05747   0.03294    |     0.02031
#> Vatnsdalsa.lag( 9)   -0.00739   0.78800  -0.07922   0.05888    |    -0.00166
#> Jokulsa.lag(10)       0.02772   0.12500  -0.00789   0.06108    |    -0.01463
#> Vatnsdalsa.lag(10)    0.02143   0.50300  -0.03550   0.09130    |     0.01848
#> Jokulsa.lag(11)      -0.01398   0.32400  -0.04424   0.01303    |     0.00939
#> Vatnsdalsa.lag(11)   -0.01607   0.58100  -0.07248   0.03928    |    -0.00641
#> Jokulsa.lag(12)       0.00855   0.54700  -0.01915   0.03774    |    -0.00888
#> Vatnsdalsa.lag(12)    0.01008   0.71300  -0.03969   0.06368    |    -0.00290
#> Jokulsa.lag(13)      -0.01758   0.32500  -0.05142   0.01520    |     0.00279
#> Vatnsdalsa.lag(13)   -0.01380   0.62100  -0.06571   0.04252    |    -0.01949
#> Jokulsa.lag(14)       0.00467   0.70600  -0.02350   0.03128    |    -0.00509
#> Vatnsdalsa.lag(14)    0.00570   0.85600  -0.04757   0.05935    |     0.03532
#> Jokulsa.lag(15)       0.02157   0.16000  -0.00587   0.05033    |     0.00212
#> Vatnsdalsa.lag(15)   -0.01242   0.55300  -0.05311   0.02665    |     0.00453
#> Precipitation.lag(1)  0.00691   0.43400  -0.01040   0.02442    |     0.00538
#> Precipitation.lag(2)  0.00605   0.33500  -0.00639   0.01899    |     0.00065
#> Precipitation.lag(3) -0.01164   0.05000  -0.02188  -0.00024    |    -0.00369
#> Precipitation.lag(4)  0.01864   0.00500   0.00528   0.03168    |     0.00421
#> Temperature.lag(1)    0.02295   0.03100   0.00223   0.04606    |     0.00219
#> Temperature.lag(2)   -0.03953   0.00001  -0.06059  -0.01768    |    -0.01169
#>                       2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)            0.00001   0.43117   1.26161
#> Jokulsa.lag( 1)        0.00001  -0.10491  -0.02608
#> Vatnsdalsa.lag( 1)     0.00001   1.07086   1.23937
#> Jokulsa.lag( 2)        0.00200   0.01625   0.08193
#> Vatnsdalsa.lag( 2)     0.00001  -0.38038  -0.20798
#> Jokulsa.lag( 3)        0.05700  -0.04835   0.00067
#> Vatnsdalsa.lag( 3)     0.21500  -0.01284   0.08114
#> Jokulsa.lag( 4)        0.29000  -0.01085   0.04147
#> Vatnsdalsa.lag( 4)     0.89400  -0.04708   0.05549
#> Jokulsa.lag( 5)        0.70400  -0.02139   0.04072
#> Vatnsdalsa.lag( 5)     0.43400  -0.06571   0.02520
#> Jokulsa.lag( 6)        0.71700  -0.02535   0.03412
#> Vatnsdalsa.lag( 6)     0.96000  -0.04230   0.03777
#> Jokulsa.lag( 7)        0.82000  -0.03261   0.02481
#> Vatnsdalsa.lag( 7)     0.68700  -0.02875   0.04305
#> Jokulsa.lag( 8)        0.45200  -0.03612   0.01526
#> Vatnsdalsa.lag( 8)     0.72100  -0.03029   0.04421
#> Jokulsa.lag( 9)        0.18800  -0.00895   0.05271
#> Vatnsdalsa.lag( 9)     0.96700  -0.04392   0.03350
#> Jokulsa.lag(10)        0.21200  -0.03852   0.00872
#> Vatnsdalsa.lag(10)     0.38700  -0.02267   0.06079
#> Jokulsa.lag(11)        0.31200  -0.00843   0.02862
#> Vatnsdalsa.lag(11)     0.70400  -0.04376   0.03483
#> Jokulsa.lag(12)        0.36100  -0.02994   0.00968
#> Vatnsdalsa.lag(12)     0.87600  -0.03723   0.03117
#> Jokulsa.lag(13)        0.77000  -0.01710   0.02238
#> Vatnsdalsa.lag(13)     0.34800  -0.05848   0.01897
#> Jokulsa.lag(14)        0.56800  -0.02425   0.01149
#> Vatnsdalsa.lag(14)     0.04800  -0.00120   0.07314
#> Jokulsa.lag(15)        0.75600  -0.01366   0.01595
#> Vatnsdalsa.lag(15)     0.76000  -0.02367   0.03424
#> Precipitation.lag(1)   0.33900  -0.00620   0.01607
#> Precipitation.lag(2)   0.92000  -0.00832   0.00938
#> Precipitation.lag(3)   0.32800  -0.01077   0.00468
#> Precipitation.lag(4)   0.39300  -0.00583   0.01323
#> Temperature.lag(1)     0.76900  -0.01179   0.01504
#> Temperature.lag(2)     0.08400  -0.02465   0.00194
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>            Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa
#> Jokulsa    0.06523    0.01115    . 0.04554    0.00555    . 0.08499    0.01727
#> Vatnsdalsa 0.01115    0.02860    . 0.00555    0.01988    . 0.01727    0.03699
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                          Mean  2(1-PD)  HDI.Lower HDI.Upper             Mean
#> (Intercept)          -0.25290   0.71200  -1.57573   1.09103    |     0.48827
#> Jokulsa.lag( 1)       1.01556   0.00001   0.94908   1.08589    |    -0.00270
#> Vatnsdalsa.lag( 1)    0.92345   0.00001   0.46453   1.41255    |     1.18331
#> Jokulsa.lag( 2)      -0.17395   0.00600  -0.30894  -0.05417    |     0.00977
#> Vatnsdalsa.lag( 2)   -0.40260   0.26500  -1.14055   0.30218    |    -0.34586
#> Jokulsa.lag( 3)       0.01076   0.85900  -0.10485   0.12034    |    -0.01191
#> Vatnsdalsa.lag( 3)    0.04449   0.85200  -0.65797   0.69584    |     0.19326
#> Jokulsa.lag( 4)      -0.07331   0.07300  -0.16011   0.00852    |     0.00584
#> Vatnsdalsa.lag( 4)   -0.17252   0.41800  -0.62730   0.28741    |    -0.08893
#> Jokulsa.lag( 5)       0.03720   0.35000  -0.03544   0.11999    |    -0.00499
#> Vatnsdalsa.lag( 5)    0.00339   0.94600  -0.61877   0.59624    |     0.01030
#> Jokulsa.lag( 6)      -0.03854   0.23900  -0.10249   0.02454    |     0.00392
#> Vatnsdalsa.lag( 6)    0.07641   0.84800  -0.47982   0.71571    |     0.02242
#> Jokulsa.lag( 7)       0.00139   0.95200  -0.06250   0.05488    |    -0.00580
#> Vatnsdalsa.lag( 7)    0.09790   0.66900  -0.34451   0.55166    |    -0.05504
#> Jokulsa.lag( 8)       0.01443   0.62400  -0.03810   0.07858    |     0.00428
#> Vatnsdalsa.lag( 8)   -0.22944   0.32900  -0.70427   0.19037    |    -0.04445
#> Jokulsa.lag( 9)       0.03891   0.22700  -0.02632   0.09992    |    -0.00165
#> Vatnsdalsa.lag( 9)    0.15417   0.49100  -0.33148   0.54694    |     0.08930
#> Jokulsa.lag(10)      -0.01992   0.59800  -0.09376   0.06021    |     0.00305
#> Vatnsdalsa.lag(10)   -0.00319   0.96900  -0.42513   0.38581    |    -0.07367
#> Jokulsa.lag(11)      -0.00427   0.92200  -0.07970   0.07029    |    -0.00729
#> Vatnsdalsa.lag(11)   -0.03278   0.83800  -0.54370   0.49346    |     0.08380
#> Jokulsa.lag(12)      -0.00536   0.88700  -0.07365   0.07144    |     0.00955
#> Vatnsdalsa.lag(12)    0.02751   0.91400  -0.43589   0.50858    |    -0.08312
#> Jokulsa.lag(13)      -0.00375   0.89800  -0.07876   0.07859    |    -0.00639
#> Vatnsdalsa.lag(13)    0.41587   0.10300  -0.05376   0.91860    |     0.14978
#> Jokulsa.lag(14)      -0.00176   0.99700  -0.07784   0.08093    |    -0.00171
#> Vatnsdalsa.lag(14)    0.10728   0.68200  -0.45140   0.63806    |    -0.05328
#> Jokulsa.lag(15)       0.04564   0.04300   0.00483   0.09303    |     0.00119
#> Vatnsdalsa.lag(15)   -0.42760   0.02000  -0.71867  -0.07456    |    -0.01858
#> Precipitation.lag(1) -0.11737   0.00200  -0.19432  -0.04120    |    -0.00311
#> Precipitation.lag(2)  0.03435   0.60000  -0.09787   0.16139    |    -0.00158
#> Precipitation.lag(3)  0.05124   0.13800  -0.01797   0.11223    |     0.00546
#> Precipitation.lag(4)  0.03007   0.34500  -0.03922   0.08933    |     0.00284
#> Temperature.lag(1)    1.12372   0.00001   0.94547   1.32249    |     0.01994
#> Temperature.lag(2)   -0.56339   0.00001  -0.77544  -0.37014    |    -0.02472
#>                       2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)            0.00001   0.30689   0.67974
#> Jokulsa.lag( 1)        0.45300  -0.00988   0.00477
#> Vatnsdalsa.lag( 1)     0.00001   1.11868   1.25367
#> Jokulsa.lag( 2)        0.11000  -0.00171   0.02222
#> Vatnsdalsa.lag( 2)     0.00001  -0.44314  -0.23777
#> Jokulsa.lag( 3)        0.04400  -0.02444  -0.00022
#> Vatnsdalsa.lag( 3)     0.00100   0.09617   0.27473
#> Jokulsa.lag( 4)        0.22500  -0.00281   0.01588
#> Vatnsdalsa.lag( 4)     0.07600  -0.16451  -0.00088
#> Jokulsa.lag( 5)        0.29700  -0.01454   0.00417
#> Vatnsdalsa.lag( 5)     0.84500  -0.08379   0.10700
#> Jokulsa.lag( 6)        0.34400  -0.00416   0.01215
#> Vatnsdalsa.lag( 6)     0.67000  -0.07197   0.12205
#> Jokulsa.lag( 7)        0.15100  -0.01359   0.00213
#> Vatnsdalsa.lag( 7)     0.10600  -0.11590   0.01215
#> Jokulsa.lag( 8)        0.25100  -0.00345   0.01142
#> Vatnsdalsa.lag( 8)     0.16700  -0.10827   0.01768
#> Jokulsa.lag( 9)        0.70400  -0.00921   0.00660
#> Vatnsdalsa.lag( 9)     0.01500   0.02097   0.16035
#> Jokulsa.lag(10)        0.54900  -0.00620   0.01235
#> Vatnsdalsa.lag(10)     0.02500  -0.12550  -0.01202
#> Jokulsa.lag(11)        0.11800  -0.01785   0.00072
#> Vatnsdalsa.lag(11)     0.02800   0.01049   0.14675
#> Jokulsa.lag(12)        0.02500   0.00146   0.01850
#> Vatnsdalsa.lag(12)     0.00800  -0.13677  -0.02045
#> Jokulsa.lag(13)        0.13600  -0.01439   0.00206
#> Vatnsdalsa.lag(13)     0.00001   0.08434   0.21610
#> Jokulsa.lag(14)        0.69500  -0.00992   0.00708
#> Vatnsdalsa.lag(14)     0.17900  -0.12902   0.02437
#> Jokulsa.lag(15)        0.69500  -0.00449   0.00666
#> Vatnsdalsa.lag(15)     0.44800  -0.06599   0.02773
#> Precipitation.lag(1)   0.53100  -0.01305   0.00719
#> Precipitation.lag(2)   0.85200  -0.01547   0.01139
#> Precipitation.lag(3)   0.30800  -0.00399   0.01627
#> Precipitation.lag(4)   0.52200  -0.00572   0.01142
#> Temperature.lag(1)     0.11800  -0.00409   0.04494
#> Temperature.lag(2)     0.06100  -0.05080  -0.00002
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>            Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa
#> Jokulsa    1.33899    0.04625    . 0.93550    0.02476    . 1.78562    0.07129
#> Vatnsdalsa 0.04625    0.02293    . 0.02476    0.01599    . 0.07129    0.03078
#> 
#> 
#> Extra parameter
#>                         Mean  2(1-PD)  HDI.Lower HDI.Upper
#> nu                    0.8145      .      0.73041   0.89419
#> 
#> 
DIC(fit3)
#>           DIC
#> fit3 7469.542
WAIC(fit3)
#>          WAIC
#> fit3 7635.115

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
             row.names=Date, ars=ars(nregim=2,p=3,d=3), n.burnin=1000,
             n.sim=2000, n.thin=2, dist="Student-t")
summary(fit4)
#> 
#> 
#> Sample size          : 5317 time points (2005-01-10 to 2025-11-28)
#> 
#> Output Series        : CCR
#> 
#> Threshold Series (TS): dVIX with a estimated delay equal to 0
#> 
#> Error Distribution   : Student-t
#> 
#> Number of regimes    : 2
#> 
#> Deterministics       : Intercept  
#> 
#> Autoregressive orders: 3 in each regime
#> 
#> Maximum lags for TS  : 3 in each regime
#> 
#> 
#> 
#> Thresholds (Mean, HDI.Lower, HDI.Upper)
#>                                                     
#> Regime 1 (-Inf,3.3126] (-Inf,1.89575] (-Inf,3.82548]
#> Regime 2  (3.3126,Inf)  (1.89575,Inf)  (3.82548,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                 Mean  2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept)  0.09111   0.00001   0.06821   0.11136
#> CCR.lag(1)  -0.04958   0.00001  -0.07271  -0.02384
#> CCR.lag(2)  -0.02920   0.17800  -0.07079   0.01300
#> CCR.lag(3)  -0.02687   0.20400  -0.07083   0.01213
#> dVIX.lag(1) -0.02963   0.03200  -0.05552  -0.00095
#> dVIX.lag(2) -0.02277   0.09900  -0.04983   0.00299
#> dVIX.lag(3)  0.01813   0.02700   0.00239   0.03419
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>        CCR          CCR          CCR
#> CCR 0.3848    . 0.35352    . 0.41834
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                 Mean  2(1-PD)  HDI.Lower HDI.Upper
#> (Intercept) -0.67469     0.087  -1.38336   0.05009
#> CCR.lag(1)  -0.37186     0.002  -0.57762  -0.09644
#> CCR.lag(2)  -0.28233     0.215  -0.66467   0.14115
#> CCR.lag(3)   0.54067     0.009   0.06682   0.90040
#> dVIX.lag(1) -0.09158     0.435  -0.32428   0.13937
#> dVIX.lag(2)  0.29346     0.029   0.01635   0.52339
#> dVIX.lag(3)  0.04870     0.377  -0.06843   0.15332
#> 
#> Scale parameter (Mean, HDI.Lower, HDI.Upper)
#>         CCR          CCR          CCR
#> CCR 1.72145    . 0.89721    . 2.51039
#> 
#> 
#> Extra parameter
#>                Mean  2(1-PD)  HDI.Lower HDI.Upper
#> nu          2.48213      .       2.2793    2.7007
#> 
#> 
DIC(fit4)
#>           DIC
#> fit4 14921.11
WAIC(fit4)
#>         WAIC
#> fit4 14952.7
# }

```
