

interfaces = {'j', 'h'};
interfaces_cell = {'t_g4_jw','t_g4_jwo','t_g5_jw','t_g5_jwo';
                    't_g4_hw','t_g4_hwo','t_g5_hw','t_g5_hwo'};
                


jit_factor = [0.02, 0.005];
ylims = [58, 70];
for kk=1:length(interfaces)
    v1 = eval(interfaces_cell{kk,1});
    v2 = eval(interfaces_cell{kk,2});
    v3 = eval(interfaces_cell{kk,3});
    v4 = eval(interfaces_cell{kk,4});
    figure; hold on; grid on;
    scatter(0.8*ones(length(v1),1), v1, 'o', 'r', 'LineWidth', 1.5);
    scatter(1.2*ones(length(v2),1), v2, 'o', 'k', 'LineWidth', 1.5);
    scatter(2.8*ones(length(v3),1), v3, 'o', 'r', 'LineWidth', 1.5);
    scatter(3.2*ones(length(v4),1), v4, 'o', 'k', 'LineWidth', 1.5);
    
    scatter(0.8, mean(v1), 100, 'X', 'b', 'LineWidth',4.5);
    scatter(1.2, mean(v2), 100, 'X', 'b', 'LineWidth',4.5);
    scatter(2.8, mean(v3), 100, 'X', 'b', 'LineWidth',4.5);
    scatter(3.2, mean(v4), 100, 'X', 'b', 'LineWidth',4.5);
    
    scatter(0.8, median(v1), 100, 'X', 'c', 'LineWidth',4.5);
    scatter(1.2, median(v2), 100, 'X', 'c', 'LineWidth',4.5);
    scatter(2.8, median(v3), 100, 'X', 'c', 'LineWidth',4.5);
    scatter(3.2, median(v4), 100, 'X', 'c', 'LineWidth',4.5);
    
    axis([0,4,0,ylims(kk)]);
    if kk == 1
        set(gca, 'YTick', 1:5:ylims(kk));
        title('With and Without Assistance - Joystick ');
    else
        set(gca, 'YTick', 1:5:ylims(kk));
         title('With and Without Assistance - Headarray');
    end
    set(gca, 'XTick', 1:1:3);
    set(gca, 'XTickLabel', {'\fontsize{10}TASK 1','', '\fontsize{10}TASK 2'});
    ylabel('\fontsize{14} Task completion time (sec)');
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
    text(max(xlim)/2, max(ylim)-5, '\fontsize{11}\color{red}o - With Assis', 'HorizontalAlignment', 'Center','BackGroundColor','none', 'FontSize', 10);
    text(max(xlim)/2, max(ylim)-8.5, '\fontsize{11}\color{black}o - Without Assis', 'HorizontalAlignment', 'Center','BackGroundColor','none', 'FontSize', 10);
    
   else
    text(max(xlim)/2, max(ylim)-5, '\fontsize{11}\color{red}o - With Assis', 'HorizontalAlignment', 'Center','BackGroundColor','none', 'FontSize', 10);
    text(max(xlim)/2, max(ylim)-9.5, '\fontsize{11}\color{black}o - Without Assis', 'HorizontalAlignment', 'Center','BackGroundColor','none', 'FontSize', 10);
    
   end
end