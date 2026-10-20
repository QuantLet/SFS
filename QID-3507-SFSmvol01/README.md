<div style="margin: 0; padding: 0; text-align: center; border: none;">
<a href="https://quantlet.com" target="_blank" style="text-decoration: none; border: none;">
<img src="https://github.com/StefanGam/test-repo/blob/main/quantlet_design.png?raw=true" alt="Header Image" width="100%" style="margin: 0; padding: 0; display: block; border: none;" />
</a>
</div>

```
Name of QuantLet: SFSmvol01

Published in: SFS

Description: Calculates daily log returns from EUR/USD and GBP/USD exchange rates, reports descriptive statistics, sample standard deviations and their correlation matrix, and plots both return series for the original sample covering 2002 to 2009. The Python companion saves a square transparent PNG figure.

Keywords: correlation-matrix, data visualization, descriptive-statistics, exchange-rate, financial, graphical representation, log-returns, plot, returns, standard deviation, summary, time-series, visualization, Python, transparent PNG

Author: Zografia Anastasiadou, Wolfgang Karl Härdle

Submitted: Tue, October 20 2026 by Wolfgang Karl Härdle

Datafiles: fx_eur_gbp_usd.txt

Programming language: Python

Python translation: OpenAI Codex, 2026-10-20

Dependencies: numpy, matplotlib

Input: Two columns of strictly positive exchange rates, EUR/USD followed by GBP/USD; no header or date column.

Output: Console summary statistics and correlation matrix; SFSmvol01.png (1600 x 1600 pixels, transparent background).

Run: python SFSmvol01.py

Notes: Original author credit is retained; the submission date records the Python update. Returns are first differences of log exchange rates. Standard deviations are calculated separately for each series with ddof=1. Year ticks reproduce the approximate positions in the R example because the data file contains no dates.

```

<div align="center">
  <img src="https://raw.githubusercontent.com/QuantLet/SFS/master/QID-3507-SFSmvol01/SFSmvol01-1.png" alt="Image" width="600"/>
</div>

<div align="center">
  <img src="https://raw.githubusercontent.com/QuantLet/SFS/master/QID-3507-SFSmvol01/SFSmvol01.png" alt="Image" width="600"/>
</div>

