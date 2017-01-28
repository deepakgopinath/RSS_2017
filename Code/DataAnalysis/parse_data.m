

loadData;
load('trial_order_all_4.mat');
load('trial_order_all_od_4.mat');
load('trial_order_all_ph0.mat');

for i=1:totalsubjects
    for j=1:size(ph1_trial_mat, 1)
        ph1_trial_mat{j, 3, i} = assis{ph1_trial_mat{j, 3, i}};
        ph2_trial_mat{j,3,i} = assis{ph2_trial_mat{j,3,i}};
    end
end

ph1_full_trial_list = [ph1_trial_mat; ph1_trial_mat_od]; %16 by 6 by 4
ph2_full_trial_list = [ph2_trial_mat; ph2_trial_mat_od];


for i=1:totalsubjects-2
    user = subList{i};
    trialId = trialList{i};
    ph1_trial_list = ph1_full_trial_list(:,:,str2double(trialId));
    ph2_trial_list = ph2_full_trial_list(:,:,str2double(trialId));
%     process_trial_cells(ph1_trial_list, ph2_trial_list);
    fnames = dir(user);
    numfids = length(fnames);
    j_ph1_ind = find(strcmp(ph1_trial_list(:,2), 'j'));
    h_ph1_ind = find(strcmp(ph1_trial_list(:,2), 'h'));
    w_ph1_ind = find(strcmp(ph1_trial_list(:,3), 'w'));
    wo_ph1_ind = find(strcmp(ph1_trial_list(:,3), 'wo'));
    od_ph1_ind = find(strcmp(ph1_trial_list(:,3), 'od'));
    
    j_ph2_ind = find(strcmp(ph2_trial_list(:,2), 'j'));
    h_ph2_ind = find(strcmp(ph2_trial_list(:,2), 'h'));
    w_ph2_ind = find(strcmp(ph2_trial_list(:,3), 'w'));
    wo_ph2_ind = find(strcmp(ph2_trial_list(:,3), 'wo'));
    od_ph2_ind = find(strcmp(ph2_trial_list(:,3), 'od'));
    for j=3:numfids
        n = fnames(j).name;
        temp = n;
        n(end-3:end) = []; 
        %if length(n) is 14 it means that trial num >= 10, if length(n) ==
        %13 then trial num < 10
        
        %extract mode switches while using joystick for both tasks for with
        %and without assistance
        %FOR PH1 intersection of j_h1_ and w_ph1
        ph1_jw_ind = intersect(j_ph1_ind, w_ph1_ind);
        ph2_jw_ind = intersect(j_ph2_ind, w_ph2_ind);
        if strcmp(n(5:7), 'PH1')
            for k=1:size(ph1_jw_ind, 1)
                if length(n) == 14 %trial > 10
                    if sum(ph1_jw_ind == str2double(n(end-1:end))) > 0
                        disp(temp);
                    end
                elseif length(n) == 13
                   if sum(ph1_jw_ind == str2double(n(end))) > 0
                        disp(temp);
                   end
                end
            end
        else
            for k=1:size(ph2_jw_ind, 1)
                if length(n) == 14 %trial > 10
                    if sum(ph2_jw_ind == str2double(n(end-1:end))) > 0
                        disp(temp);
                    end
                elseif length(n) == 13
                   if sum(ph2_jw_ind == str2double(n(end))) > 0
                        disp(temp);
                   end
                end
            end
            
            
        end
        
    end
end

