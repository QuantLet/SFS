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
