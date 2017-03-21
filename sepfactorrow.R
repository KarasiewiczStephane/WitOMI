#'@title A function to seperate a matrix, by row, into submatrices.
#'@usage sep.factor.row (x,factor)
#'@description separate matrix by rows into submatrices
#'@param x a matrix.
#'@param factor a factor of the same length as the number of row in the matrix.
#'@return list of submatrices
#'@export
sep.factor.row <- function(x,factor){
  m<-as.matrix(x)
  s <- list()
  F1 <- factor
  N <- length(levels(factor))
  levels(factor) <- 1:N
  for(i in 1:N){
    s[[i]] <- m[factor==i,]
  }
  names(s) <- levels(F1)
  return(s)
}
