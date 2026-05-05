# Watanabe-Akaike or Widely Available Information Criterion (WAIC)

Computes Watanabe-Akaike or Widely Available Information Criterion
(WAIC), an adjusted within-sample measure of predictive accuracy, for
models estimated using Bayesian methods.

## Usage

``` r
WAIC(...)
```

## Arguments

- ...:

  one or more fitted model objects of the same class.

## Value

A numeric matrix containing the WAIC values corresponding to each fitted
object supplied in `...`.

## References

Watanabe S. (2010). Asymptotic Equivalence of Bayes Cross Validation and
Widely Applicable Information Criterion in Singular Learning Theory. The
Journal of Machine Learning Research, 11, 3571–3594.
