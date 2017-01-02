% ---------------------------------------------------------------------
% Book:         SFS
% ---------------------------------------------------------------------
% Quantlet:     SFSdaxdowkernel
% ---------------------------------------------------------------------
% Description:  
% ---------------------------------------------------------------------
% Usage:        -
% ---------------------------------------------------------------------
% Inputs:      - None
% ---------------------------------------------------------------------
% Output:       Plot of kernel density estimate for DAX and Dow Jones
%               returns
% ---------------------------------------------------------------------
% Example:      Perform an empirical analysis using the data on DAX and
%               Dow Jones index from the period Jan. 1, 1997 to Dec. 30, 2004.
% ---------------------------------------------------------------------
% Author:       20090914
% ---------------------------------------------------------------------
% 

clear
close all
clc

%Load dataset
load 'daxdow.txt';

dax = daxdow(:,1);
dow = daxdow(:,2);

%Compute differences/returns
%daxret = price2ret(dax,[],'Periodic');
%dowret = price2ret(dow,[],'Periodic'); 

daxret = diff(dax);
dowret = diff(dow); 

%Log-returns
daxretlog = diff(log(dax));
dowretlog = diff(log(dow)); 

%Absolute log-returns
daxretlogabs = abs(daxretlog);
dowretlogabs = abs(dowretlog);

%Kernel Density Estimation
figure
[f, xi] = ksdensity(daxretlog);

f2      = daxretlog;
xi2     = normpdf((daxretlog-mean(daxretlog))/std(daxretlog))/std(daxretlog)';

d       = [f2 xi2];
d       = sortrows(d);
subplot(2,1,1); 

hold on
plot(xi, f, '-r', 'LineWidth', 2)
plot(d(:,1), d(:,2), '--k')
hold off
grid on
title('Kernel density estimation Dax')

[f, xi] = ksdensity(dowretlog);

f2      = dowretlog;
xi2     = normpdf((dowretlog-mean(dowretlog))/std(dowretlog))/std(dowretlog)';

d       = [f2 xi2];
d       = sortrows(d);

subplot(2,1,2);

hold on
plot(xi, f, 'LineWidth', 2)
plot(d(:,1), d(:,2), '--k')
hold off
grid on
title('Kernel density estimation Dow')

