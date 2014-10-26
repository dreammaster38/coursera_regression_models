##' Produce a classical  Cp - plot "as from Mallows himself"
##' from a "regsubsets" fit
##' @title Classical  Cp  plot  from  a "regsubsets" fit
##' @param x an object of class "regsubsets" or "summary..";
##'  typically, the result of regsubsets(..) or  summary(regsubsets(..))
##' @param kind string specifying the \emph{kind} of plot; defaults to Cp
##' @param log should log-scales be used; as in plot.default()
##' @param col.p graphical parameters for the points drawn
##' @param pch.p
##' @param bg.p
##' @param marXtra extra space to be used for par(mar = .).
##' @param bty kind of "box" around the plot; see help(par)
##' @param ylab axis and main titles for the plot
##' @param xlab
##' @param main
##' @param ... potentially further arguments passed to plot().
##' @return (nothing)
##' @author Martin Maechler, 2006, 2011
p.regsubsets <- function(x, kind = c("cp", "rsq", "rss", "adjr2", "bic"),
                         log = if(kind == "cp") "y" else "",
                         col.p = 2, pch.p = 21, bg.p = "gray",
                         marXtra = c(0,0,0, 1.6), bty = "l",
                         ylab = myExpr(kind), xlab = expression("size " ~ p),
                         main = paste(ch.kind, "plot for ", x.call), ...)
{
  if(inherits(x,"regsubsets"))
    x <- summary(x)
  stopifnot(inherits(x, "summary.regsubsets"),
            is.matrix(wh.mat <- x$which))
  size <- as.numeric(rownames(wh.mat))
  ##  with "fancy" labeling: {{omitting intercept "-1"}}:
  v <- abbreviate(colnames(wh.mat)[-1], min = 1)
  wh.txt  <- apply(wh.mat[,-1], 1, function(wh) paste(v[wh], collapse=","))
  wh.labs <- paste(format(v), names(v), sep=":  ")
  kind <- tolower(kind)
  kind <- match.arg(kind)
  y <- x[[kind]]
  ch.kind <- c("cp" = "Cp", "rsq" = "R^2", "rss" = "RSS",
               "adjr2" = "adj.R^2", "bic" = "BIC")[kind]
  myExpr <- function(knd)
    switch(knd,
           "cp" = expression(C[p]),
           "rsq" = expression(R^2),
           "rss" = expression(sum(r[i]^2, i==1,n)),
           "adjr2" = expression(R[adj.]^2),
           "bic" = "BIC")
  if(missing(main) || is.null(main)) {
    ## get formula for the main title:
    cl <- x$obj$call
    cl[[1]] <- as.name("A")
    cl <- substring(deparse(cl, width.cutoff = 500)[[1]], 3)
    x.call <- paste("(", sub("([^)])$", "\\1)",
                             sub("([^,]*,[^,]*,).*", "\\1 ...", cl)),
                    sep="")
  }
  op <- par(mar=par("mar") + marXtra, bty = bty)
  on.exit(par(op))
  plot(size, y, log = log, col=col.p, pch=pch.p, bg=bg.p,
       main=main, xlab=xlab, ylab=ylab, ...)
  text(size, y, cex = .8, labels = wh.txt, pos = 4, xpd = NA)
  leg.is.bot <- (kind %in% c("rsq", "adjr2"))
  legend(if(leg.is.bot) "bottomright" else "topright",
         legend = wh.labs, box.col=NA, bg="gray88",
         inset = c(-0.05, if(leg.is.bot).02 else -.02), xpd = NA)
}