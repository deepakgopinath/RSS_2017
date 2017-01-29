clear all; clc ; close all;
load('CONF3_91.mat');
% 
% figure;
% hold on;grid on;
% colors = {'k','r','g','b','c','y','k'};
% x = conf3_cdim_list;
% for i=1:size(conf3_cdim_list,1)
%     scatter3(x(i,1), x(i,2), x(i,3), 'MarkerEdgeColor',colors{x(i,4) + 2}, 'LineWidth', 1.2);
% end
% xlabel('World X');
% ylabel('World Y');
% zlabel('World Z');
% set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
% scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'k' );
% title('Best Control Dimension Heat Map - uh.r + max(0, 1 - d/D)  - (90-10)');
% 
% load('CONF3_55.mat');
% figure;
% hold on;grid on;
% colors = {'k','r','g','b','c','y','k'};
% x = conf3_cdim_list;
% for i=1:size(conf3_cdim_list,1)
%     scatter3(x(i,1), x(i,2), x(i,3), 'MarkerEdgeColor',colors{x(i,4) + 2}, 'LineWidth', 1.2);
% end
% xlabel('World X');
% ylabel('World Y');
% zlabel('World Z');
% set(gca, 'XDir', 'reverse');
% set(gca, 'YDir', 'reverse');
% scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'k' );
% title('Best Control Dimension Heat Map - uh.r + max(0, 1 - d/D) - 50-50');

figure;
load('CONF3_19.mat');
hold on;grid on;
colors = {'k','r','g','b','c','y','k'};
x = conf3_cdim_list;
for i=1:size(conf3_cdim_list,1)
    scatter3(x(i,1), x(i,2), x(i,3), 'MarkerEdgeColor',colors{x(i,4) + 2}, 'LineWidth', 1.2);
end
xlabel('World X');
ylabel('World Y');
zlabel('World Z');
set(gca, 'XDir', 'reverse');
set(gca, 'YDir', 'reverse');
scatter3(obj_positions(:,1), obj_positions(:,2), obj_positions(:,3), 700, 'filled', 'MarkerFaceColor', 'k' );
title('Best Control Dimension Heat Map - uh.r + max(0, 1 - d/D) 10-90');