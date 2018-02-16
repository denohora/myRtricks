# AUC investigations


x = c(0.006410256, 0.027777778, 1.000000000, 0.166666667, 0.333333333)
y = c(0.28125, 0.21875, 0.03125, 0.03125, 0.03125)

# add first point at 0,1 (zero delay - delay discounting)
x = c(0,x)
y = c(1,y)

# order x and y
ord.x = sort(x)
ord.y = y[rank(x)]

plot(x,y, type = "o", col = 2)

lines(ord.x,ord.y, type = "o", col = 3)
polygon(c(ord.x,1,0),c(ord.y,0,0), col = 3) # this is what we want

# so we must re-order x and it's corresponding y vals to get AUC

# simplest function 
auc <- function(x,y) sum(diff(x)*(y[-1]+y[-length(y)]))/2 
# note this function uses negative indexing - very handy!!
# http://www.r-tutor.com/r-introduction/vector/vector-index

auc(x,y) # doesn't work for disordered x
auc(ord.x, ord.y) # works for ordered x

auc <- function(x,y) {
  # order x and y
  ord.x = sort(x)
  ord.y = y[rank(x)]
  
  sum(diff(ord.x)*(ord.y[-1]+ord.y[-length(ord.y)]))/2 
}

auc(x,y) # works for disordered x

#########
# Earlier attempt at auc calc without negative indexing
# uses zoo for rollmean
# bit 'step by step' but makes it easier to follow

# Formula for area of trapezoid
# (x2-x1)* ((y1+y2)/2)
# x1 and x2 are consecutive x values (i.e., Prop.Delay) - these are increasing
# y1 and y2 are consecutive y values (i.e., Prop.Eq) - these correspond to increasing x vals 
# but may not increase themselves
library(zoo) # needed for rollmean


x = c(0.006410256, 0.027777778, 1.000000000, 0.166666667, 0.333333333)
y = c(0.28125, 0.21875, 0.03125, 0.03125, 0.03125)

# add first point at 0,1 (zero delay - delay discounting)
x = c(0,x)
y = c(1,y)

ord.x = sort(x)
ord.y = y[rank(x)]
diff.x = diff(ord.x)
rollmean.y = rollmean(ord.y,2)
area.xy = diff.x * rollmean.y
total.area = sum(area.xy) 







