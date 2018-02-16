r2.corr.lmer<-function(lmer.object){
  summary(lm(attr(lmer.object, "y") ~ fitted (lmer.object))) 
  $r.squared}
# Jarrett Byrnes | 1 Apr 16:40 http://permalink.gmane.org/gmane.comp.lang.r.lme4.devel/689