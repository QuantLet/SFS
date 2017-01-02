% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFScola1
% ---------------------------------------------------------------------
% Description: SFScola1 reads daily stock prices for Coca-Cola company
%              from 1 January 2002 to 30 November 2004 and plots
%              the time series
%              Corresponds to exercise 13.20(1.) in SFS
% ---------------------------------------------------------------------
% Usage:       -
% ---------------------------------------------------------------------
% Inputs:      none
% ---------------------------------------------------------------------
% Output:      Time series plot         
% ---------------------------------------------------------------------
% Example:     -
% ---------------------------------------------------------------------
% Author:      Julius Mungo, Andrija Mihoci  20110201
% ---------------------------------------------------------------------

clear all;
close all;
clc;

x = load('Coca_cola.txt');                             % Stock prices
plot(x);                                               % Time series plot
xlabel('Time (days)'); ylabel('Price (USD)');          % x and y labels
axis([0 length(x) min(x) max(x)]);                     % Formating the plot


