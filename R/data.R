#' @importFrom grDevices dev.new dev.interactive
#' @importFrom graphics abline hist lines par identify curve
#' @importFrom methods missingArg
#' @importFrom stats pnorm pt density median model.extract model.matrix pgamma qgamma qnorm quantile rbeta rbinom rexp rgamma rnorm runif sd terms na.omit acf pacf qqnorm dnorm predict resid
#' @importFrom utils setTxtProgressBar txtProgressBar
#' @importFrom Formula Formula model.part
#' @importFrom mvtnorm pmvnorm pmvt
#' @importFrom GIGrvg rgig
#' @importFrom coda mcmc as.mcmc geweke.diag geweke.plot HPDinterval
#'
#' @title Temperature, rainfall and two rivers' flows in Iceland.
#'
#' @description These data correspond to two daily series of river flows, in cubic meters
#' per second, in Iceland, from January 1, 1972, to December 12, 1974. In addition, daily
#' series of precipitation, measured in millimeters, and temperature, measured in degrees
#' Celsius, were collected at the Hveravellir meteorological station. The recorded
#' precipitation value corresponds to the accumulated precipitation up to 9:00 A.M.
#' since the same time the previous day.
#' @docType data
#'
#' @usage data(iceland.rf)
#'
#' @format A data frame with 1096 rows and 5 variables:
#' \describe{
#'   \item{Vatnsdalsa}{a numerical vector indicating the Vatnsdalsá river flow.}
#'   \item{Jokulsa}{a numerical vector indicating the Jökulsá Eystri river flow.}
#'   \item{Precipitation}{a numerical vector indicating the rainfall.}
#'   \item{Temperature}{a numerical vector indicating the temperature.}
#'   \item{Date}{a vector that indicates the date each measurement was performed.}
#' }
#' @keywords datasets
#' @references Tong, Howell (1990) Non‑linear Time Series: A Dynamical System Approach.
#'             Oxford University Press. Oxford, UK.
#' @references Ruey S., Tsay (1998) Testing and Modeling Multivariate Threshold Models.
#'             Journal of the American Statistical Association, 93, 1188-1202.
#' @examples
#' data(iceland.rf)
#' dev.new()
#' plot(ts(as.matrix(iceland.rf[,-5])), main="Iceland")
#'
"iceland.rf"
#'
#' @title Returns of the closing prices of three financial indexes
#'
#' @description These data correspond to the returns on closing prices of the Colcap,
#' Bovespa, and S&P 500 indexes from February 10, 2010 to March 31, 2016 (1505 time
#' points). Colcap is a leading indicator of the price dynamics of the 20 most liquid
#' shares on the Colombian stock market. Bovespa is the Brazilian stock market index,
#' the world's thirteenth largest and most important stock exchange, and the first in
#' Latin America. Finally, the Standard & Poor's 500 (S&P 500) index is a stock index
#' based on the 500 largest companies in the United States.
#'
#' @docType data
#'
#' @usage data(returns)
#'
#' @format A data frame with 1505 rows and 4 variables:
#' \describe{
#'   \item{Date}{a vector that indicates the date each measurement was performed.}
#'   \item{COLCAP}{a numerical vector indicating the returns on closing prices of COLCAP.}
#'   \item{SP500}{a numerical vector indicating the returns on closing prices of SP500.}
#'   \item{BOVESPA}{a numerical vector indicating the returns on closing prices of BOVESPA.}
#' }
#' @keywords datasets
#' @references Romero, L.V. and Calderon, S.A. (2021) Bayesian estimation of a multivariate TAR model when the noise
#'             process follows a Student-t distribution. Communications in Statistics - Theory and Methods, 50, 2508-2530.
#' @examples
#' data(returns)
#' dev.new()
#' plot(ts(as.matrix(returns[,-1])), main="Returns")
#'
"returns"
#'
#' @title Rainfall and two river flows in Colombia
#'
#' @description The data represent daily rainfall (in mm) and two river flows (in \eqn{m^3}/s)
#' in southern Colombia. A meteorological station located at an altitude of 2400 meters was
#' used to measure rainfall. The El Trebol hydrological station was used to measure the flow
#' in the Bedon river at an altitude of 1720 meters. The Villalosada hydrological station
#' measured the flow in the La Plata river at an altitude of 1300 meters. Geographically, the
#' stations are located near the equator. The last characteristic allows for control over
#' hydrological and meteorological factors that might distort the dynamic relationship between
#' rainfall and river flows. January 1, 2006, to April 14, 2009, was the sample period.
#' @docType data
#'
#' @usage data(riverflows)
#'
#' @format A data frame with 1200 rows and 4 variables:
#' \describe{
#'   \item{Date}{a vector that indicates the date each measurement was performed.}
#'   \item{Bedon}{a numerical vector indicating the Bedon river flow.}
#'   \item{LaPlata}{a numerical vector indicating the La Plata river flow.}
#'   \item{Rainfall}{a numerical vector indicating the rainfall.}
#' }
#' @keywords datasets
#' @references Calderon, S.A. and Nieto, F.H. (2017) Bayesian analysis of multivariate threshold autoregressive models
#'             with missing data. Communications in Statistics - Theory and Methods, 46, 296-318.
#' @examples
#' data(riverflows)
#' dev.new()
#' plot(ts(as.matrix(riverflows[,-1])), main="Rainfall and river flows")
#'
"riverflows"
#'

