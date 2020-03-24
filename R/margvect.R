#' @rdname margvect
#' @title Summarizes the results of the sub-environmental spaces
#' @description The function plot the resulting sub-environmental space of the WitOMI calculation.
#' @aliases margvect
#' @export margvect
#' @importFrom graphics par layout
#' @param x an object of class \code{subniche}.
#' @param xax column for abscisse.
#' @param yax column for ordinate.
#' @param colo string of colors of equal length than the number of G_k, if NULL "red"
#' @param ... further arguments passed to or from other methods.
#' @usage margvect(x, xax = 1, yax = 2, colo = NULL, ...)

margvect <- function (x, xax = 1, yax = 2, colo = NULL, ...)
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
  if (is.null(colo) == TRUE){
    colo <- c(rep("red",length(levels(x$factor))))
  }
  def.par <- par(no.readonly = TRUE)
  on.exit(par(def.par))
  layout(matrix(c(1, 2, 3, 4, 4, 5, 4, 4, 6), 3, 3), respect = TRUE)
  par(mar = c(0.1, 0.1, 0.1, 0.1))
  s.corcircle(x$as, xax, yax, sub = "Axis", csub = 2, clabel = 1.25)
  s.arrow(x$c1, xax, yax, sub = "Variables", csub = 2, clabel = 1.25)
  scatterutil.eigen(x$eig, wsel = c(xax, yax))
  s.chull(x$ls,factor(rep(1,dim(x$ls)[1])), xax, yax, optchull = 1,clabel = 0, cpoint = 2, sub = "G_k marginality vectors",
          csub = 2)
  s.arrow(x$G_k, xax, yax,  clabel = 1.5, add.plot=T)
  s.chull(x$ls,factor(rep(1,dim(x$ls)[1])), xax, yax, optchull = 1,clabel = 0, cpoint = 1)
  s.chull(x$ls, x$factor,label=rownames(x$G_k),clabel = 1.5, col=colo,sub = "Available Resource units",csub = 2, optchull = 1, cpoint = 1, add.plot = T)
  s.label(x$sub[is.na(x$sub[,1])==FALSE,], xax,yax, clabel = 1.5,sub = "Subniches", csub = 2)
}
#' @examples
#' library(subniche)
#' data(doubs)
#' dudi1 <- dudi.pca(doubs$env, scale = TRUE, scan = FALSE, nf = 3)
#' nic1 <- niche(dudi1, doubs$fish, scann = FALSE)
#' # number of sites
#' N <- dim(nic1$ls)[1]
#' #Create a factor which defines the subsets
#' fact <- factor(c(rep(1,N/2),rep(2,N/2)))
#' # nic1 will be use as reference and fact will be use to define the subniches environment
#' subnic1 <- subniche(nic1, fact)
#' margvect(subnic1)
