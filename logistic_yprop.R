# extact the x value for a specific y proportion from a fitted logistic reg

logistic.yprop.x <- function(fit, y.prop = .5){
  # logistic eq = log odds = beta0 + beta1*x1
  
  # log odds = (1-prop)/prop, e.g., log odds of 50% = 0
  log.odds = log(y.prop/(1-y.prop))
  
  intercept = coef(fit)[1] # beta0
  slope = coef(fit)[2] # beta1
  
  # log odds = intercept + slope*x
  # x = (log odds - intercept) / slope
  est.yprop.x = (log.odds - intercept) / slope
  # remove the names attribute
  names(est.yprop.x) <- NULL
  return(est.yprop.x)
}

# logistic.yprop.x(logistic.reg)