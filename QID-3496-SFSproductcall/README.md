
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFSproductcall** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFSproductcall

Published in : SFS

Description : 'Calculates the price of a European product call option of Allianz and Munich RE
stock prices.'

Keywords : 'asset, black-scholes, call, european-option, financial, option, option-price, price,
simulation, stock-price'

Author : Zografia Anastasiadou

Submitted : Mon, August 03 2015 by quantomas

Input: 
- K: strike price
- S1, S2: stock possible prices
- sigma1, sigma2: volatilities
- rho: correlation
- r: interest rate
- tau: time to maturity

Example : 'The example is produced for the values K=6000, S1=60, S2=100, sigma1=0.4249,
sigma2=0.314, rho=0.3, r=0.01, tau=1.'

```


### R Code:
```r
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# parameter settings
K      = 6000
S1     = 60         # stock price for Allianz
S2     = 100        # stock price for Munich RE
sigma1 = 0.4249     # volatility for Allianz
sigma2 = 0.314      # volatility for Munich RE
rho    = 0.3
r      = 0.01
tau    = 1

sigmasq = sigma1^2 + 2 * rho * sigma1 * sigma2 + sigma2^2
sigma   = sqrt(sigmasq)

d1 = (log(S1 * S2/K) + (2 * r - (sigma1^2 + sigma2^2)/2) * tau)/(sigma * sqrt(tau))
d2 = d1 + sigma * sqrt(tau)

cdf1 = pnorm(d1)
cdf2 = pnorm(d2)

# price of european product call
(ce = exp((r + sigma1 * sigma2 * rho) * tau) * S1 * S2 * cdf2 - (exp(-r * tau) * 
    K * cdf1))  

```
