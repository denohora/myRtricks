lav.form <- function(var.names) {
  var.vector = c(var.names, var.names)
  nam.loc = seq(1, (length(var.vector)-1), by = 2)
  plus.loc = seq(2, (length(var.vector)-1), by = 2)
  var.vector[nam.loc] = var.names
  var.vector[plus.loc] = " + "
  var.vector = var.vector[-length(var.vector)]
  form = paste(var.vector, collapse = "")
  return(form)
}

lav.form(1:3)
lav.form(c("x", "y", "z"))