
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **blackscholes** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : blackscholes

Published in : 'Statistics of Financial Markets : Exercises and Solutions'

Description : Computes values for call and put options according to Black Scholes.

Keywords : black-scholes, call, financial, option, option-price, put

See also : IBTcrr, IBTimpliedvola, SFSIBTbc, SFSIBTdk

Author : anonumous

Submitted : Wed, February 08 2012 by Dedy Dwi Prastyo

Input: 
- S: stock price
- X: exercise price
- rf: risk-free rate
- T: time to maturity
- sigma: volatility

Output: 
- values[1]: call value
- values[2]: put value

```


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# Black-Scholes Option 
# Value Call value is returned in values[1], put in values[2]
blackscholes = function(S, X, rf, T, sigma) {
    values = c(2)
    d1 = (log(S/X) + (rf + sigma^2/2) * T)/sigma * sqrt(T)
    d2 = d1 - sigma * sqrt(T)
    values[1] = S * pnorm(d1) - X * exp(-rf * T) * pnorm(d2)
    values[2] = X * exp(-rf * T) * pnorm(-d2) - S * pnorm(-d1)
    values
}

```
