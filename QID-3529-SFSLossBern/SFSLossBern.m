%------------------------------------------------------------------------
% Book:         SFS
% ----------------------------------------------------------------------
% Quantlet:     SFSLossBern
% ----------------------------------------------------------------------
% Description:  Loss distribtion in the simplified Bernoulli model.
%               Corresponds to exercise 18.4 in SFS.
%------------------------------------------------------------------------
% Usage:        -
%-----------------------------------------------------------------------
% Inputs:       None
%-----------------------------------------------------------------------
% Output:       Plots of the loss distribution in the simplified Bernouli  
%               model with default probabilities comming from Beta
%               distribution.
% ----------------------------------------------------------------------
% Example:      the example is produced for the 100 obligors and Beta
%               parameters:  (5,25), (10,25), (15,25), (5,45), (10,90), 
%               (20,180) 
%------------------------------------------------------------------------
% Author  :     Szymon Borak 20090731
%------------------------------------------------------------------------

clear
close all
clc

h  = 0.001;
p  = 0:h:0.99;
m  = 100;
k  = 0:m;
L1 = zeros(1,m+1);
L2 = L1;
L3 = L1;


fp1 = betapdf(p,5,25);
fp2 = betapdf(p,10,25);
fp3 = betapdf(p,15,25);


for i=1:(m+1)
    L1(i) = sum(binopdf(k(i),m,p).*fp1*h);
    L2(i) = sum(binopdf(k(i),m,p).*fp2*h);
    L3(i) = sum(binopdf(k(i),m,p).*fp3*h);
end
plot(k,L1,k,L2,k,L3,'Linewidth',2,'Color',[0,0,1])

fp4 = betapdf(p,5,45);
fp5 = betapdf(p,10,90);
fp6 = betapdf(p,20,180);




