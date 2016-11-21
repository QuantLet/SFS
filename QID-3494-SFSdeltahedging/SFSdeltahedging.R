rm(list = ls(all = TRUE))
graphics.off()

# parameter settings
stockprices = c(49, 49.75, 52, 50.1, 48.375, 48.25, 48.75, 49.625, 48.25, 48.25, 
    51.125, 51.5, 49.875, 49.875, 48.75, 47.5, 48, 46.25, 48.12, 46.62, 48.12)
weeks = 22:0        # numer of weeks
tau   = weeks/52    # time to maturity
K     = 50          # strike price
r     = 0.05        # interest rate
sigma = 0.2         # volatility
S     = rbind(0, 0, cbind(stockprices))

y = (log(S/K) + ((r - ((sigma^2)/2))) * tau)/(sigma * sqrt(tau))
t(t(y))
x = y + sigma * sqrt(tau)
t(t(x))

Delta = round(digits = 4, t(t(pnorm(x))))

# generate dummy time vector
time = c(-1:20)

# Hedging takes place if element changes from 0 to 1 or vice versa from 0 to 1
# purchase
Hedge_strat = ifelse(diff(Delta) > 0, 1, 0)
t(t(Hedge_strat))

purch = ifelse(Hedge_strat == 1, 1e+05, 0)
sell  = ifelse(Hedge_strat == 0, -1e+05, 0)

# Shares purchased
Shares_purchased = purch * (diff(Delta))

# Shares sold
Shares_sold = sell * (diff(Delta))

# Total shares
cumushares = 0
for (i in 2:(length(S[2:23, ]))) {
    cumushares[i] = cumushares[i - 1] + Shares_purchased[i] - Shares_sold[i]
    print(cumushares[i])
}

# Cost of shares, multiply number of shares (bought) with corresponding price
Cost_shares = Shares_purchased * (S[-1, ])

# Revenue of shares, multiply number of shares (sold) with corresponding price
Revenue_shares = Shares_sold * (S[-1, ])

# Cumulative Costs
cumucosts = 0
for (i in 2:(length(Cost_shares))) {
    cumucosts[i] = cumucosts[i - 1] + Cost_shares[i] - Revenue_shares[i]
    print(cumucosts[i])
}

# Table of costs
table = cbind(time, S[2:23, 1], Delta[2:23, 1], round(cumushares, digits = 2), Cost_shares, 
    Revenue_shares, cumucosts)
table = table[-1, ]
colnames(table) = c("Time", "Stock price", "Delta Hedging", "Shares purchased", "Cost of shares", 
    "Revenue of shares", "Cumulativ costs")
print("Table of costs of hedging")
table
