
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFShullhedgeratio** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFShullhedgeratio

Published in : SFS

Description : 'Calculates the performance measure of a Stop-Loss strategy for an increasing hedging
frequency delta_t.'

Keywords : 'asset, black-scholes, call, delta, european-option, financial, hedging, option,
option-price, price, simulation, stock-price'

Author : Szymon Borak, Wolfgang K. Härdle, Brenda López Cabrera

Submitted : Mon, August 03 2015 by quantomas

```


### R Code:
```r
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("fOptions")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# parameter settings
S0     = 49         # Starting price
T      = 20/52      # Time to maturity
si     = 0.2        # Volatility
mu     = 0.13       # Drift
r      = 0.05       # Interest rate
K      = 50         # Strikeprice
NSteps = 2000       # Number of steps
NRepl  = 500        # Number of replications

NumObs = c(4, 5, 10, 20, 50, 100)

# Calculate the BS Price of the call
CallOpt = GBSOption(TypeFlag = "c", S = S0, X = K, Time = T, r = r, b = 0, sigma = si)
Call = attr(CallOpt, "price")

# Simulate the paths for the underlying stock
St        = matrix(0, NRepl, NSteps + 1)
St[, 1]   = rep(S0, NRepl)  #All paths start with S0
dt = T/NSteps  #Discretize the time to maturity into discrete time steps corresponding to NSteps in T
drift     = (mu - 0.5 * si^2) * dt  #Calculate the drift rate
diffusion = si * sqrt(dt)  #Calculate the diffusion process rate

for (i in seq(1, NRepl, 1)) {
    for (j in seq(1, NSteps, 1)) {
        St[i, j + 1] = St[i, j] * exp(drift + diffusion * rnorm(1, 0, 1))
    }
}

# Calculate the hedging cost at the specified observation times
ObsDensity      = NSteps/NumObs # size of time steps for the observations
DiscountFactors = exp(-r * seq(0, NSteps, 1) * dt)
Cost = matrix(0, NRepl, length(NumObs))
L = matrix(0, length(ObsDensity), length(ObsDensity))

for (m in seq(1, length(ObsDensity), 1)) {
    for (k in seq(1, NRepl, 1)) {
        CashFlows = matrix(0, NSteps + 1, 1)
        if (St[k, 1] >= K) {
            Covered 		= 1
            CashFlows[1] 	= -St[k, 1]
        } else {
            Covered = 0
        }
        for (t in seq(1, (NSteps + 1), ObsDensity[m])) {
            if ((Covered == 1) && (St[k, t] < K)) {
                # Sell
                Covered = 0
                CashFlows[t] = St[k, t]
            }
            if ((Covered == 0) && (St[k, t] > K)) {
                # Buy
                Covered = 1
                CashFlows[t] = -St[k, t]
            }
        }
        if (St[k, NSteps + 1] >= K) {
            # Option is exercised
            CashFlows[NSteps + 1] = CashFlows[NSteps + 1] + K
        }
        Cost[k, m] = -DiscountFactors %*% CashFlows
    }
    V      = apply(Cost, 2, var)
    L[m, ] = sqrt(V)/Call
}

print("Performance measure L:")
(X = colMeans(L))

```
