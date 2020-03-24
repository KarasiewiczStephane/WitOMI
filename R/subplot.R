#' @title Sub-community plot under each sub-environmental space K
#' @aliases subplot
#' @description  The function to represent the community subniche position under each subenvironment K with their respective marginality from G_K.
#' @usage subplot(subnic, main=NULL, xlab=NULL, ylab=NULL, col.axis="azure3", lty.axis=2,
#'        lwd.axis=2, col.sublab="black", font.sublab=2, cex.sublab=0.7, show.lines=F,
#'        border.E="#92c5de", col.E="#92c5de", lty.E=1, lwd.E=1, border.K ="#2c7fb8",
#'        col.K ="#2c7fb8", lty.K=1, lwd.K=1, col.arrow="black", angle.arrow=20, lwd.arrow=2,
#'        length.arrow=0.1, col.G_k= "#b35806", cex.G_k=0.5, pch.G_k=19,
#'        col.su="#b35806", cex.su=0.5, pch.su=1, posi.leg="topleft", bty.leg="n", ...)
#' @param ...	further arguments passed to or from other methods.
#' @param subnic an object of class \code{subniche}.
#' @param main a main title for the plot, see \link[graphics]{title} for more details.
#' @param xlab a label for the x axis, defaults to a description of x, see \link[graphics]{title} for more details.
#' @param ylab a label for the y axis, defaults to a description of y, see \link[graphics]{title} for more details.
#' @param col.axis axis color, see \link[graphics]{par} for more details.
#' @param lty.axis axis line type, see \link[graphics]{par} for more details.
#' @param lwd.axis  axis width, see \link[graphics]{par} for more details.
#' @param col.sublab color of the species labels, see \link[wordcloud]{textplot} for more details.
#' @param font.sublab font of the species labels, see \link[wordcloud]{textplot} for more details.
#' @param cex.sublab size of the species labels, see \link[wordcloud]{textplot} for more details.
#' @param show.lines if true, then lines are plotted between x,y and the word, for those words not covering their x,y coordinates. See \link[wordcloud]{textplot} for more details.
#' @param border.E color border of E polygon, see \link[graphics]{polygon} for more details.
#' @param col.E inside color of E polygon, see \link[graphics]{polygon} for more details.
#' @param lty.E line type for the E border, see \link[graphics]{polygon} for more details.
#' @param lwd.E line width for the E border, see \link[graphics]{polygon} for more details.
#' @param border.K color border of K polygon, see \link[graphics]{polygon} for more details.
#' @param col.K inside color of K polygon, see \link[graphics]{polygon} for more details.
#' @param lty.K line type for the K border, see \link[graphics]{polygon} for more details.
#' @param lwd.K line width for the K border, see \link[graphics]{polygon} for more details.
#' @param col.G_k color of the point representing G_k, see \link[graphics]{points} for more details.
#' @param cex.G_k size of the point representing G_k, see \link[graphics]{points} for more details.
#' @param pch.G_k type of the point representing G_k, see \link[graphics]{points} for more details.
#' @param col.su color of the points representing the sampling units (SU), see \link[graphics]{points} for more details.
#' @param cex.su size of the points representing the sampling units (SU), see \link[graphics]{points} for more details.
#' @param pch.su type of the points representing the sampling units (SU), see \link[graphics]{points} for more details.
#' @param posi.leg legend location in the graph, see \link[graphics]{legend} for more details.
#' @param col.arrow arrow color, see \link[graphics]{arrows} for more details.
#' @param angle.arrow arrow angle head, see \link[graphics]{arrows} for more details.
#' @param lwd.arrow arrow width, see \link[graphics]{arrows} for more details.
#' @param length.arrow arrow head length, see \link[graphics]{arrows} for more details.
#' @param bty.leg the type of box to be drawn around the legends. The allowed values are "o" (the default) and "n". See \link[graphics]{legend} for more details

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
#' eig <- round(subnic1$eig/sum(subnic1$eig)*100,2)[1:2]
#' #Two graphs are drawn one after the other
#' subplot(subnic1,main="Species subniche in K",
#' xlab=paste(paste("OMI1", eig[1], sep=" "),"%", sep=""),
#' ylab=paste(paste("OMI2", eig[2], sep=" "),"%", sep=""))
#'
#' @rdname subplot
#' @export subplot
#' @importFrom graphics par layout arrows points legend polygon abline
#' @importFrom wordcloud textplot
#' @importFrom siar convexhull
subplot <- function(subnic, main=NULL, xlab=NULL, ylab=NULL, col.axis="azure3", lty.axis=2, lwd.axis=2, col.sublab="black", font.sublab=2,
                    cex.sublab=0.7, show.lines=F, border.E="#92c5de", col.E="#92c5de", lty.E=1,lwd.E=1,
                    border.K ="#2c7fb8", col.K ="#2c7fb8", lty.K=1, lwd.K=1, col.arrow="black",
                    angle.arrow=20, lwd.arrow=2, length.arrow=0.1, col.G_k= "#b35806", cex.G_k=0.5,
                    pch.G_k=19, col.su="#b35806", cex.su=0.5, pch.su=1, posi.leg="topleft", bty.leg="n", ...){
  fac <- subnic$factor
  lev <- levels(fac)
  N <- length(lev)
  subsp <- subnic$sub
  if(anyNA(subsp))
    subsp <- subsp[-which(is.na(subsp[,1])==T),]
  for (i in 1:N){
    subnici <- subnic$ls[which(fac==lev[i]),]
    G_k <- subnic$G_k[grep(lev[i],rownames(subnic$G_k)),]
    subspk <- subsp[grep(lev[i],rownames(subsp)),]
    sp <- sub(lev[i],"",rownames(subspk))
    m <- dim(subspk)[1]
    plot(subnic$ls, main=main, xlab=xlab, ylab=ylab, type="n",...)
    E <- convexhull(subnic$ls[,1], subnic$ls[,2])
    polygon(E$xcoords,E$ycoords, border=border.E, col=col.E, lty=lty.E, lwd=lwd.E)
    K <- convexhull(subnici[,1], subnici[,2])
    polygon(K$xcoords,K$ycoords, border=border.K, col=col.K, lty=lty.K, lwd=lwd.K)
    points(subnici,cex=cex.su,col=col.su, pch=pch.su)
    arrows(rep(G_k[,1],m),rep( G_k[,2],m),subspk[,1], subspk[,2], angle=angle.arrow,
           col=col.arrow,lwd=lwd.arrow, length=length.arrow)
    textplot(subspk[,1], subspk[,2], sp, show.lines,
             col=col.sublab,font=font.sublab,cex=cex.sublab,new=F)
    points(G_k[,1], G_k[,2], col=col.G_k, pch=pch.G_k, cex= cex.G_k)
    abline(h=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
    abline(v=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
    legend(posi.leg,legend=c("E","K","G_K","SU"),pch=c(15,15,pch.G_k, pch.su),
           col=c(col.E, col.K ,col.G_k, col.su), bty=bty.leg,...)
  }

}
