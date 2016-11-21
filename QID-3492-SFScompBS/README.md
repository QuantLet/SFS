
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFScompBS** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFScompBS

Published in : SFS

Description : 'Calculates and compares the price of a plain vanilla call option with a power call
option.'

Keywords : 'asset, black-scholes, call, european-option, financial, option, option-price, price,
simulation, stock-price'

Author : Derrick Kanngiesser

Submitted : Sun, August 02 2015 by quantomas

Input: 
- K: strike price
- S: stock price
- sigma: volatility
- r: interest rate
- tau: time to maturity
- alpha: parameter

Example : The example is produced for the values K=10, S=15, sigma=0.22, r=0.02, tau=1.5, alpha=2.

```


### R Code:
```r
rm(list = ls(all = TRUE))
graphics.off()

# parameter settings
K     = 10
S     = 15      # 10 for ATM vanilla, 15 for ITM vanilla
sigma = 0.22    # volatility
r     = 0.02
tau   = 1.5
alpha = 2

# calculation of BS power call option
z  = (log(S/(K^(1/alpha))) + (r - (1/2) * sigma^2))/(sigma * sqrt(tau))
zz = z + alpha * sigma * sqrt(tau)
p  = pnorm(z)
pp = pnorm(zz)
C1 = S^(alpha) * exp((alpha - 1) * (r + 0.5 * alpha * sigma^2) * tau) * pp - K * 
    exp(-r * tau) * p

# calculation of BS plain vanilla european call option
d = exp(-(tau/4) * r) + exp(-(tau/2) * r)
y = (log(S/K) + (r - sigma^2/2) * tau)/(sigma * sqrt(tau))

# output
(cdfy = pnorm(y))
(cdfn = pnorm(y + sigma * sqrt(tau)))
(C2 = S * cdfn - (K * exp(-r * tau) * cdfy)) 

```
