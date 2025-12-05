#'
#' @title Simulation of multivariate time series according to a TAR model
#' @description This function simulates multivariate time series according to a user-specified TAR model.
#' @param n a positive integer value indicating the length of the desired output series.
#' @param k a positive integer value indicating the dimension of the desired output series.
#' @param ars It is a list composed of four objects, namely: the number of regimes (\code{nregim}),
#'            the autoregressive order (\code{p}), and the maximum lags for the exogenous (\code{q})
#'            and the threshold (\code{d}) series within each regime. It can be validated using the
#'            \code{ars()} routine.
#' @param Intercept an (optional) logical variable. If \code{TRUE}, then the model includes an intercept.
#' @param delay an (optional) non-negative integer value indicating the delay in the threshold series.
#' @param trend It is an (optional) character string that allows the user to specify the
#'              degree of deterministic time trend to be included in each regime. The available
#'              options are: linear trend ("linear"), quadratic trend ("quad"), and no time
#'              trend ("none"). By default, \code{trend} is set to "none".
#' @param nseason It is an (optional) integer value that allows the user to specify the number
#'                of seasonal periods. When the \code{nseason} is specified, \code{nseason}-1
#'                seasonal dummies are added to the regressors within each regime.
#' @param thresholds a vector with \eqn{l-1} real values sorted ascendingly.
#' @param parms a list with as many sublists as regimes in the user-specified TAR model. Each sublist is composed of two matrices. The first corresponds
#'              to location parameters, while the second corresponds to scale parameters.
#' @param t.series a matrix with the values of the threshold series.
#' @param ex.series a matrix with the values of the multivariate exogenous series.
#' @param dist an (optional) character string which allows the user to specify the multivariate
#'             distribution to be used to describe the behavior of the noise process. The
#'             available options are: Gaussian ("Gaussian"), Student-\eqn{t} ("Student-t"),
#'             Slash ("Slash"), Symmetric Hyperbolic ("Hyperbolic"), Laplace ("Laplace"), and
#'             contaminated normal ("Contaminated normal"). By default,\code{dist} is set to
#'             "Gaussian".
#' @param skewness an (optional) vector with the values of the skewness parameters. By default,\code{delta} is set to \code{NULL}.
#' @param extra a value indicating the value of the extra parameter of the noise process distribution, if any.
#' @param setar an (optional) positive integer indicating the component of the output series which should
#'              be the threshold variable. By default,\code{setar} is set to \code{NULL}.
#'
#' @return a \code{data.frame} containing the output series, threshold series (if any), and multivariate exogenous series (if any).
#' @references Vanegas, L.H. and Calderón, S.A. and Rondón, L.M. (2025) Bayesian estimation of a multivariate tar model when the
#'             noise process distribution belongs to the class of gaussian variance mixtures. International Journal
#'             of Forecasting.
#' @export simtar
#' @examples
#' \donttest{
#' ###### Simulation of a trivariate TAR model with two regimes
#' n <- 2000
#' k <- 3
#' myars <- ars(nregim=2,p=c(1,2))
#' Z <- as.matrix(arima.sim(n=n+max(myars$p),list(ar=c(0.5))))
#' probs <- sort((0.6 + runif(myars$nregim-1)*0.8)*c(1:(myars$nregim-1))/myars$nregim)
#' parms <- list()
#' for(j in 1:myars$nregim){
#'     np <- 1 + myars$p[j]*k
#'     parms[[j]] <- list()
#'     parms[[j]]$location <- c(ifelse(runif(np*k)<=0.5,1,-1)*rbeta(np*k,shape1=4,shape2=16))
#'     parms[[j]]$location <- matrix(parms[[j]]$location,np,k)
#'     parms[[j]]$scale <- rgamma(k,shape=1,scale=1)*diag(k)
#' }
#' thresholds <- quantile(Z,probs=probs)
#' out1 <- simtar(n=n,k=k,ars=myars,parms=parms,thresholds=thresholds,
#'                t.series=Z,dist="Student-t",extra=6)
#' str(out1)
#'
#' fit1 <- mtar(~ Y1 + Y2 + Y3 | t.series, data=out1, ars=myars, dist="Student-t",
#'              n.sim=3000, n.burn=2000, n.thin=2)
#' summary(fit1)
#'
#' ###### Simulation of a trivariate VAR model
#' n <- 2000
#' k <- 3
#' myars <- ars(nregim=1,p=2)
#' parms <- list()
#' for(j in 1:myars$nregim){
#'     np <- 1 + myars$p[j]*k
#'     parms[[j]] <- list()
#'     parms[[j]]$location <- c(ifelse(runif(np*k)<=0.5,1,-1)*rbeta(np*k,shape1=4,shape2=16))
#'     parms[[j]]$location <- matrix(parms[[j]]$location,np,k)
#'     parms[[j]]$scale <- rgamma(k,shape=1,scale=1)*diag(k)
#' }
#' out2 <- simtar(n=n,k=k,ars=myars,parms=parms,dist="Slash",extra=2)
#' str(out2)
#'
#' fit2 <- mtar(~ Y1 + Y2 + Y3, data=out2, ars=myars, dist="Slash", n.sim=3000,
#'              n.burn=2000, n.thin=2)
#' summary(fit2)
#'
###### Simulation of a trivariate SETAR model with two regimes
#' n <- 5000
#' k <- 3
#' myars <- ars(nregim=2,p=c(1,2))
#' parms <- list()
#' for(j in 1:myars$nregim){
#'     np <- 1 + myars$p[j]*k
#'     parms[[j]] <- list()
#'     parms[[j]]$location <- c(ifelse(runif(np*k)<=0.5,1,-1)*rbeta(np*k,shape1=4,shape2=16))
#'     parms[[j]]$location <- matrix(parms[[j]]$location,np,k)
#'     parms[[j]]$scale <- rgamma(k,shape=1,scale=1)*diag(k)
#' }
#' out3 <- simtar(n=n, k=k, ars=myars, parms=parms, delay=2,
#'                thresholds=-1, dist="Laplace", setar=2)
#' str(out3)
#'
#' fit3 <- mtar(~ Y1 + Y2 + Y3, data=out3, ars=myars, dist="Laplace",
#'              n.sim=3000, n.burn=2000, n.thin=2, setar=2)
#' summary(fit3)
#'
#' }
#'
simtar <- function(n,k=2,ars=ars(),Intercept=TRUE,trend=c("none","linear","quad"),nseason=NULL,
                   parms,delay=0,thresholds=NULL,t.series=NULL,ex.series=NULL,dist=c("Gaussian",
                   "Student-t","Hyperbolic","Laplace","Slash","Contaminated normal","Skew-Student-t",
                   "Skew-normal"),skewness=NULL,extra=NULL,setar=NULL){
  dist <- match.arg(dist)
  trend <- match.arg(trend)
  if(k<=0 | k!=floor(k)) stop("The value of the argument 'k' must be a positive integer!",call.=FALSE)
  if(n<=0 | n!=floor(n)) stop("The value of the argument 'n' must be a positive integer!",call.=FALSE)
  if(!is.null(nseason)){
     if(nseason!=floor(nseason) | nseason<2) stop("The value of the argument 'nseason' must be an integer higher than 1",call.=FALSE)
  }
  deterministic <- Intercept + switch(trend,"linear"=1,"quad"=2) + ifelse(is.null(nseason),0,nseason-1)
  regim <- ars$nregim

  if(regim > 1){
     if(delay<0 | delay!=floor(delay)) stop("The value of the argument 'delay' must be a non-negative integer!",call.=FALSE)
     if(delay==0 & !is.null(setar)) stop("For SETAR models the value of the argument 'delay' must be a positive integer!",call.=FALSE)
     if(is.null(t.series) & is.null(setar)) stop("For TAR models the argument 't.series' is required!",call.=FALSE)
     if(is.null(thresholds)) stop("For TAR and SETAR models the argument 'thresholds' is required!",call.=FALSE) else thresholds <- sort(thresholds)
     if(length(thresholds)!=regim-1)
        stop(paste0("The length of the argument 'thresholds' must be ",regim-1,", and the length of the argument supplied is ",length(thresholds)),call.=FALSE)
  }
  ps <- max(ars$p,ars$q,ars$d,delay)
  if(regim > 1 & is.null(setar)){
     if(length(t.series)!=n+ps)
        stop(paste0("The length of the argument 't.series' must be ",n+ps,", and the length of the argument supplied is ",length(t.series)),call.=FALSE)
  }
  if(max(ars$q)>0){
     if(is.null(ex.series)) stop("An exogenous series is required!",call.=FALSE)
     if(nrow(ex.series)!=n+ps)
        stop(paste0("The number of rows of 'ex.series' must be ",n+ps,", and the number of rows of the argument supplied is ",nrow(ex.series)),call.=FALSE)
     r <- ncol(ex.series)
  }else r <- 0
  if(dist %in% c("Student-t","Hyperbolic","Slash","Contaminated normal","Skew-Student-t")){
     if(is.null(extra))
        stop("For 'Student-t', 'Hyperbolic', 'Slash', 'Contaminated normal' and 'Skew-Student-t' distributions an extra parameter value must be specified!",call.=FALSE)
     if(dist %in% c("Student-t","Skew-Student-t","Hyperbolic","Slash") & extra[1]<=0)
        stop("For 'Student-t', 'Skew-Student-t', 'Hyperbolic', and 'Slash' distributions the extra parameter value must be positive!",call.=FALSE)
     if(dist=="Contaminated normal" & (length(extra)!=2 | any(extra<=0) | any(extra>=1)))
        stop("For 'Contaminated normal' distribution the extra parameter must be a 2-dimensional vector with values in the interval (0,1)!",call.=FALSE)
  }
  if(dist %in% c("Skew-normal","Skew-Student-t") & (is.null(skewness) | length(extra)!=k))
     stop(paste0("For 'Skew-normal' and 'Skew-Student-t' distributions an ",k,"-dimensional skewness parameter must be specified!"),call.=FALSE)
  switch(trend,
         "none"={Xd <- matrix(1,n,1)},
         "linear"={Xd <- matrix(cbind(1,c(1:n)),n,2)},
         "quad"={Xd <- matrix(cbind(1,c(1:n),c(1:n)^2),n,3)})
  if(!is.null(nseason))
     Xd <- cbind(Xd,matrix(rep(diag(nseason),ceiling(n/nseason)),ceiling(n/nseason)*nseason,nseason,byrow=TRUE)[1:n,-1])
  if(!Intercept) Xd <- Xd[,-1]
  for(i in 1:regim){
      if(ncol(parms[[i]]$location)!=k | nrow(parms[[i]]$location)!=(ncol(Xd)+ars$p[i]*k+ars$q[i]*r+ars$d[i]))
         stop(paste0("The dimension of the location matrix in regime ",i," must be ",(deterministic+ars$p[i]*k+ars$q[i]*r+ars$d[i]),"X",k,"!"),call.=FALSE)
      parms[[i]]$scale2  <- try(chol(parms[[i]]$scale),silent=TRUE)
      if(!is.matrix(parms[[i]]$scale2)) stop(paste0("The scale matrix in regime ",i," is not positive definite!"),call.=FALSE)
  }
  myseries <- matrix(rnorm((n+ps)*k),n+ps,k)
  for(i in 1:n){
      current <- ps + i
      if(regim > 1){
         if(!is.null(setar)) t.series.c <- myseries[current-delay,setar]
         else t.series.c <- t.series[current-delay]
         regimeni <- cut(t.series.c,breaks=c(-Inf,thresholds,Inf),labels=1:regim)
      }else regimeni <- 1
    X <-  Xd[i,]
    for(j in 1:ars$p[regimeni]) X <- c(X,myseries[current-j,])
    if(ars$q[regimeni] > 0) for(j in 1:ars$q[regimeni]) X <- c(X,ex.series[current-j,])
    if(ars$d[regimeni] > 0) for(j in 1:ars$d[regimeni]) if(!is.null(setar)) X <- c(X,myseries[current-j,setar]) else X <- c(X,t.series[current-j])
    Theta <- parms[[regimeni]]$location
    mu <- colSums(matrix(X,nrow(Theta),ncol(Theta))*Theta)
    u <- switch(dist,
                "Gaussian"=1,
                "Student-t"=,
                "Skew-Student-t"={1/rgamma(1,shape=extra/2,rate=extra/2)},
                "Slash"={1/rbeta(1,shape1=extra/2,shape2=1)},
                "Contaminated normal"={ifelse(runif(1)<=extra[1],1/extra[2],1)},
                "Laplace"={rexp(1,rate=1/8)},
                "Hyperbolic"={rgig(n=1,lambda=1,chi=1,psi=extra^2)})
    if(dist %in% c("Skew-normal","Skew-Student-t")) offset <- sqrt(u)*matrix(skewness*qnorm(0.5 + runif(k)*0.5),k,1)
    else offset <- matrix(0,k,1)
    myseries[current,] <- crossprod(parms[[regimeni]]$scale2,matrix(sqrt(u)*rnorm(k),k,1)) + matrix(mu,k,1) + offset
  }
  for(i in 1:regim) parms[[i]]$scale2 <- NULL
  datos <- data.frame(myseries)
  colnames(datos) <- paste("Y",1:k,sep="")
  if(regim > 1 & is.null(setar)) datos <- data.frame(datos,t.series) else datos <- data.frame(datos)
  if(max(ars$q)>0){
     colnames(ex.series) <- paste("X",1:r,sep="")
     datos <- data.frame(datos,ex.series)
  }
  return(datos)
}
#'
#'
