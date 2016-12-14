%------------------------------------------------------------------------
% Book:         SFS
% ----------------------------------------------------------------------
% Quantlet:     SFSbb
% ----------------------------------------------------------------------
% Description:  A sample path of Brownian Bridge
%------------------------------------------------------------------------
% Usage:        SFSbb
%-----------------------------------------------------------------------
% Inputs:       none
%-----------------------------------------------------------------------
% Output:       a plot of a sample path
%               
% ----------------------------------------------------------------------
% Example:      the example of a sample path
%------------------------------------------------------------------------
% Author  :     Weining Wang
%------------------------------------------------------------------------

clear all;
close all;
clc;

%%Brownian Bridge
% main calculation
dt = 0.004;
n  = 250;
l  = 1;
t  = 0:dt:n*dt; 

%randseed(0);
z      = unifrnd(0,1,n,1);
z      = 2*(z>0.5)-1;
z      = z*sqrt(dt);  %//to get finite and non-zero varinace
z2     = dt*sum(z);
z      = z-z2;
x      = [0;cumsum(z)];
listik = [t',x];

% output
plot(listik(:,1),listik(:,2))

%title('Wiener process')
xlabel('Time')
ylabel('Values of process X_t')