% ------------------------------------------------------------------------------
% Book:        SFS
% ------------------------------------------------------------------------------
% Quantlet:    SFSornstein
% ------------------------------------------------------------------------------
% Description:    To see the intuition of this process, W.L.G. we choose mu = 1; eta = 1:2 and
%                 sigma = 0:3. Figure 5.3 displays the plot. Dark green and blue lines correspond to
%                 different initial values 2 and 0.
% ------------------------------------------------------------------------------
% Usage:       SFSornstein
% ------------------------------------------------------------------------------
% Inputs:      -
% ------------------------------------------------------------------------------
% Output:     Graphic representation of a Ornstein-Uhlenbeck process with 
%             different initial values. 
% ------------------------------------------------------------------------------
% Example:     An example is produced for mu = 1, eta = 1.2 and sigma = 0.3
%                 
% ------------------------------------------------------------------------------
% Author:      Axel Gross-Klussmann
% ------------------------------------------------------------------------------
%
function SFSornstein 
init = [0 0];
t    = (0:2/999:2);
ou1  = ou(init);
hold on;
plot(t,ou1,'b','LineWidth',2.5);

init = [2 0]; 
ou2  = ou(init);
plot(t,ou2,'Color',[0,.4,0],'LineWidth',2.5);
title('Ornstein-Uhlenbeck process');

axlimx = xlim;
line([axlimx(1) axlimx(2)],[1.2 1.2],'LineStyle',':','Color',[0,.4,0],'LineWidth',1.5);


function oup=ou(init);
theta = 1;
mu    = 1.2; 
sigma = 0.3;
 

steps = 1000;
oup   = normrnd(init(1),sqrt(init(2)));
to    = 2;
from  = 0;

for i=1:steps-1
    oup(i+1) = oup(i) + theta*(mu-oup(i))*(to-from)/steps+sigma*normrnd(0,sqrt(sigma^2*(to-from)/steps));
end



                        