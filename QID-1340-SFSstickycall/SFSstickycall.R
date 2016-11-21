
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# parameter settings
S0     = 100              # Underlying price at time t_0
S1     = 105              # Underlying price at time t_1
strike = seq(85, 115, 1)  # range of strike prices
tau    = 0.25             # time to maturity
r      = 0.02             # interest rate

# Calculation of option price by BS model
blsprice = function(S0, strike, r, tau, sigma) {
    d1 = (log(S0/strike) + (r + sigma^2/2) * tau)/(sigma * sqrt(tau))
    d2 = d1 - sigma * sqrt(tau)
    blsprice = S0 * pnorm(d1) - strike * exp(-r * tau) * pnorm(d2)
}

# calculate
ivsmileK = 0.000167 * strike^2 - 0.03645 * strike + 2.08
callinit = blsprice(S0, strike, r, tau, ivsmileK)
callstickystrike = blsprice(S1, strike, r, tau, ivsmileK)
ivsmilemon = 0.000167 * (strike * S0/S1)^2 - 0.03645 * strike * S0/S1 + 2.08
callstickymon = blsprice(S1, strike, r, tau, ivsmilemon)

# plot
plot(strike, callinit, type = "l", col = "blue", xlab = "Strike", ylab = "Call prices", 
    ylim = c(0, 25))
lines(strike, callstickystrike, col = "dark green")
lines(strike, callstickymon, col = "red")
title("Call prices as a function of strikes")

dev.new()
plot(strike, (callstickystrike - callstickymon)/callstickystrike, type = "l", col = "blue", 
    xlab = "Strike", ylab = "")
title("Relative diff. between call prices for diff. stickyness assumptions")

dev.new()
plot(strike, ivsmileK, type = "l", col = "blue", xlab = "Strike", ylab = "sigma_imp")
lines(strike, ivsmilemon, col = "dark green")
title("Implied volatility for different stickiness assumptions")