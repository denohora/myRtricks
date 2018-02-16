
setwd("~/Google Drive/Risk_Intell")

# trim <- function (x) gsub("\\s+", "", x)
# 
# data <- readLines('textstims_nonum.csv')
# data = data[-1]
# for(data.ix in 1:length(data)) data[data.ix] =trim(data[data.ix])
# for(data.ix in 1:length(data)) data[data.ix] = paste('textQuestion[', data.ix-1,'] = "', data[data.ix], '";', sep = "" )
# print(data)
# write(data, 'textstims.txt')


setwd("~/Google Drive/Risk_Intell/text_source")

data = readLines('textstims.js')
data = data[6:length(data)]
for(data.ix in 1:length(data)) data[data.ix] =strsplit(data[data.ix],'"')[[1]][2]
head(data)
write(data, 'textstims_doh.csv', sep = ',')





