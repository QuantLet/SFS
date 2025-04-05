% ---------------------------------------------------------------------
%  Book:        SFS
% ---------------------------------------------------------------------
%  Quantlet:    IBTcrr
% ---------------------------------------------------------------------
%  Description: computes European option prices using a binomial tree for
%      	        assets with no/continuous dividends assuming a constant 
%               implied volatility.
% ---------------------------------------------------------------------
% Usage:        C = IBTcrr(S0, K, r, sig, T, n, flag)
%---------------------------------------------------------------------
% Inputs:       Price of underlying asset, Strike price, Interest rate, 
%               Implied Volatility, Time to expiration, Number of steps
%               in the tree, Flag for Call/Put option
% ---------------------------------------------------------------------
% Output:       Price of an European option.
% --------------------------------------------------------------------- 
% Example:      C = IBTcrr(100, 80, 0.03, 0.1, 1, 4, 1)
%               option flag (1 for call, 0 for put)
%---------------------------------------------------------------------
% Result:       C =
%                      22.3543
%---------------------------------------------------------------------
% Authors:      Wolfgang Haerdle, Ying Chen, Alena Mysickova 20080628
% --------------------------------------------------------------------
function [price] = IBTcrr(s0, k, i, sig, t, n, flag)
type = 1;                 % 0 is American/1 is European
div  = 0;
if s0 <= 0
  disp('IBTcrr: Price of Underlying Asset should be positive! Please input again')
  s0 = input('s0=');
end
  if k < 0
  disp('IBTcrr: Exercise price couldnot be negative! Please input again')
    k = input('k=');
  end
  if sig < 0
  disp('IBTcrr: Volatility should be positive! Please input again')
    sig = input('sig=');
  end
  if t <= 0
  disp('IBTcrr: Time to expiration should be positive! Please input again')
   t = input('t=');
  end
  if n < 1
  disp('IBTcrr: Number of steps should be at least equal to 1! Please input again')
  n = input('n=');
  end
  if (n > 150)	   % Constraint of n, otherwise it will take too much time
  disp('IBTcrr: Could you please choose a smaller n? Please input again')
  n = input('n=');
  end
dt        = t/n;				              % Interval of step
u         = exp(sig.*sqrt(dt));               % Up movement parameter u      
d         = 1./u;                             % Down movement parameter d      
b         = i-div;                            % Costs of carry 
p         = 0.5+0.5*(b-sig^2/2)*sqrt(dt)/sig; % Probability of up movement
s         = ones(n+1,n+1)*s0;
un        = ones(n+1,1)-1;
un(n+1,1) = 1;
dm        = un';
um        = [];
j         = 1;
while j < n+1
    d1 = [ones(1,n-j)-1 (ones(1,j+1)*d).^((1:j+1)-1)];
    dm = [dm; d1];                                       % Down movement dynamics
    u1 = [ones(1,n-j)-1 (ones(1,j+1)*u).^((j:-1:0))];
    um = [um; u1];                                       % Up movement dynamics
	j  = j+1;
end
 um          = [un';um]';
 dm          = dm';
 s           = s(1,1).*um.*dm;                         % Stock price development
 Stock_Price = s;
 s           = flipud(s);                              % Rearangement
  opt        = zeros(size(s));   
 if flag == 1 & type == 0                              % Option is a american call 
  opt(:,n+1) = max(s(:,n+1)-k,0);                      % Determine option values from prices 
  for j = n:-1:1; 
    l = 1:j; 
% Probable option values discounted back one time step 
    discopt = ((1-p)*opt(l,j+1)+p*opt(l+1,j+1))*exp(-b*dt); 
% Option value is max of current price - X or discopt 
    opt(:,j) = [max(s(1:j,j)-k,discopt);zeros(n+1-j,1)];
  end 
    American_Call_Price = flipud(opt);
 elseif flag == 1 & type == 1                          % Option is a european call 
  opt(:,n+1) = max(s(:,n+1)-k,0);                      % Determine option values from prices 
  for j = n:-1:1; 
    l = 1:j; 
% Probable option values discounted back one time step 
    discopt = ((1-p)*opt(l,j+1)+p*opt(l+1,j+1))*exp(-b*dt); 
% Option value
    opt(:,j) = [discopt;zeros(n+1-j,1)];
  end 
    European_Call_Price = flipud(opt);
    %disp(' ') ;
    %disp('The price of the option at time t_0 is')
    price=European_Call_Price(n+1,1);
elseif flag == 0 & type == 0                           % Option is an american put 
  opt(:,n+1) = max(k-s(:,n+1),0);                      % Determine option values from prices 
  for j = n:-1:1 
    l = 1:j; 
% Probable option values discounted back one time step 
    discopt = ((1-p)*opt(l,j+1)+p*opt(l+1,j+1))*exp(-b*dt); 
% Option value is max of X - current price or discopt 
    opt(:,j) = [max(k-s(1:j,j),discopt);zeros(n+1-j,1)];
  end
    American_Put_Price = flipud(opt);
  elseif flag == 0 & type == 1                         % Option is a european put 
  opt(:,n+1) = max(k-s(:,n+1),0);                      % Determine option values from prices 
  for j = n:-1:1 
    l = 1:j; 
% Probable option values discounted back one time step 
    discopt = ((1-p)*opt(l,j+1)+p*opt(l+1,j+1))*exp(-b*dt); 
% Option value 
    opt(:,j) = [discopt;zeros(n+1-j,1)];
    end 
    European_Put_Price = flipud(opt);
    %disp(' ') ;
    %disp('The price of the option at time t_0 is')
    price=European_Put_Price(n+1,1);
 end
