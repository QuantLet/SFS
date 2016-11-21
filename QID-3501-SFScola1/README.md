
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFScola1** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : SFScola1

Published in : SFS

Description : 'Plots the time series of daily stock prices for Coca-Cola company from 1 January
2002 to 30 November 2004.'

Keywords : 'asset, data visualization, financial, graphical representation, plot, price,
stock-price, time-series, visualization'

See also : SFScola2, SFScola3, SFScola3

Author : Szymon Borak, Wolfgang K. Härdle, Brenda López Cabrera

Submitted : Mon, August 03 2015 by quantomas

Datafile : Coca_cola.txt

```

![Picture1](SFScola1-1.png)


### R Code:
```r
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

x = read.table("Coca_cola.txt") # Stock prices
x = ts(x)                       # transform to time series object

# plotting with adjusted axes
plot(x, type = "l", ylab = "Price (USD)", xlab = "Time (days)", col = "blue", ylim = c(min(x), 
    max(x)), xlim = c(0, length(x)), lwd = 2)
```
