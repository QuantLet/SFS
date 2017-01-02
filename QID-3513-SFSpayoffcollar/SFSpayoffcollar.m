% ---------------------------------------------------------------------
% Book:         SFS
% ---------------------------------------------------------------------
% Quantlet:     SFSpayoffcollar
% ---------------------------------------------------------------------
% Description:  Draws a payoff graphic of a collar at the expiration 
%               date.
% ---------------------------------------------------------------------
% Usage:        SFSpayoffcollar
% ---------------------------------------------------------------------
% Inputs:       St - stock price
%               Kp - strike price for long put
%               Kc - strike price for short call
% ---------------------------------------------------------------------
% Output:       plot of collar option
% ---------------------------------------------------------------------
% Example:      an example is produced for the values: St=15,
%               Kp=12.5, Kc=17.5
% ---------------------------------------------------------------------
% Author:       Maria Grith, Vladimir Georgescu
% ---------------------------------------------------------------------

clear
disp('Please input St, Kp, Kc  as: [15,12.5,17.5] or [15 12.5 17.5]') ;
disp(' ') ;
para = input('[St, Kp, Kc]=');

while length(para) < 3
  disp('Not enough input arguments. Please input in 1*3 vector form like [15,12.5,17.5] or [15 12.5 17.5]');
  para = input('[St, Kp, Kc]=');
end

St = para(1);
Kp = para(2);
Kc = para(3);
disp(' ') ;

plot(0:2*St, 0:2*St, 'LineStyle','-.');
line([0,Kp],[Kp, Kp],'color','r', 'Linewidth', 2)
line([Kc, Kp],[Kc, Kp],'Color', 'r', 'LineWidth',2)
line([Kc,2*St],[Kc, Kc],'Color','r','LineWidth', 2)
title('Payoff of a Collar')
xlabel('S_T')
ylabel('Payoff')



    