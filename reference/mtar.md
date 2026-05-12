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
#> Thresholds (Mean, HDI_low, HDI_high)
#>                                                                  
#> Regime 1    (-Inf,-0.00171]    (-Inf,-0.00376]    (-Inf,-0.00089]
#> Regime 2 (-0.00171,0.00699] (-0.00376,0.00416] (-0.00089,0.00851]
#> Regime 3      (0.00699,Inf)      (0.00416,Inf)      (0.00851,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)    -0.00315     1e-05 -0.00435 -0.00221    |    -0.00767   0.00001
#> COLCAP.lag(1)   0.14521     1e-02  0.03710  0.23835    |     0.02218   0.70000
#> BOVESPA.lag(1)  0.07307     2e-02  0.01023  0.12945    |    -0.00333   0.96000
#>                 HDI_low HDI_high
#> (Intercept)    -0.00959 -0.00624
#> COLCAP.lag(1)  -0.11571  0.15906
#> BOVESPA.lag(1) -0.09872  0.08169
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   6e-05 0.00003    .  5e-05 0.00002    .  7e-05 0.00004
#> BOVESPA  3e-05 0.00013    .  2e-05 0.00011    .  4e-05 0.00015
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                   Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)    0.00034      0.25 -0.00016  0.00099    |     0.00049      0.27
#> COLCAP.lag(1)  0.07208      0.06 -0.00412  0.12697    |     0.04160      0.40
#> BOVESPA.lag(1) 0.08180      0.01  0.04075  0.12234    |    -0.03858      0.22
#>                 HDI_low HDI_high
#> (Intercept)    -0.00035  0.00139
#> COLCAP.lag(1)  -0.05753  0.13423
#> BOVESPA.lag(1) -0.10128  0.02408
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   4e-05   1e-05    .  3e-05   1e-05    .  5e-05   2e-05
#> BOVESPA  1e-05   8e-05    .  1e-05   7e-05    .  2e-05   9e-05
#> 
#> 
#> Regime3:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)     0.00454   0.00001  0.00291  0.00575    |     0.01077   0.00001
#> COLCAP.lag(1)   0.07469   0.19000 -0.04480  0.18811    |     0.17885   0.05000
#> BOVESPA.lag(1)  0.07610   0.10000 -0.00426  0.16320    |    -0.10311   0.18000
#> COLCAP.lag(2)   0.06979   0.24000 -0.04207  0.17986    |    -0.05523   0.45000
#> BOVESPA.lag(2) -0.07117   0.08000 -0.14307  0.00151    |    -0.07217   0.26000
#>                 HDI_low HDI_high
#> (Intercept)     0.00723  0.01282
#> COLCAP.lag(1)   0.01964  0.35975
#> BOVESPA.lag(1) -0.22896  0.04830
#> COLCAP.lag(2)  -0.21912  0.10913
#> BOVESPA.lag(2) -0.19397  0.04272
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         COLCAP BOVESPA      COLCAP BOVESPA      COLCAP BOVESPA
#> COLCAP   5e-05 0.00002    .  4e-05   1e-05    .  6e-05 0.00004
#> BOVESPA  2e-05 0.00013    .  1e-05   1e-04    .  4e-05 0.00016
#> 
#> 
#> Extra parameter
#>                   Mean  2(1-PD)  HDI_low HDI_high
#> nu             5.79294      .    4.42491   6.9933
#> 
#> 
DIC(fit1)
#>            DIC
#> fit1 -18222.45
WAIC(fit1)
#>          WAIC
#> fit1 -18180.3

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
#> Thresholds (Mean, HDI_low, HDI_high)
#>                                                       
#> Regime 1    (-Inf,3.49158] (-Inf,3]     (-Inf,3.93932]
#> Regime 2 (3.49158,10.0096]   (3,10] (3.93932,10.01594]
#> Regime 3     (10.0096,Inf) (10,Inf)     (10.01594,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)     1.31958   0.00001  1.10008  1.52486    |     3.42595   0.00001
#> Bedon.lag(1)    0.56273   0.00001  0.48530  0.64222    |     0.15309   0.12000
#> LaPlata.lag(1)  0.04636   0.01000  0.01698  0.07564    |     0.63175   0.00001
#> Bedon.lag(2)    0.05184   0.12000 -0.00963  0.12150    |    -0.04127   0.59000
#> LaPlata.lag(2) -0.02141   0.11000 -0.04671  0.00248    |    -0.06872   0.05000
#> Bedon.lag(3)    0.02871   0.34000 -0.02925  0.08419    |     0.02550   0.78000
#> LaPlata.lag(3)  0.00358   0.74000 -0.01925  0.02188    |     0.06490   0.02000
#> Bedon.lag(4)    0.03095   0.42000 -0.02292  0.10501    |    -0.09161   0.32000
#> LaPlata.lag(4) -0.01575   0.07000 -0.03064  0.00271    |     0.00834   0.73000
#> Bedon.lag(5)    0.08781   0.01000  0.04279  0.13970    |     0.15201   0.04000
#> LaPlata.lag(5) -0.00709   0.30000 -0.02105  0.00494    |     0.02453   0.22000
#>                 HDI_low HDI_high
#> (Intercept)     2.89878  3.94294
#> Bedon.lag(1)   -0.02699  0.32427
#> LaPlata.lag(1)  0.55630  0.69946
#> Bedon.lag(2)   -0.24202  0.13051
#> LaPlata.lag(2) -0.12874  0.00028
#> Bedon.lag(3)   -0.09573  0.13986
#> LaPlata.lag(3)  0.01208  0.11560
#> Bedon.lag(4)   -0.25213  0.07669
#> LaPlata.lag(4) -0.04248  0.05712
#> Bedon.lag(5)    0.03244  0.28216
#> LaPlata.lag(5) -0.01569  0.06791
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>           Bedon LaPlata        Bedon LaPlata        Bedon LaPlata
#> Bedon   0.32768 0.36746    . 0.27409 0.27129    . 0.39726 0.48454
#> LaPlata 0.36746 2.31030    . 0.27129 1.91113    . 0.48454 2.76007
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)     2.12773   0.00001  1.25691  2.89565    |     6.86550   0.00001
#> Bedon.lag(1)    0.58630   0.00001  0.49038  0.66428    |     0.13516   0.24000
#> LaPlata.lag(1)  0.02297   0.10000 -0.00267  0.05492    |     0.53815   0.00001
#> Bedon.lag(2)    0.10093   0.07000 -0.01950  0.22289    |    -0.00644   0.97000
#> LaPlata.lag(2) -0.02127   0.19000 -0.05010  0.01247    |     0.03156   0.29000
#> Bedon.lag(3)   -0.03765   0.55000 -0.13902  0.07273    |    -0.06951   0.56000
#> LaPlata.lag(3) -0.00965   0.57000 -0.04066  0.02081    |     0.03781   0.28000
#> Bedon.lag(4)    0.10571   0.04000  0.00065  0.20215    |     0.24022   0.05000
#> LaPlata.lag(4)  0.00729   0.67000 -0.02064  0.03557    |    -0.04182   0.36000
#> Bedon.lag(5)    0.02357   0.60000 -0.05353  0.09066    |    -0.25951   0.00001
#> LaPlata.lag(5)  0.00539   0.71000 -0.02087  0.03213    |     0.11140   0.01000
#>                 HDI_low HDI_high
#> (Intercept)     5.07360  9.01380
#> Bedon.lag(1)   -0.03774  0.39103
#> LaPlata.lag(1)  0.45389  0.61551
#> Bedon.lag(2)   -0.23228  0.21766
#> LaPlata.lag(2) -0.02985  0.09888
#> Bedon.lag(3)   -0.29094  0.12953
#> LaPlata.lag(3) -0.01787  0.12010
#> Bedon.lag(4)    0.01957  0.51771
#> LaPlata.lag(4) -0.12220  0.02683
#> Bedon.lag(5)   -0.46358 -0.08504
#> LaPlata.lag(5)  0.04027  0.18512
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>           Bedon LaPlata        Bedon LaPlata        Bedon LaPlata
#> Bedon   1.09573 1.34042    . 0.90866 1.01454    . 1.29829 1.66497
#> LaPlata 1.34042 6.46395    . 1.01454 5.33729    . 1.66497 7.63309
#> 
#> 
#> Regime3:
#> 
#> Autoregressive coefficients
#>                    Mean  2(1-PD)   HDI_low HDI_high             Mean  2(1-PD) 
#> (Intercept)     5.57818   0.00001  4.15873  7.31318    |    16.62186   0.00001
#> Bedon.lag(1)    0.45329   0.00001  0.29600  0.59888    |     0.54495   0.05000
#> LaPlata.lag(1)  0.04782   0.00001  0.01926  0.08698    |     0.33651   0.00001
#> Bedon.lag(2)    0.09096   0.17000 -0.04469  0.25465    |    -0.55935   0.05000
#> LaPlata.lag(2) -0.00384   0.76000 -0.03642  0.02447    |     0.11513   0.10000
#> Bedon.lag(3)   -0.09691   0.06000 -0.20252  0.00392    |    -0.61606   0.00001
#> LaPlata.lag(3)  0.03740   0.06000  0.00901  0.07426    |     0.28741   0.00001
#> Bedon.lag(4)    0.00482   0.91000 -0.13156  0.12932    |     0.09580   0.77000
#> LaPlata.lag(4)  0.00017   0.98000 -0.04035  0.04070    |    -0.01665   0.82000
#> Bedon.lag(5)    0.18776   0.01000  0.07240  0.35826    |     0.25929   0.27000
#> LaPlata.lag(5) -0.01446   0.48000 -0.05217  0.01886    |     0.06727   0.23000
#>                 HDI_low HDI_high
#> (Intercept)    10.31207 22.63209
#> Bedon.lag(1)   -0.01386  1.07966
#> LaPlata.lag(1)  0.21900  0.49800
#> Bedon.lag(2)   -1.13000 -0.01892
#> LaPlata.lag(2) -0.02077  0.26954
#> Bedon.lag(3)   -0.98236 -0.17635
#> LaPlata.lag(3)  0.15241  0.43315
#> Bedon.lag(4)   -0.48734  0.62058
#> LaPlata.lag(4) -0.17667  0.11111
#> Bedon.lag(5)   -0.21102  0.67940
#> LaPlata.lag(5) -0.01569  0.22868
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>           Bedon  LaPlata        Bedon  LaPlata        Bedon  LaPlata
#> Bedon   2.76943  7.12080    . 2.29665  5.52123    . 3.25775  8.49109
#> LaPlata 7.12080 42.77683    . 5.52123 35.13907    . 8.49109 50.26098
#> 
#> 
DIC(fit2)
#>        DIC
#> fit2 12930
WAIC(fit2)
#>          WAIC
#> fit2 12971.17

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
#> Thresholds (Mean, HDI_low, HDI_high)
#>                                                     
#> Regime 1 (-Inf,0.3746] (-Inf,0.31348] (-Inf,0.48342]
#> Regime 2  (0.3746,Inf)  (0.31348,Inf)  (0.48342,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                          Mean  2(1-PD)   HDI_low HDI_high             Mean
#> (Intercept)           3.10315   0.00001  2.57522  3.61074    |     0.56600
#> Jokulsa.lag( 1)       0.88524   0.00001  0.84034  0.91988    |    -0.04125
#> Vatnsdalsa.lag( 1)    0.29743   0.00001  0.19968  0.41228    |     1.15607
#> Jokulsa.lag( 2)      -0.06061   0.01000 -0.10168 -0.01738    |     0.03700
#> Vatnsdalsa.lag( 2)   -0.28404   0.00001 -0.41528 -0.12546    |    -0.30113
#> Jokulsa.lag( 3)      -0.00332   0.90000 -0.03621  0.03706    |    -0.02649
#> Vatnsdalsa.lag( 3)    0.10654   0.01000  0.01598  0.21355    |     0.08313
#> Jokulsa.lag( 4)       0.01791   0.38000 -0.02430  0.05813    |     0.00972
#> Vatnsdalsa.lag( 4)   -0.05038   0.26000 -0.15695  0.03804    |    -0.03480
#> Jokulsa.lag( 5)      -0.04024   0.16000 -0.09723  0.02118    |     0.01187
#> Vatnsdalsa.lag( 5)   -0.01307   0.73000 -0.08367  0.04424    |    -0.00444
#> Jokulsa.lag( 6)       0.04365   0.13000 -0.00619  0.09457    |     0.00232
#> Vatnsdalsa.lag( 6)   -0.02009   0.57000 -0.08070  0.05064    |    -0.01998
#> Jokulsa.lag( 7)       0.01213   0.63000 -0.03981  0.06298    |     0.00344
#> Vatnsdalsa.lag( 7)    0.00102   0.93000 -0.07124  0.05940    |     0.01692
#> Jokulsa.lag( 8)      -0.01684   0.42000 -0.05168  0.02823    |    -0.01977
#> Vatnsdalsa.lag( 8)    0.00556   0.75000 -0.05346  0.05148    |     0.00824
#> Jokulsa.lag( 9)       0.01761   0.30000 -0.01380  0.06086    |     0.02747
#> Vatnsdalsa.lag( 9)   -0.02869   0.29000 -0.08691  0.02674    |     0.00127
#> Jokulsa.lag(10)       0.01768   0.24000 -0.01418  0.04868    |    -0.01940
#> Vatnsdalsa.lag(10)    0.02971   0.40000 -0.02864  0.08482    |     0.01448
#> Jokulsa.lag(11)      -0.01114   0.50000 -0.04001  0.01052    |     0.01146
#> Vatnsdalsa.lag(11)   -0.00751   0.78000 -0.06060  0.05010    |     0.00145
#> Jokulsa.lag(12)       0.00295   0.81000 -0.02585  0.02862    |    -0.01100
#> Vatnsdalsa.lag(12)    0.00336   0.88000 -0.04408  0.05127    |    -0.00805
#> Jokulsa.lag(13)      -0.00872   0.66000 -0.03375  0.02488    |     0.00967
#> Vatnsdalsa.lag(13)   -0.01931   0.52000 -0.07057  0.03380    |    -0.02620
#> Jokulsa.lag(14)       0.00395   0.80000 -0.02264  0.02733    |    -0.00813
#> Vatnsdalsa.lag(14)    0.01124   0.65000 -0.03835  0.05612    |     0.03776
#> Jokulsa.lag(15)       0.00960   0.51000 -0.01264  0.02901    |     0.00348
#> Vatnsdalsa.lag(15)   -0.01506   0.39000 -0.04630  0.02193    |     0.00214
#> Precipitation.lag(1)  0.00523   0.53000 -0.01280  0.02082    |     0.00331
#> Precipitation.lag(2)  0.00455   0.54000 -0.00873  0.01781    |     0.00175
#> Precipitation.lag(3) -0.01295   0.02000 -0.02314 -0.00202    |    -0.00431
#> Precipitation.lag(4)  0.02258   0.00001  0.00983  0.03798    |     0.00614
#> Temperature.lag(1)    0.01569   0.16000 -0.00347  0.03660    |    -0.00029
#> Temperature.lag(2)   -0.02969   0.01000 -0.04763 -0.00857    |    -0.01362
#>                       2(1-PD)   HDI_low HDI_high
#> (Intercept)            0.00001  0.24921  0.89300
#> Jokulsa.lag( 1)        0.00001 -0.07096 -0.01599
#> Vatnsdalsa.lag( 1)     0.00001  1.07521  1.22861
#> Jokulsa.lag( 2)        0.01000  0.01229  0.06841
#> Vatnsdalsa.lag( 2)     0.00001 -0.40390 -0.21068
#> Jokulsa.lag( 3)        0.03000 -0.05282 -0.00543
#> Vatnsdalsa.lag( 3)     0.01000  0.01387  0.16867
#> Jokulsa.lag( 4)        0.46000 -0.01067  0.04288
#> Vatnsdalsa.lag( 4)     0.35000 -0.11111  0.03531
#> Jokulsa.lag( 5)        0.45000 -0.01972  0.04565
#> Vatnsdalsa.lag( 5)     0.88000 -0.04918  0.03235
#> Jokulsa.lag( 6)        0.89000 -0.02430  0.03421
#> Vatnsdalsa.lag( 6)     0.41000 -0.06911  0.02077
#> Jokulsa.lag( 7)        0.80000 -0.02733  0.03286
#> Vatnsdalsa.lag( 7)     0.37000 -0.03238  0.05256
#> Jokulsa.lag( 8)        0.08000 -0.05246  0.00079
#> Vatnsdalsa.lag( 8)     0.63000 -0.02109  0.03716
#> Jokulsa.lag( 9)        0.07000 -0.00039  0.06247
#> Vatnsdalsa.lag( 9)     0.85000 -0.03738  0.03041
#> Jokulsa.lag(10)        0.10000 -0.04304  0.00080
#> Vatnsdalsa.lag(10)     0.50000 -0.02378  0.05374
#> Jokulsa.lag(11)        0.22000 -0.00404  0.03118
#> Vatnsdalsa.lag(11)     0.96000 -0.03565  0.03842
#> Jokulsa.lag(12)        0.29000 -0.02948  0.00906
#> Vatnsdalsa.lag(12)     0.70000 -0.03595  0.02917
#> Jokulsa.lag(13)        0.34000 -0.01344  0.03259
#> Vatnsdalsa.lag(13)     0.23000 -0.07156  0.01163
#> Jokulsa.lag(14)        0.40000 -0.02760  0.00791
#> Vatnsdalsa.lag(14)     0.01000  0.00382  0.06940
#> Jokulsa.lag(15)        0.68000 -0.01101  0.01628
#> Vatnsdalsa.lag(15)     0.78000 -0.02192  0.02516
#> Precipitation.lag(1)   0.58000 -0.00486  0.01577
#> Precipitation.lag(2)   0.73000 -0.00799  0.01054
#> Precipitation.lag(3)   0.29000 -0.01343  0.00351
#> Precipitation.lag(4)   0.21000 -0.00283  0.01620
#> Temperature.lag(1)     0.99000 -0.01304  0.01286
#> Temperature.lag(2)     0.04000 -0.02483  0.00030
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>            Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa
#> Jokulsa    0.05484    0.00842    . 0.03765    0.00342    . 0.07218    0.01332
#> Vatnsdalsa 0.00842    0.02339    . 0.00342    0.01594    . 0.01332    0.03052
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                          Mean  2(1-PD)   HDI_low HDI_high             Mean
#> (Intercept)          -0.11569   0.87000 -1.21200  0.88188    |     0.47935
#> Jokulsa.lag( 1)       1.01018   0.00001  0.92619  1.07879    |    -0.00484
#> Vatnsdalsa.lag( 1)    0.82776   0.00001  0.46778  1.15540    |     1.20546
#> Jokulsa.lag( 2)      -0.15454   0.00001 -0.29177 -0.05140    |     0.01555
#> Vatnsdalsa.lag( 2)   -0.44196   0.02000 -0.78537  0.00797    |    -0.33448
#> Jokulsa.lag( 3)       0.00287   0.99000 -0.08559  0.10451    |    -0.01558
#> Vatnsdalsa.lag( 3)    0.05720   0.74000 -0.38966  0.50312    |     0.16211
#> Jokulsa.lag( 4)      -0.06182   0.08000 -0.13104  0.00524    |     0.00639
#> Vatnsdalsa.lag( 4)   -0.11829   0.58000 -0.48483  0.32436    |    -0.08640
#> Jokulsa.lag( 5)       0.02941   0.40000 -0.03283  0.08066    |    -0.00414
#> Vatnsdalsa.lag( 5)    0.06951   0.80000 -0.46273  0.56755    |    -0.03092
#> Jokulsa.lag( 6)      -0.03818   0.20000 -0.09067  0.01611    |     0.00289
#> Vatnsdalsa.lag( 6)   -0.11034   0.72000 -0.49533  0.37029    |     0.06509
#> Jokulsa.lag( 7)      -0.00861   0.86000 -0.07084  0.03966    |    -0.00503
#> Vatnsdalsa.lag( 7)    0.24553   0.24000 -0.15344  0.63157    |    -0.05261
#> Jokulsa.lag( 8)       0.02861   0.30000 -0.03453  0.08380    |     0.00376
#> Vatnsdalsa.lag( 8)   -0.29479   0.03000 -0.61092 -0.01362    |    -0.08637
#> Jokulsa.lag( 9)       0.03659   0.20000 -0.01819  0.08932    |    -0.00385
#> Vatnsdalsa.lag( 9)    0.20822   0.27000 -0.12350  0.61812    |     0.13418
#> Jokulsa.lag(10)      -0.02665   0.38000 -0.10642  0.04764    |     0.00474
#> Vatnsdalsa.lag(10)   -0.08676   0.67000 -0.40733  0.32466    |    -0.07775
#> Jokulsa.lag(11)      -0.00983   0.85000 -0.09044  0.05287    |    -0.00713
#> Vatnsdalsa.lag(11)    0.21763   0.37000 -0.18643  0.66501    |     0.06317
#> Jokulsa.lag(12)       0.00841   0.81000 -0.05505  0.08014    |     0.00979
#> Vatnsdalsa.lag(12)   -0.08943   0.77000 -0.58627  0.36843    |    -0.06607
#> Jokulsa.lag(13)       0.00877   0.89000 -0.07509  0.08327    |    -0.00734
#> Vatnsdalsa.lag(13)    0.15359   0.61000 -0.34233  0.61288    |     0.15412
#> Jokulsa.lag(14)      -0.01801   0.65000 -0.08233  0.05786    |    -0.00224
#> Vatnsdalsa.lag(14)    0.28607   0.10000 -0.04555  0.58080    |    -0.03058
#> Jokulsa.lag(15)       0.04603   0.00001  0.00812  0.08514    |     0.00249
#> Vatnsdalsa.lag(15)   -0.40338   0.01000 -0.65254 -0.14673    |    -0.04881
#> Precipitation.lag(1) -0.09320   0.00001 -0.16528 -0.02885    |    -0.00264
#> Precipitation.lag(2)  0.02262   0.71000 -0.08125  0.10617    |    -0.00691
#> Precipitation.lag(3)  0.03868   0.17000 -0.01211  0.08658    |     0.00496
#> Precipitation.lag(4)  0.02067   0.46000 -0.02654  0.07749    |     0.00534
#> Temperature.lag(1)    1.09091   0.00001  0.91697  1.24965    |     0.03861
#> Temperature.lag(2)   -0.56731   0.00001 -0.70679 -0.36588    |    -0.04487
#>                       2(1-PD)   HDI_low HDI_high
#> (Intercept)            0.00001  0.26033  0.67259
#> Jokulsa.lag( 1)        0.20000 -0.01270  0.00330
#> Vatnsdalsa.lag( 1)     0.00001  1.13663  1.28075
#> Jokulsa.lag( 2)        0.03000  0.00513  0.02828
#> Vatnsdalsa.lag( 2)     0.00001 -0.39672 -0.23409
#> Jokulsa.lag( 3)        0.02000 -0.02870 -0.00475
#> Vatnsdalsa.lag( 3)     0.00001  0.09904  0.25979
#> Jokulsa.lag( 4)        0.19000 -0.00323  0.01549
#> Vatnsdalsa.lag( 4)     0.05000 -0.14392 -0.00755
#> Jokulsa.lag( 5)        0.43000 -0.01441  0.00524
#> Vatnsdalsa.lag( 5)     0.46000 -0.11465  0.04256
#> Jokulsa.lag( 6)        0.56000 -0.00570  0.01343
#> Vatnsdalsa.lag( 6)     0.17000 -0.01341  0.13631
#> Jokulsa.lag( 7)        0.26000 -0.01193  0.00328
#> Vatnsdalsa.lag( 7)     0.17000 -0.11118  0.01380
#> Jokulsa.lag( 8)        0.36000 -0.00356  0.01090
#> Vatnsdalsa.lag( 8)     0.00001 -0.13910 -0.02851
#> Jokulsa.lag( 9)        0.43000 -0.01186  0.00528
#> Vatnsdalsa.lag( 9)     0.00001  0.05885  0.19789
#> Jokulsa.lag(10)        0.45000 -0.00501  0.01525
#> Vatnsdalsa.lag(10)     0.02000 -0.12759 -0.00171
#> Jokulsa.lag(11)        0.19000 -0.01537  0.00412
#> Vatnsdalsa.lag(11)     0.11000 -0.00056  0.13007
#> Jokulsa.lag(12)        0.03000  0.00047  0.02009
#> Vatnsdalsa.lag(12)     0.07000 -0.11743  0.00367
#> Jokulsa.lag(13)        0.10000 -0.01645  0.00078
#> Vatnsdalsa.lag(13)     0.00001  0.09110  0.21250
#> Jokulsa.lag(14)        0.63000 -0.01153  0.00638
#> Vatnsdalsa.lag(14)     0.25000 -0.08137  0.02003
#> Jokulsa.lag(15)        0.43000 -0.00256  0.00883
#> Vatnsdalsa.lag(15)     0.04000 -0.08591 -0.00401
#> Precipitation.lag(1)   0.64000 -0.01281  0.00944
#> Precipitation.lag(2)   0.40000 -0.02234  0.00556
#> Precipitation.lag(3)   0.35000 -0.00517  0.01630
#> Precipitation.lag(4)   0.22000 -0.00416  0.01405
#> Temperature.lag(1)     0.01000  0.01073  0.06029
#> Temperature.lag(2)     0.01000 -0.06888 -0.01352
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>            Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa      Jokulsa Vatnsdalsa
#> Jokulsa    1.37275    0.04653    . 0.98840    0.01991    . 1.78460    0.07198
#> Vatnsdalsa 0.04653    0.03175    . 0.01991    0.02153    . 0.07198    0.04130
#> 
#> 
#> Extra parameter
#>                         Mean  2(1-PD)  HDI_low HDI_high
#> nu                   0.82639      .    0.74069  0.90632
#> 
#> 
DIC(fit3)
#>           DIC
#> fit3 7537.516
WAIC(fit3)
#>          WAIC
#> fit3 7698.527

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
#> Thresholds (Mean, HDI_low, HDI_high)
#>                                                      
#> Regime 1 (-Inf,0.90872] (-Inf,0.89739] (-Inf,0.96858]
#> Regime 2  (0.90872,Inf)  (0.89739,Inf)  (0.96858,Inf)
#> 
#> 
#> Regime1:
#> 
#> Autoregressive coefficients
#>                 Mean  2(1-PD)   HDI_low HDI_high
#> (Intercept)  0.09392   0.00001  0.07171  0.11414
#> CCR.lag(1)  -0.05160   0.00001 -0.08229 -0.02207
#> CCR.lag(2)  -0.03830   0.08000 -0.09105 -0.00055
#> CCR.lag(3)  -0.03252   0.17000 -0.07006  0.01445
#> dVIX.lag(1) -0.03903   0.01000 -0.06360 -0.00743
#> dVIX.lag(2) -0.02365   0.07000 -0.04610  0.00204
#> dVIX.lag(3)  0.01846   0.03000  0.00373  0.03390
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>         CCR          CCR          CCR
#> CCR 0.34378    . 0.31715    . 0.36785
#> 
#> 
#> Regime2:
#> 
#> Autoregressive coefficients
#>                 Mean  2(1-PD)   HDI_low HDI_high
#> (Intercept)  0.02734      0.63 -0.08618  0.12360
#> CCR.lag(1)  -0.09997      0.02 -0.17320 -0.02929
#> CCR.lag(2)   0.00937      0.86 -0.09468  0.17498
#> CCR.lag(3)   0.04965      0.40 -0.07694  0.16737
#> dVIX.lag(1)  0.04157      0.44 -0.05353  0.14242
#> dVIX.lag(2)  0.00312      0.92 -0.06347  0.07384
#> dVIX.lag(3)  0.03108      0.17 -0.00612  0.08609
#> 
#> Scale parameter (Mean, HDI_low, HDI_high)
#>        CCR          CCR        CCR
#> CCR 0.7478    . 0.65606    . 0.889
#> 
#> 
#> Extra parameter
#>                Mean  2(1-PD)  HDI_low HDI_high
#> nu          2.40479      .    2.22956   2.5635
#> 
#> 
DIC(fit4)
#>           DIC
#> fit4 14937.12
WAIC(fit4)
#>          WAIC
#> fit4 14946.36
# }

```
