% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFScontourgumbel
% ---------------------------------------------------------------------
% Description: SFScontourgumbel produces a contour plot of the Gumbel
%              copula density
% ---------------------------------------------------------------------
% Usage:       SFScontourgumbel
% ---------------------------------------------------------------------
% Inputs:      p - theta
% ---------------------------------------------------------------------
% Output:      Contour plot of the Gumbel copula density
% ---------------------------------------------------------------------
% Example:     An example is produced for p = 2.
% ---------------------------------------------------------------------
% Author:      Barbara Choros 
% ---------------------------------------------------------------------

clc;
close all;

[u,v] = meshgrid(0.001:0.01:1);
p     = 2;

arg     = (-log(u)).^p+(-log(v)).^p;
gcopuly = exp(-arg.^(1/p))./u./v.*(log(u).*log(v)).^(p-1).*...
          arg.^(1/p-2).*(p-1+arg.^(1/p));

grid on

contour(u,v,gcopuly,150)

xlabel('X');
ylabel('Y');
title('Contour Plot of the Gumbel Copula Density, \theta=2')
