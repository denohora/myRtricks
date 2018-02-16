
# plot binomial distribution for number of trials in binary choice

numtrials = 12 # adjust this

# these lines plot the distribution
plot((0:numtrials)/numtrials*100, pbinom(0:numtrials, size=numtrials, prob=0.5), type = "o",
     xlab =  "% Correct", ylab = "Cumulative Probability", main = paste("Binomial Distribution for", numtrials, "trials"))
lines(c(0,100), c(.05,.05), lty= 2) # line for sig towards 0
lines(c(0,100), c(.95,.95), lty= 2) # line for sug towards 1

