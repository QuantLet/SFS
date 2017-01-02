% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFSbottomstraddle
% ---------------------------------------------------------------------
% Description: SFSbottomstraddle plots the combination of a long call 
%              and a long put with the same strike, i.e. a straddle strategy. Values can be
%              entered interactively. Refers to exercise 1.4 in SFS.
% ---------------------------------------------------------------------
% Usage:       SFSbottomstraddle
% ---------------------------------------------------------------------
% Inputs:      St    - Stock price
%              K     - Strike price
%              r     - Interest rate
%              T     - Time to expiration
%              sigma - Volatility
% ---------------------------------------------------------------------
% Output:      Plot of a straddle option strategy
% ---------------------------------------------------------------------
% Example:     An example is produced for the values: St=20, K=25, T=1, 
%              sigma = 0.4 and r=0.03.
% ---------------------------------------------------------------------
% Author:      Lasse Groth 20090709
% ---------------------------------------------------------------------

clear
clc
close all

disp('Please input St, K, T, sigma, r  as: [20,25,1,0.4,0.03]') ;
disp(' ') ;
para = input('[St, K, T, sigma, r]=');

while length(para) < 5
    disp(' ')
    disp('Not enough input arguments. Please input in 1*5 vector form like [20,25,1,0.4,0.03]');
  para = input('[St, K, T, sigma, r]=');
end

St    = para(1);
K     = para(2);
T     = para(3);
sigma = para(4);
r     = para(5);
disp(' ');

[call, put] = blsprice(St,K,r,T,sigma);

call_T      = call*exp(r*T);
put_T       = put*exp(r*T);

x           = [0 K 2*K];

y1          = [-call_T -call_T K-call_T];
y2          = [K-put_T -put_T -put_T];
y3          = y1+y2;

hold on
plot(x,y1,'--k','LineWidth',1)
plot(x,y2,'--k','LineWidth',1)
plot(x,y3,'-r','LineWidth',2)
plot(x,[0 0 0],':k','LineWidth',0.2)
hold off

axis([0 2*K -1.3*(call_T+put_T) 1.3*(K-min(call_T,put_T))])
xlabel('S_T');      
ylabel('Payoff');
title('Bottom Straddle');

