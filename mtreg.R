# mt regressions

# TODO: use a narrower range of RT for these analyses

##=========================== SETTING DIRECTORIES  =================================
sgg_root = "E:/Santi/Data_Analyses/exp2_isws_a" # lab
# sgg_root = "C:/Users/15238039/Dropbox/PhD_Santi/Data_Analyses/exp2_isws_a" # NUIG office
# sgg_root = "C:/Users/User/Dropbox/PhD_Santi/Data_Analyses/exp2_isws_a" # From Home PC
doh_root = "~/Dropbox/PG Work/PhDs/PhD_Santi/Data_Analyses/exp2_isws_a"  

dataFolder = "workingData"

root = sgg_root
root = doh_root

data.folder = paste(root, dataFolder, sep = "/")

setwd(root)

####################################################################################
# source("Rscripts/1_sgg_master.R") # unique trial indentifier for choice dat

choice.data = read.table(gzfile(paste(data.folder, "choice_data_compressed.csv", sep = "/")),
                         row.names= 1, stringsAsFactors=F)
dyn.data = read.table(gzfile(paste(data.folder, "dyn_data_compressed.csv", sep = "/")),
                      row.names= 1, stringsAsFactors=F)


##==== Generating interp'd traj's =====
## NB check NAs in subj_id
colnames(dyn.data) 
colnames(choice.data)
dyn.data = merge(dyn.data, choice.data[,c('option_chosen','points_earned', 'avoidThresh', 
                                          'target','is_threat', 'shock_delivered', 'response_time',
                                          'trial_unique', 'percTT','avoidT_level')],
                 by = c("trial_unique"))
length(unique(dyn.data$subj_id)); head(dyn.data[ ,1:5])

## check sequence of data - is it chronological?
dyn.data$diff.t = c(0,diff(dyn.data$timestamp)) 
hist(dyn.data$diff.t) # no - diff.t should be constant, i.e., sampling rate 

## generate seq var and re-order dataframe
dyn.data$seq = ave(dyn.data$timestamp, dyn.data$trial_unique, FUN = rank)
dyn.data = dyn.data[order(dyn.data$trial_unique,dyn.data$seq),]
dyn.data$diff.t = c(0,diff(dyn.data$timestamp))
dyn.data[dyn.data$seq==1,]$diff.t = 0
hist(dyn.data$diff.t)  # it shouldn't vary (i.e., all approx the same value)
max(dyn.data$diff.t)

##----- checking the sampling rate -------
# max(dyn.data$diff.t); # min(dyn.data$diff.t) # why do I get a negative values????
# sr = dyn.data$diff.t[dyn.data$diff.t >= 9]
# range(sr); 1000/mean(sr)
meanDT = mean(dyn.data[dyn.data$seq>1,]$diff.t) # should be around 10 ms
# sampling_rate =  round(1000/meanDT,1)  # frequencyinstead of dividing by 1, we divide by 1000 (as the samples are in ms)
print(paste("sampling rate= ", round(1000/meanDT,1)))
##-----------------------------------------

dyn.data$diff.t =NULL

dyn.data$mouse_y = dyn.data$mouse_y * -1 # invert the direction of the screen y-axis (plots going upwards)

## check av num samples per trial per participant
num.samples = aggregate(mouse_x ~ subj_id + trial_no + block_no, dyn.data, length)
mean.samples = aggregate(mouse_x ~ subj_id, num.samples, mean) 

## mostly 100 or close - enough interp steps (no downsampling)
# min.samples = aggregate(mouse_x ~ subj_id, num.samples, min) 
eyeonly.vars = c("pupil_size", "eye_x", "eye_y")
mouse.vars = colnames(dyn.data)[!colnames(dyn.data) %in% eyeonly.vars]



## check NAs
sum(is.na(dyn.data)) 
# hold.nas = sum(is.na(dyn.data)) - sum(is.na(dyn.data$avoidThresh))
# hold.nas == sum(is.na(dyn.data$option_chosen)) # remainder in option_chosen

unique(dyn.data$subj_id) 

# unique(dyn.data[is.na(dyn.data$option_chosen),]$subj_id) # 2027 the issue
# length(dyn.data[!is.na(dyn.data$option_chosen) &
# dyn.data$subj_id == "2027",]$subj_id) # 2027 the issue
# nrow(dyn.data[dyn.data$subj_id == "2027",])
# head(choice.data[choice.data$subj_id == "2027",]) # otioon chosen didn't come in from choice data
# dyn.data = dyn.data[dyn.data$subj_id != "2027",] # skip this p for now

rm(choice.data, eyeonly.vars, meanDT, num.samples, mean.samples)

##====  1. Generating mousetrap onject  =====
library(mousetrap)



mt.data = mt_import_long(dyn.data[dyn.data$is_threat==T,mouse.vars], xpos_label = "mouse_x", ypos_label = "mouse_y",
                         timestamps_label = "timestamp", mt_seq_label = "seq",
                         mt_id_label = c("trial_unique"))

mt.data = mt_align_start_end(mt.data)  # all trajectories with same starting and end point
mt.data = mt_time_normalize(mt.data)#, verbose = T)   # apply equally sized (101) time steps (linear interpolation based on the timestamps)
mt.data = mt_angles(mt.data, use = "tn_trajectories", na_replace=T)

mt.angles = mt_export_long(mt.data, use = "tn_trajectories", use2 = "data",
                           use2_variables = c("trial_unique", "subj_id", 
                                              "option_chosen", "target") )
# angle_v
# For vertical-based angles (angle_v), positive values indicate a movement 
# to the left of the vertical, negative values to the right of the vertical. 
# If there was no movement across two consecutive points, angle_v is not defined 
# and, by default, NA is returned. If na_replace is TRUE, the next existing 
# angle value is reported instead.

# angle_p
# For point-based angles (angle_p), angles indicate changes of movement within 
# three consecutive time steps. The reported angle is always the smaller one. 
# A value of pi (= 3.14...) (for radians) or 180 (for degrees) indicates a 
# constant movement direction, a value of 0 (both for radians and degrees) a
# complete reversal. If there was no movement across two consecutive points, 
# angle_p is not defined and, by default, NA is returned. If na_replace is TRUE, 
# the next existing angle value is reported instead. angle_p is also not defined 
# for the last point of the trajectory.

# using angle_v as DV

# some checks
# hist(mt.angles[mt.angles$steps==2,]$angle_v)
# hist(mt.angles[mt.angles$steps==5,]$angle_v)
# hist(mt.angles[mt.angles$steps==60,]$angle_v)
# hold.ranges = cbind(2:100, 2:100)
# for(step.ix in 2:100) hold.ranges[step.ix-1,] = range(mt.angles[mt.angles$steps==step.ix,]$angle_v)

######## Use mixed models to estimate betas and SE of betas for each timestep ######## 

library(lme4)
c. <- function (x) scale(x, scale = FALSE)
s. <- function (x) {
  ## Seber 1977 page 216, from http://dx.doi.org/10.1021/ie970236k
  ## Transforms continuous variable to the range [-1, 1]
  ## In linked paper, recommended before computing orthogonal
  ## polynomials
  (2 * x - max(x) - min(x)) / (max(x) - min(x))
}
# predict angle based on target and Approach
mt.angles$Approach = mt.angles$option_chosen == "T"
contrasts(mt.angles$Approach) = (contrasts(mt.angles$Approach) -.5)*2 # centre Approach predictor
contrasts(mt.angles$Approach) # sets Approach as -1,1

## Testing Mixed models to work out structure
# step.df = mt.angles[mt.angles$steps==90,]
# 
# angle.rnd1 = lmer(s.(angle_v) ~ 1|subj_id, step.df, REML = F)
# angle.rnd2 = lmer(s.(angle_v)  ~ 0 + (s.(target)|subj_id), step.df, REML = F)
# angle.rnd3 = lmer(s.(angle_v)  ~ 1 + (s.(target)|subj_id), step.df, REML = F)
# angle.rnd4 = lmer(s.(angle_v)  ~ 1 + (s.(target) + Approach|subj_id), step.df, REML = F)
# 
# angle.rnd5 = update(angle.rnd3 , .~. + (Approach|subj_id) ) 
# 
# anova(angle.rnd1, angle.rnd2, angle.rnd3, angle.rnd4, angle.rnd5) # 4 is best
# summary(angle.rnd4)
# angle.mod1 = update(angle.rnd4 , .~. + s.(target) + Approach) 
# summary(angle.mod1)
# summary(angle.mod1)$coefficients
# cbind(step, summary(angle.mod1)$coefficients)

tcmr <- function(angles.df, step, Verbose = F){
  step.df = mt.angles[mt.angles$steps==step,]

  # richer rdn structure - slower, less reliable, but better fit usually
  # angle.mod = lmer(s.(angle_v)  ~ 1 + (s.(target) + Approach|subj_id) +
  #                  s.(target) + Approach, step.df, REML = F)
  
  angle.mod = lmer(s.(angle_v) ~ (1|subj_id) +
                     s.(target) + Approach, step.df, REML = F)
  
  output = data.frame(summary(angle.mod)$coefficients)
  output$Predictor = row.names(output)
  row.names(output) = NULL
  output = output[, c(4,1,2,3)]
  
  if(Verbose ==T) print(summary(angle.mod))
  return(cbind(step, output))
}

# run tcmr to get the first set of values
hold.betas = tcmr(mt.angles, 2)
# run loop to get the rest and append to first set
for(step.ix in 3:100) hold.betas = rbind(hold.betas, tcmr(mt.angles, step.ix))

# calculate error bars
hold.betas$UpperSE = hold.betas$Estimate + hold.betas$Std..Error
hold.betas$LowerSE = hold.betas$Estimate - hold.betas$Std..Error


library(ggplot2)
gg.betas = ggplot(hold.betas[hold.betas$Predictor!="(Intercept)",], aes(x = step, y = Estimate, group = Predictor, colour = Predictor))
gg.betas = gg.betas + geom_smooth(se = F) + theme_bw() # used smoother but could use path instead
gg.betas = gg.betas + geom_smooth(aes(y=UpperSE), linetype = 2, se = F) 
gg.betas = gg.betas + geom_smooth(aes(y=LowerSE), linetype = 2, se = F) 
gg.betas

gg.ts = ggplot(hold.betas[hold.betas$Predictor!="(Intercept)",], aes(x = step, y = t.value, group = Predictor, colour = Predictor))
gg.ts = gg.ts + geom_path() + theme_bw()
gg.ts = gg.ts + geom_hline(yintercept = 2, linetype = 2) + geom_hline(yintercept = -2, linetype = 2)
gg.ts 

# including intercept
gg.betas = ggplot(hold.betas, aes(x = step, y = Estimate, group = Predictor, colour = Predictor))
gg.betas = gg.betas + geom_smooth(se = F) + theme_bw()
gg.betas = gg.betas + geom_smooth(aes(y=Upper05), linetype = 2, se = F) 
gg.betas = gg.betas + geom_smooth(aes(y=Lower05), linetype = 2, se = F) 
gg.betas

# avg angle per step - matches intercept as expected
mean.angles = aggregate(s.(angle_v) ~ steps, mt.angles[mt.angles$steps %in% 2:100,], mean)
colnames(mean.angles)[2] = "angle_v"
gg.angles = ggplot(mean.angles, aes(x = steps, y = angle_v ))
gg.angles = gg.angles + geom_path() + theme_bw()
gg.angles
