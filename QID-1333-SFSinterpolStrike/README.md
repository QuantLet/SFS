
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFSinterpolStrike** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFSinterpolStrike

Published in : 'Statistics of Financial Markets : Exercises and Solutions'

Description : 'Uses linear interpolation of option prices C1 and C3 and implied volatilities in
order to approximate the price of another option C2. All options have the same maturity, but vary
in strike with K1<K2<K3.'

Keywords : 'financial, implied-volatility, interpolation, linear, approximation, option,
volatility, risk, graphical representation, plot'

See also : SFScalendarspread, SFSinterpolMaturity, SFSriskreversal, SFSstickycall

Author : Lasse Groth

Submitted : Fri, September 30 2011 by Awdesch Melzer

Output: 
- interpol: interpolated volatility
- diff: Deviation from true price
- IntpInP: interpolated price by prices
- impvol: implied volatilities
- IntpInV: nterpolated price by volatility

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
tau    = 0.2109                  # Time to maturity
DAX    = 4617.07                 # Closing price at time t_0.
strike = 4600                    # Strike price
irate  = 0.021                   # Interest rate
svec   = c(4000, 4200, 4500)     # Vector of option strikes
cvec   = c(640.6, 448.7, 188.5)  # Vector of option prices

# Calculate implied volatilities
impvol = matrix(, , )
for (i in 1:3) impvol[i] = GBSVolatility(cvec[i], "c", DAX, svec[i], tau, irate, 
    b = irate)

# Interpolation in prices
interpolatedprice = (svec[2] - svec[1]) * (cvec[3] - cvec[1])/(svec[3] - svec[1]) + 
    cvec[1]
IntpInP = interpolatedprice

# Interpolation in volatility
interpvol = (svec[2] - svec[1]) * (impvol[3] - impvol[1])/(svec[3] - svec[1]) + 
    impvol[1]

# Calculation of option price by BS model with implied volatility
d1 = (log(DAX/svec[2]) + (irate + interpvol^2/2) * tau)/(interpvol * sqrt(tau))
d2 = d1 - interpvol * sqrt(tau)
interpolatedprice = DAX * pnorm(d1) - svec[2] * exp(-irate * tau) * pnorm(d2)
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
print(round(diff[2], 2))
```
