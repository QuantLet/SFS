% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFScalendarspread
% ---------------------------------------------------------------------
% Description: SFScalendarspread calculates and compare the prices of
%              the calendar spread for the following implied volatility
%              curves given as a function of maturity.
%              (i)  f1(tau) = 0.15 x tau + 0.05.
%              (ii) f2(tau) = 0.15 x tau + 0.06.
%              (iii)f3(tau) = 0.10 x tau + 0.075.
%              The plots compare the functions f2 and f3 to the function
%              f1.
%              Corresponds to exercise 17.5 in SFS.
% ---------------------------------------------------------------------
% Usage:       -
% ---------------------------------------------------------------------
% Inputs:      S0     - Closing price of underlying at time t_0
%              strike - strike prices
%              tau    - range of time to maturity
%              r      - interest rate
% ---------------------------------------------------------------------
% Output:      The prices of calendar spread for functions f1, f2 and f3.
%              Comparison of f1 and f2 and of f1 and f3.
% ---------------------------------------------------------------------
% Example:     -
% ---------------------------------------------------------------------
% Author:      Szymon Borak 20090731
% ---------------------------------------------------------------------

clear
close all
clc

%inputs
S0     = 100;
strike = 100;
tau    = 0.25:0.05:1;
r      = 0.02;

%define calendar spread
i1 = 1;i2=16;

f1 = @(x)0.15*x + 0.05 ; % initial
f2 = @(x)0.15*x + 0.06 ; % shifted
f3 = @(x)0.1*x + 0.075 ; % tilt

%calculate
%f1
ivterm = f1(tau);
call1  = blsprice(S0,strike,r,tau(i1),ivterm(i1));
call2  = blsprice(S0,strike,r,tau(i2),ivterm(i2));

CSp1   = call1 + call2;

%f2
ivterm = f2(tau);
call1  = blsprice(S0,strike,r,tau(i1),ivterm(i1));
call2  = blsprice(S0,strike,r,tau(i2),ivterm(i2));

CSp2   = call1 + call2;

%f3
ivterm = f3(tau);
call1  = blsprice(S0,strike,r,tau(i1),ivterm(i1));
call2  = blsprice(S0,strike,r,tau(i2),ivterm(i2));
CSp3   = call1 + call2;

%final results
disp('Prices of calendar spread')
disp('      f1        f2        f3')
disp([CSp1,CSp2,CSp3])

%difference f1 vs. f2
figure(1)
plot(tau,f1(tau),'linewidth',2.5, 'color',[0,0,1])
hold on
plot(tau,f2(tau),'linewidth',2.5,'color',[0,0,1],'linestyle','--')
hold off
title('f_1 vs. f_2')
xlabel('Maturity')
ylabel('\sigma_{imp}')
ylim([0.08,0.2])

%difference f1 vs. f3
figure(2)
plot(tau,f1(tau),'linewidth',2.5, 'color',[0,0,1])
hold on
plot(tau,f3(tau),'linewidth',2.5,'color',[0,0,1],'linestyle','--')
hold off
title('f_1 vs. f_3')
xlabel('Maturity')
ylabel('\sigma_{imp}')
%ylim([0.08,0.2])