clear;close all;
clc;

nG = 4;

n = 10;
td = rand(n, nG); tdp = rand(n,nG); tdpp = rand(n,nG);
td = sort(td, 2); tdp = sort(tdp, 2); tdpp = sort(tdpp, 2);
figure;
for i=1:n
    scatter((2*i-0.25)*ones(length(td(i, :)), 1), td(i,:)', 'LineWidth', 1.5); hold on;
%     scatter((2*i)*ones(length(tdp(i, :)), 1), tdp(i,:)', 'LineWidth', 1.5);
%     scatter((2*i+0.25)*ones(length(tdpp(i, :)), 1), tdpp(i,:)', 'LineWidth', 1.5);
    grid on;
end
figure;
mvpd_c1 =  zeros(n, 3);
dm_c1 = zeros(n, 1);
difftd = zeros(n, nG);
for i=1:n
   difftd(i, :) = tdp(i, :) - td(i,:);
end
for i=1:n
    pd = pdist(td(i, :)', 'euclidean');
    mvpd_c1(i, 1) = mean(pd); mvpd_c1(i,2) = sum(pd); mvpd_c1(i,3) = var(pd); %mean, sum and variance of pdist of n confidences. 
    sort_td = sort(td(i,:)); %sort confidences
    dm_c1(i) = mean(pd)*mean(td(i,:))*(sort_td(end) - sort_td(end-1));
    scatter(i*ones(length(pd), 1), pd); hold on; grid on;
end
figure;

mvpd_c2 = zeros(n, 3);
dm_c2 = zeros(n,1);
for i=1:n
 pd_dtd =  pdist(difftd(i,:)', 'euclidean');
 mvpd_c2(i, 1) = mean(pd_dtd);mvpd_c2(i, 2) = sum(pd_dtd);mvpd_c2(i, 3) = var(pd_dtd);
 scatter(i*ones(length(pd_dtd), 1), pd_dtd); hold on; grid on;
 dm_c2(i) = mean(pd_dtd);
end
disp(dm_c1);
disp(mvpd_c2);
