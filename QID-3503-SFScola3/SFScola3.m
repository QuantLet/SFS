% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFScola3
% ---------------------------------------------------------------------
% Description: SFScola3 reads daily stock prices for Coca-Cola company
%              from 2 January 2002 to 30 November 2004 and plots
%              the time series of returns (r1) and log returns (r2)
%              Corresponds to exercise 13.20(4.) in SFS
% ---------------------------------------------------------------------
% Usage:       -
% ---------------------------------------------------------------------
% Inputs:      none
% ---------------------------------------------------------------------
% Output:      Time series plots        
% ---------------------------------------------------------------------
% Example:     -
% ---------------------------------------------------------------------
% Author:      Julius Mungo, Andrija Mihoci  20110201
% ---------------------------------------------------------------------

clear all
close all
clc


x  = load('Coca_cola.txt');                             % Stock prices
r1 = diff(x)./x(2 : end, :);                           % Returns
r2 = diff(log(x));                                     % Log returns
subplot(2, 1, 1), plot(r1);                            % Time series r1
xlabel('Time (days)'); ylabel('Returns');              % x and y labels
subplot(2, 1, 2), plot(r2);                            % Time series r2
xlabel('Time (days)'); ylabel('Log returns');          % x and y labels


