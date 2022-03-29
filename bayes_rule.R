# https://betterexplained.com/articles/an-intuitive-and-short-explanation-of-bayes-theorem/#Bayes_Theorem
# We can turn the process above into an equation, which is Bayes’ Theorem. 
# It lets you take the test results and correct for the “skew” introduced by 
# false positives. You get the real chance of having the event. Here’s the equation:
#   
# # \displaystyle{\Pr(\mathrm{A}|\mathrm{X}) = \frac{\Pr(\mathrm{X}|\mathrm{A})\Pr(\mathrm{A})}{\Pr(\mathrm{X|A})\Pr(\mathrm{A})+ \Pr(\mathrm{X | not \ A})\Pr(\mathrm{not \ A})}}
# 
# And here’s the decoder key to read it:
#   
# Pr(A|X) = Chance of having cancer (A) given a positive test (X). 
# This is what we want to know: How likely is it to have cancer with a positive result? 
# In our case it was 7.8%. = posterior probability (updated following the test) 
# Pr(X|A) = Chance of a positive test (X) given that you had cancer (A). 
# This is the chance of a true positive, 80% in our case. = sensitivity
# Pr(A) = Chance of having cancer (1%). = base rate
# Pr(not A) = Chance of not having cancer (99%). = 1- Pr(A)
# Pr(X|not A) = Chance of a positive test (X) given that you didn’t have cancer (~A). 
# This is a false positive, 9.6% in our case. =  1-specificity

# Pr(A|X) = Pr(X|A)*Pr(A) / ( Pr(X|A)*Pr(A) + Pr(X|not A) * Pr(not A))

bayes.rule <- function(pr.A, pr.X_A, pr.X_notA) {

  post.prob = (pr.X_A*pr.A) / ( (pr.X_A*pr.A) + (pr.X_notA*(1-pr.A)) )
  
  # print(paste("Pr(A|X) =", post.prob))
  return(post.prob)
}

bayes.rule(.2, .9, .3)

bayes.rulePPV <- function(base.rate, sens, spec) {
  pr.A = base.rate
  pr.X_A = sens 
  pr.X_notA = 1 - spec
  post.prob = (pr.X_A*pr.A) / ( (pr.X_A*pr.A) + (pr.X_notA*(1-pr.A)) )
  
  # print(paste("Pr(A|X) =", post.prob))
  return(post.prob)
  
}
bayes.rulePPV(.2,.9,.7)
bayes.rulePPV(.1,.9,.7)
bayes.rulePPV(.8,.1,.3)

p.vals = seq(from =.001, to = .5, by = .005)
# bayes.rulePPV(p.vals,.9,.7)
plot(p.vals,bayes.rulePPV(p.vals,.9,.7))
lines(p.vals, p.vals, lty = 2)

p.vals = seq(from =.0001, to = .1, by = .0005)
# bayes.rulePPV(p.vals,.9,.7)
plot(p.vals,bayes.rulePPV(p.vals,.9,.7))

