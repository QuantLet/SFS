# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()
set.seed(0)
x = rnorm(1002, 0, 1)
y = filter(filt = c(1, -1, 1), x = x)

autocorr = acf(y[2:1001], lag.max = 20, col = "red", main = "Sample Autocorrelation Function (ACF)", 
    ylab = "Sample Autocorrelation")
print(cbind(autocorr$lag, autocorr$acf)) 
