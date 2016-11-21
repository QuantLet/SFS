# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

x = read.table("Coca_cola.txt")     # Stock prices
x = ts(x)                           # transform into time series object

autocorr = acf(x, lag.max = 100, col = "red", main = "Sample Autocorrelation Function (ACF)", 
    ylab = "Sample Autocorrelation") 
