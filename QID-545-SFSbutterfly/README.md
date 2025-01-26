<div style="margin: 0; padding: 0; text-align: center; border: none;">
<a href="https://quantlet.com" target="_blank" style="text-decoration: none; border: none;">
<img src="https://github.com/StefanGam/test-repo/blob/main/quantlet_design.png?raw=true" alt="Header Image" width="100%" style="margin: 0; padding: 0; display: block; border: none;" />
</a>
</div>

```
Name of QuantLet: SFSbutterfly

Published in: Statistics of Financial Markets : Exercises and Solutions

Description: Plots a butterfly option strategy either produced with call or put options. The combination of two long puts/calls with strike prices of K1 and K3 and two shorted puts/calls with strike price K2=0.5*(K1+K3).

Keywords: asset, black-scholes, call, put, derivative, european-option, financial, graphical representation, option, option-price, plot, price, simulation, stock-price

See also: SFSbottomstrangle, SFSbottomstraddle, SFSpayoffcollar, SFSstrap, SFSstrip, SFSbitreeNDiv

Author: Lasse Groth

Submitted: Tue, December 22 2009 by Lasse Groth

Input: 
- St : Stock price
- K1 : Exercise price put/call 1
- K3 : Exercise price put/call 3
- r : Interest rate
- T : Time to expiration
- sigma : Volatility
- flag : 1 for calls, 0 for puts

Example: 
- 1: 'An example is produced for the values: St=10, K1=13, K3=21, T=3, sigma = 0.5, r=0.03, flag = 0.
- 2: 'An example is produced for the values: St=10, K1=13, K3=21, T=3, sigma = 0.5, r=0.03, flag = 1.

```
<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/SFS/master/QID-545-SFSbutterfly/SFSbutterfly_1-1.png" alt="Image" />
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/SFS/master/QID-545-SFSbutterfly/SFSbutterfly_2-1.png" alt="Image" />
</div>

