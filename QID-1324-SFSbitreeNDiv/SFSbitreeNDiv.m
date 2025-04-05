% ---------------------------------------------------------------------
% Book:         SFS
% ---------------------------------------------------------------------
% Quantlet:     SFSbitreeNDiv
% ---------------------------------------------------------------------
% Description:  SFSbitreeNDiv computes European/American option prices
%               using a binomial tree for assets without dividends.
% ---------------------------------------------------------------------
% Usage:        SFSbitreeNDiv
% ---------------------------------------------------------------------
% Inputs:       S0 - Stock price
%               k - Exercise price
%               i - Interest rate
%               t - Time to expiration
%               n - Number of intervals
%               type - 0 is American/1 is European
%               flag - 1 is call/0 is put
%               u - Upper proportion
%               d - Downward proportion
% ---------------------------------------------------------------------
% Output:      Binomial trees and price of option
% ---------------------------------------------------------------------
% Example:     Refer to exercise 8.6 in SFS
% ---------------------------------------------------------------------
% Author:      Weining Wang 20090416
% ---------------------------------------------------------------------
%

clear
clc

t    = 2;     % time
n    = 10;    % step
u    = 1.1;   % upper proportion
d    = 0.9;   % downward proportion
S0   = 50;    % initial price
type = 0;     % 0 for American , 1 for European
k    = 50;    % strike price
i    = 0.05;  % interest rate
flag = 1;     % 0 for put, 1 for call
b    = i;     % Costs of carry

%% Main Computation

dt        = t/n;                % Interval of step
p         = (exp(b)-d)/(u-d);   % Pseudo probability of up movement

un        = zeros(n+1,1);
un(n+1,1) = 1;
dm        = un';
um        = [];
j         = 1;

while j < n+1
    d1 = [zeros(1,n-j) (ones(1,j+1)*d).^((1:j+1)-1)];
    dm = [dm; d1];                                       % Down movement dynamics
    u1 = [zeros(1,n-j) (ones(1,j+1)*u).^((j:-1:0))];
    um = [um; u1];                                       % Up movement dynamics
    j  = j+1;
end

um          = [un';um]';
dm          = dm';

s           = S0.*um.*dm;                                % Stock price development

Stock_Price = s
s           = flipud(s);                                 % Rearangement
opt         = zeros(size(s));

if flag == 1 & type == 0 % Option is a American call
    opt(:,n+1) = max(s(:,end)-k,0);  % Determine option values from prices
    for j = n:-1:1;
        l = 1:j;
        % Probable option values discounted back one time step
        discopt = ((1-p)*opt(l,j+1)+p*opt(l+1,j+1))*exp(-b*dt);
        % Option value is max of current stock price - strike or discopt
        opt(:,j) = [max(s(1:j,j)-k,discopt);zeros(n+1-j,1)];
    end
    American_Call_Price = flipud(opt)
    disp(' ') ;
    disp('The price of the American call option at time t_0 is')
    disp(American_Call_Price(n+1,1))
    

elseif flag == 1 & type == 1 % Option is a European call
    opt(:,n+1) = max(s(:,n+1)-k,0);  % Determine option values from prices
    for j = n:-1:1;
        l = 1:j;
        % Probable option values discounted back one time step
        discopt = ((1-p)*opt(l,j+1)+p*opt(l+1,j+1))*exp(-b*dt);
        % Option value
        opt(:,j) = [discopt;zeros(n+1-j,1)];
    end
    European_Call_Price = flipud(opt)
    disp(' ') ;
    disp('The price of the European call option at time t_0 is')
    disp(European_Call_Price(n+1,1))
     

elseif flag == 0 & typ == 0 % Option is an American put                              
    opt(:,n+1) = max(k-s(:,n+1),0);  % Determine option values from prices
    for j = n:-1:1
        l = 1:j;
        % Probable option values discounted back one time step
        discopt = ((1-p)*opt(l,j+1)+p*opt(l+1,j+1))*exp(-b*dt);
        % Option value is max of X - current price or discopt
        opt(:,j) = [max(k-s(1:j,j),discopt);zeros(n+1-j,1)];
        find(max(k-s(1:j,j),0)>discopt);
    end
    American_Put_Price = flipud(opt)
    disp(' ') ;
    disp('The price of the American put option at time t_0 is')
    disp(American_Put_Price(n+1,1))    
    

elseif flag == 0 & type == 1 % Option is a European put                           
    opt(:,n+1) = max(k-s(:,n+1),0);  % Determine option values from prices
    for j = n:-1:1
        l = 1:j;
        % Probable option values discounted back one time step
        discopt = ((1-p)*opt(l,j+1)+p*opt(l+1,j+1))*exp(-b*dt);
        % Option value
        opt(:,j) = [discopt;zeros(n+1-j,1)];
    end
    European_Put_Price = flipud(opt)
    disp(' ') ;
    disp('The price of the European put option at time t_0 is')
    disp(European_Put_Price(n+1,1))
    
end


