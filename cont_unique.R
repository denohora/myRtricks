cont.unique <- function (x) x[c(TRUE, !x[-length(x)] == x[-1])] 
# removes contiguous duplicates to give an output like unique 
# (https://stackoverflow.com/questions/10769640/how-to-remove-repeated-elements-in-a-vector-similar-to-set-in-python)
# (https://paulrougieux.github.io/)