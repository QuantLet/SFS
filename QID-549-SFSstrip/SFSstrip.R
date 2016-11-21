
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

strip = function(St, K, r, T, sigma, N) {
    
    # Calculate the terms for the BS option prices
    d1 = (log(St/K) + (r + sigma^2/2) * T)/(sigma * sqrt(T))
    d2 = d1 - sigma * sqrt(T)
    
    # Calculate plain vanilla option prices
    put = -St * pnorm(-d1) + K * exp(-r * T) * pnorm(-d2)
    cal = St * pnorm(d1) - K * exp(-r * T) * pnorm(d2)
    
    # Value of plain vanilla options at time T
    cal_T = cal * exp(r * T)
    put_T = put * exp(r * T)
    
    # Set the coordinates
    x = c(0, K, 2 * K)
    
    # Calculate the payoff at each coordinate
    y1 = c(-cal_T, -cal_T, -cal_T + K)
    y2 = N * c(-put_T + K, -put_T, -put_T)
    
    # Combine the payoffs of options to get the strip strategy
    y = y1 + y2
    
    # Plot strip option strategy payoff
    plot(x, y, type = "l", lwd = 3, col = "red", xlab = "S_T", ylab = "Payoff", 
        xlim = c(0, x[3]), ylim = c(y[2] * 1.1, y2[1] * 1.1))
    title("Strip")
    
    # Plot plain vanilla option payoff profiles
    lines(x, y1, lty = 2)
    lines(x, y2, lty = 2)
    
    lines(x, c(0, 0, 0), lty = 3)
    
}

strip(25, 20, 0.03, 1, 0.5, 2)