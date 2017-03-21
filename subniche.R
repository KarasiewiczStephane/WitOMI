#' @import ade4
#' @title The Within Outlying Mean Indexes
#' @aliases subniche print.subniche plot.subniche margvect subplot summary.subniche refparam rtest.subniche subparam.refor rtestrefor subparam.subor rtestsubor
#' @description  The method allows to divide the realized niche, estimated from the \link[ade4]{niche} function in the \link{ade4} package into subniches defined by a factor, which creates the
#' subsets. See details for more information.
#' @usage subniche(nic, factor)
#' @param nic an object of class \code{niche}.
#' @param factor a factor which will defined the subsets within which the subniches will be calculated (the same length of the number of sites)
#' @param x an object of class \code{subniche}.
#' @param xtest an object of class \code{subniche}.
#' @param object an object of class \code{subniche}.
#' @param xax specify the x column in your matrix
#' @param yax specify the y column in your matrix
#' @param ...	further arguments passed to or from other methods
#' @param nrepet the number of permutations for the testing procedure
#' @return Adds items in the niche list and changing the class into \code{subniche} containing:
#' @return \code{factor} the factor use to divide the environmental and species matrix into subset.
#' @return \code{mav} a data frame with the subset origins, \emph{G_k}.
#' @return \code{mus} a data frame with the subset species niche coordinates
#' @keywords subniche
#' @author Stephane Karasiewicz, \email{stephane.karasiewicz@wanadoo.fr}
#' @details The Within Outlying Mean Indexes are statistical exploratory niche method which provides observation of niche shift and/or conservatism, of an entire community,at different subset
#' (temporal and/or spatial) and comparable under the same environmental gradients. This hindcasting multivariate analysis is based on the OMI analysis (Doledec \emph{et al.} 2000) which is used as reference.
#' The niches refinement is inspired by the K-select (Calenge \emph{et al.} 2005) which emphasizes the limiting factors in habitat used.The different estimations should help understand:
#'
#' 1. the environmental factors defining a species' reference niche, over the sampling domain within a community.
#'
#' 2. the environmental factors defining a species' subniches, under each subsets, within a community.
#'
#' 3.the observation of the biological constraint exerted on the species subniche.
#'
#' The subniches parameters can be calculated from both the reference origin,\emph{G}, which corresponds to the reference plane origin, and from \emph{G_k}, which corresponds to the
#' suborigins. \emph{G} is the graphical representation of the average habitat conditions of the sampling domain. \emph{G_k} is the average habitat conditions of the subset defined by the factor. They are complementary has you can compare:
#'
#' 1. a single species' subniches to \emph{G}.
#'
#' 2. the community' subniches to \emph{G_k} at a specific subset.
#'
#' 3.the difference between the potential subniche and the subniche correspond to the observe biological constraint (Karasiewicz \emph{et al.}, in review) .
#'
#'  The subniches of a single species can only be compared to \emph{G} as it is the common origin to all subsets. Whereas \emph{G_k} is only common to the species found within the
#' subset. So comparing different subniches of one species, found within different subsets, is only relevant to \emph{G}. The community's subniches can be compared to both \emph{G}
#' and \emph{G_k}, but \emph{G}, being the overall average habitat conditions, will not express the specificity of the environmental conditions that the species
#' encountered at the subscale. \emph{G_k}, being the average subset habitat conditions, will reflect the atypical value of the habitat conditions, making the
#' comparison of the community's subniches parameters more relevant. The observation the biological constraint on a species subniche can be use for further analysis and interpretation.
#'
#' @references Doledec S., Chessel D. and Gimaret C. (2000). Niche separation in community analysis: a new method. \emph{Ecology},\bold{81}, 2914-1927.
#'
#' Calenge C., Dufour A.B. and Maillard D. (2005). K-select analysis: a new method to analyse habitat selection in radio-tracking studies. \emph{Ecological modelling}, \bold{186}, 143-153.
#'
#' Thomas D.L., Taylor E.J., (1990). Study designs and tests for comparing resource use and availability.\emph{ J. Wildl. Manage.}, \bold{54}, 322-330.
#'
#' Karasiewicz S.,Doledec S.and Lefebvre S. (in review). Within Outlying Mean Indexes: refining the OMI analysis for the realized niche decomposition.
#' @seealso \link[ade4]{niche} \link[ade4]{niche.param}
#' @examples
#' library(ade4)
#'data(doubs)
#'dudi1 <- dudi.pca(doubs$env, scale = TRUE, scan = FALSE, nf = 3)
#'nic1 <- niche(dudi1, doubs$fish, scann = FALSE)
#'# number of sites
#'N <- dim(nic1$ls)[1]
#'#Create a factor which defines the subsets
#'fact <- factor(c(rep(1,N/2),rep(2,N/2)))
#'# nic1 will be use as reference and fact will be use to define the subniches environment
#'subnic1 <- subniche(nic1, fact)
#'# the following two functions do the same display, plot.refniche is adapted to subniche objects
#'plot(nic1)
#'plot(subnic1)
#'#Display the marginality vector of the suborigins and the species subniche
#'margvect(subnic1)
#'#Display the subset's chull, found within the overall environment's chull,
#'#and the corresponding species positions
#'subplot(subnic1)
#'# The following two functions do the same display, refparam is adapted to subniche objects
#'niche.param(nic1)
#'refparam(subnic1)
#'# The following two functions do the same display, rtest is adapted to subniche objects
#'rtest(nic1,10)
#'rtest(subnic1,10)
#'#Calculates the subniches' parameters from G with the corresponding rtest
#'subparam.refor(subnic1)
#'rtestrefor(subnic1,10)
#'#Calculates the subniches' parameters from G_k with the corresponding rtest
#'subparam.subor(subnic1)
#'rtestsubor(subnic1,10)
#' @export subniche
#' @rdname subniche
#' @importFrom stats weighted.mean
subniche <- function(nic, factor){
  if (!inherits(nic, "niche"))
    stop("Object of class niche expected")
  appel <- as.list(nic$call)
  Y <- eval.parent(appel[[3]])
  liani <- split(as.data.frame(nic$ls), factor)
  N <- max(as.numeric(levels(factor)))
  liwei <- sep.factor.row(Y,factor)
  for(i in 1:length(liwei)){
    w <- liwei[[i]]
    w2 <- apply(w, 2, sum)
    liwei[[i]] <- sweep(w, 2, w2, "/")
  }
  mav <- as.data.frame(t(as.matrix(data.frame(lapply(liani,
                                                     function(x) apply(x, 2, mean))))))
  names(mav) <- names(nic$li)
  mutemp <- list()

  for (i in 1:length(liwei)){
    mutemp[[i]] <- matrix(nrow=length(colnames(Y)), ncol=nic$nf)
    rownames(mutemp[[i]]) <- paste(colnames(Y),levels(factor)[[i]],sep="")
    for(j in 1:length(colnames(Y))){
      z <- liwei[[i]][,j]
      mutemp[[i]][j,] <- apply(liani[[i]],2, weighted.mean, z)
    }
  }
  mutemp <- do.call("rbind", mutemp)
  nic$mus <- mutemp
  nic$mav <- mav
  nic$factor <- factor
  class(nic) <- c("subniche", "dudi")
  return(nic)
}
#' @rdname subniche
#' @method print subniche
#' @export
print.subniche <- function (x, ...)
{
  if (!inherits(x, "subniche"))
    stop("to be used with 'niche' object")
  cat("Subscale Niche analysis\n")
  cat("call: ")
  print(x$call)
  cat("class: ")
  cat(class(x), "\n")
  cat("\n$rank (rank)     :", x$rank)
  cat("\n$nf (axis saved) :", x$nf)
  cat("\n$RV (RV coeff)   :", x$RV)
  cat("\n\neigen values: ")
  l0 <- length(x$eig)
  cat(signif(x$eig, 4)[1:(min(5, l0))])
  if (l0 > 5)
    cat(" ...\n\n")
  else cat("\n\n")
  sumry <- array("", c(4, 4), list(1:4, c("vector", "length",
                                          "mode", "content")))
  sumry[1, ] <- c("$eig", length(x$eig), mode(x$eig), "eigen values")
  sumry[2, ] <- c("$lw", length(x$lw), mode(x$lw), "row weigths (crossed array)")
  sumry[3, ] <- c("$cw", length(x$cw), mode(x$cw), "col weigths (crossed array)")
  sumry[4, ] <- c("$factor", length(x$factor), mode(x$factor), "factor used")
  print(sumry, quote = FALSE)
  cat("\n")
  sumry <- array("", c(10, 4), list(1:10, c("data.frame", "nrow",
                                            "ncol", "content")))
  sumry[1, ] <- c("$vectors", nrow(x$vectors), ncol(x$vectors), "eigen vectors")
  sumry[2, ] <- c("$tab", nrow(x$tab), ncol(x$tab), "crossed array (averaging species/sites)")
  sumry[3, ] <- c("$li", nrow(x$li), ncol(x$li), "species coordinates")
  sumry[4, ] <- c("$l1", nrow(x$l1), ncol(x$l1), "species normed scores")
  sumry[5, ] <- c("$co", nrow(x$co), ncol(x$co), "variables coordinates")
  sumry[6, ] <- c("$c1", nrow(x$c1), ncol(x$c1), "variables normed scores")
  sumry[7, ] <- c("$ls", nrow(x$ls), ncol(x$ls), "sites coordinates")
  sumry[8, ] <- c("$as", nrow(x$as), ncol(x$as), "axis upon niche axis")
  sumry[9, ] <- c("$mav", nrow(x$mav), ncol(x$mav), "G_k coordinates")
  sumry[10, ] <- c("$mus", nrow(x$mus), ncol(x$mus), "species coordinates at each subscale")

  print(sumry, quote = FALSE)
  cat("\n")
}
#' @rdname subniche
#' @method plot subniche
#' @export
#' @importFrom graphics par layout
plot.subniche <- function (x, xax = 1, yax = 2, ...)
{
  if (!inherits(x, "subniche"))
    stop("Use only with 'subniche' objects")
  if (x$nf == 1) {
    warnings("One axis only : not yet implemented")
    return(invisible())
  }
  if (xax > x$nf)
    stop("Non convenient xax")
  if (yax > x$nf)
    stop("Non convenient yax")
  def.par <- par(no.readonly = TRUE)
  on.exit(par(def.par))
  layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), respect = TRUE)
  par(mar = c(0.1, 0.1, 0.1, 0.1))
  s.corcircle(x$as, xax, yax, sub = "Axis", csub = 2, clabel = 1.25)
  s.arrow(x$c1, xax, yax, sub = "Variables", csub = 2, clabel = 1.25)
  scatterutil.eigen(x$eig, wsel = c(xax, yax))
  s.label(x$ls, xax, yax, clabel = 0, cpoint = 2, sub = "Samples and Species",
          csub = 2)
  s.label(x$li, xax, yax, clabel = 1.5, add.plot = TRUE)
  s.label(x$ls, xax, yax, clabel = 1.25, sub = "Samples", csub = 2)
  s.distri(x$ls, eval.parent(as.list(x$call)[[3]]), cstar = 0,
           axesell = FALSE, cellipse = 1, sub = "Reference Niches", csub = 2)
}
#' @rdname subniche
#' @export
#' @importFrom graphics par layout
margvect <- function (x, xax = 1, yax = 2, ...)
{
  if (!inherits(x, "subniche"))
    stop("Use only with 'subniche' objects")
  if (x$nf == 1) {
    warnings("One axis only : not yet implemented")
    return(invisible())
  }
  if (xax > x$nf)
    stop("Non convenient xax")
  if (yax > x$nf)
    stop("Non convenient yax")
  def.par <- par(no.readonly = TRUE)
  on.exit(par(def.par))
  layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), respect = TRUE)
  par(mar = c(0.1, 0.1, 0.1, 0.1))
  s.corcircle(x$as, xax, yax, sub = "Axis", csub = 2, clabel = 1.25)
  s.arrow(x$c1, xax, yax, sub = "Variables", csub = 2, clabel = 1.25)
  scatterutil.eigen(x$eig, wsel = c(xax, yax))
  s.label(x$ls, xax, yax, clabel = 0, cpoint = 2, sub = "G_k marginality vectors",
          csub = 2)
  s.arrow(x$mav, xax, yax,  clabel = 1.5, add.plot=T)
  s.chull(x$ls, x$factor,clabel = 1.5, sub = "Available Resource units",csub = 2, optchull = 1, cpoint = 1)
  s.label(x$mus[is.na(x$mus[,1])==FALSE,], xax,yax, clabel = 1.5,sub = "Sub Niches", csub = 2)
}
#' @rdname subniche
#' @export
#' @importFrom graphics par layout arrows points
subplot <- function (x, xax = 1, yax = 2, ...)
{
  if (!inherits(x, "subniche"))
    stop("Use only with 'subniche' objects")
  if (x$nf == 1) {
    warnings("One axis only : not yet implemented")
    return(invisible())
  }
  if (xax > x$nf)
    stop("Non convenient xax")
  if (yax > x$nf)
    stop("Non convenient yax")
  if (length(levels(x$factor)) > 20)
    stop("length level factor > 20 ")
  def.par <- par(no.readonly = TRUE)
  on.exit(par(def.par))
  op <- par(oma = c(0,0,0,0) + 0.1,
            mar = c(0,0,0,0) + 0.1)
  f <- factor(sort(rep(levels(x$factor),nrow(x$li))))
  mav <- x$mav
  mut <- x$mus
  for (i in as.numeric(min(levels(x$factor))):as.numeric(max(levels(x$factor))))
  {
    s.distri(x$ls, eval.parent(as.list(x$call)[[3]]), cstar = 0,axesell = FALSE, cellipse = 0, cpoint=0, sub = i, csub = 2)
    s.distri(x$ls[x$factor==i,], eval.parent(as.list(x$call)[[3]])[x$factor==i,], cstar = 0,axesell = FALSE, cellipse = 0, cpoint=1, sub = i, csub = 2,add.plot = T)
    s.label(mut[f==i,],label=rownames(x$li),add.plot = T)
    arrows(mav[array(levels(x$factor)==i), 1],mav[array(levels(x$factor)==i), 2],  mut[f==i,1],mut[f==i,2], length = 0.1)
    points(mav[array(levels(x$factor)==i),],pch=16, col="red")
    s.chull(x$ls[x$factor==i,], x$factor[x$factor==i], clabel = 0, optchull = 1, col=rep("red", length(levels(x$factor[x$factor==i]))), cpoint = 0,add.plot = T)
    s.chull(x$ls,factor(rep(i,length(x$ls[,1]))), clabel = 0,col="black", optchull = 1, cpoint = 0,add.plot = T)

  }
  par(op)
}
#' @rdname subniche
#' @method summary subniche
#' @export
summary.subniche <- function (object, ...)
{
  cat("Class: ")
  cat(class(object))
  cat("\nCall: ")
  print(object$call)
  cat("\nTotal inertia: ")
  cat(signif(sum(object$eig), 4))
  cat("\n")
  l0 <- length(object$eig)
  cat("\nEigenvalues:\n")
  vec <- object$eig[1:(min(5, l0))]
  names(vec) <- paste("Ax", 1:length(vec), sep = "")
  print(format(vec, digits = 4, trim = TRUE, width = 7), quote = FALSE)
  cat("\nProjected inertia (%):\n")
  vec <- (object$eig/sum(object$eig) * 100)[1:(min(5, l0))]
  names(vec) <- paste("Ax", 1:length(vec), sep = "")
  print(format(vec, digits = 4, trim = TRUE, width = 7), quote = FALSE)
  cat("\nCumulative projected inertia (%):\n")
  vec <- (cumsum(object$eig)/sum(object$eig) * 100)[1:(min(5,
                                                           l0))]
  names(vec)[1] <- "Ax1"
  if (l0 > 1)
    names(vec)[2:length(vec)] <- paste("Ax1:", 2:length(vec),
                                       sep = "")
  print(format(vec, digits = 4, trim = TRUE, width = 7), quote = FALSE)
  if (l0 > 5) {
    cat("\n")
    cat(paste("(Only 5 dimensions (out of ", l0, ") are shown)\n",
              sep = "", collapse = ""))
  }
  cat("\n")
}
#' @rdname subniche
#' @export
refparam <- function (x)
{
  if (!inherits(x, "subniche"))
    stop("Object of class 'subniche' expected")
  appel <- as.list(x$call)
  X <- eval.parent(appel[[2]])$tab
  Y <- eval.parent(appel[[3]])
  w1 <- apply(Y, 2, sum)
  if (any(w1 <= 0))
    stop(paste("Column sum <=0 in Y"))
  Y <- sweep(Y, 2, w1, "/")
  calcul.param <- function(freq, mil) {
    inertia <- sum(freq * mil * mil)
    m <- apply(freq * mil, 2, sum)
    margi <- sum(m^2)
    mil <- t(t(mil) - m)
    tolt <- sum(freq * mil * mil)
    u <- m/sqrt(sum(m^2))
    z <- mil %*% u
    tolm <- sum(freq * z * z)
    tolr <- tolt - tolm
    w <- c(inertia, margi, tolm, tolr)
    names(w) <- c("inertia", "OMI", "Tol", "Rtol")
    w1 <- round(w[2:4]/w[1], digits = 3) * 100
    names(w1) <- c("omi", "tol", "rtol")
    return(c(w, w1))
  }
  res <- apply(Y, 2, calcul.param, mil = X)
  t(res)
}
#' @rdname subniche
#' @method rtest subniche
#' @export
rtest.subniche <- function (xtest, nrepet = 99, ...)
{
  if (!inherits(xtest, "dudi"))
    stop("Object of class dudi expected")
  if (!inherits(xtest, "subniche"))
    stop("Type 'niche' expected")
  appel <- as.list(xtest$call)
  X <- eval.parent(appel$dudiX)$tab
  Y <- eval.parent(appel$Y)
  w1 <- apply(Y, 2, sum)
  if (any(w1 <= 0))
    stop(paste("Column sum <=0 in Y"))
  Y <- sweep(Y, 2, w1, "/")
  calcul.margi <- function(freq, mil) {
    m <- apply(freq * mil, 2, sum)
    return(sum(m^2))
  }
  obs <- apply(Y, 2, calcul.margi, mil = X)
  obs <- c(obs, OMI.mean = mean(obs))
  sim <- sapply(1:nrepet, function(x) apply(apply(Y, 2, sample),
                                            2, calcul.margi, mil = X))
  sim <- rbind(sim, OMI.mean = apply(sim, 2, mean))
  res <- as.krandtest(obs = obs, sim = t(sim))
  return(res)
}
#' @rdname subniche
#' @export
subparam.refor <- function(x){
  res <- list()
  appel <- as.list(x$call)
  y <-eval.parent(appel[[3]])
  factor <- x$factor
  subniche.param <- function (x,y)
  {
    if (!inherits(x, "subniche"))
      stop("Object of class 'subniche' expected")
    appel <- as.list(x$call)
    X <- eval.parent(appel[[2]])$tab[y,]
    Y <- eval.parent(appel[[3]])[y,]
    w1 <- apply(Y, 2, sum)
    Y <- sweep(Y, 2, w1, "/")
    calcul.param <- function(freq, mil) {
      inertia <- sum(freq * mil * mil)
      m <- apply(freq * mil, 2, sum)
      margi <- sum(m^2)
      mil <- t(t(mil) - m)
      tolt <- sum(freq * mil * mil)
      u <- m/sqrt(sum(m^2))
      z <- mil %*% u
      tolm <- sum(freq * z * z)
      tolr <- tolt - tolm
      w <- c(inertia, margi, tolm, tolr)
      names(w) <- c("inertia", "OMI", "Tol", "Rtol")
      w1 <- round(w[2:4]/w[1], digits = 3) * 100
      names(w1) <- c("omi", "tol", "rtol")
      return(c(w, w1))
    }
    res <- apply(Y, 2, calcul.param, mil = X)
    t(res)
  }
  N <- max(as.numeric(levels(factor)))
  for(i in 1:N){
    res[[i]] <-  subniche.param(x,array(factor)==i)

  }
  return(res)
}
#' @rdname subniche
#' @export
rtestrefor <- function(x, nrepet){
factor <- x$factor
res <- list()
N <- max(as.numeric(levels(factor)))
appel <- as.list(x$call)
X <- eval.parent(appel[[2]])$tab
Y <- eval.parent(appel[[3]])
calcul.margi <- function(freq, mil) {
  m <- apply(freq * mil, 2, sum)
  return(sum(m^2))
}
for(i in 1:N){
  X1 <- X[array(factor)==i,]
  Xwobs <- apply(X1, 2, mean)
  Xsim <- sapply(1:nrepet, function(x) apply(t <- apply(X, 2, sample)[array(factor)==i,], 2, mean))
  Xtest <- as.krandtest(obs=Xwobs, sim=t(Xsim))
  Xtestpvalue <- prod(Xtest$pvalue)
  w1 <- apply(Y[array(factor)==i,], 2, sum)
  Y1 <- sweep(Y[array(factor)==i,], 2, w1, "/")
  obs <- apply(Y1, 2, calcul.margi, mil = X1)
  obs <- c(obs, OMI.mean = mean(obs,na.rm=TRUE))
  sim <- sapply(1:nrepet, function(x) apply(sweep(t <- apply(Y, 2, sample)[array(factor)==i,], 2,apply(t, 2, sum),"/"), 2, calcul.margi, mil = X1))
  sim <- rbind(sim, OMI.mean = apply(sim, 2, mean,na.rm=TRUE))
  omitest <- as.krandtest(obs = obs, sim = t(sim))
  res[[i]] <- as.matrix(Xtestpvalue*omitest$pvalue)
  rownames(res[[i]]) <- c(colnames(Y),"mean")
}
return(res)
}
#' @rdname subniche
#' @export
subparam.subor <- function(x){
  res <- list()
  appel <- as.list(x$call)
  y <-eval.parent(appel[[3]])
  factor <- x$factor
  subnichesub.param <- function (x,y)
  {
    if (!inherits(x, "subniche"))
      stop("Object of class 'subniche' expected")
    appel <- as.list(x$call)
    X <- eval.parent(appel[[2]])$tab[y,]
    X <- as.matrix(scale(X, center=T,scale=F))
    Y <- eval.parent(appel[[3]])[y,]
    w1 <- apply(Y, 2, sum)
    Y <- sweep(Y, 2, w1, "/")
    calcul.param <- function(freq, mil) {
      inertia <- sum(freq * mil * mil)
      m <- apply(freq * mil, 2, sum)
      margi <- sum(m^2)
      mil <- t(t(mil) - m)
      tolt <- sum(freq * mil * mil)
      u <- m/sqrt(sum(m^2))
      z <- mil %*% u
      tolm <- sum(freq * z * z)
      tolr <- tolt - tolm
      w <- c(inertia, margi, tolm, tolr)
      names(w) <- c("inertia", "OMI", "Tol", "Rtol")
      w1 <- round(w[2:4]/w[1], digits = 3) * 100
      names(w1) <- c("omi", "tol", "rtol")
      return(c(w, w1))
    }
    res <- apply(Y, 2, calcul.param, mil = X)
    t(res)
  }
  N <- max(as.numeric(levels(factor)))
  for(i in 1:N){
    res[[i]] <-  subnichesub.param(x,array(factor)==i)

  }
  return(res)
}
#' @rdname subniche
#' @export
rtestsubor <- function(x, nrepet){
  factor <- x$factor
  res <- list()
  N <- max(as.numeric(levels(factor)))
  appel <- as.list(x$call)
  X <- eval.parent(appel[[2]])$tab
  Y <- eval.parent(appel[[3]])
  calcul.margi <- function(freq, mil) {
    m <- apply(freq * mil, 2, sum)
    return(sum(m^2))
  }
  for(i in 1:N){
    X1 <- X[array(factor)==i,]
    Xwobs <- apply(X1, 2, mean)
    Xobs <- sweep(X1, 2,Xwobs,"-")
    Xsim <- sapply(1:nrepet, function(x) apply(t <- apply(X, 2, sample)[array(factor)==i,], 2, mean))
    Xtest <- as.krandtest(obs=Xwobs, sim=t(Xsim))
    Xtestpvalue <- prod(Xtest$pvalue)
    w1 <- apply(Y[array(factor)==i,], 2, sum)
    Y1 <- sweep(Y[array(factor)==i,], 2, w1, "/")
    obs <- apply(Y1, 2, calcul.margi, mil = Xobs)
    obs <- c(obs, OMI.mean = mean(obs,na.rm=TRUE))
    sim <- sapply(1:nrepet, function(x) apply(sweep(t <- apply(Y, 2, sample)[array(factor)==i,], 2,apply(t, 2, sum),"/"), 2, calcul.margi, mil = Xobs))
    sim <- rbind(sim, OMI.mean = apply(sim, 2, mean,na.rm=TRUE))
    omitest <- as.krandtest(obs = obs, sim = t(sim))
    res[[i]] <- as.matrix(Xtestpvalue*omitest$pvalue)
    rownames(res[[i]]) <- c(colnames(Y),"mean")
  }
  return(res)
}

