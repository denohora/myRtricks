make_comb_mat <- function(vec, CombLength, Perms = F, Repeats = F){
  # vec # vector of numbers from which to create perms
  # PermLength # length of each perm
  # Perms = F # if T, return permutations, if F, return combinations
  # Repeats = F # if T allow repetition of values (e.g., 1-1-1), if F don't allow
  
  if(!length(vec) > CombLength) print("vector of combinates shorter than Combination Length")
  
  lst = lapply(numeric(CombLength), function(x) vec)
  mat = as.matrix(expand.grid(lst))
  
  if(Repeats == F) mat = mat[colSums(apply(mat,1,duplicated))==0,] 
  # remove rows including repeats of the same value
  
  if(Perms == F){
    sort.rows = apply(mat,1,sort)
    row.content = apply(sort.rows,2,paste, collapse = "")
    mat = mat[!duplicated(row.content), ]
  } # perms False
  return(mat)
}
# https://stackoverflow.com/questions/3993546/how-to-generate-a-matrix-of-combinations
