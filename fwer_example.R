# FWER - at least one significant result

fwer = function(p.val, n.tests) return(1 - (1-p.val)^n.tests)
fwer(.05,2) 
fwer(.05, 5)
fwer(.05, 1:10)
n.tests = 1:20
fwer.ntests = fwer(.05, n.tests)
plot(n.tests, fwer.ntests)

bonferroni = fwer(.05/n.tests, n.tests)
plot(n.tests, bonferroni)


# sample.space 
# [.95 Test1NonSig, .95 Test2NonSig]
# [.05 Test1Sig, .95 Test2NonSig]
# [.95 Test1NonSig, .05 Test2Sig]
# [.05 Test1Sig, .05 Test2Sig]
.95^2 + .05*.95*2 + .05^2
# at least one nonsig test = 1 - .05^2 = 1 - all sig
# at least one sig test = 1 - (1-.05)^2 = 1 - all nonsig

x^2 + 2xy + y^2