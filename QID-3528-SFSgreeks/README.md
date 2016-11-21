
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFSgreeks** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFSgreeks

Published in : SFS

Description : Calculates the Delta, the Gamma and the Theta of a portfolio.

Keywords : 'asset, black-scholes, call, european-option, financial, greeks, option, option-price,
portfolio'

See also : SFSBSCopt1

Author : Zografia Anastasiadou

Submitted : Wed, August 05 2015 by quantomas

Input: 
- K: strike price
- S: stock price
- tau1: time to maturity of call to be longed
- tau2: time to maturity of call to be shorted
- r: interest rate
- sigma: volatility

Example : 'The example is produced for the values: K = 220, S = 220, tau1 = 0.5, tau2 = 0.25, r =
0.06, sigma = 0.25.'

```


### R Code:
```r
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# parameter settings
K     = 220      # Set strike price
S     = 220      # Set stock price
tau1  = 6/12     # Set time of maturity of call to be longed
tau2  = 3/12     # Set time of maturity of call to be shorted
r     = 0.06     # Set interest rate
sigma = 0.25     # Set volatility

# call to be longed
y1 = (log(S/K) + (r - sigma^2/2) * tau1)/(sigma * sqrt(tau1))
(delta1 = pnorm(y1 + sigma * sqrt(tau1)))

# call to be shorted
y2 = (log(S/K) + (r - sigma^2/2) * tau2)/(sigma * sqrt(tau2))
(delta2 = -pnorm(y2 + sigma * sqrt(tau2)))

 # the overall delta of the portfolio
(delta  = delta1 + delta2) 

# call to be longed
a1 = dnorm(y1 + sigma * sqrt(tau1))
(gamma1 = (1/(sigma * S * sqrt(tau1))) * a1)

# call to be shorted
a2 = dnorm(y2 + sigma * sqrt(tau2))
(gamma2 = -(1/(sigma * S * sqrt(tau2))) * a2)

# the overall gamma of the portfolio
(gamma = gamma1 + gamma2)  

# call to be longed
t1 = -(sigma * S)/(2 * sqrt(tau1))
(theta1 = (t1 * a1) - (r * K * exp(-r * tau1) * pnorm(y1)))

# call to be shorted
t2 = -(sigma * S)/(2 * sqrt(tau2))
(theta2 = (t2 * a2) - (r * K * exp(-r * tau2) * pnorm(y2)))

# the overall gamma of the portfolio
(theta = theta1 + theta2)  
```
