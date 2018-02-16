t.test.fromSummaryStats <- function(mu,n,s) {
  -diff(mu) / sqrt( sum( s^2/n ) )
}

mu <- c(6.03,6.63)
s <- c(1.79,1.66)
n <- c(65,.61)
t.test.fromSummaryStats(mu,n,s)

# library(BSDA)
# tsum.test()
