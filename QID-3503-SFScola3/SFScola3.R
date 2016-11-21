# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

x = read.table("Coca_cola.txt")     # Stock prices
x = ts(x)                           # transform to time series object

# Returns
r1 = (x[2:length(x)] - x[1:length(x) - 1])/x[1:length(x) - 1]   # Returns
r2 = log(x[2:length(x)]) - log(x[1:length(x) - 1])              # Log returns
split.screen(c(2, 1))

# Time series r1
screen(1)
plot(r1, type = "l", col = "blue", xlab = "Time (days)", ylab = "Returns")
# Time series r2
screen(2)
plot(r2, type = "l", col = "blue", xlab = "Time (days)", ylab = "Log Returns") 
