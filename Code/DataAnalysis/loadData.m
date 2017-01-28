% clear all; clc; close all;
% total_subjects = 8;
% subList = {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8'}; totalsubjects = 8; %or length)subList)
% trialList = {'3'};
% phases = {'PH1', 'PH2'};
% interfaces = {'J2', 'HA'};
% tasks = {'G4', 'G5'};
% assis = {'w','wo'};
% trials_per_phase = 16;

clear all ;clc; close all;

subList = {'H1', 'H2', 'H3', 'H4'}; total_subjects = 4; %or length)subList)
trialList = {'4', '1', '2', '3'};
phases = {'PH0', 'PH1', 'PH2'};
interfaces = {'J2', 'HA'};
tasks = {'G3','G4', 'G5'};
assis = {'w','wo'};
trials_per_phase = 16;

total_time_all = zeros(trials_per_phase, length(phases), total_subjects);
num_mode_switches = zeros(trials_per_phase, length(phases), total_subjects);
mode_switch_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
cdim_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
cmode_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
mode_switches_all = cell(trials_per_phase, length(phases), total_subjects);


count = 1;
for i=1:total_subjects
    user = subList{i};
    trialId = trialList{i};
    fnames = dir(user);
    numfids = length(fnames);
    for j=3:numfids
        n = fnames(j).name;
        fprintf('FILENAME is %s\n', n);
        load(n);
        temp = n; n(end-3:end) = []; %remove .mat extension
        if length(n) == 14
            trialnum = str2double(n(end-1:end));
        else
            trialnum = str2double(n(end));
        end
        if strcmp(n(5:7), 'PH0')
            ph = 1;
        elseif strcmp(n(5:7), 'PH1')
            ph = 2;
        else
            ph = 3;
        end
        subid = str2double(n(2));
        total_time_all(trialnum, ph, subid) = total_time;
        
        mode_switches(1,:) = []; %remove 0's in first row.
        cdim_conf_disamb(1,:) = []; %remove 0's in first row. 
        cmode_conf_disamb(1,:) = [];
        
        
        num_mode_switches(trialnum, ph, subid) = size(mode_switches,1)-1; %The first mode switch came at before the start
        if size(mode_switches, 1) - 1 > 0 %if there are user initiated mode switches
%             mode_switch_time_stamps(trialnum, ph, subid) = {mode_switches(2:end,2)};
            normalized_mode_switch_times = mode_switches(2:end, 2) - start_time;
            normalized_cdim_times = cdim_conf_disamb(:, end) - start_time;
            normalized_cmode_times = cmode_conf_disamb(:, end) - start_time;
            mode_switch_time_stamps(trialnum, ph, subid) = {normalized_mode_switch_times};
            cdim_time_stamps(trialnum, ph, subid) = {normalized_cdim_times};
            cmode_time_stamps(trialnum, ph, subid) = {normalized_cmode_times};
            mode_switches_all(trialnum, ph, subid) = {mode_switches(2:end, 1)};
%             disp(normalized_mode_switch_times(1)); 
        else
            mode_switch_time_stamps(trialnum, ph, subid) = {-1};
            cdim_time_stamps(trialnum, ph, subid) = {-1};
            cmode_time_stamps(trialnum, ph, subid) = {-1};
            mode_switches_all(trialnum, ph, subid) = {-1};
%             normalized_mode_switch_times = mode_switches(1:end, 2) - start_time;
%             disp(normalized_mode_switch_times);
%           
        end
%         disp(assistance_requested);
    end
end