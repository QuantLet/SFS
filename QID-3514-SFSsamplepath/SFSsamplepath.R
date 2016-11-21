
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

t = 11
x = 0.5836
y = NULL

for (i in 1:t) {
    z = (-1)^i * x
    y = rbind(y, z)
    i = i + 1
}
x_a = 1:t

plot(x_a, y[1:t, ], xlim = c(0, t), ylim = c(-1, 1), col = "blue", cex = 2, xlab = c(""), 
    ylab = c(""))
 