% ------------------------------------------------------------------------------
% Book:        SFS
% ------------------------------------------------------------------------------
% Quantlet:    SFSchisq
% ------------------------------------------------------------------------------
% Description: SFSchisq plots the probability density plot of the chi-squared
%              distribution for different degrees of freedom.
% ------------------------------------------------------------------------------
% Usage:       -
% ------------------------------------------------------------------------------
% Inputs:      None.
% ------------------------------------------------------------------------------
% Output:      Probability density plots of chi squared distribution
% ------------------------------------------------------------------------------
% Example:     Chi-squared pdf plots for df=1 and df=5.
% ------------------------------------------------------------------------------
% Author:      Awdesch Melzer 20120503
% ------------------------------------------------------------------------------

clear all;
close all;
clc;

x   = [0:0.01:40]';
df  = 1;
pch = chi2pdf(x,df);

% Pdf plot of chi-squared distribution df=1
figure(1)
plot(x,pch,'LineWidth',3)
xlim([0,6])
ylim([0,4])
title(['Chi-Squared Distribution, df = ', int2str(df)])
box on

x   = [0:0.01:40]';
df  = 5;
pch = chi2pdf(x,df);

% Pdf plot of chi-squared distribution df=5
figure(2)
plot(x,pch,'LineWidth',3)
xlim([0,20])
ylim([0,0.16])
title(['Chi-Squared Distribution, df = ', int2str(df)])
box on
