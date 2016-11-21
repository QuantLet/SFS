
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFSacfMA3** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFSacfMA3

Published in : SFS

Description : Plots the autocorrelation function of an MA(3) (moving average) process.

Keywords : 'acf, autocorrelation, discrete, graphical representation, linear, moving-average, plot,
process, simulation, stationary, stochastic, stochastic-process, time-series'

Author : Szymon Borak, Wolfgang K. Härdle, Brenda López Cabrera

Submitted : Wed, July 29 2015 by quantomas

Example : The simulation is produced for the random sample of 1000 observations.

```

![Picture1](SFSacfMA3-1.png)


### R Code:
```r
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()
set.seed(0)
x = rnorm(1002, 0, 1)
y = filter(filt = c(1, -1, 1), x = x)

autocorr = acf(y[2:1001], lag.max = 20, col = "red", main = "Sample Autocorrelation Function (ACF)", 
    ylab = "Sample Autocorrelation")
print(cbind(autocorr$lag, autocorr$acf)) 

```
