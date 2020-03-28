#' @title Convex hull decomposition
#' @aliases subarea
#' @description  The function is used to calculate the coordinates and area of each convex hull from E environmental space to SR subniche.
#' @usage subarea(subnic)
#' @param subnic an object of class \code{subniche}.
#' @return A list containing the coordinates and area of each convex hulls
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
#' area_sub <- subarea(subnic1)
#' @author S. Karasiewicz, \email{stephane.karasiewicz@wanadoo.fr}
#' @references Karasiewicz S.,Doledec S.and Lefebvre S. (2017). Within outlying mean indexes: refining the OMI analysis for the realized niche decomposition. \emph{PeerJ} 5:e3364. \url{https://doi.org/10.7717/peerj.3364}.
#' @details The convex hulls measured are :
#' \enumerate{
#' \item E is the environmental space.
#' \item K the sub-environmental space.
#' \item NR the realized subniche.
#' \item SP the existing fundamental subniche.
#' \item SB the area of the biological constraint reducing SP.
#' \item SR the species realized subniche.}
#' See \href{https://doi.org/10.7717/peerj.3364}{Karasiewicz,et al. (2017)} for more details on the subniche concept.
#' @rdname subarea
#' @export subarea
#' @import polyclip
#' @importFrom siar convexhull
#' @importFrom polyclip polyclip
subarea <- function(subnic){
  selecto <-  function(x,n){
    substring(x,nchar(x)-n+1)
  }
  res <- list()
  res$E <- convexhull(subnic$ls[,1], subnic$ls[,2])
  names(res$E) <- c("TA" ,  "x", "y","samples")
  res$K <- list()
  lev <- levels(subnic$factor)
  for(i in 1:length(lev)){
    res$K[[i]] <- convexhull(subnic$ls[which(subnic$factor==lev[i]),1], subnic$ls[which(subnic$factor==lev[i]),2])
    names(res$K[[i]]) <- c("TA" ,  "x", "y","samples")
  }
  names(res$K) <- lev
  appel <- as.list(subnic$call)
  Y <- eval.parent(appel[[3]])
  Y[Y!=0] <- 1
  spnam <- colnames(Y)
  res$NR <- list()
  for (i in 1:length(spnam)){
    occfact <- factor(Y[,i])
    if (sum(Y[,i])>2){
      res$NR[[i]] <- convexhull(subnic$ls[which(occfact==1),1], subnic$ls[which(occfact==1),2])
      names( res$NR[[i]]) <- c("TA","x","y","samples")
    } else {
      res$NR[[i]] <- list(TA=NULL,x=subnic$ls[which(occfact==1),1], y=subnic$ls[which(occfact==1),2], samples=rownames(subnic$ls[which(occfact==1),]))
    }
  }
  names(res$NR) <- spnam

  subsp <- subnic$sub
  if(anyNA(subsp))
    subsp <- subsp[-which(is.na(subsp[,1])==T),]

  subsp <- rownames(subsp)

  res$SR <- list()
  for(i in 1:length(lev)){
    y <- Y[subnic$factor==lev[i],]
    ls <- subnic$ls[subnic$factor==lev[i],]
    ch <- nchar(lev[i])
    subnam <- c()
    for (k in 1:length(subsp)){
      if(isTRUE(selecto(subsp[k],ch)==lev[i])){
        subi <- substr(subsp[k],1,nchar(subsp[k])-ch)
        subnam <- c(subnam, subi)
      } else { next }
    }
    res$SR[[i]] <- list()
    for (j in 1:length(subnam)){
      occfact <- factor(y[,subnam[j]])
      if(sum(y[,subnam[j]])>2){
        res$SR[[i]][[j]] <- convexhull(ls[which(occfact==1),1], ls[which(occfact==1),2])
        names(res$SR[[i]][[j]]) <- c("TA","x","y","samples")
      } else {
        res$SR[[i]][[j]] <- list(TA=NULL,x=subnic$ls[which(occfact==1),1], y=subnic$ls[which(occfact==1),2], samples=rownames(subnic$ls[which(occfact==1),]))
      }
    }
    names(res$SR[[i]]) <- paste(subnam,lev[i], sep="_")
  }
  names(res$SR) <- lev

  res$SP <- list()
  for(i in 1:length(lev)){
    y <- Y[subnic$factor==lev[i],]
    ls <- subnic$ls[subnic$factor==lev[i],]
    ch <- nchar(lev[i])
    subnam <- c()
    for (k in 1:length(subsp)){
      if(isTRUE(selecto(subsp[k],ch)==lev[i])){
        subi <- substr(subsp[k],1,nchar(subsp[k])-ch)
        subnam <- c(subnam, subi)
      } else { next }
    }
    res$SP[[i]] <- list()
    for (j in 1:length(subnam)){
      if(sum(y[,subnam[j]])>2){
        C <- polyclip(res$K[[i]],res$NR[subnam[j]])
        res$SP[[i]][[j]] <-convexhull(C[[1]]$x, C[[1]]$y)
        names(res$SP[[i]][[j]]) <-  c("TA","x","y","samples")
      } else {
        res$SP[[i]][[j]] <- res$SR[[i]][[j]]
      }
    }
    names(res$SP[[i]]) <- paste(subnam, lev[i],sep="")
  }
  names(res$SP) <- lev

  res$SB <- list()
  for(i in 1:length(lev)){
    res$SB[[i]] <- list()
    ch <- nchar(lev[i])
    subnam <- c()
    for (k in 1:length(subsp)){
      if(isTRUE(selecto(subsp[k],ch)==lev[i])){
        subi <- substr(subsp[k],1,nchar(subsp[k])-ch)
        subnam <- c(subnam, subi)
      } else { next }
    }
    for (j in 1:length(subnam)){
      res$SB[[i]][[j]]<- res$SP[[i]][[j]][[1]]-res$SR[[i]][[j]][[1]]
    }
    names(res$SB[[i]]) <- subnam
  }
  names(res$SB) <- lev
  return(res)
}

