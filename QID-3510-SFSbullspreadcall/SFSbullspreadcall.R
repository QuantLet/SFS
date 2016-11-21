
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

bullspreadcall = function(St, K1, K2, T, sigma, r) {
    if (K1 > K2) 
        print("K2 must be larger than K1") else {
        K  = c(K1, K2)
        
        # Calculate the terms for the BS option prices
        d1 = (log(St/K) + (r + sigma^2/2) * T)/(sigma * sqrt(T))
        d2 = d1 - sigma * sqrt(T)
        
        # Set the coordinates
        x  = c(0, K1, K2, K1 + K2)
        cal = numeric(2)
        
        # Calculate to plain vanilla call option prices
        for (i in 1:2) {
            cal[i] = St * pnorm(d1[i]) - K[i] * exp(-r * T) * pnorm(d2[i])
        }
        
        # Value of plain vanilla options at time T
        cal_T = cal * exp(r * T)
        
        # Calculate the payoff at each coordinate
        y1 = c(-cal_T[1], -cal_T[1], K[2] - K[1] - cal_T[1], K[2] - cal_T[1])
        y2 = c(cal_T[2], cal_T[2], cal_T[2], -K[1] + cal_T[2])
        
        # Determine the strategy payoff
        y = y1 + y2
        
        # Plot strategy
        plot(x, y, type = "l", lwd = 3, col = "red", xlab = "S_T", ylab = "Payoff", 
            xlim = c(0.7 * x[2], 1.4 * x[2]), ylim = c(-1.2 * y[3], 1.2 * y[3]))
        title("Bull Call Spread")
        
        # Plot plain vanilla option payoff profiles
        lines(x, y1, lty = 2)
        lines(x, y2, lty = 2)
        lines(x, c(0, 0, 0, 0), lty = 3)
        text(95, 8.2, "Short Call")
        text(80, -12, "Long Call")
    }
}
bullspreadcall(92, 100, 120, 1, 0.4, 0.03) 
