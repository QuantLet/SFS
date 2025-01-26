<div style="margin: 0; padding: 0; text-align: center; border: none;">
<a href="https://quantlet.com" target="_blank" style="text-decoration: none; border: none;">
<img src="https://github.com/StefanGam/test-repo/blob/main/quantlet_design.png?raw=true" alt="Header Image" width="100%" style="margin: 0; padding: 0; display: block; border: none;" />
</a>
</div>

```
Name of QuantLet: SFSstickycall

Published in: Statistics of Financial Markets : Exercises and Solutions

Description: Plots call option prices as a function of strikes for 85<K<115. The implied volatility function may be fixed to the strike prices (sticky strike) or moneyness K/S (sticky moneyness). Compares the relative difference of both approaches.

Keywords: financial, implied-volatility, interpolation, linear, approximation, option, volatility, risk, graphical representation, plot, moneyness, strike

See also: SFScalendarspread, SFSinterpolMaturity, SFSinterpolStrike, SFSriskreversal

Author: Lasse Groth

Submitted: Fri, September 30 2011 by Awdesch Melzer

Example: 
- 1: 'Call prices as a function of strikes for r = 2%, tau = 0.25. The implied volatility functions curves are given as f(K) = 0.000167K^2 - 0.03645K + 2.08 (blue and green curves) and f*(K) = f(KxS0/S1) (red curve). The level of underlying price is S0 = 100 (blue) and S1 = 105 (green, red).
- 2: 'Relative differences of the call prices for two different stickiness assumptions.
- 3: 'Implied volatility functions f(K) = 0.000167K2 - 0.03645K + 2.08 and f*(K) = f(KxS0/S1).

```
<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/SFS/master/QID-1340-SFSstickycall/SFSstickycall_1-1.png" alt="Image" />
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/SFS/master/QID-1340-SFSstickycall/SFSstickycall_2-1.png" alt="Image" />
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/SFS/master/QID-1340-SFSstickycall/SFSstickycall_3-1.png" alt="Image" />
</div>

