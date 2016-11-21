
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFStrinomialSB** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFStrinomialSB

Published in : SFS

Description : 'Calculates risk neutral probabilities of the up, middle, and down movements such
that the price of the call option with strike K is equal to the price of the hedging portfolio
minimizing the quadratic hedging error at time t = 0.'

Keywords : 'asset, binomial-tree, call, delta, error, european-option, financial, hedging, implied
binomial tree, option, option-price, portfolio, price, probability, risk, simulation, stock-price,
trinomial'

Author : Awdesch Melzer

Submitted : Mon, August 03 2015 by quantomas

Input: 
- S0: stock price of one period trinomial model
- Su, Sd, Sm: stock possible prices
- K: strike price

Example : 'The example is produced for the values: S0 = 100, Su = 120, Sd = 80, Sm = S0, K = 100.'

```


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("pracma")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# stock tree
S0 = 100
Su = 120
Sd = 80
Sm = S0

# strike price
K = 100

# payoff of the call option
Sdplus = (Sd - K) * ((Sd - K) > 0)
Smplus = (Sm - K) * ((Sm - K) > 0)
Suplus = (Su - K) * ((Su - K) > 0)

# hedging with minimal quadratic error
A = rbind(cbind(Su, 1), cbind(Sm, 1), cbind(Sd, 1))
b = rbind(Suplus, Smplus, Sdplus)
delta = mldivide(A, b)

# call option price under this hedging
call = delta[1] * S0 + delta[2]

# martingale measure of this hedging
A = rbind(t(A), t(b))
b = rbind(S0, 1, call)
(q = mldivide(A, b))

```
