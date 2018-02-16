# Single subject plot function

# idea here is to make an easy single sub plot function - data in LONG format
# adds phase lines etc like in typical JEAB/JABA plot
# require(lattice)
# ss.multiplot( responses, conditions, subID, sessions==NULL, type == "ABA" )

# responses = vectors of sequential scores (data frame of columns?)
# conditions = vector of conditions (factor levels)
# subID = vector of subject identifiers
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


xyplot(responses~sessions|subID, 
       hold_data[hold_data$Session<13 & hold_data$Order=="High First" & hold_data$ParticipantID!='TRAIN',], 
       groups = Phase, type = 'o', ylim = c(0,40), main = "Study 3 - High Goal First", col = 1,
       ylab = "Responses",
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         panel.lines(c(3.5,3.5), c(0,40), lty =3, col = 1)
         panel.lines(c(6.5,6.5), c(0,40), lty =3, col = 1)
         panel.lines(c(9.5,9.5), c(0,40), lty =3, col = 1)
       })



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


