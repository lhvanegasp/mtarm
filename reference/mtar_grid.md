# Bayesian Estimation of Multivariate TAR Models

This function is a wrapper that applies
[`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md) over a
grid of model specifications defined by all combinations of the noise
distribution (`dist`), the number of regimes (from `nregim.min` to
`nregim.max`), the autoregressive order within each regime (from `p.min`
to `p.max`), the maximum lag of the exogenous series within each regime
(from `q.min` to `q.max`), and the maximum lag of the threshold series
within each regime (from `d.min` to `d.max`). In all calls to
[`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md), the
same set of time points is used for model fitting. This is achieved by
appropriately adjusting the `subset` argument of
[`mtar()`](https://lhvanegasp.github.io/mtarm/reference/mtar.md) for
each model specification, thereby ensuring comparability across models.

## Usage

``` r
mtar_grid(
  formula,
  data,
  subset,
  Intercept = TRUE,
  trend = c("none", "linear", "quadratic"),
  nseason = NULL,
  nregim.min = 1,
  nregim.max = NULL,
  p.min = 1,
  p.max = NULL,
  q.min = 0,
  q.max = 0,
  d.min = 0,
  d.max = 0,
  row.names,
  dist = "Gaussian",
  prior = list(),
  n.sim = 500,
  n.burnin = 100,
  n.thin = 1,
  ssvs = FALSE,
  setar = NULL,
  plan_strategy = c("multisession", "sequential"),
  progress = TRUE
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
  the environment from which `mtar_grid()` is called.

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

- nregim.min:

  An optional integer specifying the minimum number of regimes. By
  default, `nregim.min` is set to `1`.

- nregim.max:

  An integer specifying the maximum number of regimes.

- p.min:

  An optional integer specifying the minimum autoregressive order within
  each regime. By default, `p.min` is set to `1`.

- p.max:

  An integer specifying the maximum autoregressive order within each
  regime.

- q.min:

  An optional integer specifying the minimum value of the maximum lag of
  the exogenous series within each regime. By default, `q.min` is set to
  `0`.

- q.max:

  An optional integer specifying the maximum value of the maximum lag of
  the exogenous series within each regime. By default, `q.max` is set to
  `0`.

- d.min:

  An optional integer specifying the minimum value of the maximum lag of
  the threshold series within each regime. By default, `d.min` is set to
  `0`.

- d.max:

  An optional integer specifying the maximum value of the maximum lag of
  the threshold series within each regime. By default, `d.max` is set to
  `0`.

- row.names:

  An optional variable in `data` labelling the time points corresponding
  to each row of the data set.

- dist:

  A character vector specifying the multivariate distributions used to
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

- plan_strategy:

  An optional character string specifying the execution strategy for
  parallel computation. Available options are `"sequential"` and
  `"multisession"`. By default, `plan_strategy` is set to
  `"sequential"`.

- progress:

  An optional logical indicating whether a progress bar should be
  displayed during execution. By default, `progress` is set to `TRUE`.

## Value

A list whose elements are objects of class `mtar`, each corresponding to
a distinct model specification considered in the grid.

## See also

mtar

## Examples

``` r
# \donttest{
###### Example 1: Returns of the closing prices of three financial indexes
data(returns)
fit1 <- mtar_grid(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
                  subset={Date<="2015-12-07"}, dist=c("Gaussian","Student-t",
                  "Slash","Laplace"), nregim.min=2, nregim.max=3, p.min=2,
                  p.max=2, n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
summary(fit1)
#>               Length Class Mode
#> Gaussian.2.2  24     mtar  list
#> Gaussian.3.2  24     mtar  list
#> Laplace.2.2   24     mtar  list
#> Laplace.3.2   24     mtar  list
#> Slash.2.2     24     mtar  list
#> Slash.3.2     24     mtar  list
#> Student-t.2.2 24     mtar  list
#> Student-t.3.2 24     mtar  list

###### Example 2: Rainfall and two river flows in Colombia
data(riverflows)
fit2 <- mtar_grid(~ Bedon + LaPlata | Rainfall, data=riverflows,
                  row.names=Date, subset={Date<="2009-02-13"},dist="Laplace",
                  nregim.min=2, nregim.max=3, p.min=1, p.max=3,n.burnin=100,
                  n.sim=200, n.thin=2, plan_strategy="multisession")
fit2
#> 
#> 
#> Sample size          :1137 time points (2006-01-04 to 2009-02-13)
#> 
#> Output Series        :Bedon    |    LaPlata
#> 
#> Threshold Series     :Rainfall with a estimated delay equal to 0
#> 
#> Error Distribution   :Laplace
#> 
#> Number of regimes    :2 to 3
#> 
#> Deterministics       :Intercept  
#> 
#> Autoregressive orders:1 to 3

###### Example 3: Temperature, precipitation, and two river flows in Iceland
data(iceland.rf)
fit3 <- mtar_grid(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                  data=iceland.rf,subset={Date<="1974-11-06"},row.names=Date,
                  dist=c("Slash","Student-t"), nregim.min=1, nregim.max=2,
                  p.min=15, p.max=15, q.min=4, q.max=4, d.min=2, d.max=2,
                  n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
fit3
#> 
#> 
#> Sample size          :1026 time points (1972-01-16 to 1974-11-06)
#> 
#> Output Series        :Jokulsa    |    Vatnsdalsa
#> 
#> Exogenous Series (ES):Precipitation
#> 
#> Error Distribution   :Slash
#> 
#> Number of regimes    :1 to 2
#> 
#> Deterministics       :Intercept  
#> 
#> Autoregressive orders:15 to 15
#> 
#> Maximum lags for ES  :4 to 4

###### Example 4: U.S. stock returns
data(US.returns)
fit4 <- mtar_grid(~ CCR | dVIX, data=US.returns, subset={Date<="2025-11-28"},
                  row.names=Date, dist=c("Laplace","Student-t","Slash"),
                  nregim.min=1, nregim.max=2, p.min=3, p.max=3, d.min=3,
                  d.max=3, n.burnin=100, n.sim=200, n.thin=2,
                  plan_strategy="multisession")
#> Error in getGlobalsAndPackages(expr, envir = envir, globals = globals): The total size of the 7 globals exported for future expression (‘FUN()’) is 649.84 MiB. This exceeds the maximum allowed size 500.00 MiB per plan() argument 'maxSizeOfObjects'. This limit is set to protect against transfering too large objects to parallel workers by mistake, which may not be intended and could be costly. See help("future.globals.maxSize", package = "future") for how to adjust or remove the default threshold via an R option The three largest globals are ‘FUN’ (649.61 MiB of class ‘function’), ‘mycall’ (240.07 KiB of class ‘call’) and ‘grid’ (895 bytes of class ‘list’)
fit4
#> Error: object 'fit4' not found
# }
```
