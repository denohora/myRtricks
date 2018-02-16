# plots outline histogram

outline.hist <- function(hist,  ...){
  
  xvals = c(hist$breaks[1],hist$breaks[1])
  for(b.ix in 2:length(hist$breaks)) xvals = c(xvals, hist$breaks[b.ix], hist$breaks[b.ix])
  xvals
  
  counts = 0
  for(c.ix in 1:length(hist$counts)) counts = c(counts, hist$counts[c.ix], hist$counts[c.ix])
  counts = c(counts,0)
  
  polygon(xvals, counts, ...)

}