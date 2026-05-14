test_that("mtar returns a valid structure", {
  n <- 1000
  k <- 3
  Intercept <- TRUE
  myars <- ars(nregim=2,p=c(1,2))
  Z <- as.matrix(arima.sim(n=n+max(myars$p),list(ar=c(0.5))))
  probs <- sort((0.6 + runif(myars$nregim-1)*0.8)*c(1:(myars$nregim-1))/myars$nregim)
  dist <- "Student-t"
  extra <- 6
  parms <- list()
  for(j in 1:myars$nregim){
    np <- 1 + myars$p[j]*k
    parms[[j]] <- list()
    parms[[j]]$location <- c(ifelse(runif(np*k)<=0.5,1,-1)*rbeta(np*k,shape1=4,shape2=16))
    parms[[j]]$location <- matrix(parms[[j]]$location,np,k)
    parms[[j]]$scale <- rgamma(k,shape=1,scale=1)*diag(k)
  }
  thresholds <- quantile(Z,probs=probs)
  out <- simtar(n=n, k=k, ars=myars, parms=parms, thresholds=thresholds,
                t.series=Z, dist=dist, extra=extra, Intercept=Intercept,
                Verbose=FALSE)

  fit <- mtar(~ Y1 + Y2 + Y3 | Z, data=out, ars=myars, dist=dist,
              n.burn=100, n.sim=200, n.thin=2, progress=FALSE)

  for(i in 1:myars$nregim){
    expect_all_true(dim(fit$chains[[i]]$location)==c(Intercept+myars$p[i]*k,k*fit$n.sim))
    expect_false(any(is.na(fit$chains[[i]]$location)))
    expect_all_true(dim(fit$chains[[i]]$scale)==c(k,k*fit$n.sim))
    expect_false(any(is.na(fit$chains[[i]]$scale)))
  }
  expect_true(length(fit$chains$h)==fit$n.sim)
  expect_false(any(is.na(fit$chains$h)))
  expect_all_true(dim(fit$chains$thresholds)==c(1,fit$n.sim))
  expect_false(any(is.na(fit$chains$thresholds)))
  expect_all_true(dim(fit$chains$extra)==c(1,fit$n.sim))
  expect_false(any(is.na(fit$chains$extra)))
  expect_true(is.null(fit$setar))
})

test_that("mtar is reproducible using seed()", {
  n <- 2000
  k <- 3
  myars <- ars(nregim=2,p=c(1,2))
  dist <- "Laplace"
  parms <- list()
  for(j in 1:myars$nregim){
    np <- 1 + myars$p[j]*k
    parms[[j]] <- list()
    parms[[j]]$location <- c(ifelse(runif(np*k)<=0.5,1,-1)*rbeta(np*k,shape1=4,shape2=16))
    parms[[j]]$location <- matrix(parms[[j]]$location,np,k)
    parms[[j]]$scale <- rgamma(k,shape=1,scale=1)*diag(k)
  }
  out <- simtar(n=n, k=k, ars=myars, parms=parms, delay=2,
                thresholds=-1, dist=dist, setar=2, Verbose=FALSE)
  set.seed(9226)
  fit0 <- mtar(~ Y1 + Y2 + Y3, data=out, ars=myars, dist=dist,
               n.burn=100, n.sim=200, n.thin=2, setar=2)
  set.seed(9226)
  fit1 <- mtar(~ Y1 + Y2 + Y3, data=out, ars=myars, dist=dist,
               n.burn=100, n.sim=200, n.thin=2, setar=2)

  for(i in 1:myars$nregim){
    expect_true(all(fit0$chains[[i]]$location==fit1$chains[[i]]$location))
    expect_true(all(fit0$chains[[i]]$scale==fit1$chains[[i]]$scale))
  }
  expect_true(all(fit0$chains$h==fit1$chains$h))
  expect_true(all(fit0$chains$thresholds==fit1$chains$thresholds))
  expect_equal(fit0$setar,fit1$setar)
})


test_that("mtar only accepts valid distributions",{
  vd <- c("Gaussian","Student-t","Hyperbolic","Laplace","Slash",
          "Contaminated normal","Skew-Student-t","Skew-normal")
  size <- 20
  nvd <- sample(vd,size=size,replace=TRUE)
  pos <- ceiling(nchar(nvd)*runif(size))
  substr(nvd,pos,pos) <- sample(letters,size=size,replace=TRUE)
  data(iceland.rf)
  for(i in 1:size){
    expect_error(
      fit <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                  data=iceland.rf, subset={Date<="1974-11-06"}, row.names=Date,
                  ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=1000, n.sim=2000,
                  n.thin=2, dist=nvd[i]))
  }
})

test_that("mtar only accepts valid TAR specifications",{
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa,	data=iceland.rf,
                subset={Date<="1974-11-06"}, row.names=Date,
                ars=ars(nregim=2,p=15), n.burnin=1000, n.sim=2000,
                n.thin=2, dist="Slash"))
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa | Temperature,	data=iceland.rf,
                subset={Date<="1974-11-06"}, row.names=Date,
                ars=ars(nregim=2,p=15,q=4,d=2), n.burnin=1000, n.sim=2000,
                n.thin=2, dist="Slash"))
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa | 1 | Precipitation,
                data=iceland.rf, subset={Date<="1974-11-06"},
                row.names=Date, ars=ars(nregim=2,p=15,q=4,d=2),
                n.burnin=1000, n.sim=2000, n.thin=2, dist="Slash"))
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa,	data=iceland.rf, setar=2,
                subset={Date<="1974-11-06"}, row.names=Date,
                ars=ars(nregim=2,p=15,d=2), n.burnin=1000, n.sim=2000,
                n.thin=2, dist="Slash"))
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa,	data=iceland.rf, setar=3,
                subset={Date<="1974-11-06"}, row.names=Date,
                ars=ars(nregim=2,p=15), n.burnin=1000, n.sim=2000,
                n.thin=2, dist="Slash"))
})

test_that("mtar only accepts valid prior distributions specifications",{
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa, setar=2,
                data=iceland.rf, subset={Date<="1974-11-06"},
                row.names=Date, ars=ars(nregim=2,p=15,q=4,d=2),
                n.burnin=1000, n.sim=2000, n.thin=2, dist="Slash",
                prior=list(hmin=0)))
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                data=iceland.rf, subset={Date<="1974-11-06"},
                row.names=Date, ars=ars(nregim=2,p=15,q=4,d=2),
                n.burnin=1000, n.sim=2000, n.thin=2, dist="Slash",
                prior=list(delta0=-1)))
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                data=iceland.rf, subset={Date<="1974-11-06"},
                row.names=Date, ars=ars(nregim=2,p=15,q=4,d=2),
                n.burnin=1000, n.sim=2000, n.thin=2, dist="Slash",
                prior=list(omega0=-1)))
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                data=iceland.rf, subset={Date<="1974-11-06"},
                row.names=Date, ars=ars(nregim=2,p=15,q=4,d=2),
                n.burnin=1000, n.sim=2000, n.thin=2, dist="Slash",
                prior=list(tau0=0.5)))
  expect_error(
    fit <- mtar(~ Jokulsa + Vatnsdalsa | Temperature | Precipitation,
                data=iceland.rf, subset={Date<="1974-11-06"},
                row.names=Date, ars=ars(nregim=2,p=15,q=4,d=2),
                n.burnin=1000, n.sim=2000, n.thin=2, dist="Slash",
                prior=list(alpha1=1.5)))
})
