%% 洋流觀測分析_W2_hw02  00781035_曾鈺皓
clear;clc
load 'TS_hw2.txt'
% readtable('TS_hw2.txt')
%% 
T = TS_hw2(:,1);
S = TS_hw2(:,2);

plot(S,T,'.')
xticks(fix(min(S))-0.4:0.2:fix(max(S))+0.4);
yticks(fix(min(T)-1):1:fix(max(T)+1));
ylabel('Temperature (^oC)');xlabel('Salinity (psu)');
title('TS_hw2','Interpreter','none');

grid on
% axis equal
print('TS_hw2','-dpng')