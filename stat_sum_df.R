#updated version of stat_sum_df
# http://stackoverflow.com/questions/32669473/plotting-the-means-with-confidence-intervals-with-ggplot

stat_sum_df <- function(fun, geom="crossbar", ...) { 
  stat_summary(fun.data=fun, geom=geom, fun.args=list(conf.int=0.95), ...) 
}
