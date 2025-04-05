% ---------------------------------------------------------------------
% Book:         SFS
% ---------------------------------------------------------------------
% Quantlet:     SFSIBTbc
% ---------------------------------------------------------------------
% Description:  starting program to calculate the stock price on the 
%               nodes in the implied tree, the transition probability tree,
%		        the Arrow-Debreu tree and local volatility using 
%               Barle and Cakici's method.
% ---------------------------------------------------------------------
% Usage:        [S,AD,p,LV] = SFSIBTbc(S0, r, t, n, func)
%----------------------------------------------------------------------
% Inputs:       Price of underlying asset, Interest rate, Time to
%               expiration, Number of steps, Type of function for implied
%               volatility
% ---------------------------------------------------------------------
% Output:       Implied binomial trees of stock prices, transition
%               probabilities and Arrow-Debreu prices
% ---------------------------------------------------------------------
% Example:     
%               [S,AD,p,LV] = SFSIBTbc(100, 0.05, 3, 3, 2)
%               Stree = IBTresort(S)                     
%               ADtree = IBTresort(AD)
%               Ptree = IBTresort(p)
%               LVtree = IBTresort(LV)
%----------------------------------------------------------------------               
% Result:       Output is an implied binomial tree for the price process
%               of the underlying, a tree of transition probabilities, a
%               tree of Arrow-Debreu prices and a local volatility tree.
% 
% Stree =
%
%         0         0         0  152.8083
%         0         0  129.7438         0
%         0  113.9051         0  130.1637
%  100.0000         0  110.5171         0
%         0   97.0256         0  103.7047
%         0         0   89.0555         0
%         0         0         0   85.2037

%
% ADtree =
%
%         0         0         0    0.0546
%         0         0    0.2084         0
%         0    0.4566         0    0.3724
%    1.0000         0    0.5097         0
%         0    0.4947         0    0.3370
%         0         0    0.1867         0
%         0         0         0    0.0968
%
% Ptree =
%
%         0         0    0.2752
%         0    0.4800         0
%    0.4800         0    0.4716
%         0    0.6032         0
%         0         0    0.4550
%
% LVtree =
%
%         0         0    0.0716
%         0    0.0801         0
%    0.0801         0    0.1134
%         0    0.1056         0
%         0         0    0.0979
%
%----------------------------------------------------------------------
% Reference:	How to Grow a Smiling Tree, 
%               S. Barle and N.Cakici, 1998
% ---------------------------------------------------------------------
% Author:      Wolfgang Haerdle, Jun Zheng, Alena Mysickova 
% ---------------------------------------------------------------------
function [Smat,ADmat,pmat,LVmat] = SFSIBTbc(s0, r, t, n, func);
%format long
if s0 <= 0
  disp('SFSIBTbc: Price of Underlying Asset should be positive! Please input again')
  s0 = input('s0=');
end
if (r < 0 || r > 1)
  disp('SFSIBTbc: Interest rate need to be between 0 and 1! Please input again')
    sig = input('r=');
end
if t <= 0
  disp('SFSIBTbc: Time to expiration should be positive! Please input again')
   t = input('t=');
end
if n < 1
  disp('SFSIBTbc: Number of steps should be at least equal to 1! Please input again')
  n = input('n=');
end
if (n > 150)	   % Constraint of n, otherwise it will take too much time
  disp('SFSIBTbc: Could you please choose a smaller n? Please input again')
  n = input('n=');
end
dt         = t/n;
Smat       = zeros(n+1,n+1);  % Stock price at nodes
Smat(1,1)  = s0;              % First node equals the underlying price
ADmat      = zeros(n+1,n+1);  % Arrow-Debreu prices
ADmat(1,1) = 1;               % First Arrow-Debreu price equals 1
pmat       = zeros(n,n);      % Transition probabilites
infl       =  exp(r*dt);
for i=1:n;
    %******   Step 1 : Find central nodes of stock tree *************************
	if mod(i,2) == 0;       %(i+1) is odd
        mi = (i/2+1);
		Smat(mi,i+1) = s0*exp(r*dt*i);    %center point price set to spot
        if (Smat(mi,i+1) < infl*Smat(mi-1,i)|| Smat(mi,i+1) > infl*Smat(mi,i))
            Smat(mi,i+1) = infl*(Smat(mi-1,i)+Smat(mi,i))/2;
        end
		lnode  = mi;
        llnode = mi;
    else                    % (i+1) is even 
		%%%%%% find the upper and the lower node 
		mi            = round((i+1)/2);
		Call_Put_Flag = 1;               % 1 for call/0 for put
		S             = Smat(mi,i);      % S_n^i
        F             = infl*S;          % F_n^i    
        sigma         = IBTimpliedvola(s0,F,i*dt,func);                   % func=1 for interpolation, else a parabola
        C             = IBTblackscholes(s0,F,r,sigma,i*dt,Call_Put_Flag); % Call price from BS model
		rho_u         = 0;
		if (mi+1 )<= i;
           rho_u = sum(ADmat(mi+1:i,i).*(infl*Smat(mi+1:i,i)-F));
        end
        Sl = F*(ADmat(mi,i)*F-infl*C+rho_u)/(ADmat(mi,i)*F+infl*C-rho_u);   % Lower node
        Su = F^2/Sl ;                                                       % Upper node
    %%%%%%% Compensation %%%%%%%%
        if (Su < F || Sl>F)
            Su = sqrt(F^3/Smat(mi-1,i));
            Sl = F^2/Su;
        end    
        if (mi < i) && (mi > 1);
            if (Su > infl*Smat(mi+1,i)||Sl < infl*Smat(mi-1,i));
                Su = sqrt(F^3/Smat(mi-1,i));
                Sl = F^2/Su;
            end
            if (Su > infl*Smat(mi+1,i)||Su < infl*S);
                Su = infl*(S+Smat(mi+1,i))/2;
            end
            if (Sl > infl*S||Sl<infl*Smat(mi-1,i));
                Sl = infl*(S+Smat(mi-1,i))/2;
            end
         end
       Smat(mi+1,i+1) = Su;
       Smat(mi,i+1)   = Sl;
        lnode         = mi+1;
        llnode        = mi;	
    end
	%******   Step 2 : Find upper nodes of stock tree *************************
	for j = (lnode+1):1:(i+1);
		Call_Put_Flag = 1;            % Call price
		S             = Smat(j-1,i);  % S_n^i, i=j-1, i^1 = j
        F             = infl*S;       % F_n^i   
		sigma         = IBTimpliedvola(s0,F,i*dt,func);                   % func=1 for interpolation, else a parabola
        C             = IBTblackscholes(s0,F,r,sigma,i*dt,Call_Put_Flag); % Call price from BS model
		rho_u         = 0;
		if j <= i
            rho_u = sum(ADmat(j:i,i).*(infl*Smat(j:i,i)-F));
        end
        dc = C*infl-rho_u;
		Su = (Smat(j-1,i+1)*(dc)-ADmat(j-1,i)*F*(F-Smat(j-1,i+1)))/(dc-ADmat(j-1,i)*(F-Smat(j-1,i+1))); % Upper node
        %%%% Compensation %%%%%%%
        if j <= i
           if (Su > infl*Smat(j,i) || Su < infl*S); 
               Su = infl*(Smat(j,i)+S)/2;
           end
        else
            if Su > S*exp(2*sigma*sqrt(dt))|| Su < F;
                Su = S*Smat(j-1,i+1)/Smat(j-2,i);
            end
        end    
       Smat(j,i+1) = Su; 
	end	
	%******   Step 3 : Find lower nodes of stock tree (EQ 9) *************************
	for j=(llnode-1):-1:1
		Call_Put_Flag = 0;            % Put price
		S             = Smat(j,i);    % S_n^i
        F             = S*infl;       % F_n^i
		sigma         = IBTimpliedvola(s0,F,i*dt,func);                   % func=1 for interpolation, else a parabola
        P             = IBTblackscholes(s0,F,r,sigma,i*dt,Call_Put_Flag); % Put price from BS model
		if j > 1
            rho_l = sum(ADmat(1:j-1,i).*(F-infl*Smat(1:j-1,i)));    
        else
            rho_l = 0;
        end
		dc = infl*P-rho_l;
        Sl = (ADmat(j,i)*F*(Smat(j+1,i+1)-F)-dc*Smat(j+1,i+1))/(ADmat(j,i)*(Smat(j+1,i+1)-F)-dc);   % Lower node
		%%%%%% Compensation %%%%%%%%%
        if (j > 1)
            if (Sl < infl* Smat(j-1,i) || Sl > infl * S);
                Sl = infl* (Smat(j-1,i)+S)/2;
            end
        else
            if(Sl > infl*S || Sl < S*exp(-2*sigma*sqrt(dt)));
                Sl = S* Smat(j+1,i+1)/Smat(j+1,i);
            end
        end
        Smat(j,i+1) = Sl;
	end	
	%******   Step 4 : Find nodes of probability and Arrow Debreu tree *************************
	%%%%%%%% Transition probabilities %%%%
    pmat(1,1) = (infl*Smat(1,1)-Smat(1,2))/(Smat(2,2)-Smat(1,2));
    if i > 1
       pmat(1:i,i) = (infl.*Smat(1:i,i)-Smat(1:i,i+1))./(Smat(2:i+1,i+1)-Smat(1:i,i+1));
    end
    %%%%%%% Arrow-Debreu Prices %%%%%
    ADmat(1,i+1) = ADmat(1,i)*(1-pmat(1,i))./infl;    % lambda_{n+1}^{0}
    if i>1
        ADmat(2:i,i+1) = (ADmat(2:i,i).*(1-pmat(2:i,i))+ADmat(1:i-1,i).*pmat(1:i-1,i))./infl;
    end
    ADmat(i+1,i+1) = ADmat(i,i)*pmat(i,i)./infl;  % lambda_{n+1}^{n+1}
end
%******   Step 5 : Find nodes of implied local volatility tree *************************
LVmat = zeros(n,n);
for i=1:n,
	LVmat(1:i,i) = log(Smat(2:i+1,i+1)./Smat(1:i,i+1)).*(pmat(1:i,i).*(1-pmat(1:i,i))).^0.5;
end
