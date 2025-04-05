% ------------------------------------------------------------------------------
% Book:        SFS
% ------------------------------------------------------------------------------
% Quantlet:    SFSbullspreadcall
% ------------------------------------------------------------------------------
% Description: SFSbullspreadcall plots the combination of a long call and a 
%              short call where the exercise price of the short call is higher 
%              than the exercise price of the long call, i.e. bull spread 
%              strategy. Values can be entered interactively.
%              Refers to exercise 1.3 in SFS.         
% ------------------------------------------------------------------------------
% Usage:       -
% ------------------------------------------------------------------------------
% Inputs:      St    - Stock price
%              K1    - Exercise price for long call
%              K2    - Exercise price for short call
%              r     - Interest rate
%              T     - Time to expiration
%              sigma - Volatility
% ------------------------------------------------------------------------------
% Output:      Plot of a bull option strategy calls.
% ------------------------------------------------------------------------------
% Example:     An example is produced for the values: St=92, K1=100,
%              K2=120, T=3, sigma = 0.4, r=0.03.
% ------------------------------------------------------------------------------
% Author:      R: Zografia Anastasiadou, 20110225
%              Matlab: Awdesch Melzer 20130123
% ------------------------------------------------------------------------------

clear all
close all
clc

 
St    = 92;     % Stock price
K1    = 100;    % Exercise price for long call
K2    = 120;    % Exercise price for short call, K1<K2
T     = 1;      % Time to expiration, i.e. 0.25 for quarter of year
sigma = 0.4;    % Volatility
r     = 0.03;   % Interest rate


	
	K = [K1,K2]';
	
    %Calculate the terms for the BS option prices
    
    d1  = (log(St./K) + (r+sigma.^2/2).*T)/(sigma.*sqrt(T));
    d2  = d1-sigma.*sqrt(T);
    
    %Set the coordinates
    x   = [0;K1;K2;K1+K2];

    cal = [];
    %Calculate to plain vanilla call option prices
    for (i = 1:2)
    cal(i) = St.*normcdf(d1(i)) - K(i).*exp(-r.*T).*normcdf(d2(i));
    end
    %Value of plain vanilla options at time T
    cal_T  = cal.*exp(r*T);

    %Calculate the payoff at each coordinate
    y1     = [-cal_T(1);-cal_T(1);K(2)-K(1)-cal_T(1);K(2)-cal_T(1)];
    y2     = [cal_T(2);cal_T(2);cal_T(2);-K(1)+cal_T(2)];
    
    %Determine the strategy payoff
    y = y1+y2;

    %Plot strategy
    plot(x,y,'-r','LineWidth',2)
    hold on
    xlabel('S_T','FontSize',16,'FontWeight','Bold')
    ylabel('Payoff','FontSize',16,'FontWeight','Bold')
    xlim([0.7*x(2),1.4*x(2)])
    ylim([-1.2*y(3),1.2*y(3)])
    title('Bull Call Spread','FontSize',16,'FontWeight','Bold')
    set(gca,'LineWidth',1.6,'FontSize',16,'FontWeight','Bold');
    box on
    
    %Plot plain vanilla option payoff profiles
    plot(x,y1,'--k','LineWidth',2)
    plot(x,y2,'--k','LineWidth',2)
    
    plot(x,[0,0,0,0]',':k','LineWidth',3) 
    
    text(95,8.2,'Short Call','FontSize',16,'FontWeight','Bold')
    text(80,-12,'Long  Call','FontSize',16,'FontWeight','Bold')
    hold off
    
    % to save the plot in pdf or png please uncomment next 2 lines:
% print -painters -dpdf -r600 SFSbullspreadcall.pdf
% print -painters -dpng -r600 SFSbullspreadcall.png
  