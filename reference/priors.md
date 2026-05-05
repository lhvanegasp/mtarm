# Auxiliary function for setting hyperparameter values

This function constructs and validates the list of hyperparameter values
used to define the prior distributions of the model parameters.
Hyperparameters not explicitly provided by the user are assigned their
default values, which define non-informative prior distributions.

## Usage

``` r
priors(prior, regim, k, dist, setar, ssvs)
```

## Arguments

- prior:

  A list specifying user-defined values for the hyperparameters. Any
  hyperparameters not included in this list are set to their default
  values.

- regim:

  A positive integer indicating the number of regimes in the model.

- k:

  A positive integer indicating the dimension of the multivariate output
  series.

- dist:

  A character string specifying the distribution chosen to model the
  noise process.

- setar:

  A positive integer indicating the component of the output series that
  acts as the threshold variable in a SETAR specification. If `NULL` is
  specified then the model is not a SETAR.

- ssvs:

  A logical indicating whether the Stochastic Search Variable Selection
  (SSVS) procedure should be applied.

## Value

A list containing the hyperparameter values defining the prior
distributions of all model parameters.
