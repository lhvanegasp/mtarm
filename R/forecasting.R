#' @title Forecasting for a multivariate TAR model.
#' @description This function computes forecasting from a fitted multivariate TAR model.
#' @param object an object of the class \emph{mtar}.
#' @param ... additional arguments affecting the predictions produced
#' @param newdata an (optional) data frame containing the future values of the
#'                threshold series, if any in the fitted model; the exogenous
#'                series, if any in the fitted model; and the output series
#'                provided that \code{out.of.sample=TRUE}.
#' @param n.ahead an integer value specifying the number of forecast steps.
#' @param row.names an (optional) vector that allows the user to name the time point to
#'                  which each row in \code{newdata} corresponds
#' @param credible an (optional) value for the level of the credible intervals. By default, \code{credible} is set to 0.95.
#' @param out.of.sample an (optional) logical variable. If \code{TRUE}, then the log-score is computed, which is a measurement to assess density forecasts. Therefore, the data.frame specified in the argument \code{data} must to include the true values of the output series.
#' @return a list with the following component
#'
#' \tabular{ll}{
#' \code{ypred}   \tab a matrix with the results of the forecasting,\cr
#' \tab \cr
#' \code{summary} \tab a matrix with the mean and credible intervals of the forecasting,\cr
#' }
#' @references Nieto, F.H. (2005) Modeling Bivariate Threshold Autoregressive Processes in the Presence of Missing Data.
#'             Communications in Statistics - Theory and Methods, 34, 905-930.
#' @references Romero, L.V. and Calderon, S.A. (2021) Bayesian estimation of a multivariate TAR model when the noise
#'             process follows a Student-t distribution. Communications in Statistics - Theory and Methods, 50, 2508-2530.
#' @references Calderon, S.A. and Nieto, F.H. (2017) Bayesian analysis of multivariate threshold autoregressive models
#'             with missing data. Communications in Statistics - Theory and Methods, 46, 296-318.
#' @references Karlsson, S. (2013) Chapter 15-Forecasting with Bayesian Vector Autoregression. In Elliott, G. and
#'             Timmermann, A. Handbook of Economic Forecasting, Volume 2, 791–89, Elsevier.
#' @references Vanegas, L.H. and Calderón, S.A. and Rondón, L.M. (2025) Bayesian estimation of a multivariate tar model when the
#'             noise process distribution belongs to the class of gaussian variance mixtures. International Journal
#'             of Forecasting.
#' @examples
#' \donttest{
#' ###### Example 1: Returns of the closing prices of three financial indexes
#' data(returns)
#' fit1 <- mtar(~ COLCAP + BOVESPA | SP500, data=returns, subset={Date<="2016-03-14"},
#'              row.names=Date, dist="Gaussian", ars=ars(nregim=3,p=c(1,1,2)), n.burnin=100,
#'              n.sim=3000, n.thin=2)
#' out1 <- predict(fit1, newdata=subset(returns,Date>"2016-03-14"), n.ahead=10)
#' out1$summary
#'
#' ###### Example 2: Rainfall and two river flows in Colombia
#' data(riverflows)
#' fit2 <- mtar(~ Bedon + LaPlata | Rainfall, data=riverflows, subset={Date<="2009-04-04"},
#'              row.names=Date, dist="Gaussian", ars=ars(nregim=3,p=5), n.burnin=2000,
#'              n.sim=3000, n.thin=2)
#' out2 <- predict(fit2, newdata=subset(riverflows,Date>"2009-04-04"), n.ahead=10)
#' out2$summary
#' }
#' @method predict mtar
#' @export
#'
predict.mtar <- function(object,...,newdata,n.ahead=1,row.names,credible=0.95,out.of.sample=FALSE){
  regim <- object$regim
  if(((regim>1 & is.null(object$setar)) | max(object$ars$q) > 0) & missing(newdata))
     stop("The argument 'newdata' is required!",call.=FALSE)
  if(n.ahead<=0 | n.ahead!=floor(n.ahead))
     stop("The value of the argument 'n.ahead' must be a positive integer!",call.=FALSE)
  if(credible <=0 | credible >=1)
     stop("The value of the argument 'credible' must be within the interval (0,1)!",call.=FALSE)
  if(out.of.sample & missing(newdata))
     stop("The argument 'new data' is required for out-of-sample forecast accuracy measures!",call.=FALSE)
  gendist <- function(dist,Sigma,extra,delta){
    Sigma <- as.matrix(Sigma)
    nor <- crossprod(chol(Sigma),matrix(rnorm(k),k,1))
    u <- switch(dist,
                "Gaussian"=,"Skew-normal"={1},
                "Student-t"=,"Skew-Student-t"={1/rgamma(1,shape=extra/2,rate=extra/2)},
                "Slash"={1/rbeta(1,shape1=extra/2,shape2=1)},
                "Contaminated normal"={1/(1 - (1-extra[2])*rbinom(1,1,extra[1]))},
                "Hyperbolic"={rgig(n=1,lambda=1,chi=1,psi=extra^2)},
                "Laplace"={rexp(1,rate=1/8)})
    if(dist %in% c("Skew-normal","Skew-Student-t"))
       out_ <- sqrt(u)*matrix(delta*qnorm(0.5 + runif(k)*0.5) + nor,k,1)
    else out_ <- nor*sqrt(u)
    return(t(out_))
  }
  if(!missing(newdata)){
     mmf <- match.call(expand.dots = FALSE)
     m <- match(c("newdata","row.names"), names(mmf), 0)
     mmf <- mmf[c(1,m)]
     mmf$drop.unused.levels <- TRUE
     names(mmf)[names(mmf)=="newdata"] <- "data"
     mmf[[1]] <- as.name("model.frame")
     mmf <- eval(mmf, parent.frame())
     if(!missingArg(row.names)) row.names <- as.vector(as.character(model.extract(mmf,row.names)))
  }
  if(regim>1 & is.null(object$setar)){
     mz <- model.part(Formula(object$formula), data = mmf, rhs = 2, terms = TRUE)
     Z <- model.matrix(mz, data = mmf)
     if(attr(terms(mz),"intercept")){
        Znames <- colnames(Z)
        Z <- as.matrix(Z[,-1])
     }
     if(nrow(Z)<n.ahead)
        stop(paste0("The data.frame 'newdata' must have at least ",n.ahead," rows!"),call.=FALSE)
     Z <- rbind(object$threshold.series,matrix(Z[1:n.ahead,],n.ahead,1))
  }
  if(max(object$ars$q) > 0){
     mx2 <- model.part(Formula(object$formula), data = mmf, rhs = 3, terms = TRUE)
     X2 <- model.matrix(mx2, data = mmf)
     if(attr(terms(mx2),"intercept")){
        X2names <- colnames(X2)
        X2 <- as.matrix(X2[,-1])
        colnames(X2) <- X2names[-1]
     }
     if(nrow(X2)<n.ahead)
        stop(paste0("The data.frame 'newdata' must have at least ",n.ahead," rows!"),call.=FALSE)
     X2 <- rbind(object$exogenous.series,matrix(X2[1:n.ahead,],n.ahead,ncol(object$exogenous.series)))
  }
  y <- object$output.series
  name <- colnames(y)
  n <- nrow(y)
  k <- ncol(y)
  ysim <- rbind(matrix(y,n,k*object$n.sim),matrix(0,n.ahead,k*object$n.sim))
  if(out.of.sample){
     Lik <- function(dist,y,M,Sigma,delta,log,nu){
       Sigma <- as.matrix(Sigma)
       resu <- matrix(y-M,1,k)
       if(dist %in% c("Skew-normal","Skew-Student-t")){
          A <- chol2inv(chol(Sigma + as.vector(delta^2)*diag(k)))
          out <- resu%*%tcrossprod(A,resu)
          muv <- resu%*%(A*matrix(delta,k,k,byrow=TRUE))
          Sigmav <- diag(k) - matrix(delta,k,k)*A*matrix(delta,k,k,byrow=TRUE)
          if(dist=="Skew-normal"){
             out <- out + k*log(2*pi)
             if(k > 1) out <- out - 2*log(pmvnorm(lower=-as.numeric(muv),upper=rep(Inf,k),sigma=Sigmav))
             else out <- out - 2*log(pnorm(-muv/sqrt(Sigmav),lower.tail=FALSE))
          }
          if(dist=="Skew-Student-t"){
             out <- (nu+k)*log(1 + out/nu) - 2*lgamma((nu+k)/2) + 2*lgamma(nu/2) + k*log(nu*pi)
             muv <- muv*matrix(sqrt((nu + k)/(nu + out)),nrow(muv),k)
             if(k > 1) out <- out - 2*log(pmvt(lower=-as.numeric(muv),upper=rep(Inf,k),sigma=Sigmav,df=round(nu,0)+k))
             else out <- out - 2*log(pt(-muv/sqrt(Sigmav),df=nu,lower.tail=FALSE))
          }
       }else{
        out <- resu%*%tcrossprod(chol2inv(chol(Sigma)),resu)
        out <- switch(dist,
                      "Gaussian"={out},
                      "Laplace"={-2*log(besselK(sqrt(out)/2,(2-k)/2)) - ((2-k)/2)*log(out)	+ (k+2)*log(2)},
                      "Student-t"={(nu+k)*log(1 + out/nu) - 2*lgamma((nu+k)/2) + 2*lgamma(nu/2) + k*log(nu/2)},
                      "Contaminated normal"={-2*log(nu[1]*exp(-out*nu[2]/2)*nu[2]^(k/2) + (1-nu[1])*exp(-out/2))},
                      "Slash"={ifelse(out==0,-2*log(nu/(nu+k)),-2*lgamma((k+nu)/2) + (k+nu)*log(out/2) -2*log((nu/2)*pgamma(1,shape=(k+nu)/2,rate=out/2)))},
                      "Hyperbolic"={-2*log(besselK(nu*sqrt(1+out),(2-k)/2)) -((2-k)/2)*log(1+out) - k*log(nu) +2*log(besselK(nu,1))})
        out <- out + k*log(2*pi)
       }
       out <- -(out + log(det(Sigma)))/2
       if(log) out <- out + sum(y)
       return(exp(out))
     }
    mx <- model.part(Formula(object$formula), data = mmf, rhs = 1, terms = TRUE)
    D <- model.matrix(mx, data = mmf)
    if(attr(terms(mx),"intercept")){
       Dnames <- colnames(D)
       D <- matrix(D[,-1],ncol=length(Dnames)-1)
       colnames(D) <- Dnames[-1]
    }
    ytrue <- D
    if(nrow(ytrue)<n.ahead)
       stop(paste0("The data.frame 'newdata' must have at least ",n.ahead," rows!"),call.=FALSE)
    else ytrue <- matrix(D[1:n.ahead,],n.ahead,k)
    if(object$log) ytrue <- log(ytrue)
    prek <- matrix(0,n.ahead,object$n.sim)
    ytrue <- rbind(matrix(y,n,k),matrix(ytrue,nrow(ytrue),k))
  }
  switch(object$trend,
         "none"={Xd <- matrix(1,n.ahead,1)},
         "linear"={Xd <- matrix(cbind(1,c((n+1):(n+n.ahead))),n.ahead,2)},
         "quad"={Xd <- matrix(cbind(1,c((n+1):(n+n.ahead)),c((n+1):(n+n.ahead))^2),n.ahead,3)})
  nseason <- object$nseason
  n2 <- n + n.ahead
  if(!is.null(nseason))
     Xd <- cbind(Xd,matrix(rep(diag(nseason),ceiling(n2/nseason)),ceiling(n2/nseason)*nseason,nseason,byrow=TRUE)[(n+1):(n+n.ahead),-1])
  if(!object$Intercept) Xd <- Xd[,-1]
  for(i in 1:object$n.sim){
      if(regim > 1){
         h <- object$chains$h[i]
         thresholds <- object$chains$thresholds[,i]
      }
      for(j in (n+1):(n+n.ahead)){
          if(regim > 1){
             if(!is.null(object$setar)) iz <- ysim[j-h,(i-1)*k + object$setar] else iz <- Z[j-h]
             regs <- cut(iz,breaks=c(-Inf,sort(thresholds),Inf),labels=FALSE)
          }else regs <- 1
          X <- Xd[j-n,]
          for(l in 1:object$ars$p[regs]) X <- c(X,ysim[j-l,((i-1)*k+1):(i*k)])
          if(object$ars$q[regs] > 0) for(l in 1:object$ars$q[regs]) X <- c(X,X2[j-l,])
          if(object$ars$d[regs] > 0) for(l in 1:object$ars$d[regs]) X <- c(X,Z[j-l,])
          if(object$ssvs) zetai <- object$chains[[regs]]$zeta[,i] else zetai <- rep(1,length(X))
          M <- matrix(X[zetai==1],1,sum(zetai))%*%object$chains[[regs]]$location[zetai==1,((i-1)*k+1):(i*k)]
          if(object$dist %in% c("Gaussian","Laplace")) extrai <- NULL else extrai <- object$chains$extra[,i]
          if(object$dist %in% c("Skew-normal","Skew-Student-t")) deltai <- object$chains$delta[,i] else deltai <- rep(0,k)
          ysim[j,((i-1)*k+1):(i*k)] <- M + gendist(object$dist,object$chains[[regs]]$scale[,((i-1)*k+1):(i*k)],extrai,deltai)
          if(out.of.sample){
             prek[j-n,i] <- Lik(object$dist,ytrue[j,],M,object$chains[[regs]]$scale[,((i-1)*k+1):(i*k)],deltai,object$log,extrai)
          }
      }
  }
  ysim <- matrix(ysim[-c(1:n),],n.ahead,k*object$n.sim)
  colnames(ysim) <- rep(colnames(y),object$n.sim)
  if(object$log) ysim <- exp(ysim)
  out_ <- vector()
  predi <- function(x){
     x <- matrix(x,1,length(x))
     ks <- seq(credible,1,length=object$n.sim*(1-credible))
     lis <- t(apply(x,1,quantile,probs=ks-credible))
     lss <- t(apply(x,1,quantile,probs=ks))
     dif <- apply(abs(lss-lis),1,which.min)
     out_ <- c(ifelse(object$log,median(x),mean(x)),lis[dif],lss[dif])
     names(out_) <- paste0(name[i],c(".Mean",".HDI_Low",".HDI_high"))
     return(out_)
  }
  for(i in 1:k) out_ <- cbind(out_,t(apply(matrix(ysim[,seq(i,k*object$n.sim,k)],n.ahead,object$n.sim),1,predi)))
  if(missingArg(row.names)) row.names <- 1:n.ahead
  rownames(ysim) <- rownames(out_) <- row.names[1:n.ahead]
  out__ <- list(summary=out_,output.series=y)
  class(out__) <- "predict_mtar"
  if(out.of.sample){
     out__$log.score <- matrix(-log(rowMeans(prek)),n.ahead,1)
     if(object$log) ytrue <- exp(ytrue)
     ytrue <- matrix(ytrue[-c(1:n),],n.ahead,k)
     out__$APE <- 100*matrix(abs((out_[,seq(1,3*k,3)] - ytrue)/ytrue),nrow(ytrue),k)
     out__$SE <- matrix((out_[,seq(1,3*k,3)] - ytrue)^2,nrow(ytrue),k)
     rownames(out__$log.score) <- rownames(out__$APE) <- rownames(out__$SE) <- rownames(out_)
     colnames(out__$APE) <- paste0(colnames(y),sep=".","APE")
     colnames(out__$SE) <- paste0(colnames(y),sep=".","SE")
  }
  return(out__)
}

#' @method plot predict_mtar
#' @export
plot.predict_mtar <- function(x,...,n,historical=list(),forecasts=list(),forecasts.PI=list(),main=NULL){
    k <- ncol(x$output.series)
    out_ <- x$summary
    n.ahead <- nrow(out_)
    y <- matrix(x$output.series,nrow(x$output.series),ncol(x$output.series))
    if(missingArg(n)) n <- nrow(y) else n <- ceiling(abs(n))
    y2 <- rbind(matrix(y[(nrow(y)-n+1):nrow(y),],ncol=k),matrix(out_[,seq(1,3*k,3)],ncol=k))
    forecasts$xlim <- historical$xlim <- c(1,n+n.ahead)
    forecasts$x <- (n+1):(n+n.ahead)
    forecasts.PI$ylab <- forecasts.PI$xlab <- historical$xlab <- historical$ylab <- ""
    if(is.null(historical$type)) historical$type <- "l"
    if(is.null(historical$lty)) historical$lty <- 1
    if(is.null(historical$col)) historical$col <- "black"
    forecasts$xlim <- c(1,n+n.ahead)
    if(is.null(forecasts$type)) forecasts$type <- "l"
    if(is.null(forecasts$lty)) forecasts$lty <- 1
    if(is.null(forecasts$col)) forecasts$col <- "blue"
    if(is.null(forecasts$xlab)) forecasts$xlab <- ""
    if(is.null(forecasts$ylab)) forecasts$ylab <- ""
    if(is.null(forecasts.PI$density)) forecasts.PI$density <- NA
    if(is.null(forecasts.PI$col)) forecasts.PI$col <- "light gray"
    for(i in 1:k){
        dev.new()
        historical$ylim <- forecasts.PI$ylim <- forecasts$ylim <- range(y2[,i],out_[,1:3+3*(i-1)])
        historical$x <- y[(nrow(y)-n+1):nrow(y),i]
        if(is.null(main)) historical$main <- colnames(x$output.series)[i]
        else historical$main <- main[i]
        do.call("plot",historical)
        xs <- c((n+1):(n+n.ahead),(n+n.ahead):(n+1))
        ys <- c(out_[,2+3*(i-1)],out_[nrow(out_):1,3+3*(i-1)])
        par(new=TRUE)
        forecasts.PI$x <- xs
        forecasts.PI$y <- ys
        do.call("polygon",forecasts.PI)
        forecasts$y <- out_[,1+3*(i-1)]
        forecasts$main <- colnames(y)[i]
        par(new=TRUE)
        do.call("plot",forecasts)
    }
}
#'
#'
#' @method out.of.sample mtar
#' @export
out.of.sample.mtar <- function(...,newdata,n.ahead=1,by.component=FALSE){
  another <- list(...)
  call. <- match.call()
  k <- ncol(another[[1]]$data[[1]]$y)
  out <- matrix(0,length(another),ifelse(by.component,2*k+1,3))
  outnames <- vector()
  for(ii in 1:length(another)){
      temp <- predict(another[[ii]],newdata=newdata,n.ahead=n.ahead,out.of.sample=TRUE)
      out[ii,1] <- mean(temp$log.score)
      if(by.component){
         out[ii,2:(k+1)] <- apply(temp$APE,2,mean)
         out[ii,(k+2):(2*k+1)] <- apply(temp$SE,2,mean)
      }else{
         out[ii,2] <- mean(apply(temp$APE,1,mean))
         out[ii,3] <- mean(apply(temp$SE,1,mean))
      }
      outnames[ii] <- as.character(call.[ii+1])
  }
  rownames(out) <- outnames
  if(!by.component) colnames(out) <- c("log.score","MAPE","MSE")
  else{
    name <- c("log.score")
    me <- c("MAPE","MSE")
    for(i in 1:length(me)) name <- c(name,paste0(colnames(another[[1]]$data[[1]]$y),sep=".",me[i]))
    colnames(out) <- name
  }
  return(out)
}
#'
#' @method out.of.sample listmtar
#' @export
out.of.sample.listmtar <- function(x,newdata,n.ahead=1,by.component=FALSE,...){
  k <- ncol(x[[1]]$data[[1]]$y)
  out <- matrix(0,length(x),ifelse(by.component,2*k+1,3))
  for(i in 1:length(x)){
      temp <- predict(x[[i]],newdata=newdata,n.ahead=n.ahead,out.of.sample=TRUE)
      out[i,1] <- mean(temp$log.score)
      if(by.component){
         out[i,2:(k+1)] <- mean(apply(temp$APE,1,mean))
         out[i,(k+2):(2*k+1)] <- mean(apply(temp$SE,1,mean))
      }else{
         out[i,2] <- mean(apply(temp$APE,1,mean))
         out[i,3] <- mean(apply(temp$SE,1,mean))
      }
  }
  rownames(out) <- names(x)
  if(!by.component) colnames(out) <- c("log.score","MAPE","MSE")
  else{
    name <- c("log.score")
    me <- c("MAPE","MSE")
    for(i in 1:length(me)) name <- c(name,paste0(colnames(x[[1]]$data[[1]]$y),sep=".",me[i]))
    colnames(out) <- name
  }
  return(out)
}
#'
#'
