
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFSstoploss** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFSstoploss

Published in : SFS

Description : 'Calculates the Black-Scholes call price of a stock and produces a table of the costs
of hedging.'

Keywords : 'asset, black-scholes, call, cost, delta, european-option, financial, hedging, option,
option-price, price, simulation, stock-price, strategy'

Author : Derrick Kanngiesser

Submitted : Mon, August 03 2015 by quantomas

```


### R Code:
```r
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# Calculate the price of the call
S     = c(49, 49.75, 52, 50, 48.37, 48.25, 48.75, 49.62, 48.25, 48.25, 51.12, 51.5, 49.87, 
			49.87, 48.75, 47.5, 48, 46.25, 48.12, 46.62, 48.12)
K     = 50
tau   = 0.3846  ### 20 weeks
r     = 0.05
sigma = 0.2
n     = 1e+05

blsprice.call = function(S, K, tau, r, sigma) {
    d1 = (log(S/K) + (r - 0.5 * sigma^2) * tau)/(sigma * sqrt(tau))
    d2 = d1 + sigma * sqrt(tau)
    S * pnorm(d2) - K * exp(-r * tau) * pnorm(d1)
}
(C = blsprice.call(S, K, r, tau, sigma))

# Calculate the cost of hedging start with 49 under a) and 51 under b)
stockprices = t(c(49, 49.75, 52, 50, 48.37, 48.25, 48.75, 49.62, 48.25, 48.25, 51.12, 
				51.5, 49.87, 49.87, 48.75, 47.5, 48, 46.25, 48.12, 46.62, 48.12))

# generate time vector
time = c(-1:20)

# generate dummy variable vector to test if stock price crosses K=50, 1==yes, 0==no
S = rbind(0, t(stockprices))
# vector has to start with a zero (or any number smaller than 50) in order to impose action
# in case the first value is greater than 50
D = rbind(0, S)
Hedge_strat = ifelse(D > 50, 1, 0)

# hedging takes place if element changes from 0 to 1 or vice versa from 0 to 1 purchase
(Shares_purchase = ifelse(diff(Hedge_strat) == 1, 1e+05, 0))

# from 1 to 0 sell
(Shares_sold = ifelse(diff(Hedge_strat) == -1, -1e+05, 0))

# Cost of shares, multiply number of shares (bought) with corresponding price
Cost_shares = Shares_purchase * S

# Revenue of shares, multiply number of shares (sold) with corresponding price
Revenue_shares = Shares_sold * S

# Cumulative Costs
cumucosts = 0
for (i in 2:(length(Cost_shares))) {
    cumucosts[i] = cumucosts[i - 1] + Cost_shares[i] + Revenue_shares[i]
    print(cumucosts[i])
}

# Table of costs
tablefull = cbind(time, S, Hedge_strat[2:23], Shares_purchase, Cost_shares,
				  Revenue_shares, cumucosts)
table = tablefull[-1, ]
colnames(table) = c("Time", "Stock price", "Hedge strategy", "Shares purchased", "Cost of shares", 
    "Revenue of shares", "Cumulative costs")
print("Table of costs of hedging")
table
```
