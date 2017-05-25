
clear all ;clc; close all;

subList = {'H1', 'H2', 'H3', 'H4'}; total_subjects = 4; %or length)subList)
trialList = {'4', '1', '2', '3'};
phases = {'PH0', 'PH1', 'PH2'};
interfaces = {'J2', 'HA'};
tasks = {'G3','G4', 'G5'};
assis = {'w','wo'};
task_order = {'G5', 'G4', 'G4', 'G5'};
trials_per_phase = 16;

loadData;
load('trial_order_all_4.mat');
load('trial_order_all_od_4.mat');
load('trial_order_all_ph0.mat');

for i=1:total_subjects
    for j=1:size(ph1_trial_mat, 1)
        ph1_trial_mat{j, 3, i} = assis{ph1_trial_mat{j, 3, i}};
        ph2_trial_mat{j,3,i} = assis{ph2_trial_mat{j,3,i}};
    end
end

ph1_full_trial_list = [ph1_trial_mat; ph1_trial_mat_od]; %16 by 6 by 4
ph2_full_trial_list = [ph2_trial_mat; ph2_trial_mat_od];

ms_g4_jw = [];
ms_g5_jw = [];
ms_g4_jwo = [];
ms_g5_jwo = [];

ms_g4_hw = [];
ms_g5_hw = [];
ms_g4_hwo = [];
ms_g5_hwo = [];

t_g4_jw = [];
t_g5_jw = [];
t_g4_jwo = [];
t_g5_jwo = [];

t_g4_hw = [];
t_g5_hw = [];
t_g4_hwo = [];
t_g5_hwo = [];

for i=1:total_subjects
    user = subList{i};
    trialId = trialList{i}; %this is to load the correct trial order list
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
    
    
    %ASK THE SPECIFIC COMBINATION
    ph1_jw_ind = intersect(j_ph1_ind, w_ph1_ind);
    ph2_jw_ind = intersect(j_ph2_ind, w_ph2_ind);
    
    ph1_jwo_ind = intersect(j_ph1_ind, wo_ph1_ind);
    ph2_jwo_ind = intersect(j_ph2_ind, wo_ph2_ind);
    
    ph1_hw_ind = intersect(h_ph1_ind, w_ph1_ind);
    ph2_hw_ind = intersect(h_ph2_ind, w_ph2_ind);
    
    ph1_hwo_ind = intersect(h_ph1_ind, wo_ph1_ind);
    ph2_hwo_ind = intersect(h_ph2_ind, wo_ph2_ind);
    
    ph1id = 2; ph2id = 3; 
    subid = i;
    if strcmp(task_order{i},'G4') %means ph1 is G4
        ms_g4_jw = [ms_g4_jw; num_mode_switches(ph1_jw_ind ,ph1id, subid)];
        ms_g4_jwo = [ms_g4_jwo ; num_mode_switches(ph1_jwo_ind, ph1id, subid)];
        ms_g4_hw = [ms_g4_hw; num_mode_switches(ph1_hw_ind, ph1id, subid)];
        ms_g4_hwo = [ms_g4_hwo ; num_mode_switches(ph1_hwo_ind, ph1id, subid)];
   
        %time for g4
        
        t_g4_jw = [t_g4_jw; total_time_all(ph1_jw_ind, ph1id, subid)];
        t_g4_jwo = [t_g4_jwo; total_time_all(ph1_jwo_ind, ph1id, subid)];
        t_g4_hw = [t_g4_hw; total_time_all(ph1_hw_ind, ph1id, subid)];
        t_g4_hwo = [t_g4_hwo; total_time_all(ph1_hwo_ind, ph1id, subid)];
    else %means G4 task happened in ph2
        ms_g4_jw = [ms_g4_jw; num_mode_switches(ph2_jw_ind, ph2id, subid)];
        ms_g4_jwo = [ms_g4_jwo ; num_mode_switches(ph2_jwo_ind, ph2id, subid)];
        ms_g4_hw = [ms_g4_hw; num_mode_switches(ph2_hw_ind, ph2id, subid)];
        ms_g4_hwo = [ms_g4_hwo ; num_mode_switches(ph2_hwo_ind, ph2id, subid)];
        
        t_g4_jw = [t_g4_jw; total_time_all(ph2_jw_ind, ph2id, subid)];
        t_g4_jwo = [t_g4_jwo; total_time_all(ph2_jwo_ind, ph2id, subid)];
        t_g4_hw = [t_g4_hw; total_time_all(ph2_hw_ind, ph2id, subid)];
        t_g4_hwo = [t_g4_hwo; total_time_all(ph2_hwo_ind, ph2id, subid)];
    end
    
    
    if strcmp(task_order{i},'G5') %means ph1 is G5
        ms_g5_jw = [ms_g5_jw; num_mode_switches(ph1_jw_ind ,ph1id, subid)];
        ms_g5_jwo = [ms_g5_jwo; num_mode_switches(ph1_jwo_ind ,ph1id, subid)];
        ms_g5_hw = [ms_g5_hw; num_mode_switches(ph1_hw_ind, ph1id, subid)];
        ms_g5_hwo = [ms_g5_hwo ; num_mode_switches(ph1_hwo_ind, ph1id, subid)];
        
        t_g5_jw = [t_g5_jw; total_time_all(ph1_jw_ind, ph1id, subid)];
        t_g5_jwo = [t_g5_jwo; total_time_all(ph1_jwo_ind, ph1id, subid)];
        t_g5_hw = [t_g5_hw; total_time_all(ph1_hw_ind, ph1id, subid)];
        t_g5_hwo = [t_g5_hwo; total_time_all(ph1_hwo_ind, ph1id, subid)];
    else %means G4 task happened in ph2
        ms_g5_jw = [ms_g5_jw; num_mode_switches(ph2_jw_ind, ph2id, subid)];
        ms_g5_jwo = [ms_g5_jwo; num_mode_switches(ph2_jwo_ind ,ph2id, subid)];
        ms_g5_hw = [ms_g5_hw; num_mode_switches(ph2_hw_ind, ph2id, subid)];
        ms_g5_hwo = [ms_g5_hwo ; num_mode_switches(ph2_hwo_ind, ph2id, subid)];
        
         t_g5_jw = [t_g5_jw; total_time_all(ph2_jw_ind, ph2id, subid)];
        t_g5_jwo = [t_g5_jwo; total_time_all(ph2_jwo_ind, ph2id, subid)];
        t_g5_hw = [t_g5_hw; total_time_all(ph2_hw_ind, ph2id, subid)];
        t_g5_hwo = [t_g5_hwo; total_time_all(ph2_hwo_ind, ph2id, subid)];
    end

end


%plotting stuff
% plotting_script;
% plotting_script_time;


