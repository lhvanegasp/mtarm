# Rainfall and two river flows in Colombia

This dataset contains daily observations of rainfall (in millimeters)
and river flows (in \\m^3\\/s) for two rivers in southern Colombia.
Rainfall was recorded at a meteorological station located at an altitude
of 2400 meters above sea level. River flows were measured at two
hydrological stations: El Trébol station, which monitors the Bedón River
at an altitude of 1720 meters, and Villalosada station, which monitors
the La Plata River at an altitude of 1300 meters. The stations are
located near the equator, a geographic feature that helps reduce
seasonal distortions and facilitates the analysis of the dynamic
relationship between rainfall and river flows. The sample period spans
from January 1, 2006, to April 14, 2009.

## Usage

``` r
data(riverflows)
```

## Format

A data frame with 1200 rows and 4 variables:

- Date:

  A vector indicating the date of each observation.

- Bedon:

  A numeric vector giving the daily flow of the Bedón River.

- LaPlata:

  A numeric vector giving the daily flow of the La Plata River.

- Rainfall:

  A numeric vector indicating daily rainfall amounts.

## References

Calderon, S.A. and Nieto, F.H. (2017) Bayesian analysis of multivariate
threshold autoregressive models with missing data. Communications in
Statistics - Theory and Methods, 46, 296-318.

## Examples

``` r
data(riverflows)
dev.new()
plot(ts(as.matrix(riverflows[,-1])), main="Rainfall and river flows")
```
