split.code <- function(text, split, output = "All") { 
  if(output == "All")  unlist(strsplit(text, split) )
  else unlist(strsplit(text, split)) [output]
}