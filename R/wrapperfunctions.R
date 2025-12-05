#' @title Bayesian estimation of a multivariate TAR model
#' @description This is a wrapper function that applies the routine \code{mtar()} for each combination
#' of the noise process distribution (\code{dist}), the number of regimes (\code{nregim.min} to \code{nregim.max})
#' and the autoregressive order within each regime (\code{p.min} to \code{p.max}). In all calls to \code{mtar()},
#' the time points employed in the fitting process are the same, which is accomplished by managing the
#' argument \code{subset} of \code{mtar()}.
#' @param formula a three-part expression of type \code{Formula} describing the TAR model
#'                to be fitted to the data. In the first part, the variables in the
#'                multivariate output series are listed; in the second part, the threshold
#'                series is specified, and in the third part, the variables in the
#'                multivariate exogenous series are specified.
#' @param nregim.min an (optional) integer that represents the minimum value for the number
#'                   of regimes. By default, \code{nregim.min} is set to 1.
#' @param nregim.max an integer that represents the maximum value for the number
#'                   of regimes.
#' @param p.min an (optional) integer that represents the minimum value for the autoregressive
#'              order within each regime. By default, \code{p.min} is set to 1.
#' @param p.max an integer that represents the maximum value for the autoregressive
#'              order within each regime.
#' @param q     an (optional) logical variable. If \code{TRUE} then the maximum lag for the exogenous
#'              series within each regime is set to be equal to the autoregressive order. By default,
#'              \code{q} is set to FALSE.
#' @param d     an (optional) logical variable. If \code{TRUE} then the maximum lag for the threshold
#'              series within each regime is set to be equal to the autoregressive order. By default,
#'              \code{d} is set to FALSE.
#' @param Intercept an (optional) logical variable. If \code{TRUE} then the model
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
#'             typically the environment from which \code{mtar_grid()} is called.
#' @param subset an (optional) vector specifying a subset of observations to be used in the
#'               fitting process.
#' @param dist Specifies the multivariate distributions to be used to describe the noise process
#'             behavior as a character string vector. The available options are: Gaussian
#'             ("Gaussian"), Student-\eqn{t} ("Student-t"), Slash ("Slash"), Symmetric Hyperbolic ("Hyperbolic"),
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
#' @param log an (optional) logical variable. If \code{TRUE} then the behaviour of the output
#'            series is described using the exponentiated version of \code{dist}.
#' @return a list-type object comprising objects of class \code{mtar}, which correspond to the
#' results of a call to the routine \code{mtar()} for each combination of the noise process distribution
#'  (\code{dist}), the number of regimes (\code{nregim.min} to \code{nregim.max}) and the autoregressive
#'  order within each regime (\code{p.min} to \code{p.max}).
#' @seealso mtar
#' @export mtar_grid
mtar_grid <- function(formula, data, subset, Intercept=TRUE, trend=c("none","linear","quad"), nseason=NULL,
                      nregim.min=1, nregim.max=NULL, p.min=1, p.max=NULL, q=FALSE, d=FALSE, row.names,
                      dist="Gaussian", prior=list(), n.sim=500, n.burnin=100, n.thin=1, ssvs=FALSE, setar=NULL,
                      log=FALSE){
  dist <- unique(dist)
  if(!all(dist %in% c("Gaussian","Student-t","Hyperbolic","Laplace","Slash","Contaminated normal","Skew-Student-t","Skew-normal")))
    stop("Only 'Gaussian', 'Student-t', 'Hyperbolic', 'Laplace', 'Slash', 'Contaminated normal',
          'Skew-Student-t' and 'Skew-normal' distributions are supported",call.=FALSE)
  if((sum(dist %in% c("Student-t","Hyperbolic","Slash"))>1 | sum(dist %in% c("Skew-Student-t","Hyperbolic","Slash"))>1)
     & (!is.null(prior$gamma0) | !is.null(prior$eta0))){
    message("\nThe hyperparameters 'gamma0' and 'eta0' are set to their by-default values\n")
    prior$gamma0 <- prior$eta0 <- NULL
  }
  if(nregim.min!=floor(nregim.min) | nregim.min<=0)
    stop("The argument 'nregim.min' must be a positive integer value!",call.=FALSE)
  if(is.null(nregim.max)) stop("The argument 'nregim.max' is required!",call.=FALSE)
  if(nregim.max!=floor(nregim.max) | nregim.max<=0 | nregim.max<nregim.min)
    stop("The argument 'nregim.max' must be a positive integer greater than or equal to nregim.min!",call.=FALSE)
  if(p.min!=floor(p.min) | p.min<=0)
    stop("The argument 'p.min' must be a positive integer value!",call.=FALSE)
  if(is.null(p.max)) stop("The argument 'p.max' is required!",call.=FALSE)
  if(p.max!=floor(p.max) | p.max<=0 | p.max<p.min)
    stop("The argument 'p.max' must be a positive integer greater than or equal to p.min!",call.=FALSE)
  rs <- nregim.min:nregim.max
  aos <- p.min:p.max
  mycall <- match.call()
  mycall[[1]] <- as.name("mtar")
  mycall$ars <- ars(nregim=1,p=1)
  mycall$stop <- TRUE
  temp <- eval(mycall)
  mydata <- temp$data
  k <- temp$k
  mycall$subset <- mycall$stop <- NULL
  if(!is.null(temp$mynames)) mycall$row.names <- as.name("mynames")
  mycall$data <- data.frame(mydata,mynames=temp$mynames)
  mycall$bar <- FALSE
  ps <- max(max(aos),ifelse(max(rs) > 1,ifelse(is.null(prior$hmax),3,prior$hmax),0))
  out <- list()
  name <- vector()
  counter <- 0
  rep <- length(rs)*length(aos)*length(dist)
  bar <- txtProgressBar(min=0, max=rep, initial=0, width=50, char="+", style=3)
  for(Ds in 1:length(dist)){
    mycall$dist <- dist[Ds]
    for(r in 1:length(rs)){
      mycall$prior <- priors(prior,regim=rs[r],k=k,dist=dist[Ds],setar=mycall$setar,ssvs=mycall$ssvs)
      for(ao in 1:length(aos)){
        if(q){
          if(d) mycall$ars <- ars(nregim=rs[r],p=aos[ao],q=aos[ao],d=aos[ao])
          else mycall$ars <- ars(nregim=rs[r],p=aos[ao],q=aos[ao])
        }else{
          if(d) mycall$ars <- ars(nregim=rs[r],p=aos[ao],d=aos[ao])
          else mycall$ars <- ars(nregim=rs[r],p=aos[ao])
        }
        ps.ao <- ps - max(aos[ao],ifelse(rs[r] > 1,mycall$prior$hmax,0))
        if(ps.ao > 0) mycall$subset <- -c(1:ps.ao) else mycall$subset <- NULL
        out[[counter+1]] <- eval(mycall)
        name <- c(name,paste0(dist[Ds],".",rs[r],".",aos[ao]))
        counter <- counter + 1
        setTxtProgressBar(bar,counter)
      }
    }
  }
  names(out) <- name
  class(out) <- "listmtar"
  return(out)
}
#'
#' @title Geweke's convergence diagnostic for objects of class \code{mtar}
#' @param x an object of class \code{mtar} generated by a call to the function \code{mtar()}
#' @param frac1	fraction to use from beginning of chain
#' @param frac2	fraction to use from end of chain
#' @seealso geweke.diag
#' @export geweke.diagTAR
#' @description This is a wrapper function that applies the routine \code{geweke.diag()} to the chains obtained from a call to the function \code{mtar()}.
geweke.diagTAR <- function(x,frac1=0.1,frac2=0.5){
  if(!inherits(x,"mtar")) stop("Only objects of class 'mtar' are supported!",call.=FALSE)
  x2 <- as.mcmc(x)
  x2$delay <- NULL
  if(x$ars$nregim > 1){
    x2$thresholds <- geweke.diag(x2$thresholds,frac1=frac1,frac2=frac2)$z
    temp <- matrix(x2$thresholds,length(x2$thresholds),1)
    rownames(temp) <- names(x2$thresholds); colnames(temp) <- ""
    x2$thresholds <- temp
  }
  temp <- data.frame(ns=NA)
  temp2 <- matrix(NA,ncol(x2$scale[[1]]),1)
  rownames(temp2) <- colnames(x2$scale[[1]])
  cc <- c(colnames(x$data[[1]]$y),":Time",":Season")
  cc2 <- c(paste0(1:ncol(x$data[[1]]$y),colnames(x$data[[1]]$y)),":.1Time",":.2Season")
  for(j in 1:x$ars$nregim){
    x2$location[[j]] <- geweke.diag(x2$location[[j]],frac1=frac1,frac2=frac2)$z
    x2$location[[j]] <- data.frame(ns=names(x2$location[[j]]),ps=x2$location[[j]])
    temp <- merge(temp,x2$location[[j]],by.x="ns",by.y="ns",all.x=TRUE,all.y=TRUE)
    x2$scale[[j]] <- geweke.diag(x2$scale[[j]],frac1=frac1,frac2=frac2)$z
    temp2 <- cbind(temp2,matrix(x2$scale[[j]],length(x2$scale[[j]]),1))
  }
  temp <- temp[!is.na(temp[,1]),]
  for(jj in 1:(length(cc))) temp[,1] <- gsub(cc[jj],cc2[jj],temp[,1])
  temp <- temp[sort(temp[,1],index=TRUE)$ix,]
  for(jj in 1:(length(cc))) temp[,1] <- gsub(cc2[jj],cc[jj],temp[,1])
  x2$location <- as.matrix(temp[,-1])
  rownames(x2$location) <- temp[,1]
  x2$scale <- matrix(temp2[,-1],nrow(temp2),x$ars$nregim)
  rownames(x2$scale) <- rownames(temp2)
  colnames(x2$location) <- colnames(x2$scale) <- paste0("Regime ",1:x$ars$nregim)
  if(!(x$dist %in% c("Gaussian","Laplace","Skew-normal"))){
    x2$extra <- geweke.diag(x2$extra,frac1=frac1,frac2=frac2)$z
    temp <- matrix(x2$extra,length(x2$extra),1)
    rownames(temp) <- names(x2$extra); colnames(temp) <- ""
    x2$extra <- temp
  }
  if(x$dist %in% c("Skew-normal","Skew-Student-t")){
    x2$skewness <- geweke.diag(x2$skewness,frac1=frac1,frac2=frac2)$z
    temp <- matrix(x2$skewness,length(x2$skewness),1)
    rownames(temp) <- names(x2$skewness); colnames(temp) <- ""
    x2$skewness <- temp
  }
  x2$frac <- c(frac1,frac2)
  class(x2) <- "gdmtar"
  return(x2)
}
#'
#'
#' @method print gdmtar
#' @export
print.gdmtar <- function(x, digits=max(3, getOption("digits") - 2), ...){
  cat("\nFraction in 1st window = ",x$frac[1])
  cat("\nFraction in 2nd window = ",x$frac[2],"\n\n")
  if(!is.null(x$thresholds)){
    cat("Thresholds:\n")
    print(x$thresholds,digits=digits,na.print="")
  }
  cat("\n\nAutoregressive coefficients:\n")
  print(x$location,digits=digits,na.print="")
  cat("\n\nScale parameter:\n")
  print(x$scale,digits=digits,na.print="")
  if(!is.null(x$skewness)){
    cat("\n\nSkewness parameter:\n")
    print(x$skewness,digits=digits,na.print="")
  }
  if(!is.null(x$extra)){
    cat("\n\nExtra parameter:\n")
    print(x$extra,digits=digits,na.print="")
  }
}
#'
#' @title Geweke-Brooks plot for objects of class \code{mtar}
#' @param x an object of class \code{mtar} generated by a call to the function \code{mtar()}.
#' @param frac1	fraction to use from beginning of chain
#' @param frac2	fraction to use from end of chain
#' @param nbins Number of segments
#' @param pvalue p-value used to plot confidence limits for the null hypothesis
#' @param auto.layout	If \code{TRUE} then, set up own layout for plots, otherwise use existing one
#' @param ask If \code{TRUE} then prompt user before displaying each page of plots. Default is \code{dev.interactive()}.
#' @param ... Graphical parameters
#' @seealso geweke.plot
#' @description This is a wrapper function that applies the routine \code{geweke.plot()} to the chains obtained from a call to the function \code{mtar()}.
#' @export geweke.plotTAR
geweke.plotTAR <- function(x, frac1=0.1, frac2=0.5, nbins=20, pvalue=0.05, auto.layout=TRUE, ask, ...){
  if(!inherits(x,"mtar")) stop("Only objects of class 'mtar' are supported!",call.=FALSE)
  x2 <- as.mcmc(x)
  if(!is.null(x2$thresholds)){
    dev.new()
    cat("\nThresholds\n")
    geweke.plot(x2$thresholds,frac1=frac1,frac2=frac2,nbins=nbins,pvalue=pvalue,
                auto.layout=auto.layout,ask=ask,...)
  }
  for(j in 1:x$regim){
    dev.new()
    cat(paste("\nAutoregressive coefficients Regime",j,"\n"))
    geweke.plot(x2$location[[j]],frac1=frac1,frac2=frac2,nbins=nbins,pvalue=pvalue,
                auto.layout=auto.layout,ask=ask,...)
    dev.new()
    cat(paste("\nScale parameter Regime",j,"\n"))
    geweke.plot(x2$scale[[j]],frac1=frac1,frac2=frac2,nbins=nbins,pvalue=pvalue,
                auto.layout=auto.layout,ask=ask,...)
  }
  if(!is.null(x2$skewness)){
    dev.new()
    cat("\nSkewness parameter\n")
    geweke.plot(x2$skewness,frac1=frac1,frac2=frac2,nbins=nbins,pvalue=pvalue,
                auto.layout=auto.layout,ask=ask,...)
  }
  if(!is.null(x2$extra)){
    dev.new()
    cat("\nExtra parameter\n")
    geweke.plot(x2$extra,frac1=frac1,frac2=frac2,nbins=nbins,pvalue=pvalue,
                auto.layout=auto.layout,ask=ask,...)
  }
}
