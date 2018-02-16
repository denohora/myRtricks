# http://stackoverflow.com/questions/9490482/combined-plot-of-ggplot2-not-in-a-single-plot-using-par-or-layout-functio

library(ggplot2)
library(grid)


vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)


plot1 <- qplot(mtcars,x=wt,y=mpg,geom="point",main="Scatterplot of wt vs. mpg")
plot2 <- qplot(mtcars,x=wt,y=disp,geom="point",main="Scatterplot of wt vs disp")
plot3 <- qplot(wt,data=mtcars)
plot4 <- qplot(wt,mpg,data=mtcars,geom="boxplot")
plot5 <- qplot(wt,data=mtcars)
plot6 <- qplot(mpg,data=mtcars)
plot7 <- qplot(disp,data=mtcars)

# 4 figures arranged in 2 rows and 2 columns
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))
print(plot1, vp = vplayout(1, 1))
print(plot2, vp = vplayout(1, 2))
print(plot3, vp = vplayout(2, 1))
print(plot4, vp = vplayout(2, 2))


# One figure in row 1 and two figures in row 2
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))
print(plot5, vp = vplayout(1, 1:2))
print(plot6, vp = vplayout(2, 1))
print(plot7, vp = vplayout(2, 2))