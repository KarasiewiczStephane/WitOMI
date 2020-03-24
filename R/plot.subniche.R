#' @rdname plot.subniche
#' @aliases plot.subniche
#' @title Summarizes the results of the species subniche
#' @description The function plot the resulting species subniche of the WitOMI calculation.
#' @param ... further arguments passed to or from other methods.
#' @param x an object of class \code{subniche}.
#' @param xax column for abscisse.
#' @param yax column for ordinate.
#' @param ax.angle.arrow arrow angle head for plot labelled "Axes", see \link[graphics]{arrows} for more details.
#' @param ax.lwd.arrow arrow width for plot labelled "Axes", see \link[graphics]{arrows} for more details.
#' @param ax.length.arrow arrow head length for plot labelled "Axes", see \link[graphics]{arrows} for more details.
#' @param ax.col.arrow arrow color for plot labelled "Axes", see \link[graphics]{arrows} for more details.
#' @param ax.leg.posi legend position for plot labelled "Axes", see \link[graphics]{legend} for more details.
#' @param ax.leg.cex legend size label for plot labelled "Axes", see \link[graphics]{legend} for more details.
#' @param eig.col.chos bar color for the selected components for plot labelled "Eigenvalues".
#' @param eig.col.left bar color for the component leftover for plot labelled "Eigenvalues".
#' @param eig.leg.posi legend position for plot labelled "Eigenvalues", see \link[graphics]{legend} for more details.
#' @param eig.leg.cex legend size label for plot labelled "Eigenvalues"", see \link[graphics]{legend} for more details.
#' @param su.leg.posi legend position for plot labelled "SU", see \link[graphics]{legend} for more details.
#' @param su.leg.cex legend size label for plot labelled "SU", see \link[graphics]{legend} for more details.
#' @param sub.leg.posi legend position for plot labelled "Subsets", see \link[graphics]{legend} for more details.
#' @param sub.leg.cex legend size label for plot labelled "Subsets"", see \link[graphics]{legend} for more details.
#' @param col.axis axis color, see \link[graphics]{par} for more details.
#' @param lty.axis axis line type, see \link[graphics]{par} for more details.
#' @param lwd.axis  axis width, see \link[graphics]{par} for more details.
#' @param var.col.arrow variables arrow color for plot labelled "Variables and Species", see \link[graphics]{arrows} for more details.
#' @param var.angle.arrow variables arrow angle head for plot labelled "Variables and Species", see \link[graphics]{arrows} for more details.
#' @param var.lwd.arrow variables arrow width for plot labelled "Variables and Species", see \link[graphics]{arrows} for more details.
#' @param var.length.arrow variables arrow length of the edges of the arrow head (in inches).
#' @param var.leg.posi legend position for plot labelled "Variables and Species", see \link[graphics]{legend} for more details.
#' @param var.leg.cex legend size label for plot labelled "Variables and Species", see \link[graphics]{legend} for more details.
#' @param col.var color variables labels, see \link[wordcloud]{textplot} for more details.
#' @param col.sp color species labels and their respective niches, see \link[wordcloud]{textplot} for more details.
#' @param col.su color of sampling units, see \link[graphics]{points} for more details.
#' @param col.G_k color label G_k, see \link[wordcloud]{textplot} for more details.
#' @param col.ax color of axes labels, see \link[wordcloud]{textplot} for more details.
#' @param nic.leg.posi legend position for plot labelled "Niches", see \link[graphics]{legend} for more details.
#' @param nic.leg.cex legend size label for plot labelled "Niches", see \link[graphics]{legend} for more details.
#' @param pch.su type of the points representing the sampling units (SU), see \link[graphics]{points} for more details.
#' @param cex.su size of the points representing the sampling units (SU), see \link[graphics]{points} for more details.
#' @param border.E color border of E polygon, see \link[graphics]{polygon} for more details.
#' @param col.E inside color of E polygon, see \link[graphics]{polygon} for more details.
#' @param lty.E line type for the E border, see \link[graphics]{polygon} for more details.
#' @param border.K color border of K polygon, see \link[graphics]{polygon} for more details.
#' @param col.K inside color of K polygon, see \link[graphics]{polygon} for more details.
#' @param lty.K line type for the K border, see \link[graphics]{polygon} for more details.
#' @param lty.NR line type for the NR border, see \link[graphics]{polygon} for more details.
#' @param sub.angle.arrow arrow angle head for plot labelled "Subsets", see \link[graphics]{arrows} for more details.
#' @param sub.lwd.arrow arrow width for plot labelled  "Subsets", see \link[graphics]{arrows} for more details.
#' @param sub.length.arrow arrow head length for plot labelled  "Subsets", see \link[graphics]{arrows} for more details.
#' @param sub.col.arrow arrow color for plot labelled  "Subsets", see \link[graphics]{arrows} for more details.
#' @param show.lines if true, then lines are plotted between x,y and the word, for those words not covering their x,y coordinates. See \link[wordcloud]{textplot} for more details.
#' @details The function illustrate the results of subniche calculation with a great deal of customization parameters.
#' @method plot subniche
#' @export plot subniche(x, xax = 1, yax = 2, ax.angle.arrow=20, ax.col.arrow="black",
#' ax.length.arrow=0.1, ax.lwd.arrow=1, ax.leg.posi="bottomleft", ax.leg.cex=1.2,
#' eig.col.chos="black", eig.col.left="gray", eig.leg.posi="topright",
#' eig.leg.cex=1.2, su.leg.posi="bottomleft", su.leg.cex=1.2, col.axis="azure3",
#' lty.axis=2, lwd.axis=2, var.col.arrow="black", var.length.arrow=0.1,
#' var.lwd.arrow=1, var.angle.arrow=20, var.leg.posi="bottomleft", var.leg.cex=1.2,
#' col.var="black", col.sp=rainbow(n=dim(x$li)[1]), col.su="black",
#' col.G_k="red", col.ax="black", nic.leg.posi = "bottomleft",
#' nic.leg.cex=1.2, sub.leg.cex=1.2, sub.leg.posi= "bottomleft",
#' pch.su=16, cex.su=1, border.E="#92c5de", col.E="#92c5de", lty.E=1,
#' border.K ="#fdb462", col.K ="#fdb462", lty.K=1, lty.NR=1,
#' sub.angle.arrow=20, sub.col.arrow="black",sub.length.arrow=0.1,
#' sub.lwd.arrow=1, show.lines=F, ...)
#' @export
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
#' plot(subnic1)
#' @importFrom graphics par layout barplot box lines plot segments
#' @importFrom siar convexhull
#' @importFrom wordcloud textplot
#' @importFrom grDevices rainbow
plot.subniche <- function (x, xax = 1, yax = 2, ax.angle.arrow=20, ax.col.arrow="black", ax.length.arrow=0.1,
                           ax.lwd.arrow=1, ax.leg.posi="bottomleft", ax.leg.cex=1.2, eig.col.chos="black", eig.col.left="gray",
                           eig.leg.posi="topright", eig.leg.cex=1.2, su.leg.posi="bottomleft", su.leg.cex=1.2,
                           col.axis="azure3",lty.axis=2, lwd.axis=2, var.col.arrow="black", var.length.arrow=0.1,
                           var.lwd.arrow=1, var.angle.arrow=20, var.leg.posi="bottomleft", var.leg.cex=1.2, col.var="black",
                           col.sp=rainbow(n=dim(x$li)[1]), col.su="black", col.G_k="red", col.ax="black",
                           nic.leg.posi = "bottomleft", nic.leg.cex=1.2, sub.leg.cex=1.2, sub.leg.posi= "bottomleft",
                           pch.su=16, cex.su=1, border.E="#92c5de", col.E="#92c5de", lty.E=1, border.K ="#fdb462",
                           col.K ="#fdb462", lty.K=1, lty.NR=1, sub.angle.arrow=20, sub.col.arrow="black",
                           sub.length.arrow=0.1, sub.lwd.arrow=1, show.lines=F, ...)
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
  plot(c(-1, 1), c(-1, 1), type = "n",  xlab=NA, ylab=NA, xaxt='n',yaxt='n',asp=1)
  radius <- 1
  theta <- seq(0, 2 * pi, length = 200)
  lines(x = radius * cos(theta), y = radius * sin(theta))
  segments(0,-1,0,1)
  segments(-1,0,1,0)
  N <- dim(x$as)[1]
  arrows(rep(0,N),rep(0,N),x$as[,xax], x$as[,yax], angle= ax.angle.arrow,
         col= ax.col.arrow, length=ax.length.arrow)
  textplot(x$as[,xax]*1.1,x$as[,yax]*1.1, rownames(x$as), new=F, show.lines=show.lines, col=col.ax)
  legend(ax.leg.posi, "Axis",cex=ax.leg.cex, bty="n")
  barplot(x$eig, col=c(rep(eig.col.chos,x$nf), rep(eig.col.left,length(x$eig-x$nf))), yaxt='n')
  legend(eig.leg.posi, "Eigenvalues", cex=eig.leg.cex, bty="n")
  plot(x$ls, type = "n",  xlab=NA, ylab=NA, xaxt='n',yaxt='n',asp=1)
  box()
  E <- convexhull(x$ls[,xax], x$ls[,yax])
  polygon(E$xcoords,E$ycoords, border=border.E, col=col.E, lty=lty.E)
  abline(h=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
  abline(v=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
  textplot(x$ls[,xax],x$ls[,yax],rownames(x$ls),new=F, show.lines=show.lines, col=col.su)
  legend(su.leg.posi, "SU", cex=su.leg.cex, bty="n")
  textplot(x$li[,xax],x$li[,yax], rownames(x$li), show.lines=show.lines, col=col.sp,
           new=T, xlab=NA, ylab=NA,xaxt='n',yaxt='n', asp=1)
  box()
  m <- dim(x$c1)[1]
  arrows(rep(0,m),rep(0,m),x$c1[,xax], x$c1[,yax], angle=var.angle.arrow,
         col=var.col.arrow, length=var.length.arrow)
  textplot(x$c1[,xax]*1.2,x$c1[,yax]*1.2, rownames(x$c1), new=F, show.lines=show.lines, col=col.var)
  abline(h=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
  abline(v=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
  legend(var.leg.posi, "Variables and Species", cex=var.leg.cex, bty="n")
  plot(x$ls, type = "n", xlab=NA, ylab=NA,xaxt='n',yaxt='n',asp=1)
  box()
  E <- convexhull(x$ls[,xax], x$ls[,yax])
  polygon(E$xcoords,E$ycoords, border=border.E, col=col.E, lty=lty.E)
  points(x$ls[,xax],x$ls[,yax], pch=pch.su, cex=cex.su, col=col.su)
  are_sub <- subarea(x)
  for (i in 1:dim(x$li)[1]){
    NR <- are_sub$NR[[i]]
    polygon(NR$x,NR$y, border=col.sp[i], col=NULL, lty=lty.NR)
  }
  abline(h=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
  abline(v=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
  legend(nic.leg.posi, "Niches", cex=nic.leg.cex, bty="n")
  plot(x$ls, type = "n",  xlab=NA, ylab=NA,xaxt='n',yaxt='n',asp=1)
  box()
  E <- convexhull(x$ls[,xax], x$ls[,yax])
  polygon(E$xcoords,E$ycoords, border=border.E, col=col.E, lty=lty.E)
  N <- length(levels(x$factor))
  for (i in 1:N){
    K <- are_sub$K[[i]]
    polygon(K$x,K$y, border=border.K, col=col.K, lty=lty.K)
  }
  points(x$ls[,xax],x$ls[,yax], pch=pch.su, cex=cex.su, col=col.su)
  abline(h=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
  abline(v=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
  textplot(x$G_k[,xax]*1.1, x$G_k[,yax]*1.1,rownames(x$G_k), new=F,
           show.lines=show.lines, col=col.G_k)
  arrows(rep(0,N), rep(0,N), x$G_k[,xax], x$G_k[,yax], code=2, col=sub.col.arrow,
         length=sub.length.arrow, angle=sub.angle.arrow, lwd=sub.lwd.arrow)
  legend(sub.leg.posi, "Subsets", cex=sub.leg.cex, bty="n")
}
