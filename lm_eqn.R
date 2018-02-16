# takes lm object and outputs equation and R2
lm.eqn = function(lm){
# lm = lm(Dprime ~ h, data = df)
m = lm;
  eq <- substitute(italic(y) == a + b ~ italic(x)*","~~italic(r)^2~"="~r2, 
                   list(a = format(coef(m)[1], digits = 2), 
                        b = format(coef(m)[2], digits = 2), 
                        r2 = format(summary(m)$r.squared, digits = 3)))
  return(as.expression(eq));                 
}

# p1 = p + geom_text(aes(x = 25, y = 300, label = lm_eqn(df)), parse = TRUE)

# From:
# http://stackoverflow.com/questions/7549694/ggplot2-adding-regression-line-equation-and-r2-on-graph