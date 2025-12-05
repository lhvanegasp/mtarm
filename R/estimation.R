#'
#' @title Bayesian estimation of a multivariate Threshold Autoregressive (TAR) model.
#' @description This function uses Gibbs sampling to generate a sample from the posterior
#'              distribution of the parameters of a multivariate TAR model when the noise
#'              process follows Gaussian, Student-\eqn{t}, Slash, Symmetric Hyperbolic,
#'              Contaminated normal, Laplace, Skew-normal, or skew-\eqn{t} distribution.
#' @param formula a three-part expression of type \code{Formula} describing the TAR model
#'                to be fitted to the data. In the first part, the variables in the
#'                multivariate output series are listed; in the second part, the threshold
#'                series is specified, and in the third part, the variables in the
#'                multivariate exogenous series are specified.
#' @param ars a list composed of four objects, namely: the number of regimes (\code{nregim}),
#'            the autoregressive order (\code{p}), and the maximum lags for the exogenous (\code{q})
#'            and the threshold (\code{d}) series within each regime. It can be validated using the
#'            routine \code{ars()}. Only \code{nregim} and \code{p} are required.
#' @param Intercept an (optional) logical variable. If \code{TRUE}, then the model
#'                  includes an intercept.
#' @param trend an (optional) character string that allows the user to specify the
#'              degree of deterministic time trend to be included in each regime. The available
#'              options are: linear trend ("linear"), quadratic trend ("quad"), and no time
#'              trend ("none"). By default, \code{trend} is set to "none".
#' @param nseason an (optional) integer value that allows the user to specify the number
#'                of seasonal periods. When the \code{nseason} is specified, \code{nseason}-1
#'                seasonal dummies are added to the regressors within each regime.
#' @param data a data frame containing the variables in the model.
#'             If not found in data, the variables are taken from \code{environment(formula)},
#'             typically the environment from which \code{mtar} is called.
#' @param subset an (optional) vector specifying a subset of observations to be used in the
#'               fitting process.
#' @param dist an (optional) character string that allows the user to specify the
#'             multivariate distribution to be used to describe the noise process
#'             behavior. The available options are: Gaussian ("Gaussian"), Student-\eqn{t}
#'             ("Student-t"), Slash ("Slash"), Symmetric Hyperbolic ("Hyperbolic"),
#'             Laplace ("Laplace"), Contaminated normal ("Contaminated normal"),
#'             Skew-normal ("Skew-normal") and Skew-Student-\eqn{t} ("Skew-Student-t").
#'             By default, \code{dist} is set to "Gaussian".
#' @param n.sim an (optional) positive integer specifying the required number of iterations
#'              for the simulation after the burn-in period. By default, \code{n.sim} is set
#'              to 500.
#' @param n.burnin an (optional) positive integer specifying the required number of burn-in
#'                 iterations for the simulation. By default, \code{n.burnin} is set to 100.
#' @param n.thin an (optional) positive integer specifying the required thinning interval
#'               for the simulation. By default, \code{n.thin} is set to 1.
#' @param row.names an (optional) vector that allows the user to name the time point to
#'                  which each row in the data set corresponds.
#' @param prior an (optional) list that allows the user to specify the values of the
#'              hyperparameters, that is, allows to specify the values of the parameters
#'              of the prior distributions. It can be validated using the \code{priors()} routine.
#' @param ssvs  an (optional) logical variable. If \code{ssvs=TRUE} then the Stochastic Search
#'              Variable Selection (SSVS) procedure is applied to identify relevant lags of the
#'              output, exogenous and threhold series. By default, \code{ssvs} is set to \code{FALSE}.
#' @param setar an (optional) positive integer indicating the component of the output series which is
#'              the threshold variable. By default,\code{setar} is set to \code{NULL}, which
#'              indicates that the fitted model is not SETAR.
#' @param ... further arguments passed to or from other methods.
#'
#' @return an object of class \emph{mtar} in which the main results of the model fitted to the data are stored, i.e., a
#' list with components including
#' \tabular{ll}{
#' \code{chains}   \tab list with several arrays, which store the values of each model parameter in each iteration of the simulation,\cr
#' \tab \cr
#' \code{n.sim}    \tab number of iterations of the simulation after the burn-in period,\cr
#' \tab \cr
#' \code{n.burnin} \tab number of burn-in iterations in the simulation,\cr
#' \tab \cr
#' \code{n.thin}   \tab thinning interval in the simulation,\cr
#' \tab \cr
#' \code{ars}      \tab list composed of four objects, namely: \code{nregim}, \code{p}, \code{q} and \code{d},
#'                      each of which corresponds to a vector of non-negative integers with as
#'                      many elements as there are regimes in the fitted TAR model,\cr
#' \tab \cr
#' \code{dist}     \tab name of the multivariate distribution used to describe the behavior of
#'                      the noise process,\cr
#' \tab \cr
#' \code{threshold.series}  \tab vector with the values of the threshold series,\cr
#' \tab \cr
#' \code{output.series}   \tab matrix with the values of the output series,\cr
#' \tab \cr
#' \code{exogenous.series} \tab matrix with the values of the exogenous series,\cr
#' \tab \cr
#' \code{Intercept}    \tab If \code{TRUE}, then the model included an intercept term in each regime,\cr
#' \tab \cr
#' \code{trend}    \tab the degree of the deterministic time trend, if any,\cr
#' \tab \cr
#' \code{nseason}    \tab the number of seasonal periods, if any,\cr
#' \tab \cr
#' \code{formula}      \tab the formula,\cr
#' \tab \cr
#' \code{call}         \tab the original function call.\cr
#' }
#' @export mtar
#' @seealso \link{DIC}, \link{WAIC}
#' @references Nieto, F.H. (2005) Modeling Bivariate Threshold Autoregressive Processes in the Presence of Missing Data.
#'             Communications in Statistics - Theory and Methods, 34, 905-930.
#' @references Romero, L.V. and Calderon, S.A. (2021) Bayesian estimation of a multivariate TAR model when the noise
#'             process follows a Student-t distribution. Communications in Statistics - Theory and Methods, 50, 2508-2530.
#' @references Calderon, S.A. and Nieto, F.H. (2017) Bayesian analysis of multivariate threshold autoregressive models
#'             with missing data. Communications in Statistics - Theory and Methods, 46, 296-318.
#' @references Vanegas, L.H. and Calderón, S.A. and Rondón, L.M. (2025) Bayesian estimation of a multivariate tar model when the
#'             noise process distribution belongs to the class of gaussian variance mixtures. International Journal
#'             of Forecasting.
#' @examples
#' \donttest{
#' ###### Example 1: Returns of the closing prices of three financial indexes
#' data(returns)
#' fit1 <- mtar(~ COLCAP + BOVESPA | SP500, data=returns, row.names=Date,
#'              dist="Gaussian", ars=ars(nregim=3,p=c(1,1,2)), n.burnin=100,
#'              n.sim=3000, n.thin=2)
#' summary(fit1)
#'
#' ###### Example 2: Rainfall and two river flows in Colombia
#' data(riverflows)
#' fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, row.names=Date,
#'              dist="Gaussian", ars=ars(nregim=3,p=5), n.burnin=2000,
#'              n.sim=3000, n.thin=2)
#' summary(fit2)
#' }
#'
#'
mtar <- function(formula, data, subset, Intercept=TRUE, trend=c("none","linear","quad"), nseason=NULL, ars=ars(), row.names,
                 dist=c("Gaussian","Student-t","Hyperbolic","Laplace","Slash","Contaminated normal","Skew-Student-t","Skew-normal"),
                 prior=list(), n.sim=500, n.burnin=100, n.thin=1, ssvs=FALSE, setar=NULL, ...){
  dist <- match.arg(dist)
  trend <- match.arg(trend)
  log <- FALSE
  if(!is.null(nseason)){
     if(nseason!=floor(nseason) | nseason<2) stop("The value of the argument 'nseason' must be an integer higher than 1",call.=FALSE)
  }
  if(missing(data)) data <- environment(formula)
  regim <- ars$nregim
  mmf <- match.call(expand.dots = FALSE)
  m <- match(c("formula", "data", "subset", "na.action", "row.names"), names(mmf), 0)
  mmf <- mmf[c(1,m)]
  mmf$drop.unused.levels <- TRUE
  mmf[[1]] <- as.name("model.frame")
  mmf$formula <- Formula(formula)
  mmf <- eval(mmf, parent.frame())
  if(!missingArg(row.names)) row.names <- as.vector(as.character(model.extract(mmf,row.names)))
  mx <- model.part(Formula(formula), data = mmf, rhs = 1, terms = TRUE)
  D <- model.matrix(mx, data = mmf)
  if(attr(terms(mx),"intercept")){
     Dnames <- colnames(D)
     D <- matrix(D[,-1],ncol=length(Dnames)-1)
     colnames(D) <- Dnames[-1]
  }
  if(log){
     if(any(D<0)) stop(paste0("There are non-positive values in the output series, so it cannot be described using the log-",tolower(dist)," distribution."),call.=FALSE)
     D <- log(D)
  }
  k <- ncol(D)
  nano_ <- list(...)
  if(!is.null(nano_$stop)){
     if(!missingArg(row.names)) return(list(data=mmf,k=k,mynames=row.names))
     else return(list(data=mmf,k=k))
     stop(call.=FALSE)
  }
  if(!is.null(setar)){
     if(floor(setar)!=setar | setar<1 | setar>k) stop(paste("The value of the argument SETAR should be an integer greater than or equal to 1, but less than or equal to",k),call.=FALSE)
  }
  if(regim > 1){
     if(is.null(setar)){
        mz <- model.part(Formula(formula), data = mmf, rhs = 2, terms = TRUE)
        Z <- model.matrix(mz, data = mmf)
        if(attr(terms(mz),"intercept")){
           Znames <- colnames(Z)
           Z <- as.matrix(Z[,-1])
           colnames(Z) <- Znames[-1]
        }
     }else{
          if(max(ars$d)>0) stop("The lags of the threshold series are not applicable to SETAR models, since they coincide with the output series lags!",call.=FALSE)
          Z <- matrix(D[,setar],ncol=1)
          colnames(Z) <- colnames(D)[setar]
     }
     ta <- vector()
  }
  if(max(ars$q) > 0){
     mx2 <- model.part(Formula(formula), data = mmf, rhs = 3, terms = TRUE)
     X2 <- model.matrix(mx2, data = mmf)
     if(attr(terms(mx2),"intercept")){
        X2names <- colnames(X2)
        X2 <- as.matrix(X2[,-1])
        colnames(X2) <- X2names[-1]
     }
     r <- ncol(X2)
  }
  prior <- priors(prior,regim=regim,k=k,dist=dist,setar=setar,ssvs=ssvs)
  data <- list()
  chains <- list()
  n.sim <- ceiling(abs(n.sim))
  n.thin <- ceiling(abs(n.thin))
  n.burnin <- ceiling(abs(n.burnin))
  rep <- n.sim*n.thin + n.burnin
  ids0 <- matrix(seq(1,n.sim*n.thin*k,k))
  ids0 <- ids0[seq(1,n.sim*n.thin,n.thin)]
  ids <- (n.burnin+1)*k + as.vector(apply(matrix(ids0),1,function(x) x + c(0:(k-1))))
  ids1 <- n.burnin + seq(1,n.sim*n.thin,n.thin)
  Sigmanew2 <- list()
  name <- list()
  tn1 <- function(mu,var){
         temp <- pnorm(0,mean=mu,sd=sqrt(var))
         temp <- temp + runif(1)*(1 - temp)
         return(ifelse(temp>0.9999999999999999,-mu*0.001,qnorm(temp)*sqrt(var) + mu))
  }
  if(regim > 1){
     ps <- max(ars$p,ars$q,ars$d,prior$hmax)
     Zs <- Z[(ps+1-prior$hmin):(nrow(D)-prior$hmin),]
     t1 <- quantile(Zs,probs=prior$alpha1)
     t0 <- quantile(Zs,probs=prior$alpha0)
     probs <- prior$alpha0 + (prior$alpha1-prior$alpha0)*seq(1,regim-1,1)/regim
     thresholds <- quantile(Zs,probs=probs)
     regs <- cut(Zs,breaks=c(-Inf,sort(thresholds),Inf),labels=FALSE)
     thresholds.chains <- matrix(thresholds,regim-1,1)
     hs.chains <- matrix(prior$hmin,1,1)
  }else{
       ps <- max(ars$p,ars$q,ars$d)
       regs <- matrix(1,nrow(D)-ps,1)
  }
  switch(trend,
         "none"={Xd <- matrix(1,nrow(D)-ps,1)
                 namedeter="(Intercept)"
                 deterministic <- 1},
         "linear"={Xd <- matrix(cbind(1,seq(1,nrow(D)-ps,1)),nrow(D)-ps,2)
                   namedeter=c("(Intercept)","Time")
                   deterministic <- 2},
         "quad"={Xd <- matrix(cbind(1,seq(1,nrow(D)-ps,1),seq(1,nrow(D)-ps,1)^2),nrow(D)-ps,3)
                 namedeter=c("(Intercept)","Time","Time^2")
                 deterministic <- 3})
  if(!is.null(nseason)){
     if(!Intercept) stop("The argument 'nseason' is not applicable when 'Intercept=FALSE'!",call.=FALSE)
     Xd <- cbind(Xd,matrix(rep(diag(nseason),ceiling((nrow(D)-ps)/nseason)),ceiling((nrow(D)-ps)/nseason)*nseason,nseason,byrow=TRUE)[1:(nrow(D)-ps),-1])
     namedeter <- c(namedeter,paste0("Season.",2:nseason))
     deterministic <- deterministic + nseason - 1
  }
  if(!Intercept){
     Xd <- Xd[,-1]
     namedeter <- namedeter[-1]
     deterministic <- deterministic - 1
  }
  if(!missingArg(row.names)) row.names2 <- row.names[(ps+1):nrow(D)] else row.names2 <- 1:(nrow(D)-ps)
  for(i in 1:regim){
      y <- matrix(D[(ps+1):nrow(D),1:k],ncol=k); X <- Xd
      if(ars$p[i] > 0){
         for(j in 1:ars$p[i]) X <- cbind(X,D[((ps+1)-j):(nrow(D)-j),])
         name0 <- rep(1:ars$p[i],k)
         if(any(nchar(name0)>1)){
            name1 <- nchar(name0); name1 <- max(name1) - name1
            name0 <- unlist(lapply(1:length(name1),function(x) paste0(rep(" ",name1[x]),name0[x])))
         }
         name[[i]] <- c(namedeter,paste0(rep(colnames(D)[1:k],ars$p[i]),sort(paste0(".lag(",name0)),")"))
      }
      if(ars$q[i]>0){
         for(j in 1:ars$q[i]) X <- cbind(X,X2[((ps+1)-j):(nrow(D)-j),])
         name0 <- rep(1:ars$q[i],r)
         if(any(nchar(name0)>1)){
            name1 <- nchar(name0); name1 <- max(name1) - name1
            name0 <- unlist(lapply(1:length(name1),function(x) paste0(rep(" ",name1[x]),name0[x])))
         }
         name[[i]] <- c(name[[i]],paste0(rep(colnames(X2),ars$q[i]),sort(paste0(".lag(",name0)),")"))
      }
      if(ars$d[i]>0){
         for(j in 1:ars$d[i]) X <- cbind(X,Z[((ps+1)-j):(nrow(D)-j),])
         name0 <- 1:ars$d[i]
         if(any(nchar(name0)>1)){
            name1 <- nchar(name0); name1 <- max(name1) - name1
            name0 <- unlist(lapply(1:length(name1),function(x) paste0(rep(" ",name1[x]),name0[x])))
         }
         name[[i]] <- c(name[[i]],paste0(rep(colnames(Z),ars$d[i]),sort(paste0(".lag(",name0)),")"))
      }
      colnames(X) <- name[[i]]
      rownames(X) <- rownames(y) <- row.names2
      colnames(y) <- colnames(D)
      data[[i]] <- list()
      data[[i]]$y <- y
      data[[i]]$X <- X
      places <- regs == i
      X <- matrix(X[places,],sum(places),ncol(X))
      y <- matrix(y[places,],nrow(X),ncol(y))
      betanew <- solve(crossprod(X),crossprod(X,y),symmetric=TRUE)
      Sigmanew <- crossprod(y-X%*%betanew)/nrow(X)
      Sigmanew2[[i]] <- chol2inv(chol(Sigmanew))
      chains[[i]] <- list()
      chains[[i]]$location <- betanew
      chains[[i]]$scale <- Sigmanew
      chains[[i]]$zeta <- matrix(1,nrow(betanew),1)
  }
  tol <- unlist(lapply(data,function(x) ncol(x$X)))*k*1.2
  us <- matrix(1,nrow(data[[1]]$X),1)
  ss <- matrix(0,nrow(data[[1]]$X),1)
  zs <- matrix(0,nrow(data[[1]]$y),k)
  chains$delta <- matrix(0,k,1)

  Omega0 <- diag(k)*prior$omega0
  switch(dist,
         "Hyperbolic"={chains$extra <- matrix((prior$gamma0+prior$eta0)/2,1,1)
                       nus <- matrix(seq(prior$gamma0,prior$eta0,length=10001),10001,1)
                       num1 <- nus[2:length(nus)] - nus[1:(length(nus)-1)]
                       num2 <- (nus[2:length(nus)] + nus[1:(length(nus)-1)])/2
                       resto <- log(nus) - log(besselK(nus,nu=1))},
         "Skew-Student-t"=,
         "Student-t"={chains$extra <- matrix((prior$gamma0+prior$eta0)/2,1,1)
                      nus <- matrix(seq(prior$gamma0,prior$eta0,length=10001),10001,1)
                      num1 <- nus[2:length(nus)] - nus[1:(length(nus)-1)]
                      num2 <- (nus[2:length(nus)] + nus[1:(length(nus)-1)])/2
                      resto <- (nus/2)*log(nus/2) - lgamma(nus/2)},
         "Slash"={chains$extra <- matrix(100,1,1)},
         "Contaminated normal"={chains$extra <- matrix(c(0.01,0.99),2,1)})
  lsm <- function(aq0,aq1){
      delta1 <- prior$delta0^(s/sum(aq1))
      delta0 <- prior$delta0^(s/sum(aq0))
      X1 <- matrix(sqrt(usi),n,sum(aq1))*matrix(X[,aq1==1],n,sum(aq1))
      X0 <- matrix(sqrt(usi),n,sum(aq0))*matrix(X[,aq0==1],n,sum(aq0))
      ys <- matrix(sqrt(usi),n,k)*y
      X12 <- crossprod(X1) + diag(sum(aq1))/delta1
      X02 <- crossprod(X0) + diag(sum(aq0))/delta0
      theta0 <- solve(X02,crossprod(X0,ys) + matrix(prior$mu0/delta0,sum(aq0),k))
      theta1 <- solve(X12,crossprod(X1,ys) + matrix(prior$mu0/delta1,sum(aq1),k))
      res0 <- crossprod(ys - X0%*%theta0)
      res0 <- log(det(res0 + crossprod((theta0-prior$mu0)/matrix(sqrt(delta0),sum(aq0),k)) + Omega0))
      res1 <- crossprod(ys - X1%*%theta1)
      res1 <- log(det(res1 + crossprod((theta1-prior$mu0)/matrix(sqrt(delta1),sum(aq1),k)) + Omega0))
      aa <- (k/2)*(log(det(X12)) - log(det(X02))) + ((prior$tau0+n)/2)*(res1 - res0) + log((1-prior$rho0)/prior$rho0)
      if(aa <= log(1/runif(1) - 1)) aq <- aq1 else aq <- aq0
      return(aq)
  }
  Loglik <- function(h,thresholds){
    regs <- cut(Z[(ps+1-h):(nrow(D)-h),],breaks=c(-Inf,sort(thresholds),Inf),labels=FALSE)
    result <- 0
    for(i in 1:regim){
        places <- regs == i
        if(ssvs) zeta <- chains[[i]]$zeta[,ncols/k]
        else zeta <- rep(1,ncol(data[[i]]$X))
        X <- matrix(data[[i]]$X[places,zeta==1],sum(places),sum(zeta))
        y <- matrix(data[[i]]$y[places,] - matrix(chains$delta[,ncol(chains$delta)],nrow(X),k,byrow=TRUE)*zs[places,],nrow(X),k)
        usi <- us[places]
        Xu <- matrix(sqrt(usi),nrow(X),ncol(X))*X
        yu <- matrix(sqrt(usi),nrow(X),k)*y
        resu <- yu-Xu%*%chains[[i]]$location[zeta==1,(ncols-k+1):ncols]
        ds <- colSums(t(resu)*tcrossprod(Sigmanew2[[i]],resu))
        result <- result -0.5*sum(ds - log(det(Sigmanew2[[i]])) - k*log(usi) + k*log(2*pi))
    }
    return(result)
  }
  nano_$bar <- ifelse(is.null(nano_$bar),TRUE,FALSE)
  if(nano_$bar) bar <- txtProgressBar(min=0, max=rep, initial=0, width=min(50,rep), char="+", style=3)
  for(j in 1:rep){
      if(dist %in% c("Skew-normal","Skew-Student-t")){
         bis <- matrix(0,k,1)
         Bis <- matrix(0,k,k)
      }
      if(regim > 1){
         hs <- hs.chains[,j]
         thresholds <- thresholds.chains[,j]
         regs <- cut(Z[(ps+1-hs):(nrow(D)-hs),],breaks=c(-Inf,sort(thresholds),Inf),labels=FALSE)
      }
      for(i in 1:regim){
          places <- regs == i
          X <- matrix(data[[i]]$X[places,],sum(places),ncol(data[[i]]$X))
          n <- nrow(X); s <- ncol(X)
          y2z <- matrix(data[[i]]$y[places,],n,k)
          y <- matrix(y2z - matrix(chains$delta[,j],n,k,byrow=TRUE)*zs[places,],n,k)
          if(ssvs){
             usi <- us[places]
             zeta <- chains[[i]]$zeta[,j]
             for(oi in 1:ars$p[i]){
                 zeta0 <- zeta1 <- zeta
                 zeta1[deterministic + ((oi-1)*k + 1):(oi*k)] <- 1
                 zeta0[deterministic + ((oi-1)*k + 1):(oi*k)] <- 0
                 zeta <- lsm(zeta0,zeta1)
             }
             if(ars$q[i]>0){
                for(oi in 1:ars$q[i]){
                    zeta0 <- zeta1 <- zeta
                    zeta1[deterministic + ars$p[i]*k + ((oi-1)*r + 1):(oi*r)] <- 1
                    zeta0[deterministic + ars$p[i]*k + ((oi-1)*r + 1):(oi*r)] <- 0
                    zeta <- lsm(zeta0,zeta1)
                }
             }
             if(ars$d[i]>0){
                for(oi in 1:ars$d[i]){
                    zeta0 <- zeta1 <- zeta
                    offset <- ifelse(ars$q[i]>0,ars$q[i]*r,0)
                    zeta1[deterministic + ars$p[i]*k + offset + oi] <- 1
                    zeta0[deterministic + ars$p[i]*k + offset + oi] <- 0
                    zeta <- lsm(zeta0,zeta1)
                }
             }
             chains[[i]]$zeta <- cbind(chains[[i]]$zeta,zeta)
             X <- matrix(X[,zeta==1],n,sum(zeta))
          }else zeta <- rep(1,s)
          Sigmarinv <- diag(sum(zeta))/prior$delta0^(s/sum(zeta))
          s <- sum(zeta)
          mu0s <- matrix(prior$mu0,s,k)
          ncols <- ncol(chains[[i]]$location)
          if(dist %in% c("Gaussian","Skew-normal")) us[places] <- rep(1,n)
          else{
              resu <- y-X%*%chains[[i]]$location[zeta==1,(ncols-k+1):ncols]
              usi <- colSums(t(resu)*tcrossprod(Sigmanew2[[i]],resu))
          }
          switch(dist,
                 "Laplace"={us[places] <- apply(matrix(usi,length(usi),1),1,function(x) 1/rgig(n=1,lambda=(2-k)/2,chi=x,psi=1/4))},
                 "Hyperbolic"={us[places] <- apply(matrix(usi,length(usi),1),1,function(x) 1/rgig(n=1,lambda=(2-k)/2,chi=x+1,psi=chains$extra[,j]^2))},
                 "Student-t"={us[places] <- rgamma(n,shape=(chains$extra[,j]+k)/2,scale=2/(chains$extra[,j]+usi))},
                 "Skew-Student-t"={us[places] <- rgamma(n,shape=(chains$extra[,j]+2*k)/2,scale=2/(chains$extra[,j]+usi+rowSums(matrix(zs[places,]^2,n,k))))},
                 "Slash"={u0 <- pgamma(q=1,shape=(chains$extra[,j]+k)/2,scale=2/usi)
                          us[places] <- qgamma(p=runif(n)*u0,shape=(chains$extra[,j]+k)/2,scale=2/usi)
                          us[places] <- ifelse(us[places]<.Machine$double.xmin,.Machine$double.xmin,us[places])},
                 "Contaminated normal"={a <- chains$extra[1,j]*chains$extra[2,j]^(k/2)*exp(-chains$extra[2,j]*usi/2)
                                        b <- (1-chains$extra[1,j])*exp(-usi/2)
                                        us[places] <- ifelse(runif(n)<=a/(a+b),chains$extra[2,j],1)})
          usi <- us[places]
          zsi <- matrix(0,n,k)
          if(dist %in% c("Skew-normal","Skew-Student-t")){
             ais <- matrix(chains$delta[,j],k,n)*tcrossprod(Sigmanew2[[i]],y2z-X%*%chains[[i]]$location[zeta==1,(ncols-k+1):ncols])
             Ais <- diag(k) + matrix(chains$delta[,j],k,k)*Sigmanew2[[i]]*matrix(chains$delta[,j],k,k,byrow=TRUE)
             Ais2 <- chol2inv(chol(Ais))
             if(k>1) Ais3 <- chol(Ais2)
             ais <- crossprod(Ais2,ais)
             if(k==1) zsi <- matrix(unlist(lapply(1:n,function(x){mu <- ais[,x]
                                                                  var <- Ais2/usi[x]
                                                                  tn1(mu=mu,var=var)
                                                                  })),n,k,byrow=TRUE)
             else zsi <- matrix(unlist(lapply(1:n,function(x){mu <- ais[,x]
                                                              var <- Ais2/usi[x]
                                                              ind <- TRUE
                                                              indc <- 1
                                                              while(ind & indc<=30){
                                                                    temp <- crossprod(Ais3/sqrt(usi[x]),matrix(rnorm(k*50),k,50))
                                                                    temp2 <- colSums(mu + temp > 0)==k
                                                                    indc <- indc + 1
                                                                    ind <- !any(temp2)
                                                              }
                                                              if(ind){
                                                                 myfout <- vector()
                                                                 for(indc in 1:k) myfout <- c(myfout,tn1(mu=mu[indc],var=var[indc,indc]))
                                                              }else myfout <- (mu + temp)[,min(c(1:50)[temp2])]
                                                              myfout
                                                              })),n,k,byrow=TRUE)
             zs[places,] <- zsi
             y <- matrix(data[[i]]$y[places,] - matrix(chains$delta[,j],n,k,byrow=TRUE)*zsi,n,k)
          }
          Xu <- matrix(sqrt(usi),n,s)*X
          yu <- matrix(sqrt(usi),n,k)*y
          A <- chol2inv(chol(Sigmarinv + crossprod(Xu)))
          M <- crossprod(A,(crossprod(Xu,yu) + crossprod(Sigmarinv,mu0s)))
          betanew <- M + crossprod(chol(A),matrix(rnorm(s*k),s,k))%*%chol(chains[[i]]$scale[,(ncols-k+1):ncols])
          betanew2 <- matrix(chains[[i]]$location[,(ncols-k+1):ncols],nrow(chains[[i]]$location),k)
          betanew2[zeta==1,] <- betanew
          chains[[i]]$location <- cbind(chains[[i]]$location,betanew2)
          Omega <- Omega0 + crossprod(betanew-mu0s,Sigmarinv)%*%(betanew-mu0s) + crossprod(yu-Xu%*%betanew)
          Omegachol <- chol(chol2inv(chol(Omega)))
          Sigmanew2[[i]] <- tcrossprod(crossprod(Omegachol,matrix(rnorm(k*(prior$tau0+s+n)),k,prior$tau0+s+n)))
          chains[[i]]$scale <- cbind(chains[[i]]$scale,chol2inv(chol(Sigmanew2[[i]])))
          if(dist=="Contaminated normal"){
             resu <- y-X%*%betanew
             ss[places] <- colSums(t(resu)*tcrossprod(Sigmanew2[[i]],resu))
          }
          if(dist %in% c("Skew-normal","Skew-Student-t")){
             bis <- bis + rowSums(matrix(matrix(usi,k,n,byrow=TRUE)*t(zsi)*tcrossprod(Sigmanew2[[i]],(y2z-X%*%betanew)),k,n))
             Bis <- Bis + Reduce(`+`, lapply(1:n,function(x) usi[x]*(matrix(zsi[x,],k,k)*Sigmanew2[[i]]*matrix(zsi[x,],k,k,byrow=TRUE))))
          }
      }
      switch(dist,
             "Hyperbolic"={etanew <- length(us)*(resto - (1/2)*(nus^2*mean(1/us)))
                           etanew <- exp(etanew - max(etanew))
                           probs <- num1*(etanew[2:length(nus)] + etanew[1:(length(nus)-1)])/2
                           etanew <- sample(x=num2,size=1,prob=probs/sum(probs))
                           chains$extra <- cbind(chains$extra,matrix(etanew,1,1))},
           "Skew-Student-t"=,
           "Student-t"={etanew <- length(us)*resto + (nus/2)*sum(log(us)-us)
                        etanew <- exp(etanew - max(etanew))
                        probs <- num1*(etanew[2:length(nus)] + etanew[1:(length(nus)-1)])/2
                        etanew <- sample(x=num2,size=1,prob=probs/sum(probs))
                        chains$extra <- cbind(chains$extra,matrix(etanew,1,1))},
           "Slash"={etanew <- rgamma(1,shape=prior$gamma0+length(us),scale=2/(prior$eta0-sum(log(us))))
                    chains$extra <- cbind(chains$extra,matrix(etanew,1,1))},
           "Contaminated normal"={a <- us==chains$extra[2,j]
                                  etanew1 <- max(0.01,rbeta(1,shape1=prior$gamma01+sum(a),shape2=prior$eta01+length(a)-sum(a)))
                                  u0 <- pgamma(q=1,shape=(sum(a)*k + prior$gamma02)/2,scale=2/(prior$eta02 + sum(ss*a)))
                                  etanew2 <- max(0.01,qgamma(p=runif(1)*u0,shape=(sum(a)*k + prior$gamma02)/2,scale=2/(prior$eta02 + sum(ss*a))))
                                  chains$extra <- cbind(chains$extra,matrix(c(etanew1,etanew2),2,1))})
      if(dist %in% c("Skew-normal","Skew-Student-t")){
         Bis2 <- chol2inv(chol(Bis + diag(k)/prior$lambda0))
         chains$delta <- cbind(chains$delta,Bis2%*%bis + crossprod(chol(Bis2),matrix(rnorm(k),k,1)))
      }else chains$delta <- cbind(chains$delta,matrix(0,k,1))
      ncols <- ncol(chains[[1]]$location)
      if(regim > 1){
         a0 <- (thresholds.chains[,j] - t0)/(t1 - t0)
         if(length(a0) > 1) a0 <- c(a0[1],diff(a0))
         if(is.null(nano_$tp)) tp <- 3000 else tp <- abs(nano_$tp)
         a0 <- tp*c(a0,1-sum(a0))
         ind <- TRUE
         while(ind){
               r0 <- rgamma(length(a0),shape=a0,scale=rep(1,length(a0)))
               r0 <- r0/sum(r0)
               thresholds.new <- t0 + cumsum(r0[-length(a0)])*(t1 - t0)
               if(length(unique(thresholds.new))==(length(r0)-1)){
                  indl <- table(cut(Z[(ps+1-hs):(nrow(D)-hs),],breaks=c(-Inf,sort(thresholds.new),Inf),labels=FALSE))
                  if(length(indl) == regim) ind <- any(indl < tol)
               }
         }
         a <- min(1,exp(Loglik(hs,thresholds.new) - Loglik(hs,thresholds.chains[,j]) +
              sum((tp*r0-1)*log(a0/tp) - lgamma(tp*r0)) + lgamma(sum(tp*r0)) - sum((a0-1)*log(r0) - lgamma(a0)) - lgamma(sum(a0))))
         if(runif(1) > a){
            thresholds.new <- thresholds.chains[,j]
            ta <- c(ta,0)
         }
         else ta <- c(ta,1)
         thresholds.chains <- cbind(thresholds.chains,thresholds.new)
         resul <- vector()
         if(prior$hmin!=prior$hmax){
            for(h in prior$hmin:prior$hmax) resul <- c(resul,Loglik(h,thresholds.new))
            resul <- resul-max(resul)
            resul <- exp(resul)/sum(exp(resul))
            hs.chains <- cbind(hs.chains,sample(prior$hmin:prior$hmax,size=1,prob=resul))
         }else hs.chains <- cbind(hs.chains,prior$hmin)
      }
      if(nano_$bar) setTxtProgressBar(bar,j)
  }
  for(i in 1:regim){
      chains[[i]]$location <- matrix(chains[[i]]$location[,ids],nrow=nrow(chains[[i]]$location),ncol=n.sim*k)
      rownames(chains[[i]]$location) <- name[[i]]
      chains[[i]]$scale <- matrix(chains[[i]]$scale[,ids],nrow=k,ncol=k*n.sim)
      colnames(chains[[i]]$scale) <- rep(colnames(D),n.sim)
      rownames(chains[[i]]$scale) <- colnames(D)
      if(ssvs) chains[[i]]$zeta <- chains[[i]]$zeta[,ids1]
  }
  if(dist %in% c("Skew-Student-t","Student-t","Hyperbolic","Slash","Contaminated normal"))
     chains$extra <- matrix(chains$extra[,ids1],nrow=ifelse(dist=="Contaminated normal",2,1),ncol=n.sim)
  if(dist %in% c("Skew-normal","Skew-Student-t"))
     chains$delta <- matrix(chains$delta[,ids1],nrow=k,ncol=n.sim)
  out_ <- list(data=data,chains=chains,n.burnin=n.burnin,n.sim=n.sim,n.thin=n.thin,regim=regim,Intercept=Intercept,nseason=nseason,name=name,dist=dist,ps=ps,ars=ars,formula=Formula(formula),trend=trend,deterministic=deterministic,call=match.call(),log=log,output.series=D,ssvs=ssvs,setar=setar)
  if(!missing(row.names)) out_$row.names <- paste0(" (",paste0(rownames(data[[1]]$y)[c(1,nrow(data[[1]]$y))],collapse=" to "),")")
  if(max(ars$q)>0) out_$r <- r
  if(regim > 1){
     out_$chains$thresholds <- matrix(thresholds.chains[,ids1],ncol=n.sim)
     out_$chains$h <- hs.chains[,ids1]
     out_$threshold.series=Z
     out_$ts=paste0(colnames(Z)," with a estimated delay equal to ",round(mean(out_$chains$h),digits=0))
     out_$ta=100*mean(ta[ids1-1])
  }
  if(max(ars$q) > 0) out_$exogenous.series=X2
  class(out_) <- "mtar"
  return(out_)
}
#'
#'
