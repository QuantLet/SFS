% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFScola2
% ---------------------------------------------------------------------
% Description: SFScola2 reads daily stock prices for Coca-Cola company
%              from 1 January 2002 to 30 November 2004 and plots
%              the sample autocorrelation function
%              Corresponds to exercise 13.20(2.) in SFS
% ---------------------------------------------------------------------
% Usage:       -
% ---------------------------------------------------------------------
% Inputs:      none
% ---------------------------------------------------------------------
% Output:      Sample ACF plot         
% ---------------------------------------------------------------------
% Example:     -
% ---------------------------------------------------------------------
% Author:      Julius Mungo, Andrija Mihoci  20110201
% ---------------------------------------------------------------------

clear all;
close all;
clc;

x                   = load('Coca_cola.txt'); % Stock prices
[ACF, Lags, Bounds] = autocorr(x, [], []);   % Sample ACF
autocorr(x, 100, 2);                         % Sample ACF plot


