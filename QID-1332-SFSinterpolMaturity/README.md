
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFSinterpolMaturity** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFSinterpolMaturity

Published in : 'Statistics of Financial Markets : Exercises and Solutions'

Description : 'Uses linear interpolation of option prices C1 and C3 and implied volatilities in
order to approximate the price of another option C2. All options have the same strike, but vary in
maturity with tau1<tau2<tau3.'

Keywords : 'financial, implied-volatility, interpolation, linear, approximation, option,
volatility, risk, graphical representation, plot'

See also : SFScalendarspread, SFSinterpolStrike, SFSriskreversal, SFSstickycall

Author : Lasse Groth

Submitted : Mon, September 26 2011 by Awdesch Melzer

Output: 
- IntpInP: Interpolated price by prices
- impvol: Implied volatilities
- diff: Deviation from true price
- IntpInV: Interpolated price by volatility
- interpvol: Interpolated volatility

```


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("fOptions")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# parameter settings
DAX    = 4617.07                       # Closing price at time t_0.
strike = 4600                          # Strike price
irate  = 0.021                         # Interest rate
mvec   = c(0.2109, 0.4602, 0.7095)     # Vector of option maturities
cvec   = c(119.4, 194.3, 256.9)        # Vector of call prices

# Calculate implied volatilities
impvol = matrix(, , )
for (i in 1:3) impvol[i] = GBSVolatility(cvec[i], "c", DAX, strike, mvec[i], irate, 
    b = irate)
IntpInV = matrix(, , )

# Interpolation in prices
interpolatedprice = (mvec[2] - mvec[1]) * (cvec[3] - cvec[1])/(mvec[3] - mvec[1]) + 
    cvec[1]
IntpInP = interpolatedprice

# Interpolation in volatility
interpvol = (mvec[2] - mvec[1]) * (impvol[3] - impvol[1])/(mvec[3] - mvec[1]) + 
    impvol[1]

# Calculation of option price by BS model with implied volatility
d1 = (log(DAX/strike) + (irate + interpvol^2/2) * mvec[2])/(interpvol * sqrt(mvec[2]))
d2 = d1 - interpvol * sqrt(mvec[2])
interpolatedprice = DAX * pnorm(d1) - strike * exp(-irate * mvec[2]) * pnorm(d2)

IntpInV = interpolatedprice

# Deviation from true price
diff = c(abs(cvec[2] - IntpInP), abs(cvec[2] - IntpInV))

print("Implied volatilities")
print("  C1     C2     C3")
print(round(impvol, 4))

print("Interpolated volatility for C2")
print(round(interpvol, 4))

print("Interpolated prices")
print("by price")
print(IntpInP)
print("by volatility")
print(IntpInV)

print("Deviation from true price")
print("by price")
print(diff[1])
print("by volatility")
print(round(diff[2], 4))
```
