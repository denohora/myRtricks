# Single subject plot function

# idea here is to make an easy single sub plot function - data in LONG format
# adds phase lines etc like in typical JEAB/JABA plot

# ssplot( data, conditions, sessions==NULL, type == "ABA" )

# data = vector of sequential scores (future: or data frame of columns)
# conditions = vector of conditions (factor levels)
# sessions = vector of session values (e.g., may have missed sessions) 
#   - if NULL, then sessions = 1: length(data)
# type = type of single subject plot
# -- "ABA" classic reversal style
# -- "MED" multi-element design (alternating treatments)
# -- "MBD" multiple baseline design

# test whether sessions list fits with number of data points in data
# if (sessions!= NULL & length(data) != length(sessions))
# ERROR "Number of Sessions does not equal number of data points"
# else sessions = 1: length(data)

# type ="ABA"
# get number of different conditions
numcond = length(unique(conditions))
# get session values
# need array to hold vectors of session values for each condition
# use a list to allow for ragged array
sessvals = array(numcond, list()) # check schinkel project for something like this

# plot mean for high goal first
lines(1:3, data[1:3], type = "o")
lines(4:6, data[4:6], type = "o")
lines(7:9, data[7:9], type = "o")
lines(10:12, data[10:12], type = "o")


# use ful raw materials

# plot mean for high goal first
lines(1:3, data[1:3], type = "o")
lines(4:6, data[4:6], type = "o")
lines(7:9, data[7:9], type = "o")
lines(10:12, data[10:12], type = "o")

# plot phase change lines
lines(c(3.5,3.5), c(-3,3), lty = 2)
lines(c(6.5,6.5), c(-3,3), lty = 2)
lines(c(9.5,9.5), c(-3,3), lty = 2)


