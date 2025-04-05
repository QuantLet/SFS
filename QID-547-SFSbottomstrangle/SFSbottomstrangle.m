% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFSbottomstrangle
% ---------------------------------------------------------------------
% Description: SFSbottomstrangle plots the combination of a long call 
%              and a long put where the call strike is larger than the 
%              put strike, i.e. a strangle strategy. Values can be
%              entered interactively. Refers to exercise 1.7 in SFS.
% ---------------------------------------------------------------------
% Usage:       SFSbottomstrangle
% ---------------------------------------------------------------------
% Inputs:      St    - Stock price
%              K1    - Exercise price put
%              K2    - Exercise price call          
%              r     - Interest rate
%              T     - Time to expiration
%              sigma - Volatility
% ---------------------------------------------------------------------
% Output:      Plot of a strangle option strategy
% ---------------------------------------------------------------------
% Example:     An example is produced for the values: St=45, K1=40, K2=50, 
%              T=1, sigma = 0.4 and r=0.03.
% ---------------------------------------------------------------------
% Author:      Lasse Groth 20090709
% ---------------------------------------------------------------------

clear
clc
close all

disp('Please input St, K1, K2, T, sigma, r  as: [45,40,50,1,0.4,0.03]') ;
disp(' ') ;
para = input('[St, K1, K2, T, sigma, r]=');

while length(para) < 6
    disp(' ')
    disp('Not enough input arguments. Please input in 1*6 vector form like [45,40,50,1,0.4,0.03]');
  para = input('[St, K1, K2, T, sigma, r]=');
end

while para(3) < para(2)
    disp(' ')
    disp('K2 must be larger than K1');
    para = input('[St, K1, K2, T, sigma, r]=');
end

St    = para(1); %Set the parameters
K1    = para(2);
K2    = para(3);
T     = para(4);
sigma = para(5);
r     = para(6);
disp(' ');

call         = blsprice(St,K2,r,T,sigma); %Calculate the plain vanilla option prices
[dummy, put] = blsprice(St,K1,r,T,sigma);

x            = [0 K1 K2 2*K2]; %Set the coordinates

y1           = [-call*exp(r*T) -call*exp(r*T) -call*exp(r*T) K2-call*exp(r*T)]; %Calculate the payoff at each coordinate
y2           = [K1-put*exp(r*T) -put*exp(r*T) -put*exp(r*T) -put*exp(r*T)];

y            = y1+y2; %Combine the payoffs of options to get the strangle strategy

hold on
plot(x,y1,'--k','LineWidth',1)
plot(x,y2,'--k','LineWidth',1)
plot(x,y,'-r','LineWidth',2)
plot(x,zeros(1,4),':k','LineWidth',0.2)
hold off

axis([0.35*K1 K2+0.65*K1 -1.3*(call*exp(r*T)+put*exp(r*T)) 0.75*(K2-max(call*exp(r*T),put*exp(r*T)))])
xlabel('S_T');      
ylabel('Payoff');
title('Strangle (Bottom)');