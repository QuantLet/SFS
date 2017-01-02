%--------------------------------------------------------------------------
% Book:         SFS
% -------------------------------------------------------------------------
% Quantlet:     SFSLossPois
% -------------------------------------------------------------------------
% Description:  Loss distribtion in the simplified Poisson model.
%               Corresponds to exercise 18.5 in SFS.
%--------------------------------------------------------------------------
% Usage:        -
%--------------------------------------------------------------------------
% Inputs:       None
%--------------------------------------------------------------------------
% Output:       Plots of the loss distribution in the simplified Poisson  
%               model with default probabilities comming from Gamma
%               distribution.
% -------------------------------------------------------------------------
% Example:      The example is produced for the 100 obligors and Gamma
%               parameters:  (2,0.05), (4,0.05), (6,0.05), (3,0.0333),
%               (2,0.05), (10,0.01). 
%--------------------------------------------------------------------------
% Author  :     Szymon Borak 20090731
%--------------------------------------------------------------------------

clear
close all
clc

h   = 0.01;
lam = 0:h:1;
m   = 100;
k   = 0:m;
L1  = zeros(1,m+1);
L2  = L1;
L3  = L1;

%Gamma pdfs with alpha = (2,4,6) and beta=5.
fp1 = gampdf(lam,2,0.05);
fp2 = gampdf(lam,4,0.05);
fp3 = gampdf(lam,6,0.05);

%Loss distribution with the Poisson model.
for i=1:(m+1)
    L1(i) = sum(poisspdf(k(i),m*lam).*fp1*h);
    L2(i) = sum(poisspdf(k(i),m*lam).*fp2*h);
    L3(i) = sum(poisspdf(k(i),m*lam).*fp3*h);
end
plot(k,L1,k,L2,k,L3,'Linewidth',2,'Color',[0,0,1])

%Gamma pdfs with alpha = (3,2,10) and beta=(3.33,5,1).
fp4 = gampdf(lam,3,0.0333);
fp5 = gampdf(lam,2,0.05);
fp6 = gampdf(lam,10,0.01);

for i=1:(m+1)
    L4(i) = sum(poisspdf(k(i),m*lam).*fp4*h);
    L5(i) = sum(poisspdf(k(i),m*lam).*fp5*h);
    L6(i) = sum(poisspdf(k(i),m*lam).*fp6*h);
end
figure
plot(k,L4,k,L5,k,L6,'Linewidth',2,'Color',[0,0,1])
xlim([0,30])

