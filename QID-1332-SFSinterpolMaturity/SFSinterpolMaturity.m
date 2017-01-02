% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFSinterpolMaturity
% ---------------------------------------------------------------------
% Description: SFSinterpolMaturity uses linear interpolation of option
%              prices C1 and C3 and implied volatilities in order to
%              approximate the price of another option C2. All options have
%              the same strike, but vary in maturity with tau1<tau2<tau3.
%              Corresponds to exercise 17.1 in SFS.
% ---------------------------------------------------------------------
% Usage:       -
% ---------------------------------------------------------------------
% Inputs:      mvec   - vector of maturities
%              cvec   - vector of call prices
%              strike - strike price of option
%              irate  - Interest rate
%              DAX    - Closing price of underlying at time t_0.
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
close all

DAX    = 4617.07; %Closing price at time t_0.
strike = 4600; %Strike price
irate  = 0.0210; %Interest rate

mvec =  [ 0.2109 0.4602 0.7095]; %Vector of option maturities
cvec = [ 119.4 194.3 256.9 ];    %Vector of call prices

impvol = blsimpv(DAX,strike,irate,mvec,cvec);

method = 'linear';

IntpInP = [];
IntpInV = [];

i = 2;

% interpolation in prices
interpolatedprice = interp1(mvec([i-1,i+1]),cvec([i-1,i+1]),mvec(i),method);
IntpInP           = [IntpInP interpolatedprice];

% interpolation in volatility
interpvol         = interp1(mvec([i-1,i+1]),impvol([i-1,i+1]),mvec(i),method);
interpolatedprice = blsprice(DAX,strike,irate,mvec(i),interpvol);
IntpInV           = [IntpInV interpolatedprice];

%Deviation from true price
diff = [abs(cvec(i)-IntpInP), abs(cvec(i)-IntpInV)];

disp('Implied volatilities')
disp('      C1        C2        C3')
disp(impvol)

disp('Interpolated volatility for C2')
disp(interpvol)

disp('Interpolated prices')
disp(' by price  by volatility')
disp([IntpInP, IntpInV])

disp('Deviation from true price')
disp('   by price  by volatility')
disp(diff)