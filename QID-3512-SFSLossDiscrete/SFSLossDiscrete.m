% ----------------------------------------------------------------------
% Book:         SFS
% ----------------------------------------------------------------------
% Quantlet:     SFSLossDiscrete
% ----------------------------------------------------------------------
% Description:  Loss distribution of portfolio of two zero coupon bonds
%               with zero recovery.
%               Corresponds to excercise 18.3 in SFS.
% ----------------------------------------------------------------------
% Usage:        -
% ----------------------------------------------------------------------
% Inputs:       PD  - probability of default
%               RHO - correlation
% ----------------------------------------------------------------------
% Output:       plot of the portfolio loss distribution for four different
%               correlation paramenters.
% ----------------------------------------------------------------------
% Example:      the example is produced for the values:
%               PD = 0.2
%               RHO  = [0,0.2,0.5,1]
% -----------------------------------------------------------------------
% Author:       Szymon Borak 20090731
% -----------------------------------------------------------------------

close all
clear
clc

%Plots of correlation dependence in discrete case

L     = [0,1,2];
PD    = 0.2;
RHO   = [0,0.2,0.5,1];
PL012 = [];

for i =1:length(RHO)
    rho   = RHO(i);
    PL2   = rho*(1-PD)*PD + PD^2;
    PL1   = PD*(1-PD)*(1-rho);
    PL0   = (1-PD)-PD*(1-PD)*(1-rho);
    PL012 = [PL012,[PL0;PL1;PL2]];
end

bar(L,PL012,'group')
legend( ['\rho =' num2str(RHO(1))],['\rho=' num2str(RHO(2))],['\rho=' num2str(RHO(3))],['\rho = ' num2str(RHO(4))])

xlabel('Loss')
ylabel('Probability')
