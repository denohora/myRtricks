clients_ssubPlot <- function(sessions, phases, responses, 
                     client_list = NULL,
                     JABA_style = T){
  
  library(ggplot2)

    if(is.null(client_list) == T) {
    # assumes each session 1 is a new client
    start_client_sessions <- which(sessions==1)
    final_client_sessions <- c( which(sessions==1)[-1]-1, length(sessions))
    client_list <- rep(0, length(sessions))
    for(i in 1: length(start_client_sessions)) {
      client_list[start_client_sessions[i]: final_client_sessions[i]] = i
    }
    client_list <- paste("client", client_list)
  }
  
  data <- data.frame(sessions, phases, responses, client_list)
  # TODO check for repeated phase names and append a number A becomes A2
  
  label_location <- aggregate(sessions ~ phases + client_list, data, mean)
  phase_change <- aggregate(sessions ~ phases + client_list, data, max)
  phase_change$sessions <- phase_change$sessions +.5
  
  ssPlot <- ggplot(data, aes(sessions, responses, group = phases) ) 
  # add geoms etc
  ssPlot <- ssPlot + theme_linedraw() + 
            facet_grid(client_list ~., scales = "free", space = "free", switch = "y") +
            theme(panel.grid = element_blank()) +
            geom_point(show.legend = F) + geom_path()
  
  # add phase lines etc
  ssPlot <- ssPlot + coord_cartesian(ylim = c(0, max(responses)+1) ) +
            geom_vline(data = phase_change, aes(xintercept = sessions), linetype = 2) +
            geom_text(data = label_location, aes(x = sessions, label = phases), y = max(responses)+1)

  
  return(ssPlot)  
}

# EXAMPLE

# # # session numbers
# # # example data - 3 sets of client sessions
# sessions <- 1:20
# client_sessions <- c( 1:20, 1:16, 1:24 )
# # 
# # # phase labels - one for each session
# # # example data - A-B-A-B design, second A and B labelled as A2 and B2
# # phases <- c( rep("A", 5), rep("B", 5), 
# #               rep("A2", 5), rep("B2", 5) )
# # client_phases <- rep(phases, 3) 
# gen_phases_abab <- function(phase_length){
#   phases <- c( rep("A", phase_length), rep("B", phase_length), 
#                  rep("A2", phase_length), rep("B2", phase_length) )
#   return(phases)
# }
# client_phases <- c( gen_phases_abab(5), 
#                     gen_phases_abab(4), 
#                     gen_phases_abab(6) ) 
# 
# # # response number - one for each session
# # # example data - 5 responses at baseline, then 5 increased, 5 reversed and 5 increased again
# # responses <- round(c( rnorm(n = 5, mean = 3), rnorm(n = 5, mean = 6), 
# #                 rnorm(n = 5, mean = 3), rnorm(n = 5, mean = 6) ), 0)
# # 
# gen_resps_abab <- function(low_mean, high_mean, phase_length){
#   resps <- round(c( rnorm(n = phase_length, mean = low_mean), 
#             rnorm(n = phase_length, mean = high_mean), 
#             rnorm(n = phase_length, mean = low_mean), 
#             rnorm(n = phase_length, mean = high_mean) ), 0)
#   return(resps)
# }
# 
# client_responses <- c( gen_resps_abab(3,6,5), 
#                        gen_resps_abab(2,6,4), 
#                        gen_resps_abab(4,8,6) ) 
# 
# # client list
# client_list <- c( rep("Tom", 20), rep("Dick", 16), rep("Harry", 24) )
# 
# clients_ssubPlot(sessions = client_sessions, 
#                  phases = client_phases, 
#                  responses = client_responses, 
#                  client_list = client_list)
# 
# clients_ssubPlot(sessions = client_sessions, 
#                  phases = client_phases, 
#                  responses = client_responses)
