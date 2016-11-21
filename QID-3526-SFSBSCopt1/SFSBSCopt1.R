# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# parameter settings
K     = 80
r     = 0.07
sigma = 0.25
tau   = 1

# present value of the expected dividends
d = exp(-(tau/4) * r) + exp(-(tau/2) * r)
# stock price
S = K - d

y     = (log(S/K) + (r - sigma^2/2) * tau)/(sigma * sqrt(tau))
(cdfy = pnorm(y))
(cdfn = pnorm(y + sigma * sqrt(tau)))

# BS formula
(cs = S * cdfn - (K * exp(-r * tau) * cdfy))