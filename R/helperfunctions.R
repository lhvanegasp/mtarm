#' @title Auxiliary function to set hyperparameter values
#' @param prior list of values for the hyperparameters. Hyperparameters not included in this list take
#'              their default values.
#' @param regim positive integer value indicating the number of regimes.
#' @param k     positive integer value indicating the dimension of the output series.
#' @param dist  character string specifying the distribution used to describe the noise process behavior.
#' @param setar NULL if the model is SETAR, and a positive integer indicating the component of the output
#'              series that acts as the threshold variable, otherwise.
#' @param ssvs  a logical variable indicating if Stochastic Search Variable Selection (SSVS) is performed.
#' @return a list composed of the hyperparameter values for the a priori distribution of all the model parameters.
#' @export priors
#'
priors <- function(prior,regim,k,dist,setar,ssvs){
  if(is.null(prior$mu0)) prior$mu0 <- 0
  if(!is.numeric(prior$mu0)) stop("The hyperparameter 'mu0' must be a numeric value",call.=FALSE)
  if(is.null(prior$delta0)) prior$delta0 <- 1e9
  if(!is.numeric(prior$delta0) | prior$delta0<=0) stop("The hyperparameter 'delta0' must be a positive value",call.=FALSE)
  if(is.null(prior$omega0)) prior$omega0 <- 1e-9
  if(!is.numeric(prior$omega0) | prior$omega0<=0) stop("The hyperparameter 'omega0' must be a positive value",call.=FALSE)
  if(is.null(prior$tau0)) prior$tau0 <- k
  if(prior$tau0 <= k-1) stop(paste("The value of the hyperparameter 'tau0' must be higher than",k-1),call.=FALSE)
  if(dist %in% c("Skew-normal","Skew-Student-t")){
     if(is.null(prior$lambda0)) prior$lambda0 <- 1e9
  }
  if(regim > 1){
     if(is.null(setar)){
        if(is.null(prior$hmin)) prior$hmin <- 0
     }
     else{
      if(is.null(prior$hmin)) prior$hmin <- 1
      if(prior$hmin==0) stop("For SETAR models the delay parameter 'h' must be positive!",call.=FALSE)
     }
     if(is.null(prior$hmax)) prior$hmax <- 3
     if(is.null(prior$alpha0)) prior$alpha0 <- 0
     if(is.null(prior$alpha1)) prior$alpha1 <- 1
     if(floor(prior$hmin)!=prior$hmin | floor(prior$hmax)!=prior$hmax | prior$hmin < 0 | prior$hmax < 0)
        stop("The hyperparameters 'hmin' and 'hmax' must be positive integer values",call.=FALSE)
     if(prior$hmin > prior$hmax)
        stop("The hyperparameter 'hmin' must be lower than or equal to 'hmax'",call.=FALSE)
     if(prior$alpha0 < 0 | prior$alpha1 < 0 | prior$alpha0 > 1 | prior$alpha1 > 1)
        stop("The hyperparameters 'alpha0' and 'alpha1' must be within the interval (0,1)",call.=FALSE)
     if(prior$alpha0 > prior$alpha1)
        stop("The hyperparameter 'alpha0' must be lower than 'alpha1'",call.=FALSE)
  }
  if(ssvs){
     if(is.null(prior$rho0)) prior$rho0 <- 0.5
     if(prior$rho0 < 0 | prior$rho0 > 1) stop("The hyperparameter 'rho0' must be within the interval (0,1)",call.=FALSE)
  }
  switch(dist,
         "Hyperbolic"={if(is.null(prior$gamma0)) prior$gamma0 <- 0.1
                      if(is.null(prior$eta0)) prior$eta0 <- 4},
         "Skew-Student-t"=,
         "Student-t"={if(is.null(prior$gamma0)) prior$gamma0 <- 2
                      if(is.null(prior$eta0)) prior$eta0 <- 100},
         "Slash"={if(is.null(prior$gamma0)) prior$gamma0 <- 1e-9
                  if(is.null(prior$eta0)) prior$eta0 <- 1e-9},
         "Contaminated normal"={if(is.null(prior$gamma01)) prior$gamma01 <- 1e-9
                                if(is.null(prior$eta01)) prior$eta01 <- 1e-9
                                if(is.null(prior$gamma02)) prior$gamma02 <- 1e-9
                                if(is.null(prior$eta02)) prior$eta02 <- 1e-9})
  if(dist %in% c("Student-t","Skew-Student-t","Hyperbolic","Slash")){
     if(!is.numeric(prior$gamma0) | prior$gamma0 <= 0) stop("The hyperparameter 'gamma0' must be a positive value",call.=FALSE)
     if(!is.numeric(prior$eta0) | prior$eta0 <= 0) stop("The hyperparameter 'eta0' must be a positive value",call.=FALSE)
  }
  if(dist=="Contaminated normal"){
     if(!is.numeric(prior$gamma01) | prior$gamma01 <= 0) stop("The hyperparameter 'gamma01' must be a positive value",call.=FALSE)
     if(!is.numeric(prior$eta01) | prior$eta01 <= 0) stop("The hyperparameter 'eta01' must be a positive value",call.=FALSE)
     if(!is.numeric(prior$gamma02) | prior$gamma02 <= 0) stop("The hyperparameter 'gamma02' must be a positive value",call.=FALSE)
     if(!is.numeric(prior$eta02) | prior$eta02 <= 0) stop("The hyperparameter 'eta02' must be a positive value",call.=FALSE)
  }
  return(prior)
}
#'
#' @title Auxiliary function to set number of regimes and autoregressive orders
#' @param nregim positive integer value indicating the number of regimes.
#' @param p      a list with integer values indicating the autoregressive order within each regime
#' @param q      a list with integer values indicating the maximum lags for the exogenous series within each regime
#' @param d      a list with integer values indicating the maximum lags for the threshold series within each regime
#' @export ars
#'
ars <- function(nregim=1,p=1,q=0,d=0){
  if(nregim!=floor(nregim) | nregim<=0)
     stop("The argument 'nregim' must be a positive integer value!",call.=FALSE)
  p <- p[1:min(nregim,length(p))]
  q <- q[1:min(nregim,length(q))]
  d <- d[1:min(nregim,length(d))]
  if(any(p!=floor(p)) | any(p<=0))
     stop("The argument 'p' must be a vector of positive integer values",call.=FALSE)
  if(any(q!=floor(q)) | any(q<0) | any(d!=floor(d)) | any(d<0))
     stop("The arguments 'q' and 'd' must be vectors of non-negative integer values",call.=FALSE)
  if(length(p)==1 & nregim > 1) p <- rep(p[1],nregim)
  if(length(q)==1 & nregim > 1) q <- rep(q[1],nregim)
  if(length(d)==1 & nregim > 1) d <- rep(d[1],nregim)
  if(length(p) < nregim) p[(length(p)+1):nregim] <- rep(1,nregim-length(p))
  if(length(q) < nregim) q[(length(q)+1):nregim] <- rep(0,nregim-length(q))
  if(length(d) < nregim) q[(length(d)+1):nregim] <- rep(0,nregim-length(d))
  return(list(nregim=nregim,p=p,q=q,d=d))
}
#'


