abbrev_coeffs <- function(coeffs, coeff_col, pval_col, extra_cols){

  pval_lessthan05 <- coeffs[,pval_col] <= .05 & coeffs[,pval_col] > .01
  pval_lessthan01 <- coeffs[,pval_col] <= .01 & coeffs[,pval_col] > .001
  pval_lessthan001 <- coeffs[,pval_col]<.001
  
  asterisks <- rep("", length(pval_lessthan05))
  asterisks[pval_lessthan05] <- "*"
  asterisks[pval_lessthan01] <- "**"
  asterisks[pval_lessthan001] <- "***"
  
  abbrev_coeffs <- cbind(coeffs[coeff_col], asterisks, coeffs[extra_cols])
  abbrev_coeffs$b <- paste(abbrev_coeffs$Estimate, abbrev_coeffs$asterisks, sep = "")
  return_cols <- c("b", colnames(coeffs)[extra_cols])
  return(abbrev_coeffs[, return_cols])
}

# test <- abbrev_coeffs(RT_output, coeff_col = 1, pval_col = 6, extra_cols = 2)
