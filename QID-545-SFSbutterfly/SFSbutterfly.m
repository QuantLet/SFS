% ---------------------------------------------------------------------
% Book:        SFS
% ---------------------------------------------------------------------
% Quantlet:    SFSbutterfly
% ---------------------------------------------------------------------
% Description: SFSbutterfly plots a butterfly option strategy either
%              produced with call or put options. The combination of
%              two long puts/calls with strike prices of K1 and K3
%              and two shorted puts/calls with strike price
%              K2=0.5*(K1+K3).
%              Values can be entered interactively. Refers to exercise
%              1.6 and 1.7 in SFS.
% ---------------------------------------------------------------------
% Usage:       SFSbutterfly
% ---------------------------------------------------------------------
% Inputs:      St    - Stock price
%              K1    - Exercise price put/call 1
%              K3    - Exercise price put/call 3
%              r     - Interest rate
%              T     - Time to expiration
%              sigma - Volatility
%              flag  - 1 for calls, 0 for puts
% ---------------------------------------------------------------------
% Output:      Plot of a butterfly option strategy using puts or calls
% ---------------------------------------------------------------------
% Example:     An example is produced for the values: St=10, K1=13,
%              K3=21, T=3, sigma = 0.5, r=0.03, flag = 0.
% ---------------------------------------------------------------------
% Author:      Lasse Groth 20090710
% ---------------------------------------------------------------------

clear
clc
close all

disp('Please input St, K1, K3, T, sigma, r, flag  as: [10,13,21,3,0.5,0.03,0]') ;
disp(' ') ;
para = input('[St, K1, K3, T, sigma, r, flag]=');

while length(para) < 7
    disp(' ')
    disp('Not enough input arguments. Please input in 1*7 vector form like [10,13,21,3,0.5,0.03,0]');
    para = input('[10,13,21,3,0.5,0.03,0]=');
end

if para(3)<para(2)
    disp(' ')
    disp('K3 must be larger than K1');
    para = input('[St, K1, K2, T, sigma, r]=');
end

St      = para(1); %Set the parameters
K1      = para(2);
K3      = para(3);
T       = para(4);
sigma   = para(5);
r       = para(6);
flag    = para(7);

K2      = 0.5*(K1+K3);

[C1,P1] = blsprice(St,K1,r,T,sigma); %Calculate the plain vanilla option prices
[C2,P2] = blsprice(St,K2,r,T,sigma);
[C3,P3] = blsprice(St,K3,r,T,sigma);

x       = [0;K1;K2;K3;K3+K1]; %Set the coordinates

if flag == 0; %If butterfly should be produced with puts

    y1 = [(-P1)*exp(r*T)+K1;(-P1)*exp(r*T);(-P1)*exp(r*T);(-P1)*exp(r*T);(-P1)*exp(r*T)]; %Calculate the payoff at each coordinate
    y2 = 2*[((P2)*exp(r*T)-(K2)); (P2*exp(r*T)-(K2-K1));P2*exp(r*T);P2*exp(r*T); P2*exp(r*T) ];
    y3 = [(-P3)*exp(r*T)+(K3);(-P3)*exp(r*T)+(K3-K1);(-P3)*exp(r*T)+(K2-K1);(-P3)*exp(r*T);(-P3)*exp(r*T)];

    y  = y1+y2+y3; %Combine the payoffs of options to get the butterfly strategy

    hold on
    plot(x,y,'-r','LineWidth',2)
    plot(x,y1, '--k', 'LineWidth', 1)
    plot(x,y2, '--k', 'LineWidth', 1)
    plot(x,y3, '--k', 'LineWidth', 1)
    plot(x,zeros(1,5),':k','LineWidth',0.2)
    hold off

    axis([0 x(5,:) y2(1,:)*1.1 y2(5,:)*1.1])
    xlabel('S_T');
    ylabel('Payoff');
    title('Butterfly Spread (Using Puts)');

elseif flag == 1; %If butterfly should be produced with calls

    y1 = [(-C1)*exp(r*T);(-C1)*exp(r*T);(-C1)*exp(r*T)+(K2-K1);(-C1)*exp(r*T)+(K3-K1);(-C1)*exp(r*T)+K3];%Calculate the payoff at each coordinate
    y2 = 2*[C2*exp(r*T);C2*exp(r*T);C2*exp(r*T);C2*exp(r*T)-(K3-K2); C2*exp(r*T)-(K1+K3-K2)];
    y3 = [(-C3)*exp(r*T);(-C3)*exp(r*T);(-C3)*exp(r*T);(-C3)*exp(r*T);(-C3)*exp(r*T)+K1];

    y  = y1+y2+y3; %Combine the payoffs of options to get the butterfly strategy

    hold on
    plot(x,y,'-r','LineWidth',2)
    plot(x,y1, '--k', 'LineWidth', 1)
    plot(x,y2, '--k', 'LineWidth', 1)
    plot(x,y3, '--k', 'LineWidth', 1)
    plot(x,zeros(1,5),':k','LineWidth',0.2)
    hold off

    axis([0.75*x(2,:) 0.75*x(5,:) 0.5*y2(5,:) 0.75*y1(5,:)])
    xlabel('S_T');
    ylabel('Payoff');
    title('Butterfly Spread (Using Calls)');

end

