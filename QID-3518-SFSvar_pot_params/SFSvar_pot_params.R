# Close all plots and clear variables
graphics.off()
rm(list = ls(all = TRUE))

# Load data
bet = t(read.table("beta_pot_Portf.txt"))
ksi = t(read.table("ksi_pot_Portf.txt"))
u = t(read.table("u_pot_Portf.txt"))

# Plots of shape, scale and treshold parameters
plot(bet, type = "l", col = "blue", ylim = c(-1, 5), ylab = c(""), xlab = c(""), 
    axes = FALSE)
lines(ksi, col = "red")
lines(u, col = "magenta")
title("Parameters in Peaks Over Threshold Model")
box()
axis(1, c(261, 521, 782, 1043, 1304, 1566, 1826) - 250, c("Jan 2000", "Jan 2001", 
    "Jan 2002", "Jan 2003", "Jan 2004", "Jan 2005", "Jan 2006"))
axis(2)

legend("topright", c("Scale Parameter", "Shape Parameter", "Threshold"), pch = c(15, 
    15, 15), col = c("blue", "red", "magenta")) 