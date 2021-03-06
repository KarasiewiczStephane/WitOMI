% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.subniche.R
\name{plot.subniche}
\alias{plot.subniche}
\title{Summarizes the results of the species subniche}
\usage{
\method{plot}{subniche}(
  x,
  xax = 1,
  yax = 2,
  ax.angle.arrow = 20,
  ax.col.arrow = "black",
  ax.length.arrow = 0.1,
  ax.lwd.arrow = 1,
  ax.leg.posi = "bottomleft",
  ax.leg.cex = 1.2,
  eig.col.chos = "black",
  eig.col.left = "gray",
  eig.leg.posi = "topright",
  eig.leg.cex = 1.2,
  su.leg.posi = "bottomleft",
  su.leg.cex = 1.2,
  col.axis = "azure3",
  lty.axis = 2,
  lwd.axis = 2,
  var.col.arrow = "black",
  var.length.arrow = 0.1,
  var.lwd.arrow = 1,
  var.angle.arrow = 20,
  var.leg.posi = "bottomleft",
  var.leg.cex = 1.2,
  col.var = "black",
  col.sp = rainbow(n = dim(x$li)[1]),
  col.su = "black",
  col.G_k = "red",
  col.ax = "black",
  nic.leg.posi = "bottomleft",
  nic.leg.cex = 1.2,
  sub.leg.cex = 1.2,
  sub.leg.posi = "bottomleft",
  pch.su = 16,
  cex.su = 1,
  border.E = "#92c5de",
  col.E = "#92c5de",
  lty.E = 1,
  border.K = "#fdb462",
  col.K = "#fdb462",
  lty.K = 1,
  lty.NR = 1,
  sub.angle.arrow = 20,
  sub.col.arrow = "black",
  sub.length.arrow = 0.1,
  sub.lwd.arrow = 1,
  show.lines = F,
  ...
)
}
\arguments{
\item{x}{an object of class \code{subniche}.}

\item{xax}{column for abscisse.}

\item{yax}{column for ordinate.}

\item{ax.angle.arrow}{arrow angle head for plot labelled "Axes", see \link[graphics]{arrows} for more details.}

\item{ax.col.arrow}{arrow color for plot labelled "Axes", see \link[graphics]{arrows} for more details.}

\item{ax.length.arrow}{arrow head length for plot labelled "Axes", see \link[graphics]{arrows} for more details.}

\item{ax.lwd.arrow}{arrow width for plot labelled "Axes", see \link[graphics]{arrows} for more details.}

\item{ax.leg.posi}{legend position for plot labelled "Axes", see \link[graphics]{legend} for more details.}

\item{ax.leg.cex}{legend size label for plot labelled "Axes", see \link[graphics]{legend} for more details.}

\item{eig.col.chos}{bar color for the selected components for plot labelled "Eigenvalues".}

\item{eig.col.left}{bar color for the component leftover for plot labelled "Eigenvalues".}

\item{eig.leg.posi}{legend position for plot labelled "Eigenvalues", see \link[graphics]{legend} for more details.}

\item{eig.leg.cex}{legend size label for plot labelled "Eigenvalues"", see \link[graphics]{legend} for more details.}

\item{su.leg.posi}{legend position for plot labelled "SU", see \link[graphics]{legend} for more details.}

\item{su.leg.cex}{legend size label for plot labelled "SU", see \link[graphics]{legend} for more details.}

\item{col.axis}{axis color, see \link[graphics]{par} for more details.}

\item{lty.axis}{axis line type, see \link[graphics]{par} for more details.}

\item{lwd.axis}{axis width, see \link[graphics]{par} for more details.}

\item{var.col.arrow}{variables arrow color for plot labelled "Variables and Species", see \link[graphics]{arrows} for more details.}

\item{var.length.arrow}{variables arrow length of the edges of the arrow head (in inches).}

\item{var.lwd.arrow}{variables arrow width for plot labelled "Variables and Species", see \link[graphics]{arrows} for more details.}

\item{var.angle.arrow}{variables arrow angle head for plot labelled "Variables and Species", see \link[graphics]{arrows} for more details.}

\item{var.leg.posi}{legend position for plot labelled "Variables and Species", see \link[graphics]{legend} for more details.}

\item{var.leg.cex}{legend size label for plot labelled "Variables and Species", see \link[graphics]{legend} for more details.}

\item{col.var}{color variables labels, see \link[wordcloud]{textplot} for more details.}

\item{col.sp}{color species labels and their respective niches, see \link[wordcloud]{textplot} for more details.}

\item{col.su}{color of sampling units, see \link[graphics]{points} for more details.}

\item{col.G_k}{color label G_k, see \link[wordcloud]{textplot} for more details.}

\item{col.ax}{color of axes labels, see \link[wordcloud]{textplot} for more details.}

\item{nic.leg.posi}{legend position for plot labelled "Niches", see \link[graphics]{legend} for more details.}

\item{nic.leg.cex}{legend size label for plot labelled "Niches", see \link[graphics]{legend} for more details.}

\item{sub.leg.cex}{legend size label for plot labelled "Subsets"", see \link[graphics]{legend} for more details.}

\item{sub.leg.posi}{legend position for plot labelled "Subsets", see \link[graphics]{legend} for more details.}

\item{pch.su}{type of the points representing the sampling units (SU), see \link[graphics]{points} for more details.}

\item{cex.su}{size of the points representing the sampling units (SU), see \link[graphics]{points} for more details.}

\item{border.E}{color border of E polygon, see \link[graphics]{polygon} for more details.}

\item{col.E}{inside color of E polygon, see \link[graphics]{polygon} for more details.}

\item{lty.E}{line type for the E border, see \link[graphics]{polygon} for more details.}

\item{border.K}{color border of K polygon, see \link[graphics]{polygon} for more details.}

\item{col.K}{inside color of K polygon, see \link[graphics]{polygon} for more details.}

\item{lty.K}{line type for the K border, see \link[graphics]{polygon} for more details.}

\item{lty.NR}{line type for the NR border, see \link[graphics]{polygon} for more details.}

\item{sub.angle.arrow}{arrow angle head for plot labelled "Subsets", see \link[graphics]{arrows} for more details.}

\item{sub.col.arrow}{arrow color for plot labelled  "Subsets", see \link[graphics]{arrows} for more details.}

\item{sub.length.arrow}{arrow head length for plot labelled  "Subsets", see \link[graphics]{arrows} for more details.}

\item{sub.lwd.arrow}{arrow width for plot labelled  "Subsets", see \link[graphics]{arrows} for more details.}

\item{show.lines}{if true, then lines are plotted between x,y and the word, for those words not covering their x,y coordinates. See \link[wordcloud]{textplot} for more details.}

\item{...}{further arguments passed to or from other methods.}
}
\description{
The function plot the resulting species subniche of the WitOMI calculation.
}
\details{
The function illustrate the results of subniche calculation with a great deal of customization parameters.
}
\examples{
library(subniche)
data(doubs)
dudi1 <- dudi.pca(doubs$env, scale = TRUE, scan = FALSE, nf = 3)
nic1 <- niche(dudi1, doubs$fish, scann = FALSE)
# number of sites
N <- dim(nic1$ls)[1]
#Create a factor which defines the subsets
fact <- factor(c(rep(1,N/2),rep(2,N/2)))
# nic1 will be use as reference and fact will be use to define the subniches environment
subnic1 <- subniche(nic1, fact)
plot(subnic1)
}
