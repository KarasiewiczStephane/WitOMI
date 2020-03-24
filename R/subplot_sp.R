#' @title Plot a species subniche under each sub-environmental space K
#' @aliases subplot_sp
#' @description  The function to represent the species subniche under each subenvironment K with their respective marginality from G_K.
#' @usage subplot_sp(subnic, sp, main=NULL, col.axis="azure3", lty.axis=2, lwd.axis=2,
#'xlab=NULL, ylab=NULL, col.sublab="black", font.sublab=2, cex.sublab=0.7, show.lines=F,
#'border.E="#92c5de", col.E="#92c5de", lty.E=1, lwd.E=1, border.K ="#2c7fb8",lwd.K=1,
#'col.K ="#2c7fb8", lty.K=1, col.arrow="black",angle.arrow=20, lwd.arrow=2,
#'length.arrow=0.1, col.G_k= "red", cex.G_k=1, border.SP="#fec44f", col.SB="#d95f0e",
#'lty.SP=1, lwd.SP=1, border.NR ="#fdb462", col.NR =NA,cex.sp=1, col.sp="black",
#'border.SR="#a1d99b", col.SR="#a1d99b", col.SRc="black", lty.SR=1, lwd.SR=1, pch.SR=19,
#'cex.SR=1, lty.NR=1, lwd.NR=2, pch.G_k=19, col.su="#b35806", cex.su=0.5, pch.su=1,
#'posi.leg="topleft", bty.leg="n", ... )
#' @param ...	 further arguments passed to or from other methods.
#' @param subnic an object of class \code{subniche}.
#' @param sp a character string of the species name.
#' @param main a main title for the plot, see \link[graphics]{title} for more details.
#' @param col.axis axis color, see \link[graphics]{par} for more details.
#' @param xlab label for x-axis, see \link[graphics]{title} for more details.
#' @param ylab label for y-axis, see \link[graphics]{title} for more details.
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
#' @param border.SP color border of species subniche polygon, see \link[graphics]{polygon} for more details.
#' @param lty.SP line type for the SP border, see \link[graphics]{polygon} for more details.
#' @param lwd.SP line width for the SP border, see \link[graphics]{polygon} for more details.
#' @param col.SB color of the SB area.
#' @param border.NR color border of NR polygon, see \link[graphics]{polygon} for more details.
#' @param col.NR inside color of NR polygon, see \link[graphics]{polygon} for more details.
#' @param lty.NR line type for the NR border, see \link[graphics]{polygon} for more details.
#' @param lwd.NR line width for the NR border, see \link[graphics]{polygon} for more details.
#' @param border.SR color border of SR polygon, see \link[graphics]{polygon} for more details.
#' @param col.SR inside color of SR polygon, see \link[graphics]{polygon} for more details.
#' @param lty.SR line type for the SR border, see \link[graphics]{polygon} for more details.
#' @param lwd.SR line width for the SR border, see \link[graphics]{polygon} for more details.
#' @param col.SRc color of points representing the SR position, see \link[graphics]{points} for more details.
#' @param pch.SR type of points representing the SR position, see \link[graphics]{points} for more details.
#' @param cex.SR size of points representing the SR position, see \link[graphics]{points} for more details.
#' @param col.sp color of the species label representing the NR position, see \link[wordcloud]{textplot} for more details.
#' @param cex.sp size of the species label representing the NR position, see \link[wordcloud]{textplot} for more details.
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
#' subplot_sp(subnic1,"Neba",main="Species subniche in K")
#' @rdname subplot_sp
#' @export
#' @importFrom graphics par layout arrows points legend polygon abline
#' @importFrom wordcloud textplot
#' @importFrom siar convexhull
subplot_sp <- function(subnic, sp, main=NULL, col.axis="azure3", lty.axis=2, lwd.axis=2,
                       xlab=NULL, ylab=NULL, col.sublab="black", font.sublab=2, cex.sublab=0.7, show.lines=F, border.E="#92c5de",
                       col.E="#92c5de", lty.E=1, lwd.E=1, border.K ="#2c7fb8",lwd.K=1, col.K ="#2c7fb8", lty.K=1, col.arrow="black",
                       angle.arrow=20, lwd.arrow=2, length.arrow=0.1,col.G_k= "red",cex.G_k=1,border.SP="#fec44f",
                       col.SB="#d95f0e", lty.SP=1, lwd.SP=1, border.NR ="#fdb462", col.NR =NA,cex.sp=1, col.sp="black",
                       border.SR="#a1d99b", col.SR="#a1d99b", col.SRc="black", lty.SR=1, lwd.SR=1, pch.SR=19,
                       cex.SR=1, lty.NR=1, lwd.NR=2, pch.G_k=19, col.su="#b35806", cex.su=0.5, pch.su=1,
                       posi.leg="topleft", bty.leg="n", ...){
  fac <- subnic$factor
  lev <- levels(fac)
  N <- length(lev)
  are_sub <- subarea(subnic)
  eig <- round(subnic$eig/sum(subnic$eig)*100,2)[1:2]
  subsp <- subnic$sub[grep(sp,rownames(subnic$sub)),]
  if(!anyNA(subsp)){
    nami <- rownames(subsp)
    levi <- sub(sp,"",nami)
    M <- length(levi)
    if(is.null(ylab)){
    xlab=paste(paste("OMI1",eig[1], sep=" "),"%",sep="")}
    if(is.null(ylab)){
    ylab=paste(paste("OMI1",eig[2], sep=" "),"%",sep="")}
    for (i in 1:M){
      plot(subnic$ls, main=main,  xlab=xlab, ylab=ylab, type="n",...)
      E <- are_sub$E
      K <- are_sub$K[[levi[i]]]
      NR <- are_sub$NR[[sp]]
      SR <- are_sub$SR[[levi[i]]][[nami[i]]]
      SP <- are_sub$SP[[levi[i]]][[nami[i]]]
      polygon(E$x,E$y, border=border.E, col=col.E, lty=lty.E, lwd=lwd.E)
      polygon(K$x,K$y, border=border.K, col=col.K, lty=lty.K, lwd=lwd.K)
      polygon(NR$x,NR$y, border=border.NR, col=col.NR, lty=lty.NR, lwd=lwd.NR)
      polygon(SP$x,SP$y, border=border.SP, col=col.SB, lty=lty.SP, lwd=lwd.SP)
      polygon(SR$x,SR$y, border=border.SR, col=col.SR, lty=lty.SR, lwd=lwd.SR)
      G_k <- subnic$G_k[grep(lev[i],rownames(subnic$G_k)),]
      points(G_k[,1], G_k[,2], col=col.G_k, pch=pch.G_k, cex= cex.G_k)
      arrows(G_k[,1],G_k[,2],subsp[nami[i],1], subsp[nami[i],2], angle=angle.arrow,
           col=col.arrow,lwd=lwd.arrow, length=length.arrow)
      text(subsp[nami[i],1], subsp[nami[i],2],nami[i], col=col.sp, cex=cex.sp)
      }
    } else {
      nami <- rownames(subsp)[which(is.na(subsp[,1])==F)]
      subsp<- subsp[-which(is.na(subsp[,1])==T),]
      levi <- sub(sp,"",nami)
      plot(subnic$ls, main=main,  xlab=xlab, ylab= ylab, type="n",...)
      E <- are_sub$E
      K <- are_sub$K[[levi]]
      NR <- are_sub$NR[[sp]]
      SR <- are_sub$SR[[levi]][[nami]]
      SP <- are_sub$SP[[levi]][[nami]]
      polygon(E$x,E$y, border=border.E, col=col.E, lty=lty.E, lwd=lwd.E)
      polygon(K$x,K$y, border=border.K, col=col.K, lty=lty.K, lwd=lwd.K)
      polygon(NR$x,NR$y, border=border.NR, col=col.NR, lty=lty.NR, lwd=lwd.NR)
      polygon(SP$x,SP$y, border=border.SP, col=col.SB, lty=lty.SP, lwd=lwd.SP)
      polygon(SR$x,SR$y, border=border.SR, col=col.SR, lty=lty.SR, lwd=lwd.SR)
      G_k <- subnic$G_k[grep(levi,rownames(subnic$G_k)),]
      points(G_k[,1], G_k[,2], col=col.G_k, pch=pch.G_k, cex= cex.G_k)
      arrows(G_k[,1],G_k[,2],subsp[1], subsp[2], angle=angle.arrow,
             col=col.arrow,lwd=lwd.arrow, length=length.arrow)
      text(subsp[1], subsp[2],nami, col=col.sp, cex=cex.sp)
    }
  }
