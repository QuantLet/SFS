# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

x = read.table("Coca_cola.txt") # Stock prices
x = ts(x)                       # transform to time series object

# plotting with adjusted axes
plot(x, type = "l", ylab = "Price (USD)", xlab = "Time (days)", col = "blue", ylim = c(min(x), 
    max(x)), xlim = c(0, length(x)), lwd = 2)