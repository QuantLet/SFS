%------------------------------------------------------------------------
% Book:         SFS
% ----------------------------------------------------------------------
% Quantlet:     SFSextrapolationIV
% ----------------------------------------------------------------------
% Description:  Comparison of different extrapolation methods (contant, 
%               linear and quadratic ) used for prices and IVs for calculating opiton price 
%               calculating opiton price 
%------------------------------------------------------------------------
% Usage:        SFSextrapolationIV
%-----------------------------------------------------------------------
% Inputs:       blsprice.m
%-----------------------------------------------------------------------
% Output:       option prices obtained by extrapolating prices and IVs 
%               
% ----------------------------------------------------------------------
% Example:      the example is produced for strikes: 4000, 4100 4200, 4500;
%               call prices 640.6 543.8 448.7 188.5; spot 4617.07; interest
%               rate 0.021; maturity 0.2109 
%------------------------------------------------------------------------
% Author  :     Szymon Borak 20090731
%------------------------------------------------------------------------
%


strikevec = [4000, 4100 4200, 4500];
callvec   = [640.6 543.8 448.7 188.5];
ivvec     = [0.1840 0.1714 0.1595 0.1275];

S0    = 4617.07;
irate = 0.021;
tau   = 0.2109;



%etrapolation in IV
p0 = polyfit(strikevec(2),ivvec(2),0);
p1 = polyfit(strikevec(2:3),ivvec(2:3),1);
p2 = polyfit(strikevec(2:4),ivvec(2:4),2);

v0 = polyval(p0,strikevec(1));
v1 = polyval(p1,strikevec(1));
v2 = polyval(p2,strikevec(1));

call0 = blsprice(S0,strikevec(1),irate,tau,v0,1);
call1 = blsprice(S0,strikevec(1),irate,tau,v1,1);
call2 = blsprice(S0,strikevec(1),irate,tau,v2,1);

'extrapolation in IV'
[ivvec(1), v0, v1, v2]
[callvec(1),call0,call1,call2]


%extrapolation in call prices
p0 = polyfit(strikevec(2),callvec(2),0);
p1 = polyfit(strikevec(2:3),callvec(2:3),1);
p2 = polyfit(strikevec(2:4),callvec(2:4),2);

c0 = polyval(p0,strikevec(1));
c1 = polyval(p1,strikevec(1));
c2 = polyval(p2,strikevec(1));


'extrapolation in prices'
[callvec(1),c0,c1,c2]



