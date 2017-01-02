% ---------------------------------------------------------------------
% Book:         SFS
% ---------------------------------------------------------------------
% Quantlet:     IBTimpliedvola
% ---------------------------------------------------------------------
% Description:  compute the implied volatility as an interpolation of the 
%               real data (func = 1) or as a convex function of
%               moneyness (else).
% ---------------------------------------------------------------------
% Usage:        iv = IBTimpliedvola(S, K, T, func)
%----------------------------------------------------------------------
% Inputs:       Stoc Price, Strike price, Time to maturity
%               Type of function 
% ---------------------------------------------------------------------
% Output:       Implied volatility
%----------------------------------------------------------------------
% Example:
%               IV = IBTimpliedvola(99, 100, [], [])
% ---------------------------------------------------------------------
% Result:       Output is the value of the implied volatility defined
%               by the parabola.
%
%               IV =
%                      0.1000
% ---------------------------------------------------------------------
% Reference:	Semiparametric Modeling of Implied Volatility, 
%               M. R. Fengler, 2005
% ---------------------------------------------------------------------
% Author:       Matthias Fengler, Wolfgang Haerdle, Alena Mysickova 
% ---------------------------------------------------------------------
function[iv] = IBTimpliedvola(S, K, T, func)
  if size(S) ~= size(K)
      error('impliedvola: S and K must have the same size')
  end
  if func == 1 % Interpolated for the real data, see XFGIBT05: EurexVolatilities_rawData19
        global X Y Z
        if (K <= 6630)
              iv = interp2(X,Y,Z,6630,T,'spline');
        else
              if (K >= 6675)
                     iv = interp2(X,Y,Z,6675,T,'spline');
              else
                     iv = interp2(X,Y,Z,K,T,'spline');
              end
        end
  else          % Parabola   
        X  = S./K;          
        iv = (-0.2./(log(X).^2+1))+0.3;              % M.Fengler (3.78) page 82
  end
