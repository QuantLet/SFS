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
