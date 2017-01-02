% ------------------------------------------------------------------------------
% Book:        SFS
% ------------------------------------------------------------------------------
% Quantlet:    SFSgreeks
% ------------------------------------------------------------------------------
% Description: SFSgreeks calculates the delta, the gamma and the theta of a 
%              portfolio.
%              Refers to exercise 6.8 in SFS.
% ------------------------------------------------------------------------------
% Usage:       -
% ------------------------------------------------------------------------------
% Inputs:      K - Strike price
%              S - Stock price
%              r - Interest rate
%              sigma - Volatility
%              tau1 - Time to maturity to be longed
%              tau2 - Time to maturity to be shorted
% ------------------------------------------------------------------------------
% Output:      The delta, the gamma and the theta of a portfolio.
% ------------------------------------------------------------------------------
% Example:     For [stock price, strike price, interest rate, volatility sigma, 
%              time to maturity]=[220, 220, 0.06, 0.25, 1/2 ], [delta, gamma, 
%              theta] of call to be longed is given [0.6018, 0.0099, -21.827].
%              For [stock price, strike price, interest rate, volatility sigma, 
%              time to maturity]=[220, 220, 0.06, 0.25, 1/4 ], [delta, gamma, 
%              theta] of call to be shorted is given [-0.5724, -0.0143, -28.379].
%              The overall [delta, gamma, theta] of portfolio is given
%              [0.0294, -0.0043, -50.206].
% ------------------------------------------------------------------------------
% Author:      Zografia Anastasiadou, 20110221
% ------------------------------------------------------------------------------

% Clear variables and close windows
clear all;
close all;
clc;

% User inputs

disp('Please input Price of Underlying Asset S, Exercise Price K, Domestic Interest Rate per Year r,');
disp('Volatility per Year sigma, Time to maturity of call to be longed tau1,');
disp('Time to maturity of call to be shorted tau2 as: [220, 220, 0.06, 0.25, 1/2, 1/4]');
disp(' ') ;
para = input('[S, K, r, sigma, tau1, tau2]=');

while length(para) < 6
    disp('Not enough input arguments. Please input in 1*6 vector form like [220, 220, 0.06, 0.25, 1/2, 1/4]');
    disp(' ') ;
    para = input('[S, K, i, sigma, tau1, tau2]=');
end

S     = para(1);             % Stock price
K     = para(2);             % Exercise/Strike price
r     = para(3);             % Rate of interest
sigma = para(4);          	 % Volatility
tau1  = para(5);			 % Time to maturity of call to be longed
tau2  = para(6);             % Time to maturity of call to be shorted

% Main computation
% Call to be longed
y1     = (log(S/K)+(r-sigma^2/2)*tau1)/(sigma*sqrt(tau1));
delta1 = normcdf(y1+sigma*sqrt(tau1));

% Call to be shorted
y2     = (log(S/K)+(r-sigma^2/2)*tau2)/(sigma*sqrt(tau2));
delta2 = -normcdf(y2+sigma*sqrt(tau2));

delta  = delta1 + delta2; %of the portfolio

% Output

disp('[delta1, delta2, delta]');
disp([delta1, delta2, delta]);

% Call to be longed
a1     = normpdf(y1+sigma*sqrt(tau1));
gamma1 = (1/(sigma*S*sqrt(tau1)))*a1;

% Call to be shorted
a2     = normpdf(y2+sigma*sqrt(tau2));
gamma2 = -(1/(sigma*S*sqrt(tau2)))*a2;

gamma = gamma1 + gamma2; % gamma of the portfolio

% Output

disp('[gamma1, gamma2, gamma]');
disp([gamma1, gamma2, gamma]);


% Call to be longed
t1     = -(sigma*S)/(2*sqrt(tau1));
theta1 = (t1*a1)-(r*K*exp(-r*tau1)*normcdf(y1));

% Call to be shorted
t2     = -(sigma*S)/(2*sqrt(tau2));
theta2 = (t2*a2)-(r*K*exp(-r*tau2)*normcdf(y2));

theta  = theta1+theta2; % theta of the portfolio

% Output

disp('[theta1, theta2, theta]');
disp([theta1, theta2, theta]);

% Overall [delta, gamma, theta] of portfolio

disp('[delta, gamma, theta]');
disp([delta, gamma, theta]);
