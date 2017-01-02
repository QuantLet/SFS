% -----------------------------------------------------------------------------------
%  EBook  	      SFS
% -------------------------------------------------------------------------------------
%  Matlet         IBTblackscholes
% --------------------------------------------------------------------------------------
%  Description    calculates option prices 
%                 using the Black and Scholes formula for no dividend European options
%------------------------------------------------------------------------------------------
% Usage		opc = BlackScholes(S, K, r, sigma, tau, task)
% Input
%	Parameter   S
%	Definition  scalar: the current value of the index
%			
%	Parameter   K
%	Definition  scalar: exercise price
%	Parameter   r
%	Definition  scalar: riskless interest rate
%	Parameter   sigma	
%	Definition  scalar: Black Scholes implied volatility of the European option
%			
%	Parameter   tau
%	Definition  scalar: time to expiration (by year)
%		
%	Parameter   task
%	Definition  scalar: if task=1, calculate the call option price%
%			    if task=0, calculate the put option price
%			    if task="call" "Call" or "CALL", calculate the call option price%
%			    if task="put" "PUT" or "Put" , calculate the put option price
%
%  Output	    
%	Parameter   opc
%	Definition  scalar: call option price or put option price
%-----------------------------------------------------------------------------------------------
% Example	library("finance")
%		S=100
%		r=0.03
%		K=100
%		tau=1
%		sigma=0.1
%		task=1
%		C=BlackScholes(S, K, r, sigma, tau,task)
%		C
%-------------------------------------------------------------------------------------------------------
% Result	Output is the one year's call option price :
% 
%		Contents of C
%
%		[1,]   5.582
%
%--------------------------------------------------------------------------------------------------------
% Reference	Options, Futures and Other Derivative Securities (1993), J. Hull, Prentice-Hall
%--------------------------------------------------------------------------------------------------------
% Author	J. Zheng, W. Haerdle, 20010602 
%             license MD*Tech
%--------------------------------------------------------------------------------------------------------
% updated by SB 20031215 (vectrors input enabled)
function [opv] = IBTblackscholes(S, K, r, sigma, tau, flag)
  if S <= 0
    disp('BlackScholes: price needs to be larger than 0');
    S = input('S =');
  end
  if K <= 0
      disp('BlackScholes: strike price needs to be larger than 0');
      K = input('K=');
  end
  if(flag ~= 0) && (flag ~= 1)
      disp('BlackScholes: task needs to be either 1 or 0');
      flag = input('flag=');
  end
%error(((r <= 0)||(r >= 1)),"BlackScholes: interest rate needs to be between 0 and 1")
  if r < 0
      disp('BlackScholes: interest rate can not be negative');
      input('r=');
  end
  if(sigma) <= 0
      disp('BlackScholes: volatility needs to be larger than 0');
      input('sigma=');
  end
  if (tau) < 0
      disp('BlackScholes: time to expiration can not be negative');
      input('tau=');
  end

  %%%%%%%%%%%%%%%%%%Black-Scholes formula  
 
  
  t = (tau == 0); %check if it is the expire day   							
  y = (log(S./K)+(r-sigma^2/2).*tau)./(sigma.*sqrt(tau)+t);

  if (flag == 1)
    opv = S.*(normcdf(y+sigma.*sqrt(tau),0,1).*(~t)+t)-K.*exp(-r.*tau).*(normcdf(y,0,1).*(~t)+t);
  end 
  if (flag == 0)
    opv = K.*exp(-r.*tau).*(normcdf(-y,0,1).*(~t)+t)-S.*(normcdf(-y-sigma*sqrt(tau),0,1).*(~t)+t);
  end

  opv = (opv > 0).*opv;
  %opv=reshape(opv,dimension)    
