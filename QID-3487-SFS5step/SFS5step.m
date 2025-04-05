%--------------------------------------------------------------------------
% Book:         SFS
% -------------------------------------------------------------------------
% Quantlet:     SFS5step
% -------------------------------------------------------------------------
% Description:  SFS5step gives the probabilities for 5 states of a 
%               state-dependent binomial process 
%--------------------------------------------------------------------------
% Usage:        -
%--------------------------------------------------------------------------
% Inputs:       none
%--------------------------------------------------------------------------
% Output:       table of probabilities
%                
% -------------------------------------------------------------------------
% Example:      
%--------------------------------------------------------------------------
% Author  :     Axel Groß-Klußmann
%--------------------------------------------------------------------------

clear
clc
T = 5;
P = zeros(2*T+2,T);

% first column of probability matrix
P0 = zeros(2*T+1,1); P0(T+1,1)=1;

for t = 1:T
    if t == 1 % initialize for t=1
       P(T+1+1,1) = 1/2; 
       P(T+1-1,1) = 1/2; 
    end
    
    if t > 1
        if mod(t,2) ~= 0 % time variable odd 
            for i=1:2:t
                % the probability rule
                P(T+1+i,t) = (i==0)*(P(T+1+i-1,t-1)~=0)*(1-1/(2^(abs(i+1)+1)))*P(T+1+i-1,t-1)+...
                    (i~=0)*(P(T+1+i-1,t-1)~=0)*(1/(2^(abs(i-1)+1)))*P(T+1+i-1,t-1)+(P(T+1+i+1,t-1)~=0)*(1-1/2^(abs(i+1)+1))*P(T+1+i+1,t-1);
                P(T+1-i,t) = P(T+1+i,t);           
            end
        end

        if mod(t,2) == 0 % time variable even 
            for i=0:2:t
                % the probability rule
                P(T+1+i,t) = (i==0)*(P(T+1+i-1,t-1)~=0)*(1-1/(2^(abs(i+1)+1)))*P(T+1+i-1,t-1)+...
                    (i~=0)*(P(T+1+i-1,t-1)~=0)*(1/(2^(abs(i-1)+1)))*P(T+1+i-1,t-1)+(P(T+1+i+1,t-1)~=0)*(1-1/2^(abs(i+1)+1))*P(T+1+i+1,t-1);
                P(T+1-i,t) = P(T+1+i,t); 
            end
        end
    end
end

% show the table
disp('  States ::       Probabilities');
dist=[[(5:-1:0)'; (-1:-1:-5)'] P0 P(1:end-1,:)];
disp(dist);
disp('Distribution of state-dependent binomial process after first 5 steps');