close all;
%

interfaces = {'j', 'h'};
interfaces_cell = {'ms_g4_jw','ms_g4_jwo','ms_g5_jw','ms_g5_jwo';
                    'ms_g4_hw','ms_g4_hwo','ms_g5_hw','ms_g5_hwo'};
                
                
jit_factor = [0.02, 0.005];

ylims = [8, 22];
for kk=1:length(interfaces)
    v1 = eval(interfaces_cell{kk,1});
    v2 = eval(interfaces_cell{kk,2});
    v3 = eval(interfaces_cell{kk,3});
    v4 = eval(interfaces_cell{kk,4});
    if kk == 1
        subplot(2,2,1); hold on; grid on;
    else
        subplot(2,2,2); hold on; grid on;
    end
    uvals = unique(v1);
    distri = zeros(length(uvals),1);
    for i=1:length(uvals)
        distri(i) = sum(v1 == uvals(i));
    end

    for i=1:length(v1)
        if distri(uvals == v1(i)) > 1
            scatter(0.8, v1(i),'o','r', 'LineWidth', 1.5, 'jitter', 'on', 'jitterAmount', jit_factor(kk)*(distri(uvals == v1(i)) - 1));
        else
            scatter(0.8, v1(i),'o','r', 'LineWidth', 1.5);
        end
    end

    uvals = unique(v2);
    distri = zeros(length(uvals),1);
    for i=1:length(uvals)
        distri(i) = sum(v2 == uvals(i));
    end

    for i=1:length(v2)
        if distri(uvals == v2(i)) > 1
            scatter(1.2, v2(i),'o','k', 'LineWidth', 1.5, 'jitter', 'on', 'jitterAmount', jit_factor(kk)*(distri(uvals == v2(i)) - 1));
            hold on;
        else
            scatter(1.2, v2(i),'o','k', 'LineWidth', 1.5);
        end
    end
    %G5 w wo plots
    uvals = unique(v3);
    distri = zeros(length(uvals),1);
    for i=1:length(uvals)
        distri(i) = sum(v3 == uvals(i));
    end

    for i=1:length(v3)
        if distri(uvals == v3(i)) > 1
            scatter(2.8, v3(i),'o','r', 'LineWidth', 1.5, 'jitter', 'on', 'jitterAmount', jit_factor(kk)*(distri(uvals == v3(i)) - 1));
        else
            scatter(2.8, v3(i),'o','r', 'LineWidth', 1.5);
        end
    end

    uvals = unique(v4);
    distri = zeros(length(uvals),1);
    for i=1:length(uvals)
        distri(i) = sum(v4 == uvals(i));
    end

    for i=1:length(v4)
        if distri(uvals == v4(i)) > 1
            scatter(3.2, v4(i),'o','k', 'LineWidth', 1.5, 'jitter', 'on', 'jitterAmount', jit_factor(kk)*(distri(uvals == v4(i)) -  1));
            hold on;
        else
            scatter(3.2, v4(i),'o','k', 'LineWidth', 1.5);
        end
    end
%     scatter(0.8, mean(v1), 100, 'X', 'b', 'LineWidth',4.5);
%     scatter(1.2, mean(v2), 100, 'X', 'b', 'LineWidth',4.5);
%     scatter(2.8, mean(v3), 100, 'X', 'b', 'LineWidth',4.5);
%     scatter(3.2, mean(v4), 100, 'X', 'b', 'LineWidth',4.5);
    
    scatter(0.8, median(v1), 100, 'X', 'b', 'LineWidth',4.5);
    scatter(1.2, median(v2), 100, 'X', 'b', 'LineWidth',4.5);
    scatter(2.8, median(v3), 100, 'X', 'b', 'LineWidth',4.5);
    scatter(3.2, median(v4), 100, 'X', 'b', 'LineWidth',4.5);
    
     
    
%      scatter(0.8, mode(v1), 100, 'X', 'm', 'LineWidth',4.5);
%     scatter(1.2, mode(v2), 100, 'X', 'm', 'LineWidth',4.5);
%     scatter(2.8, mode(v3), 100, 'X', 'm', 'LineWidth',4.5);
%     scatter(3.2, mode(v4), 100, 'X', 'm', 'LineWidth',4.5);
    axis([0,4,0,ylims(kk)]);
    grid on;
%     
    if kk == 1
        set(gca, 'YTick', 0:1:ylims(kk));
        title('\bf \fontsize{16} Joystick  ');
        set(gca, 'XTick', 1:1:3);
    set(gca, 'XTickLabel', {'\bf \fontsize{10}TASK 1','', '\bf \fontsize{10}TASK 2'});
    ylabel('\fontsize{14} Number of Mode Switches');
    else
        set(gca, 'YTick', 0:4:ylims(kk));
         title('\bf \fontsize{16} Headarray');
         set(gca, 'XTick', 1:1:3);
    set(gca, 'XTickLabel', {'\bf \fontsize{10}TASK 1','', '\bf \fontsize{10}TASK 2'});
%     ylabel('\fontsize{14} Number of Mode Switches');
    end
   
    
    %wilcoxon rank sum
   [p,h] = ranksum(v1, v2);
   ypos = max(max(v1), max(v2)); yoffset = 0.2;
   if p <= 0.05
    line([0.8, 0.8], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
    line([1.2, 1.2], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
    line([0.8, 1.2], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
   end
   if p <= 0.001
        text(1.0, ypos+3*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
   elseif p <= 0.01
        text(1.0, ypos+3*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
   elseif p <= 0.05
        text(1.0, ypos+3*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);

   end
   
   [p,h] = ranksum(v3,v4);
   ypos = max(max(v3), max(v4)); yoffset = 0.2;
   if p <=0.05
    line([2.8, 2.8], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
    line([3.2, 3.2], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
    line([2.8, 3.2], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
   end
   if p <= 0.001
        text(3.0, ypos+3*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
   elseif p <= 0.01
        text(3.0, ypos+3*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
   elseif p <= 0.05
        text(3.0, ypos+3*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
   end
   if kk ==1
    text(max(xlim)/2, max(ylim)-1, '\fontsize{11}\color{red}o - Assisted', 'HorizontalAlignment', 'Center','BackGroundColor','none', 'FontSize', 10);
    text(max(xlim)/2, max(ylim)-1.5, '\fontsize{11}\color{black}o - Manual', 'HorizontalAlignment', 'Center','BackGroundColor','none', 'FontSize', 10);
    
   else
    text(max(xlim)/2, max(ylim)-1, '\fontsize{11}\color{red}o - Assisted', 'HorizontalAlignment', 'Center','BackGroundColor','none', 'FontSize', 10);
    text(max(xlim)/2, max(ylim)-2.5, '\fontsize{11}\color{black}o - Manual', 'HorizontalAlignment', 'Center','BackGroundColor','none', 'FontSize', 10);
    
   end
end

% scatter(1.2*ones(length(v2), 1), v2,'o', 'k', 'LineWidth', 1.0,'jitter', 'on', 'jitterAmount', 0.05);