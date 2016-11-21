rm(list = ls(all = TRUE))
graphics.off()

x = seq(0, 40, 0.01)

# Plot of chi-squared distribution with one degree of freedom
df1 = 1
plot(x, dchisq(x, df = df1), type = "l", col = "blue3", lwd = 3, xlim = c(0, 6), 
    ylim = c(0, 4), xlab = "", ylab = "")
title(paste("Chi-Squared Distribution, df =", (df1)))

# Plot of chi-squared distribution with five degrees of freedom
dev.new()
df2 = 5
plot(x, dchisq(x, df = df2), type = "l", col = "blue3", lwd = 3, xlim = c(0, 20), 
    ylim = c(0, 0.16), xlab = "", ylab = "")
title(paste("Chi-Squared Distribution, df =", (df2)))
 
