dprime <- function(data) {
    # requires dataframe with the following variables:
    # subject (subject ID), probe (probe or foil), acc (accuracy; 1=correct, 0=false)
    # output is sub.dprime matrix of subject ids and corresponding dprime score
  
    # get total probes and foils
    subprobe.total = aggregate(probe=='probe'~subject, data=data,sum )
    subfoil.total = aggregate(probe=='foil'~subject, data=data,sum )
    
    # get acuracy on probes and foils
    subprobe.acc = aggregate(acc~subject+probe, data=data,sum ) 
    
    pH = subprobe.acc[subprobe.acc$probe=='probe',]$acc/subprobe.total[,2] # prob(Hit)
    # replace 1s with p = (N-1)/N.
    pH[pH==1] = (subprobe.total[1,2]-1)/subprobe.total[1,2] # this assumes same number of probes for each subject
    
    pFA = 1-subprobe.acc[subprobe.acc$probe=='foil',]$acc/subfoil.total[,2] # prob(False Alarm)
    # replace 0s with p = 1/N
    pFA[pFA==0] = 1/subfoil.total[1,2] # this assumes same number of foils for each subject

    dprime.score <- qnorm(pH) - qnorm(pFA)
    
    sub.dprime= cbind(subprobe.total$subject,dprime.score)
    sub.dprime= data.frame(sub.dprime)
    colnames(sub.dprime)=c('subject','dprime')
    
    return(sub.dprime)
}

#########################
# original d prime function from web

# dprime <- function(data) {
#     yes <- subset(data, probe==1) # code 'yes' probes as 1
#     no <- subset(data, probe==0) # code 'no' probes as 0
#     hit <- subset(data, probe==1 & acc == 1)
#     falsealarm <- subset(data, probe==1 & acc == 0)
#     
#     Hrate <- xtabs(~subject, data=hit)/xtabs(~subject, data=yes)
#     Frate <- xtabs(~subject, data=falsealarm)/xtabs(~subject, data=no)
#     dprime_score <- qnorm(Hrate) - qnorm(Frate)
#     
#     return(dprime_score)
# }
