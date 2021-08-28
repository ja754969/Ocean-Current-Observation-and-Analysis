%% Exercise in class (00781035)
clear;clc;clf
load Taiwan_2017.txt
load Japan_2017.txt
%   [Year , Month , Date , longitude , latitude , u-velocity , v-velocity , lD] 

%% 第1題
% Using the drifter data given in the txt files on the tronclass system, 
% calculate the total mean speed of Kuroshio in each region, east of Taiwan and 
% south of Japan, in 2017 
Taiwan_u_speed = Taiwan_2017(:,6);Taiwan_v_speed = Taiwan_2017(:,7);
Taiwan_speed = sqrt(Taiwan_u_speed.^2 + Taiwan_v_speed.^2);
Taiwan_mean_speed = mean(Taiwan_speed);

Japan_u_speed = Japan_2017(:,6);Japan_v_speed = Japan_2017(:,7);
Japan_speed = sqrt(Japan_u_speed.^2 + Japan_v_speed.^2);
Japan_mean_speed = mean(Japan_speed);
%% 第2題
% Which location has faster and slower speed of 
% Kuroshio in 2017? 
faster = (Taiwan_mean_speed > Japan_mean_speed);

if (faster == 0)
    fprintf('Japan has faster speed of  Kuroshio in 2017\n')
else 
    fprintf('Taiwan has faster speed of  Kuroshio in 2017\n')
end
%% 第3題
% Calculate the monthly average of Kuroshio speed 
% in these regions during July and December, 2017. 
% Then, show the results in a graph to compare the 
% Kuroshio speed in these regions during July and 
% December, 2017. 

Mon = [7 12];

KTJuly = Taiwan_2017(find(Taiwan_2017(:,2) == 7),:);
KTJuly_mean = mean(sqrt(KTJuly(:,6).^2 + KTJuly(:,7).^2));
KTDecember = Taiwan_2017(find(Taiwan_2017(:,2) == 12),:);
KTDecember_mean = mean(sqrt(KTDecember(:,6).^2 + KTDecember(:,7).^2));
plot(Mon,[KTJuly_mean KTDecember_mean],'o-');hold on
xticks(7:1:12);
% xticklabels({'7','8','9','10','11','12'})


JTJuly = Japan_2017(find(Japan_2017(:,2) == 7),:);
JTJuly_mean = mean(sqrt(JTJuly(:,6).^2 + JTJuly(:,7).^2));
JTDecember = Japan_2017(find(Japan_2017(:,2) == 12),:);
JTDecember_mean = mean(sqrt(JTDecember(:,6).^2 + JTDecember(:,7).^2));

plot(Mon,[JTJuly_mean JTDecember_mean],'o-');hold off
xlabel('Month(July & December)');ylabel('Kuroshio Speed (m/s)');
title('Monthly Average of Kuroshio Speed');

legend({'Taiwan','Japan'},'Location','best');

print('W6_class_Kuroshio_drifter_TaiwanJapan2017','-dpng')