
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("fUtilities")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# parameter settings
t    = 2      # time
n    = 10     # step
u    = 1.1    # upward proportion
d    = 0.9    # downward proportion
S0   = 50     # initial price
type = 1      # 0 for American, 1 for European
k    = 50     # strike price
i    = 0.05   # interest rate
flag = 1      # 0 for put, 1 for call
b    = i      # Costs of carry

# Main Computation
dt = t/n  # Interval of step
p  = (exp(b) - d)/(u - d)  # Pseudo probability of up movement
un = matrix(0, n + 1, 1)
un[n + 1, 1] = 1
dm = t(un)
um = dm
j  = 1

while (j < n + 1) {
    # Down movement dynamics
    d1 = c(matrix(0, 1, n - j), (matrix(1, 1, j + 1) * d)^(seq(0:j) - 1))
    dm = rbind(dm, d1)
    # Up movement dynamics
    u1 = c(matrix(0, 1, n - j), matrix(1, 1, j + 1) * u^seq(j, 0, -1))
    um = rbind(um, u1)
    j  = j + 1
}

um = t(um)
dm = t(dm)

# Stock price development
s = S0 * um * dm
colnames(s) = c()

print("Stock price development")
print(s)

# Rearangement
s   = s[ncol(s):1, ]
opt = matrix(0, ncol(s), ncol(s))

if (flag == 1 & type == 0) {
    # Option is a American call
    opt[, n + 1] = rowMaxs(s[, ncol(s)] - k, 0)  # Determine option values from prices
    for (j in n:1) {
        l = 1:j
        # Probable option values discounted back one time step
        discopt = ((1 - p) * opt[l, j + 1] + p * opt[l + 1, j + 1]) * exp(-b * 
            dt)
        # Option value is max of current stock price - strike or discopt
        opt[, j] = c(rowMaxs(cbind(s[1:j, j] - k, discopt)), matrix(0, n + 1 - 
            j, 1))
    }
    American_Call_Price = opt[ncol(opt):1, ]
    
    print("Option price development")
    print(American_Call_Price)
    
    print("The price of the American call option at time t_0 is")
    print(American_Call_Price[n + 1, 1])
    
}

if (flag == 1 & type == 1) {
    # Option is a European call
    opt[, n + 1] = rowMaxs(s[, ncol(s)] - k, 0)  # Determine option values from prices
    for (j in n:1) {
        l = 1:j
        # Probable option values discounted back one time step
        discopt = ((1 - p) * opt[l, j + 1] + p * opt[l + 1, j + 1]) * exp(-b * 
            dt)
        # Option value is max of current stock price - strike or discopt
        opt[, j] = c(discopt, matrix(0, n + 1 - j, 1))
    }
    
    European_Call_Price = opt[ncol(opt):1, ]
    
    print("Option price development")
    print(European_Call_Price)
    
    print("The price of the European call option at time t_0 is")
    print(European_Call_Price[n + 1, 1])
    
}

if (flag == 0 & type == 0) {
    # Option is an American put
    opt[, n + 1] = rowMaxs(k - s[, ncol(s)], 0)  # Determine option values from prices
    for (j in n:1) {
        l = 1:j
        # Probable option values discounted back one time step
        discopt = ((1 - p) * opt[l, j + 1] + p * opt[l + 1, j + 1]) * exp(-b * 
            dt)
        # Option value is max of current stock price - strike or discopt
        opt[, j] = c(rowMaxs(cbind(k - s[1:j, j], discopt)), matrix(0, n + 1 - 
            j, 1))
    }
    American_Put_Price = opt[ncol(opt):1, ]
    
    print("Option price development")
    print(American_Put_Price)
    
    print("The price of the American put option at time t_0 is")
    print(American_Put_Price[n + 1, 1])
    
}

if (flag == 0 & type == 1) {
    # Option is a European put
    opt[, n + 1] = rowMaxs(k - s[, ncol(s)], 0)  # Determine option values from prices
    for (j in n:1) {
        l = 1:j
        # Probable option values discounted back one time step
        discopt = ((1 - p) * opt[l, j + 1] + p * opt[l + 1, j + 1]) * exp(-b * 
            dt)
        # Option value is max of current stock price - strike or discopt
        opt[, j] = c(discopt, matrix(0, n + 1 - j, 1))
    }
    
    European_Put_Price = opt[ncol(opt):1, ]
    
    print("Option price development")
    print(European_Put_Price)
    
    print("The price of the European put option at time t_0 is")
    print(European_Put_Price[n + 1, 1])
    
}