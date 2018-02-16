# working on importing PsyScopeX data files directly - May 2012
# import  = psx.import("Participant*.*", "Script file:  Phase 1") # testing

# NB at the moment, you must provide the Script file string as it is written in the PsyscopeX data file
# i.e., type "Script file" then two whitespaces, then the script file name.

psx.import <- function(filename, scriptname) {
  # filename = "Participant*.*" # for testing
  files = list.files(pattern = filename) 
  firstrun = T
  for (subindex in 1:length(files)){ # not implemented yet
    # subindex = 1 # for testing
    rows = readLines(files[subindex])
    
    # use Script file to identify relevant portion of data file
    # scriptname = "Script file:  Phase 1" # for testing
    test.rows = rows[which(rows == scriptname):length(rows)] 
    # chop anything beyond the trials
    test.rows = test.rows[1:(which(test.rows[1:length(test.rows)] == "\t")-1)]
    rows = "" # release memory in rows
    
    # get the colnames (row 11) - split at tab
    sub.colnames = c("TrialRow", "Subject","SubjectName", unlist(strsplit(test.rows[12], "\t"))) # see regex for detail on "\t"
    subname = unlist(strsplit(test.rows[5], " "))
    subname = paste(subname[2:length(subname)], collapse=" ") 
    # subname holds SubjectName for connection to data files - 
    # Subject will be an integer(factor)  
    
    # set up empty data frames - reduces memory req and increases speed
    sub.data = data.frame(1:(length(test.rows)-12), subindex,subname,sub.colnames[4:ncol(sub.colnames)], stringsAsFactors = F) 
    # adjust to correct col's - this is not flexible yet
    colnames(sub.data) = sub.colnames
    for (trialrow in 13:length(test.rows)){
      sub.data[trialrow-12,4:ncol(sub.data)] = unlist(strsplit(test.rows[trialrow], "\t"))
    } # for trialrow
  
    if (firstrun == T){
      import = sub.data
      firstrun = F
    } # if firstrun
    else import = rbind(import,sub.data)
  } # for subindex
  return(import)
} #function