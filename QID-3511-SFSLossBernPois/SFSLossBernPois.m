%------------------------------------------------------------------------
% Book:         SFS
% ----------------------------------------------------------------------
% Quantlet:     SFSLossBernPois
% ----------------------------------------------------------------------
% Description:  Loss distribtions in the simplified Bernoulli models and
%               simplified Poisson model.
%               Corresponds to exercise 18.7 in SFS.
%------------------------------------------------------------------------
% Usage:        -
%-----------------------------------------------------------------------
% Inputs:       None
%-----------------------------------------------------------------------
% Output:       Plots of the loss distribution in linear and semi-log
%               scale.
% ----------------------------------------------------------------------
% Example:      The example is produced for the 100 obligors, Beta paramters
%               (1,45) and Gamma parameters (1.25,0.08).
%------------------------------------------------------------------------
% Author  :     Szymon Borak 20090731
%------------------------------------------------------------------------

close all
clear
clc


aB  = 1;                        %alpha - Bernoulli
bB  = 9*aB;                     %beta  - Bernoulli

n   = 100;

EP  = aB/(aB+bB);                        %Expected value of loss probability - Bernoulli
VP  = aB*bB/((aB+bB)*(aB+bB)*(aB+bB+1)); %Variance of loss probability - Bernoulli

bP  = ((n-1)*VP-EP*EP)/(EP*n);  %beta  - Poisson
aP  = EP/bP;                    %alpha - Poisson

VL1 = n*(n-1)*VP+n*EP*(1-EP);    %Variance of cumulative loss probability - Bernoulli

VL2 = n*n*aP*bP*bP + n*EP;       %Variance of cumulative loss probability - Poisson

disp('Variance of Cumulative Loss Probability')
disp('Bernoulli Poisson')
disp([VL1  VL2])

CORB = VP/(EP*(1-EP));         %Correlation - Bernoulli
CORP = aP*bP*bP/(aP*bP*bP+EP); %Correlation - Poisson

disp('Default Correlation')
disp('   Bernoulli  Poisson')
disp([CORB,CORP])

%Poisson pdf

h   = 0.01;
lam = 0:h:1;
m   = 100;
k   = 0:m;
L1  = zeros(1,m+1);

fp1 = gampdf(lam,aP,bP);

%Density for the Cumulative Loss Distribution in the Poisson model
for i=1:(m+1)
    L1(i) = sum(poisspdf(k(i),m*lam).*fp1*h); 
end

plot(k,L1,'Linewidth',3,'Color','blue','linestyle','-.')


%Bernoulli pdf

h   = 0.001;
p   = 0:h:0.99;
m   = 100;
k   = 0:m;
L2  = zeros(1,m+1);

fp2 = betapdf(p,aB,bB);

%Density for the Cumulative Loss Distribution in the Bernoulli model
for i=1:(m+1)
    L2(i) = sum(binopdf(k(i),m,p).*fp2*h); 
end

hold on
plot(k,L2,'Linewidth',2.5,'Color','red')
hold off
xlim([60,100])

% improvements of the pictures
figure
semilogy(k,L1,'Linewidth',3,'Color','blue','linestyle','-.')
hold on
semilogy(k,L2,'Linewidth',2.5,'Color','red')
hold off
