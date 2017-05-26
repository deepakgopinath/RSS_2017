close all;
parse_data;
%

interfaces = {'j', 'h'};
interfaces_cell = {'ms_g4_jw','ms_g4_jwo','ms_g5_jw','ms_g5_jwo';
                    'ms_g4_hw','ms_g4_hwo','ms_g5_hw','ms_g5_hwo'};
                
                
jit_factor = [0.02, 0.005];
ylims = [8, 22];
y1 = 1.0; y2 = 2.0;
for kk=1:length(interfaces)
    v1 = eval(interfaces_cell{kk,2}); %Manual RsG
    v2 = eval(interfaces_cell{kk,1}); %Dismab RsG
    v3 = eval(interfaces_cell{kk,4}); %Manual RdG
    v4 = eval(interfaces_cell{kk,3}); %Disamb RdG
    v1 = [v1;v3];
    v2 = [v2;v4];
    if kk == 1
        subplot(2,2,1); hold on; grid on;
    else
        subplot(2,2,2); hold on; grid on;
    end
    
    
    %Dismabiguation data points
    uvals = unique(v1);
    distri = zeros(length(uvals),1);
    for i=1:length(uvals)
        distri(i) = sum(v1 == uvals(i));
    end

    for i=1:length(v1)
        if distri(uvals == v1(i)) > 1
            scatter(y1, v1(i),'o','k', 'LineWidth', 1.5, 'jitter', 'on', 'jitterAmount', jit_factor(kk)*(distri(uvals == v1(i)) - 1));
        else
            scatter(y1, v1(i),'o','k', 'LineWidth', 1.5);
        end
    end
    
    
    %Manual Data points
    uvals = unique(v2);
    distri = zeros(length(uvals),1);
    for i=1:length(uvals)
        distri(i) = sum(v2 == uvals(i));
    end

    for i=1:length(v2)
        if distri(uvals == v2(i)) > 1
            scatter(y2, v2(i),'o','r', 'LineWidth', 1.5, 'jitter', 'on', 'jitterAmount', jit_factor(kk)*(distri(uvals == v2(i)) - 1));
            hold on;
        else
            scatter(y2, v2(i),'o','r', 'LineWidth', 1.5);
        end
    end
    
    scatter(y1, median(v1), 100, 'X', 'b', 'LineWidth',4.5);
    scatter(y2, median(v2), 100, 'X', 'b', 'LineWidth',4.5);
    axis([0,3,0,ylims(kk)]);
    grid on;
    
    if kk == 1
        set(gca, 'YTick', 0:1:ylims(kk));
        title('\bf \fontsize{16} Joystick  ');
        set(gca, 'XTick', 1:1:2);
        set(gca, 'XTickLabel', {'\bf \fontsize{10}Manual','\bf \fontsize{10}Disamb'});
        ylabel('\bf \fontsize{14} Number of Mode Switches');
    else
        set(gca, 'YTick', 0:4:ylims(kk));
        title('\bf \fontsize{16} Headarray');
        set(gca, 'XTick', 1:1:2);
        set(gca, 'XTickLabel', {'\bf \fontsize{10}Manual','\bf \fontsize{10}Disamb'});
    end
    
    [p,h] = ranksum(v1, v2);
    ypos = max(max(v1), max(v2)); yoffset = 0.2;
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
