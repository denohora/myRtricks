replace_vars <- function(var_list, orig_vars, new_vars){
  
  if(length(orig_vars) != length(new_vars)  ) {
    print("Error - Different numbers of variable names")
  } else {
    
    vars_mat = cbind(orig_vars, new_vars)
    new_var_list = var_list
    
    if(length(new_var_list) == 1){
      # var names in one string (e.g., lavaan call)
      for(i in seq_along(vars_mat[,1])) {
        new_var_list = gsub(vars_mat[i,1], 
                            vars_mat[i,2], new_var_list)
      } # i
    } else {
      # vector of var names (e.g., col names)
      for(i in seq_along(vars_mat[,1])) {
        new_var_list[new_var_list == vars_mat[i,1]] = vars_mat[i,2]
      } # i
    } # length(var_list)  
    
    print(cbind(orig_vars, new_vars))
    # print("replaced by")
    # print(new_vars)
    
    return(new_var_list)
  } # else
}