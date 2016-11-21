# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("polynom", "fOptions")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

strikevec = c(4000, 4100, 4200, 4500)
callvec   = c(640.6, 543.8, 448.7, 188.5)
ivvec     = c(0.184, 0.1714, 0.1595, 0.1275)
S0        = 4617.07
irate     = 0.021
tau       = 0.2109

# extrapolation in IV
p0 = poly.calc(strikevec[2], ivvec[2])
p1 = poly.calc(strikevec[2:3], ivvec[2:3])
p2 = poly.calc(strikevec[2:4], ivvec[2:4])

v0 = predict(p0, strikevec[1])
v1 = predict(p1, strikevec[1])
v2 = predict(p2, strikevec[1])

# Black-Scholes
call0 = GBSOption(TypeFlag = "c", S = S0, X = strikevec[1], b = irate - 1, r = irate, 
    Time = tau, sigma = v0)@price
call1 = GBSOption(TypeFlag = "c", S = S0, X = strikevec[1], b = irate - 1, r = irate, 
    Time = tau, sigma = v1)@price
call2 = GBSOption(TypeFlag = "c", S = S0, X = strikevec[1], b = irate - 1, r = irate, 
    Time = tau, sigma = v2)@price

cat(" extrapolation in IV", "n", c(ivvec[1], v0, v1, v2), "n", c(callvec[1], call0, 
    call1, call2))

# extrapolation in call prices
p0 = poly.calc(strikevec[2], callvec[2])
p1 = poly.calc(strikevec[2:3], callvec[2:3])
p2 = poly.calc(strikevec[2:4], callvec[2:4])

c0 = predict(p0, strikevec[1])
c1 = predict(p1, strikevec[1])
c2 = predict(p2, strikevec[1])

cat(" extrapolation in prices", "n", c(callvec[1], c0, c1, c2), "n") 
