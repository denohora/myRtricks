# reading online data
# thanks to http://yanwong.me/?p=483
# test = read.xls("http://spreadsheets.google.com/ccc?key=0AgdO92JOXxAOdHRvb0Fpd3NndkFOdVpkY1hzdHhldXc")

require(RCurl)
URL <- "http://spreadsheets.google.com/ccc?key=0AgdO92JOXxAOdHRvb0Fpd3NndkFOdVpkY1hzdHhldXc"
myCsv <-getURL(paste(URL,"&output=csv", sep=""), .opts=curlOptions(followlocation=TRUE,cookiefile="nosuchfile"), ssl.verifypeer=FALSE)
test <- read.csv(textConnection(myCsv), stringsAsFactors=FALSE)



