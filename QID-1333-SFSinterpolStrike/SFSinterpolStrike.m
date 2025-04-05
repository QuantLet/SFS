% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFSinterpolStrike
% ---------------------------------------------------------------------
% Description: SFSinterpolStrike uses linear interpolation of option
%              prices C1 and C3 and implied volatilities in order to
%              approximate the price of another option C2. All options have
%              the same maturity, but vary in strike with K1<K2<K3.
%              Corresponds to exercise 17.2 in SFS.
% ---------------------------------------------------------------------
% Usage:       -
% ---------------------------------------------------------------------
% Inputs:      svec  - vector of strike prices
%              cvec  - vector of call prices
%              tau   - Time to maturity
%              irate - Interest rate
%              DAX   - Closing price of underlying at time t_0.
% ---------------------------------------------------------------------
% Output:     impvol    - implied volatilities
%             interpvol - interpolated volatility
%             IntpInP   - interpolated price by prices
%             IntpInV   - interpolated price by volatility
%             diff      - Deviation from true price
% ---------------------------------------------------------------------
% Example:    -
% ---------------------------------------------------------------------
% Author:     Szymon Borak 20090731
% ---------------------------------------------------------------------

clear
clc

tau   = 0.2109;                   %Time to maturity
DAX   = 4617.07;                  %Closing price at time t_0.
irate = 0.021;                  %Interest rate

svec  = [4000, 4200, 4500]; %Vector of option strikes
cvec  = [640.6 448.7 188.5]; %Vector of option prices

%implied volatilities
impvol = blsimpv(DAX,svec,irate,tau,cvec);


method = 'linear';

IntpInP = [];
IntpInV = [];

i = 2;

% interpolation in prices
interpolatedprice = interp1(svec([1,end]),cvec([1,end]),svec(i),method);
IntpInP           = [IntpInP interpolatedprice];

% interpolation in vola
interpvol         = interp1(svec([1,end]),impvol([1,end]),svec(i),method);
interpolatedprice = blsprice(DAX,svec(i),irate,tau,interpvol,0);
IntpInV           = [IntpInV interpolatedprice];

%Deviation from true price
diff = [abs(cvec(i)-IntpInP), abs(cvec(i)-IntpInV)];


disp('Implied volatilities')
disp('      C1        C2        C3')
disp(impvol)

disp('Interpolated volatility for C2')
disp(interpvol)

disp('Interpolated prices')
disp('  by price  by volatility')
disp([IntpInP, IntpInV])

disp('Deviation from true price')
disp('   by price  by volatility')
disp(diff)