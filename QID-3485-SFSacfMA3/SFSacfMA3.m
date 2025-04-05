%--------------------------------------------------------------------------
% Book:         SFS
% -------------------------------------------------------------------------
% Quantlet:     SFSacfMA3
% -------------------------------------------------------------------------
% Description:  autocorrelations of simulated MA(3) process
%               
%--------------------------------------------------------------------------
% Usage:        -
%--------------------------------------------------------------------------
% Inputs:       None
%--------------------------------------------------------------------------
% Output:       Plots of the autocorrelations
% -------------------------------------------------------------------------
% Example:      The example is produced for the random sample of 1000 
%               simulations
%--------------------------------------------------------------------------
% Author  :     Maria Osipenko 
%--------------------------------------------------------------------------

randn('state', 0)             % Start from a known state.
x = randn(1000, 1);           % 1000 Gaussian deviates ~ N(0, 1).
y = filter([1 -1 1], 1, x);   % Create an MA(3) process.

% Compute the ACF with 95 percent confidence.
[ACF, Lags, Bounds] = autocorr(y, [], 2);  
[Lags, ACF]

autocorr(y, [], 2) 

