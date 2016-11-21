# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

wiener2 = function(dt, c) {
    l = 1
    n = floor(l/dt)
    t = seq(0, n * dt, c * dt)
    
    set.seed(0)
    z = runif(floor(n/c), 0, 1)
    z = 2 * (z > 0.5) - 1
    z = z * c^(-0.5) * sqrt(dt)  #to get finite and non-zero variance
    x = c(0, cumsum(z))
    
    listik = cbind(t, x)
    
    # output
    plot(listik[, 1], listik[, 2], type = "l", col = "blue", xlab = "Time", ylab = "Values of process X_t")
    title("Wiener process")
    
}

wiener2(0.001, 2) 
