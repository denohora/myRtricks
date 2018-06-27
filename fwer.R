
# how likely is it that you get one significant test out of 20 at p <.05
1-.95^20 # 65%

# plot change in probability as no tests increase
x = 1:20
prob = 1 - .95^x

plot(x, prob, type = "b", ylim = c(0,.7))
lines(x, rep(.05, length(x)), lty = 2)
