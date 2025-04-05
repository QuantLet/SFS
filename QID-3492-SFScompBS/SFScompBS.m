% ------------------------------------------------------------------------------
% Book:        SFS
% ------------------------------------------------------------------------------
% Quantlet:    SFScompBS
% ------------------------------------------------------------------------------
% Description: SFScompBS calculates and compares the price of a plain vanilla 
%             call option with a power call option. Refers to exercise 9.11 in SFS.
% ------------------------------------------------------------------------------
% Usage:       -
% ------------------------------------------------------------------------------
% Inputs:      K - Strike price
%              S1, S2 - Stock possible prices
%              sigma - Volatilities
%              rho - correlation
%              r - Interest rate
%              tau - Time to maturity
% ------------------------------------------------------------------------------
% Output:      The price of a vanilla call option and power call option.
% ------------------------------------------------------------------------------
% Example:     The example is produced for the values K=10, S1=10, S2=15, 
%              sigma=0.22, , r=0.02, tau=1.5, alpha=2. The price of the vanilla
%              call option and power call option is 5.37 and 239.61 respectively.
% ------------------------------------------------------------------------------
% Author:      R: Derrick Kanngiesser, 20120215
%              Matlab: Awdesch Melzer 20130123
% ------------------------------------------------------------------------------

clear all
close all
clc

K       = 10;   % Exercise price
S       = 15;   % Stockprice: 10 for ATM vanilla % 15 for ITM vanilla
sigma   = 0.22; % Volatility
r       = 0.02; % Interest rate
tau     = 1.5;  % Time to maturity
alpha   = 2;

%calculation of BS power call option

z       = (log(S./(K.^(1/alpha)))  +(r-(1/2).* sigma.^2)  ) / (sigma * sqrt(tau));
zz      = z + alpha.*sigma.*sqrt(tau);

p       = normcdf(z);
pp      = normcdf(zz);

% Power call
C1      = S.^(alpha) .* exp((alpha -1).*(r +0.5*alpha*sigma.^2).*tau) .*pp - K.* exp(-r.*tau) .* p


% calculation of BS plain vanilla european call option

d       = exp(-(tau./4).*r)+exp(-(tau./2).*r);

y       = (log(S./K)+(r-sigma.^2/2).*tau)./(sigma.*sqrt(tau));
cdfy    = normcdf(y);
cdfn    = normcdf(y+sigma*sqrt(tau));

C2      = S.*cdfn-(K.*exp(-r.*tau).*cdfy)
