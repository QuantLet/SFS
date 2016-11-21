collar = function(St, Kp, Kc) {
    plot(0:2 * St, 0:2 * St, type = "l", xlab = "S_T", ylab = "Payoff", col = "blue", 
        lty = 2)
    lines(c(0, Kp), c(Kp, Kp), col = "red", lwd = 2)
    lines(c(Kc, Kp), c(Kc, Kp), col = "red", lwd = 2)
    lines(c(Kc, 2 * St), c(Kc, Kc), col = "red", lwd = 2)
    title("Payoff of a Collar")
}

collar(15, 12.5, 17.5) 