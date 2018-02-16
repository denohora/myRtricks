# translate t  value to r, given df
# r sq = t.sq / (t.sq + df)
# from http://www.real-statistics.com/correlation/dichotomous-variables-t-test/

t.to.r <- function(t, df){
  r.sq = t^2 / (t^2 + df)
  r = sqrt(r.sq)
  return(r)
}

t = 7.2235
df = 35
se = 0.415 
# r sq = t.sq / (t.sq + df)
r.sq = t^2 / (t^2 + df)
r = sqrt(r.sq)

t.to.r(t = 7.2235, df = 35)
