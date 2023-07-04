# fn

ssubPlot <- function(sessions, phases, responses, JABA_style = T){
  library(ggplot2)
  data <- data.frame(sessions, phases, responses)
  # TODO check for repeated phase names and append a number A becomes A2
  
  label_location <- aggregate(sessions ~ phases, data, mean)
  
  ssPlot <- ggplot(data, aes(sessions, responses, group = phases) ) + theme_classic()
  ssPlot <- ssPlot + geom_point(show.legend = F) + geom_path()
  
  phase_change <- which(!duplicated(phases))[-1]
  
  ssPlot <- ssPlot + coord_cartesian(ylim = c(0, max(responses)+1) )
  ssPlot <- ssPlot + geom_vline(xintercept = phase_change-.5, linetype = 2)
  ssPlot <- ssPlot + geom_text(data = label_location, aes(x = sessions, label = phases), y = max(responses)+1)
  ssPlot
  
  return(ssPlot)  
}

# # TESTING AND EXAMPLE
# # data needed for plot
# 
# # session numbers
# # example data - 20 sessions
# sessions <- 1:20
# 
# # phase labels - one for each session
# # example data - A-B-A-B design, second A and B labelled as A2 and B2
# phases <- c( rep("A", 5), rep("B", 5),
#              rep("A2", 5), rep("B2", 5) )
# 
# # response number - one for each session
# # example data - 5 responses at baseline, then 5 increased, 5 reversed and 5 increased again
# responses <- round(c( rnorm(n = 5, mean = 3), rnorm(n = 5, mean = 6),
#                 rnorm(n = 5, mean = 3), rnorm(n = 5, mean = 6) ), 0)
# 
# 
# 
# test <- ssubPlot(sessions, phases, responses)

# TODO - change symbols for geom_point




