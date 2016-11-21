# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

wiener3 = function(T, t) {
    l = T + t
    g = 0:l
    
    set.seed(0)
    z = runif(l, min = 0, max = 1)
    z = 2 * (z > 0.5) - 1
    x = c(0, cumsum(z))
    
    listik = cbind(g, x)
    
    # output
    plot(listik[(T + 1):(T + t + 1), 1], listik[(T + 1):(T + t + 1), 2], type = "l", 
        col = "blue", xlab = "Time", ylab = "Values of process Y_t")
    title("Wiener process")
    
}

wiener3(100, 50) 
