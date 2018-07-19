midline.d = function(xpos.vector, midline.x = 0, rightside.positive = T) {
  xpos.resid = xpos.vector-midline.x
  if(rightside.positive == F) xpos.resid * -1
  return(max(xpos.resid))
}

# test.traj = unique(dyn.data$trial_unique)[1]
# test.traj = dyn.data[dyn.data$trial_unique == test.traj,]$mouse_x
# midline.d(test.traj, midline.x = 1920/2)
# 
# test.trajs = unique(dyn.data$trial_unique)[1000:1100]
# test.trajs = dyn.data[dyn.data$trial_unique %in% test.trajs,]
# hold = aggregate(mouse_x~trial_unique, test.trajs, midline.d, midline.x = 1920/2)

