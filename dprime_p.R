# subject =alldata[alldata$Rel.Type == "Magnitude" & alldata$TrialNum>0, ]$Subject
# probe =  alldata[alldata$Rel.Type == "Magnitude" & alldata$TrialNum>0, ]$Probe
# acc = alldata[alldata$Rel.Type == "Magnitude" & alldata$TrialNum>0, ]$Slide1.ACC
dprime.p <-function(pH,pFA,N) {
 
  # requires following variables (e.g., from a data frame)
  # p(Hits) vector, 
  # p(False alarms) vector,
  # N number of probes - integer.
  # assumes from same p
  # assumes same number of probes for each subject
  # output is dprime vector of dprime scores
  
  # replace 1s with p = (N-1)/N.
  pH[pH==1] = (N-1)/N # this assumes same number of probes for each subject
  
  # replace 0s with p = 1/N
  pFA[pFA==0] = 1/N # this assumes same number of foils for each subject
  
  dprime <- qnorm(pH) - qnorm(pFA)
  
  return(dprime)
}
