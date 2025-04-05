% ------------------------------------------------------------------------------
% Book:        SFS
% ------------------------------------------------------------------------------
% Quantlet:    SFSdeltahedging
% ------------------------------------------------------------------------------
% Description: SFSdeltahedging calculates produces a table of the costs of hedging.
%              Refers to exercise 6.4 in SFS.
% ------------------------------------------------------------------------------
% Usage:       -
% ------------------------------------------------------------------------------
% Inputs:      -
% ------------------------------------------------------------------------------
% Output:      Table of costs of hedging.
% ------------------------------------------------------------------------------
% Example:     -
% ------------------------------------------------------------------------------
% Author:      Awdesch Melzer 20120920
% ------------------------------------------------------------------------------

% clear variabels and close windows
clear all
close all
clc

stockprices = [49,49.75,52,50.1,48.375,48.25,48.75,49.625,48.25,48.25,51.125,51.50,49.875,49.875,48.75,47.50,48.00,46.25,48.12,46.62,48.12]';

weeks       = [22:-1:0]';    % numer of weeks
tau         = weeks/52;      % time to maturity
K           = 50;            % strike price
r           = 0.05;          % interest rate
sigma       = 0.20;          % volatility
S           = [0;0;stockprices];

y           = ( log(S./K) + ((r-((sigma.^2)./2))).*tau )./(sigma .* sqrt(tau));
y

x           = y + sigma*sqrt(tau);
x

Delta       = normcdf(x);

% generate dummy time vector
time = [-1:20]';

% Hedging takes place if element changes from 0 to 1 or vice versa
% from 0 to 1 purchase
Hedge_strat = (diff(Delta)>0);
Hedge_strat

purch       = (Hedge_strat==1)*100000;
sell        = (Hedge_strat==0)*(-100000);

% Shares purchased
Shares_purchased = purch.*(diff(Delta));

% Shares sold
Shares_sold = sell.*(diff(Delta));

% Total shares
cumushares = zeros(23,1);
for (i = 2:(length(S(2:23))))
cumushares(i) = cumushares(i-1) + Shares_purchased(i) - Shares_sold(i);
end

S(1) = [];
% Cost of shares, multiply number of shares (bought) with corresponding price
Cost_shares = Shares_purchased.*S;

% Revenue of shares, multiply number of shares (sold) with corresponding price
Revenue_shares = Shares_sold.*S;


% Cumulative Costs
cumucosts = 0;
for (i = 2:(length(Cost_shares)))
     	cumucosts(i) = cumucosts(i-1) + Cost_shares(i) - Revenue_shares(i);
end
cumucosts = cumucosts';


% Table of costs
table = [time, S, Delta(2:23),cumushares(1:22), Cost_shares, Revenue_shares, cumucosts];
table(1,:) = [];
format shortE
disp('Table of costs of hedging')
disp('         Time    St.Price    DeltaHedging  SharePurch  ShareCost  RevenueShare  CumulCosts')
table

