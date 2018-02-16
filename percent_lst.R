# useful function to get a list of numbers and the get the percentage for each n of sum

percent.lst <- function(lst){
  percent = rep(0, length(lst)) 
  
  for (percent.ix in 1:length(percent)){
    percent[percent.ix] = 100 * lst[percent.ix] / sum(lst) 
  }
  
  return(percent)
  
}
  

