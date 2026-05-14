# Auxiliary function to specify the number of regimes and lag orders

This auxiliary function defines the regime structure of a multivariate
TAR model by specifying the number of regimes and the corresponding lag
orders for the endogenous, exogenous, and threshold series in each
regime.

## Usage

``` r
ars(nregim = 1, p = 1, q = 0, d = 0)
```

## Arguments

- nregim:

  A positive integer indicating the total number of regimes.

- p:

  A list of positive integers specifying the autoregressive order of the
  output series within each regime.

- q:

  A list of non-negative integers specifying the maximum lag of the
  exogenous series within each regime.

- d:

  A list of non-negative integers specifying the maximum lag of the
  threshold series within each regime.

## Value

A list containing the number of regimes and the regime-specific
lag-order specifications.
