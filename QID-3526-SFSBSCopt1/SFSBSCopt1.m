% ------------------------------------------------------------------------------
% Book:        SFS
% ------------------------------------------------------------------------------
% Quantlet:    SFSBSCopt1
% ------------------------------------------------------------------------------
% Description: SFSBSCopt1 calculates the price of a call with the BS formula.
%              Refers to exercise 6.7 in SFS.
% ------------------------------------------------------------------------------
% Usage:       -
% ------------------------------------------------------------------------------
% Inputs:      K - Strike price
%              S - Stock price
%              r - Interest rate
%              sigma - Volatility
%              tau - Time to maturity
% ------------------------------------------------------------------------------
% Output:      The price of a European call option calculated by the BS formula.
% ------------------------------------------------------------------------------
% Example:     For [stock price, strike price, interest rate, volatility sigma, 
%              tau]=[78.05174, 80, 0.07, 0.25, 1], Price of European Call is 
%              given 9.446196.
% ------------------------------------------------------------------------------
% Author: Axel Groﬂ-Klausmann
% ------------------------------------------------------------------------------

clear all;
close all;
clc;

K     = 80;
r     = 0.07;
sigma = 0.25;
tau   = 1;

%present value of the expected dividends
d = exp(-(tau/4)*r)+exp(-(tau/2)*r);
%stock price
S = K-d;

y    = (log(S/K)+(r-sigma^2/2)*tau)/(sigma*sqrt(tau));
cdfy = normcdf(y);
cdfn = normcdf(y+sigma*sqrt(tau));

cdfy
cdfn

%BS formula
cs = S*cdfn-(K*exp(-r*tau)*cdfy);
cs