
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFS5step** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFS5step

Published in : SFS

Description : Computes the probabilities for 5 states of a state-dependent binomial process.

Keywords : binomial, discrete, probability, process, stochastic, stochastic-process

Author : Axel Gross-Klußmann

Submitted : Wed, July 29 2015 by quantomas

Output : Table of probabilities.

```


### R Code:
```r
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

T = 5
P = matrix(0, 2 * T + 2, T)

# first column of probability matrix
P0 = matrix(0, 2 * T + 1, 1)
P0[T + 1, 1] = 1

for (t in seq(1, T)) {
    if (t == 1) {
        # initialize for t=1
        P[T + 1 + 1, 1] = 1/2
        P[T + 1 - 1, 1] = 1/2
    }
    if (t > 1) {
        if ((t%%2) != 0) {
            # time variable odd
            for (i in seq(1, t, 2)) {
                # the probability rule
                P[T + 1 + i, t] = (i == 0) * (P[T + 1 + i - 1, t - 1] != 0) * (1 - 
                  1/(2^(abs(i + 1) + 1))) * P[T + 1 + i - 1, t - 1] + (i != 0) * 
                  (P[T + 1 + i - 1, t - 1] != 0) * (1/(2^(abs(i - 1) + 1))) * P[T + 
                  1 + i - 1, t - 1] + (P[T + 1 + i + 1, t - 1] != 0) * (1 - 1/2^(abs(i + 
                  1) + 1)) * P[T + 1 + i + 1, t - 1]
                P[T + 1 - i, t] = P[T + 1 + i, t]
            }
        }
        if ((t%%2) == 0) {
            # time variable even
            for (i in seq(0, t, 2)) {
                # the probability rule
                P[T + 1 + i, t] = (i == 0) * (P[T + 1 + i - 1, t - 1] != 0) * (1 - 
                  1/(2^(abs(i + 1) + 1))) * P[T + 1 + i - 1, t - 1] + (i != 0) * 
                  (P[T + 1 + i - 1, t - 1] != 0) * (1/(2^(abs(i - 1) + 1))) * P[T + 
                  1 + i - 1, t - 1] + (P[T + 1 + i + 1, t - 1] != 0) * (1 - 1/2^(abs(i + 
                  1) + 1)) * P[T + 1 + i + 1, t - 1]
                P[T + 1 - i, t] = P[T + 1 + i, t]
            }
        }
    }
}

# show the table
print("  States ::       Probabilities")
dist = cbind(cbind(rbind(t(t(seq(5, 0, -1))), t(t(seq(-1, -5, -1)))), P0), P[1:nrow(P) - 
    1, ])
print(dist)
print("Distribution of state-dependent binomial process after first 5 steps") 

```
