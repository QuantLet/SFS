% ---------------------------------------------------------------------
% Book:         SFS
% ---------------------------------------------------------------------
% Quantlet:     SFShullhedgeratio
% ---------------------------------------------------------------------
% Description:  Stopp loss and cost of hedging. Refers to exercise 6.2 in 
% SFS.
% ---------------------------------------------------------------------
% Usage:        -
% ---------------------------------------------------------------------
% Inputs:       St - stock price
%               Kp - strike price for long put
%               Kc - strike price for short call
% ---------------------------------------------------------------------
% Output:       BS price of the call and the cost of hedging 
% ---------------------------------------------------------------------
% Example:      an example is produced for the values:
%               K=50, R share=100000, volatility=0.2, r=5%
% ---------------------------------------------------------------------
% Author:       Brenda López Cabrera
% Date 20100202
% ---------------------------------------------------------------------

clear
clc

CallPutFlag = 'c';       % Option as call or as a put
S0          = 49;        % Starting price
T           = 20/52;     % Time to maturity
sigma       = 0.2;       % Volatility
mu          = 0.13;      % Drift
r           = 0.05;      % Interest rate
K           = 50;        % Strikeprice
NSteps      = 2000;      % Number of steps
NRepl       = 500;       % Number of replications
task        = 1          % 1 Call, 2Put
NumObs      = [4,5,10,20,50,100];

%Calculate the BS Price of the call
Call = blsprice(S0, K, r, sigma, T);



%% Simulate the paths for the underlying stock

St        = zeros(NRepl, 1+NSteps);
St(:,1)   = S0;                  %All paths start with S0
dt        = T/NSteps;            %Discretize the time to maturity into discrete time steps corresponding to NSteps in T
drift     = (mu-0.5*sigma^2)*dt; %Calculate the drift rate
diffusion = sigma*sqrt(dt);      %Calculate the diffusion process rate


for i=1:NRepl
    for j=1:NSteps
        St(i,j+1) = St(i,j)*exp(drift + diffusion*randn);
    end
end

%% Calculate the hedging cost at the specified observation times

%Determine size of time steps for the observations
ObsDensity = NSteps./NumObs;

%Determine the discount factors for all t =0,1,2,...,1000
DiscountFactors = exp(-r*(0:1:NSteps)*dt);
%DiscountFactors=zeros(1,1001)+1;

Cost = zeros(NRepl,size(NumObs,2));

for m=1:size(ObsDensity,2)
    for k=1:NRepl

        CashFlows = zeros(NSteps+1,1);

        if St(k,1) >= K
            Covered      = 1;
            CashFlows(1) = -St(k,1);
        else
            Covered = 0;
        end

        for t=1:ObsDensity(m):NSteps+1
            if (Covered == 1) && (St(k,t) < K)
                % Sell
                Covered      = 0;
                CashFlows(t) = St(k,t);
            elseif (Covered == 0) && (St(k,t) > K)
                % Buy
                Covered      = 1;
                CashFlows(t) = -St(k,t);
            end
        end

        if St(k,NSteps + 1) >= K
            % Option is exercised
            CashFlows(NSteps + 1) = CashFlows(NSteps + 1) + K;
        end

        Cost(k,m) = -dot(DiscountFactors, CashFlows);

    end
        V      = var(Cost);
        
        L(m,:) = sqrt(V)/Call;
    
    
end
disp('Performance measure L:');
X = mean(L)

