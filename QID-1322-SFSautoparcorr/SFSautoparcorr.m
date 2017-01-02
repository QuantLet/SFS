% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFSautoparcorr
% ---------------------------------------------------------------------
% Description: SFSautoparcorr reads data for DAX and FTSE 100 from 1 Jan 
%              to 31 Dec 2007, plots the ACF and PACF for returns,
%              squarred returns and absolute returns for the two indexes.
%              Performs Ljung-Box and ARCH test statistics.
%              Refers to exercise 13.1 in SFS.
% ---------------------------------------------------------------------
% Usage:       -
% ---------------------------------------------------------------------
% Inputs:      none
% ---------------------------------------------------------------------
% Output:      Plots for the ACF and PACF. Ljung-Box and ARCH test
%              statistics are calculated.
% ---------------------------------------------------------------------
% Example:     -
% ---------------------------------------------------------------------
% Author:      Andrija Mihoci  20090803
% ---------------------------------------------------------------------
%

clear
close all
clc

% Read data for FSE and LSE from 1 Jan 1998 to 31 Dec 2007
load FTSE_DAX.dat;
DS    = FTSE_DAX;
D     = [DS(:,1)];                        % date
S     = [DS(:,2:43)];                     % S(t)
s     = [log(S)];                         % log(S(t))
r     = [s(2:end,:) - s(1:(end-1),:)];    % r(t)
n     = length(r);                        % sample size
t     = [1:n];                            % time index, t
rdax  = r(:,1);                           % DAX returns
rftse = r(:,22);                          % FTSE100 returns

% ACF and PACF plots - DAX index
figure('Name','DAX');

subplot(2,2,1) 
autocorr(rdax, 8);
title('DAX, returns'); %autocorrelation for DAX returns
ylabel('acf');
hold on;

subplot(2,2,2) 
parcorr(rdax, 8);%partial autocorrelation for DAX returns
title('DAX, returns');
ylabel('pacf');
hold on;

subplot(2,2,3)
autocorr(rdax.^2, 8); %autocorrelation  for DAX squared returns
title('DAX, squared returns');
ylabel('acf');
hold on;

subplot(2,2,4)
autocorr(abs(rdax), 8); %autocorrelation  for DAX absolute returns
title('DAX, absolute returns');
ylabel('acf');
hold off;

% ACF and PACF plots - FTSE 100 index
figure('Name','FTSE 100');

subplot(2,2,1)
autocorr(rftse, 8); %autocorrelation for FTSE 100 returns
title('FTSE 100, returns');
ylabel('acf');
hold on;

subplot(2,2,2)
parcorr(rftse, 8); %partial autocorrelation for FTSE 100 returns
title('FTSE 100, returns');
ylabel('pacf');
hold on;

subplot(2,2,3), autocorr(rftse.^2, 8); %autocorrelation  for FTSE 100 squared returns
title('FTSE 100, squared returns');
ylabel('acf');
hold on;

subplot(2,2,4), autocorr(abs(rftse), 8);%autocorrelation  for FTSE 100 absolute returns
title('FTSE 100, absolute returns');
ylabel('acf');
hold off;

% Ljung-Box (Q*(8)) and ARCH test statistics - DAX index
[LBHdaxr,LBpdaxr,LBQdaxr,LBcdaxr]     = lbqtest(rdax,8,0.05,8);      %Q statistic for returns
[LBHdaxsr,LBpdaxsr,LBQdaxsr,LBcdaxsr] = lbqtest(rdax.^2,8,0.05,8);   %Q statistic for squared returns
[LBHdaxar,LBpdaxar,LBQdaxar,LBcdaxar] = lbqtest(abs(rdax),8,0.05,8); %Q statistic for absolute returns
[ARHdaxr,ARpdaxr,ARQdaxr,ARcdaxr]     = archtest(rdax,8,0.05);       %ARCH test statistics for returns 

% Ljung-Box (Q*(8)) and ARCH test statistics - FTSE 100 index
[LBHftser,LBpftser,LBQftser,LBcftser]     = lbqtest(rftse,8,0.05,8);      %Q statistic for returns
[LBHftsesr,LBpftsesr,LBQftsesr,LBcftsesr] = lbqtest(rftse.^2,8,0.05,8);   %Q statistic for squared returns
[LBHftsear,LBpftsear,LBQftsear,LBcftsear] = lbqtest(abs(rftse),8,0.05,8); %Q statistic for absolute returns
[ARHftser,ARpftser,ARQftser,ARcftser]     = archtest(rftse,8,0.05);       %ARCH test statistics for returns 

% Ljung-Box (Q*(8)) and ARCH test statistics - Summary
disp('Ljung-Box (Q*(8)) and ARCH test statistics summary - DAX')
disp([LBQdaxr, LBQdaxsr, LBQdaxar, ARQdaxr])

disp('Ljung-Box (Q*(8)) and ARCH test statistics summary - FTSE 100')
disp('')
disp([LBQftser, LBQftsesr, LBQftsear, ARQftser])