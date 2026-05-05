# Temperature, precipitation, and two river flows in Iceland

This data set contains two daily river-flow time series, measured in
cubic meters per second, for rivers in Iceland from January 1, 1972, to
December 12, 1974. Additionally, daily measurements of precipitation (in
millimeters) and temperature (in degrees Celsius) were recorded at the
Hveravellir meteorological station. The precipitation values correspond
to the accumulated precipitation up to 9:00 A.M. relative to the same
time on the previous day.

## Usage

``` r
data(iceland.rf)
```

## Format

A data frame with 1,096 rows and 5 variables:

- Vatnsdalsa:

  Numeric vector representing the daily flow of the Vatnsdalsá river.

- Jokulsa:

  Numeric vector representing the daily flow of the Jökulsá Eystri
  river.

- Precipitation:

  Numeric vector of daily precipitation amounts (millimeters).

- Temperature:

  Numeric vector of daily temperature measurements (degrees Celsius).

- Date:

  Vector indicating the calendar date of each observation.

## References

Tong, Howell (1990) Non‑linear Time Series: A Dynamical System Approach.
Oxford University Press. Oxford, UK.

Ruey S., Tsay (1998) Testing and Modeling Multivariate Threshold Models.
Journal of the American Statistical Association, 93, 1188-1202.

## Examples

``` r
data(iceland.rf)
dev.new()
plot(ts(as.matrix(iceland.rf[,-5])), main="Iceland")
```
