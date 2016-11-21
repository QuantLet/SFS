
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("pracma")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# stock tree
S0 = 100
Su = 120
Sd = 80
Sm = S0

# strike price
K = 100

# payoff of the call option
Sdplus = (Sd - K) * ((Sd - K) > 0)
Smplus = (Sm - K) * ((Sm - K) > 0)
Suplus = (Su - K) * ((Su - K) > 0)

# hedging with minimal quadratic error
A = rbind(cbind(Su, 1), cbind(Sm, 1), cbind(Sd, 1))
b = rbind(Suplus, Smplus, Sdplus)
delta = mldivide(A, b)

# call option price under this hedging
call = delta[1] * S0 + delta[2]

# martingale measure of this hedging
A = rbind(t(A), t(b))
b = rbind(S0, 1, call)
(q = mldivide(A, b))
