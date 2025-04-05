% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFSmvol01
% ---------------------------------------------------------------------
% Description: SFSmvol01 calculates the summary statistics for the EUR/USD
%              and GBP/USD exchange rates and produces a plot of the time
%              series of returns on both exchange rates for the period from 
%              01/01/2002 to 01/01/2009. Refers to exercise 3.7 in SFS.
% ---------------------------------------------------------------------
% Usage:       -
% ---------------------------------------------------------------------
% Inputs:      None
% ---------------------------------------------------------------------
% Output:      Summary statistics and plot for EUR/USD and GBP/USD
%              daily FX-rate returns.
% ---------------------------------------------------------------------
% Example:     -
% ---------------------------------------------------------------------
% Author:      Lasse Groth 20090729
%              Edit: Awdesch Melzer 20130123
% ---------------------------------------------------------------------

clc
clear
close all

fx      = load('fx_eur_gbp_usd.txt')

returns = diff(log(fx)); %Convert FX-rates to return series


%Summary statistics
summary(1,:) = mean(returns);
disp('Mean')
disp('   EUR/USD    GBP/USD');
disp(summary(1,:));

summary(2,:) = min(returns);
disp('Min')
disp('   EUR/USD    GBP/USD')
disp(summary(2,:))

summary(3,:) = max(returns);
disp('Max') 
disp('   EUR/USD    GBP/USD')
disp(summary(3,:))

summary(4,:) = median(returns);
disp('Median') 
disp('EUR/USD GBP/USD')
disp(summary(4,:))

summary(5,:) = std(returns);
disp('Standard error') 
disp('   EUR/USD   GBP/USD')
disp(summary(5,:))

summary(6:7,:) = corr(returns);
disp('Correlation') 
disp('   EUR/USD    GBP/USD')
disp(summary(6:7,:))


x = 2002:1/257:2009.47;

subplot(2,1,1) %Plot returns EUR/USD
plot(returns(:,1))
xlim([0,1827])
  title('EUR/USD','FontSize',16,'FontWeight','Bold')
    xlabel('Time','FontSize',16,'FontWeight','Bold')
    ylabel('Returns','FontSize',16,'FontWeight','Bold')
    set(gca,'XTick',[0 261 522 784 1044 1304 1565 1827],'FontSize',16,'FontWeight','Bold')                  
    set(gca,'XTickLabel',{'2002','2003','2004','2005','2006','2007','2008','2009' },'LineWidth',1.6,'FontSize',16,'FontWeight','Bold')
 box on
  
subplot(2,1,2) %Plot returns GBP/USD
plot(returns(:,2))
xlim([0,1827])
  title('GBP/USD','FontSize',16,'FontWeight','Bold')
    xlabel('Time','FontSize',16,'FontWeight','Bold')
    ylabel('Returns','FontSize',16,'FontWeight','Bold')
    set(gca,'XTick',[0 261 522 784 1044 1304 1565 1827],'FontSize',16,'FontWeight','Bold')                  
    set(gca,'XTickLabel',{'2002','2003','2004','2005','2006','2007','2008','2009' },'LineWidth',1.6,'FontSize',16,'FontWeight','Bold')
box on

    % to save the plot in pdf or png please uncomment next 2 lines:
% print -painters -dpdf -r600 SFSmvol01.pdf
% print -painters -dpng -r600 SFSmvol01.png