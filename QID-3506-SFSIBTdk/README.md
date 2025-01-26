<div style="margin: 0; padding: 0; text-align: center; border: none;">
<a href="https://quantlet.com" target="_blank" style="text-decoration: none; border: none;">
<img src="https://github.com/StefanGam/test-repo/blob/main/quantlet_design.png?raw=true" alt="Header Image" width="100%" style="margin: 0; padding: 0; display: block; border: none;" />
</a>
</div>

```
Name of QuantLet: SFSIBTdk

Published in: SFS

Description: Calculates the stock price on the nodes in the implied tree, the transition probability tree, the Arrow-Debreu tree and local volatility using Derman and Kani''s method.

Keywords: asset, binomial, binomial-tree, black-scholes, call, discrete, financial, implied binomial tree, interpolation, option, option-price, price, probability, put, simulation, stock-price, transition probability, tree, volatility

See also: IBTblackscholes, IBTcrr, IBTimpliedvola, SFSBSCopt1, SFSIBTbc

Author: Szymon Borak, Wolfgang K. Härdle, Brenda López Cabrera

Submitted: Mon, August 03 2015 by quantomas

Input: 
- s0 : price of underlying asset
- r : interest rate
- t : time to expiration
- n : number of steps
- func : type of function for implied volatility

Example: out = SFSIBTdk(100, 0.05, 3, 3, 2)

```
