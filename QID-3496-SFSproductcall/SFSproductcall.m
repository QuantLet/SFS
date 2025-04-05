% ------------------------------------------------------------------------------
% Book:        SFS
% ------------------------------------------------------------------------------
% Quantlet:    SFSproductcall
% ------------------------------------------------------------------------------
% Description: SFSproductcall calculates the price of a European product call  
%              option of Allianz and Munich RE stock prices. Refers to exercise 
%              9.7 in SFS.
% ------------------------------------------------------------------------------
% Usage:       -
% ------------------------------------------------------------------------------
% Inputs:      K - Strike price
%              S1, S2 - Stock possible prices
%              sigma1, sigma2 - Volatilities
%              rho - correlation
%              r - Interest rate
%              tau - Time to maturity
% ------------------------------------------------------------------------------
% Output:      The price of a European product call option of Allianz and Munich 
%              RE stock prices.
% ------------------------------------------------------------------------------
% Example:     The example is produced for the values K=6000, S1=60, S2=100, 
%              sigma1=0.4249, sigma2=0.314, rho=0.3, r=0.01, tau=1. The price of 
%              the European Product Call is 1633.364.
% ------------------------------------------------------------------------------
% Author:      R: Zografia Anastasiadou, 20120207
%              Matlab: Awdesch Melzer 20130123
% ------------------------------------------------------------------------------

clear all
close all
clc

K       = 6000;  % strike price
S1      = 60;    % stock price for Allianz
S2      = 100;   % stock price for Munich RE
sigma1  = 0.4249;% volatility for Allianz
sigma2  = 0.314; % volatility for Munich RE
rho     = 0.3;   % correlation
r       = 0.01;  % interest rate
tau     = 1;     % time to maturity

sigmasq = sigma1.^2+2.*rho.*sigma1.*sigma2+sigma2.^2;
sigma   = sqrt(sigmasq);

d1      = (log(S1.*S2./K)+(2.*r-(sigma1.^2+sigma2.^2)./2).*tau)./(sigma.*sqrt(tau));
d2      = d1+sigma.*sqrt(tau);

cdf1    = normcdf(d1);
cdf2    = normcdf(d2);

ce      = exp((r+sigma1.*sigma2.*rho).*tau).*S1.*S2.*cdf2-(exp(-r.*tau).*K.*cdf1); % price of european product call
ce