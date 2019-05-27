# workings on binary choice prob distribution


dbinom(4, size=5, prob=0.5) 
[1] 0.15625
dbinom(1, size=5, prob=0.5) 
[1] 0.15625
dbinom(2, size=5, prob=0.5) 
[1] 0.3125
dbinom(1:5, size=5, prob=0.5) 
[1] 0.15625 0.31250 0.31250 0.15625 0.03125
dbinom(0:5, size=5, prob=0.5) 
[1] 0.03125 0.15625 0.31250 0.31250 0.15625 0.03125
plot(dbinom(0:5, size=5, prob=0.5) )
plot(0:5, dbinom(0:5, size=5, prob=0.5) )
1/(2^5)
[1] 0.03125
> 1/(2^6)
[1] 0.015625
plot(0:1000, dbinom(0:1000, size=1000, prob=0.5) )
plot(0:100, dbinom(0:100, size=100, prob=0.5) )
plot(0:10, dbinom(0:10, size=10, prob=0.5) )
plot(0:6, dbinom(0:10, size=10, prob=0.5) )
