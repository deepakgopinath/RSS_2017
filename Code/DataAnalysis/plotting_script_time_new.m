% parse_data;
plotting_script_new;
interfaces = {'j', 'h'};
interfaces_cell = {'t_g4_jw','t_g4_jwo','t_g5_jw','t_g5_jwo';
                    't_g4_hw','t_g4_hwo','t_g5_hw','t_g5_hwo'};
jit_factor = [0.02, 0.005];
ylims = [58, 100];
y1 = 1.0; y2 = 2.0;
for kk=1:length(interfaces)
    v1 = eval(interfaces_cell{kk,2}); %Manual RsG
    v2 = eval(interfaces_cell{kk,1}); %Dismab RsG
    v3 = eval(interfaces_cell{kk,4}); %Manual RdG
    v4 = eval(interfaces_cell{kk,3}); %Disamb RdG
    v1 = [v1;v3];
    v2 = [v2;v4];
    if kk == 1
        subplot(2,2,3); hold on; grid on;
    else
        subplot(2,2,4); hold on; grid on;
    end
    scatter(y1*ones(length(v1),1), v1, 'o', 'k', 'LineWidth', 1.5);
    scatter(y2*ones(length(v2),1), v2, 'o', 'r', 'LineWidth', 1.5);
%     scatter(2.8*ones(length(v3),1), v3, 'o', 'r', 'LineWidth', 1.5);
%     scatter(3.2*ones(length(v4),1), v4, 'o', 'k', 'LineWidth', 1.5);
    scatter(y1, median(v1), 100, 'X', 'b', 'LineWidth',4.5);
    scatter(y2, median(v2), 100, 'X', 'b', 'LineWidth',4.5);
    axis([0,3,0,ylims(kk)]);
    if kk == 1
        set(gca, 'YTick', 0:10:ylims(kk));
        ylabel('\bf \fontsize{14} Task Completion Time (sec)');
    else
        set(gca, 'YTick', 0:10:ylims(kk));
    end
    set(gca, 'XTick', 1:1:2);
    set(gca, 'XTickLabel', {'\bf \fontsize{10}Manual', '\bf \fontsize{10}Disamb'});
    [p,h] = ranksum(v1, v2);
    ypos = max(max(v1), max(v2)); yoffset = 2;
    if p <= 0.05
        line([y1, y1], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        line([y2, y2], [ypos + yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
        line([y1, y2], [ypos + 2*yoffset, ypos+2*yoffset], 'LineWidth', 2.0);
    end
    if p <= 0.001
        text(0.5*(y1+y2), ypos+3*yoffset, '***', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
    elseif p <= 0.01
        text(0.5*(y1+y2), ypos+3*yoffset, '**', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
    elseif p <= 0.05
        text(0.5*(y1+y2), ypos+3*yoffset, '*', 'HorizontalAlignment', 'Center', 'BackGroundcolor', 'none', 'FontSize', 15);
    end
    
    
end