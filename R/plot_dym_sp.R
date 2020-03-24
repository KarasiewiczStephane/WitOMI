#' @title Species subniches dynamic
#' @aliases plot_dym_sp
#' @description  The function represents the species' subniches SR within its realized niche NR.
#' @param subnic an object of class \code{subniche}.
#' @param sp a character string of the species name.
#' @param main a main title for the plot, see \link[graphics]{title} for more details.
#' @param col.arrow arrow color, see \link[graphics]{arrows} for more details.
#' @param angle.arrow arrow angle head, see \link[graphics]{arrows} for more details.
#' @param lwd.arrow arrow width, see \link[graphics]{arrows} for more details.
#' @param length.arrow arrow head length, see \link[graphics]{arrows} for more details.
#' @param border.E color border of E polygon, see \link[graphics]{polygon} for more details.
#' @param col.E inside color of E polygon, see \link[graphics]{polygon} for more details.
#' @param lty.E line type for the E border, see \link[graphics]{polygon} for more details.
#' @param lwd.E line width for the E border, see \link[graphics]{polygon} for more details.
#' @param border.NR color border of NR polygon, see \link[graphics]{polygon} for more details.
#' @param col.NR inside color of NR polygon, see \link[graphics]{polygon} for more details.
#' @param lty.NR line type for the NR border, see \link[graphics]{polygon} for more details.
#' @param lwd.NR line width for the NR border, see \link[graphics]{polygon} for more details.
#' @param border.SR color border of SR polygon, see \link[graphics]{polygon} for more details.
#' @param col.SR inside color of SR polygon, see \link[graphics]{polygon} for more details.
#' @param lty.SR line type for the SR border, see \link[graphics]{polygon} for more details.
#' @param lwd.SR line width for the SR border, see \link[graphics]{polygon} for more details.
#' @param col.axis axis color, see \link[graphics]{par} for more details.
#' @param lty.axis axis line type, see \link[graphics]{par} for more details.
#' @param lwd.axis  axis width, see \link[graphics]{par} for more details.
#' @param col.SRc color of points representing the SR position, see \link[graphics]{points} for more details.
#' @param pch.SR type of points representing the SR position, see \link[graphics]{points} for more details.
#' @param cex.SR size of points representing the SR position, see \link[graphics]{points} for more details.
#' @param col.sp color of the species label representing the NR position, see \link[wordcloud]{textplot} for more details.
#' @param cex.sp size of the species label representing the NR position, see \link[wordcloud]{textplot} for more details.
#' @param show.lines if true, then lines are plotted between x,y and the word, for those words not covering their x,y coordinates, see \link[wordcloud]{textplot} for more details.
#' @param bty.leg the type of box to be drawn around the legend. The allowed values are "o" (the default) and "n", see \link[graphics]{legend} for more details.
#' @param posi.leg setting legend positions with the following keywords "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center", see \link[graphics]{legend} for more details.
#' @param font.sp An integer which specifies which font to use for species label. 1 corresponds to plain text (the default), 2 to bold face, 3 to italic and 4 to bold italic, see \link[graphics]{par} for more details.
#' @param ...	further arguments passed to or from other methods.
#' @rdname plot_dym_sp
#' @export plot_dym_sp
#' @details The convex hulls measured are :
#' \enumerate{
#' \item E is the environmental space.
#' \item NR the realized subniche.
#' \item SR the species realized subniche.}
#' The arrows represent the species' subniche marginality from the origin G.
#' See \href{https://doi.org/10.7717/peerj.3364}{Karasiewicz,et al. (2017)} for more details on the subniche concept.
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
#' plot_dym_sp(subnic1, "Neba")
#' plot_dym_sp(subnic1,"Cyca", lwd.NR = 5, col.sp="red",lty.NR=3, border.E="green",col.E=NA, col.NR=NA)
#' @importFrom graphics par layout arrows points legend polygon abline text
#' @importFrom wordcloud textplot
#' @importFrom siar convexhull
plot_dym_sp <- function(subnic, sp, main=NA, col.axis="azure3", lty.axis=2, lwd.axis=2, border.E="#92c5de", col.E="#92c5de",
                        lty.E=1, lwd.E=1, border.NR ="#fdb462", col.NR ="#fdb462",border.SR="#a1d99b", col.SR="#a1d99b",
                        col.SRc="black", lty.SR=1, lwd.SR=1, pch.SR=19, cex.SR=1, lty.NR=1, lwd.NR=2, col.arrow="black",
                        col.sp="black",cex.sp=1, show.lines=F, angle.arrow=20, lwd.arrow=2, length.arrow=0.1,font.sp=1,
                        posi.leg="topleft", bty.leg="n", ...){

fac <- subnic$factor
lev <- levels(fac)
ar_sub <- subarea(subnic)
eig <- round(subnic$eig/sum(subnic$eig)*100,2)[1:2]
E <- ar_sub$E
NR <- ar_sub$NR[[sp]]
plot(subnic$ls, main=main, xlab= paste("OMI1 ", eig[1], "%", sep=""),
     ylab= paste("OMI2 ", eig[2], "%", sep=""), type="n",...)
polygon(E$x, E$y, border=border.E, col=col.E, lty=lty.E, lwd=lwd.E)
polygon(NR$x,NR$y, border=border.NR, col=col.NR, lty=lty.NR,lwd= lwd.NR )
spli <- subnic$sub[grep(sp,rownames(subnic$sub)),]
colnames(spli) <- colnames(subnic$li)
nami <- rownames(spli)
levi <- sub(sp,"",nami)
M <- length(levi)
if(is.na(col.sp[M])){
  col.SR <- rep(col.SR,M)
  border.SR <- rep(border.SR,M)
}
for (j in 1:M){
  SR <- ar_sub$SR[[lev[j]]]
  SR <- SR[[nami[j]]]
    if (length(SR$x)>2){
      polygon(SR$x,SR$y, border=border.SR[j], col=col.SR[j],lty=lty.SR, lwd=lwd.SR)
    }
    else {
      points(SR$x,SR$y,pch=pch.SR,col=col.SR[j])
    }
}
abline(h=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
abline(v=0, lty=lty.axis, lwd=lwd.axis, col=col.axis)
points(spli[,1], spli[,2], col=col.SRc, pch=pch.SR, cex=cex.SR)
arrows(rep(0,M),rep(0,M),spli[,1], spli[,2], angle=angle.arrow,
       col=col.arrow,lwd=lwd.arrow, length=length.arrow)
li <- rbind(subnic$li[sp,], spli)
if(anyNA(li)){
li <- li[-which(is.na(li)==T),]
}
if(sum(round(apply(li,2,diff),1))==0){
  text(subnic$li[sp,1]*1.2,subnic$li[sp,2]*1.2,sp, col=col.sp, cex=cex.sp, font = font.sp)
} else {
  li <- rbind(subnic$li[sp,], spli*1.2)
 text(li[,1],li[,2],rownames(li), col=col.sp, cex=cex.sp, font = font.sp)
}
col.leg <- c(col.E,col.NR,col.SR)
pch.leg <- c(15,15,15)
if(is.na(col.E)){
  pch.leg[1] <- 0
  col.leg[1] <- border.E
}
if(is.na(col.NR)){
  pch.leg[2] <- 0
  col.leg[2] <- border.NR
}
if(anyNA(col.SR)){
  pch.leg[3] <- 0
  col.leg[3] <- border.SR
}
lty.leg <- c(0,0,0)
lwd.leg <- c(0,0,0)
if(lty.E>1){
  pch.leg[1] <- NA
  lty.leg[1] <- lty.E
  lwd.leg[1] <- lwd.E
}
if (lty.NR>1){
  pch.leg[2] <- NA
  lty.leg[2] <- lty.NR
  lwd.leg[2] <- lwd.NR
}
if (lty.SR>1){
  pch.leg[3] <- NA
  lty.leg[3] <- lty.SR
  lwd.leg[3] <- lwd.SR
}
legend(posi.leg, legend=c("E","NR", "SR"),pch=pch.leg, col=col.leg, lty=lty.leg, lwd=lwd.leg,
       bty=bty.leg,...)
}
