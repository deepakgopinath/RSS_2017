% clear all; clc; close all;
% total_subjects = 8;
% subList = {'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8'}; totalsubjects = 8; %or length)subList)
% trialList = {'3'};
% phases = {'PH1', 'PH2'};
% interfaces = {'J2', 'HA'};
% tasks = {'G4', 'G5'};
% assis = {'w','wo'};
% trials_per_phase = 16;



total_time_all = zeros(trials_per_phase, length(phases), total_subjects);

%FOR ONLY USER_INITIATED MODE SWITCHES
num_mode_switches = zeros(trials_per_phase, length(phases), total_subjects);
num_assis_req = zeros(trials_per_phase, length(phases), total_subjects);
mode_switch_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
mode_switches_all = cell(trials_per_phase, length(phases), total_subjects);

%FOR ONLY MODE SWITCHES DUE TO ASSIS REQ
assistance_req_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
assistance_req_mode_switch_all = cell(trials_per_phase, length(phases), total_subjects);


%cdim and cmode coming from ONLY mode switches
cdim_ms_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
cmode_ms_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
cdim_ms_conf_all = cell(trials_per_phase, length(phases), total_subjects);
cmode_ms_conf_all = cell(trials_per_phase, length(phases), total_subjects);


%cdim and cmode coming from ONLY assistance req
cdim_ar_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
cmode_ar_time_stamps = cell(trials_per_phase, length(phases), total_subjects);
cdim_ar_conf_all = cell(trials_per_phase, length(phases), total_subjects);
cmode_ar_conf_all = cell(trials_per_phase, length(phases), total_subjects);


%HAVE cdim and cmode time stamps and conf all separately for mode switch
%initiated and assistance initiated. 

for i=1:total_subjects
    user = subList{i};
    trialId = trialList{i};
    fnames = dir(user);
    numfids = length(fnames);
    for j=3:numfids
        n = fnames(j).name;
%         fprintf('FILENAME is %s\n', n);
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
        subid = str2double(n(2)); %H1 gets 1 H2 gets 2 and so on and so forth
        total_time_all(trialnum, ph, subid) = total_time;
        
        mode_switches(1:2,:) = []; %remove 0's in first and second row.
        cdim_conf_disamb(1,:) = []; %remove 0's in first row. 
        cmode_conf_disamb(1,:) = [];
        assistance_requested(1,:) = [];
        
        num_mode_switches(trialnum, ph, subid) = size(mode_switches,1) - size(assistance_requested, 1); % and assistance requests also triggers mode switch publisher. 
        num_assis_req(trialnum, ph, subid) = size(assistance_requested, 1);
        if size(mode_switches, 1) > 0 %if there are user initiated mode switches or assistancce req mode switches. If the user has not pressed either then this will go to else
            normalized_mode_switch_times = mode_switches(:, end) - start_time; %mode switches is from 2 and not 1 bcoz the first one is BEFORE the start of the trial
            normalized_cdim_times = cdim_conf_disamb(:, end) - start_time;
            normalized_cmode_times = cmode_conf_disamb(:, end) - start_time;
            normalized_assistance_times = assistance_requested(:, end) - start_time; 
            
            %Identify ONLY those mode switch time stamps that DID NOT come
            %from assistance requested. THese are the ones which are
            %user-initiated mode switches. 
            
            mode_switch_ignore_list = zeros(length(normalized_assistance_times), 1);
            for kk = 1:size(normalized_assistance_times, 1)
%                 disp(normalized_assistance_times(kk));
                mode_switch_ignore_list(kk) = find(abs(normalized_mode_switch_times - normalized_assistance_times(kk)) < 0.001);
            end
            
            
%           %user initiated mode switch, algo time stamps
            if num_mode_switches(trialnum, ph, subid) > 0
                mode_switch_time_stamps(trialnum, ph, subid) = {normalized_mode_switch_times((setdiff(1:length(normalized_mode_switch_times), mode_switch_ignore_list)))};
                cdim_ms_time_stamps(trialnum, ph, subid) = {normalized_cdim_times((setdiff(1:length(normalized_cdim_times), mode_switch_ignore_list)))};
                cmode_ms_time_stamps(trialnum, ph, subid) = {normalized_cmode_times((setdiff(1:length(normalized_cmode_times), mode_switch_ignore_list)))};
                mode_switches_all(trialnum, ph, subid) = {mode_switches(setdiff(1:size(mode_switches,1), mode_switch_ignore_list), 1)};
                cdim_ms_conf_all(trialnum, ph, subid) = {cdim_conf_disamb(setdiff(1:size(mode_switches,1), mode_switch_ignore_list), 1:end-1)};
                cmode_ms_conf_all(trialnum, ph, subid) = {cmode_conf_disamb(setdiff(1:size(mode_switches,1), mode_switch_ignore_list),1:end-1)};
            else
                mode_switch_time_stamps(trialnum, ph, subid) = {-1};
                cdim_ms_time_stamps(trialnum, ph, subid) = {-1};
                cmode_ms_time_stamps(trialnum, ph, subid) = {-1};
                mode_switches_all(trialnum, ph, subid) = {-1};
                cdim_ms_conf_all(trialnum, ph, subid) ={-1};
                cmode_ms_conf_all(trialnum, ph, subid) ={-1};
            end
            
            if num_assis_req(trialnum, ph, subid) > 0
            %on demand assistance intiated algo time stamps
                assistance_req_time_stamps(trialnum, ph, subid) = {normalized_assistance_times};
                cdim_ar_time_stamps(trialnum, ph, subid) = {normalized_cdim_times(mode_switch_ignore_list)};
                cmode_ar_time_stamps(trialnum, ph, subid) = {normalized_cmode_times(mode_switch_ignore_list)};      
                assistance_req_mode_switch_all(trialnum, ph, subid) = {mode_switches(mode_switch_ignore_list, 1)};
                cdim_ar_conf_all(trialnum, ph, subid) = {cdim_conf_disamb(mode_switch_ignore_list, 1:end-1)};
                cmode_ar_conf_all(trialnum, ph, subid) = {cmode_conf_disamb(mode_switch_ignore_list, 1:end-1)};
            else
                assistance_req_time_stamps(trialnum, ph, subid) = {-1};
                cdim_ar_time_stamps(trialnum, ph, subid) = {-1};
                cmode_ar_time_stamps(trialnum, ph, subid) = {-1};
                assistance_req_mode_switch_all(trialnum, ph, subid) = {-1};
                cdim_ar_conf_all(trialnum, ph, subid) = {-1};
                cmode_ar_conf_all(trialnum, ph, subid) = {-1};
            end
            
            
            %Snippet for checking if the algorithm computed the same mode
            %as the person. Most likely not. Because the algorithm at every
            %point is in a confused state. all goals are equally likely.
            %The human on the other hand is fully confident of what goal
            %s/he is going for. 
            mst = mode_switch_time_stamps(trialnum, ph, subid); mst = mst{1};
            diffmst = diff(mst);
            mst_ind = find(diffmst > 1);
            ms = mode_switches_all(trialnum, ph, subid); ms = ms{1};
%             ms = ms(mst_ind);
            if ~isempty(diffmst) && diffmst(end) < 1
                ms = [ms(mst_ind) ; ms(end)]; 
                mst_ind = [mst_ind ; length(mst)];
            else
                ms = ms(mst_ind);
            end
            cm = cmode_ms_conf_all(trialnum, ph, subid); cm = cm{1};
            [c,ind] = max(cm, [], 2);
            cm = ind(mst_ind);
            disp(sum(cm == ms));
            
            
            
            
        else
%             mode_switch_time_stamps(trialnum, ph, subid) = {-1};
%             cdim_ms_time_stamps(trialnum, ph, subid) = {-1};
%             cmode_time_stamps(trialnum, ph, subid) = {-1};
%             
%             mode_switches_all(trialnum, ph, subid) = {-1};
%             cdim_ms_conf_all(trialnum, ph, subid) = {-1};
%             cmode_ms_conf_all(trialnum, ph, subid) = {-1};
%             normalized_mode_switch_times = mode_switches(1:end, 2) - start_time;
%             disp(normalized_mode_switch_times);
%           
            mode_switch_time_stamps(trialnum, ph, subid) = {-1};
            cdim_ms_time_stamps(trialnum, ph, subid) = {-1};
            cmode_ms_time_stamps(trialnum, ph, subid) = {-1};
            %on demand assistance intiated algo time stamps
            assistance_req_time_stamps(trialnum, ph, subid) = {-1};
            cdim_ar_time_stamps(trialnum, ph, subid) = {-1};
            cmode_ar_time_stamps(trialnum, ph, subid) = {-1};
            
            
            mode_switches_all(trialnum, ph, subid) = {-1};
            cdim_ms_conf_all(trialnum, ph, subid) ={-1};
            cmode_ms_conf_all(trialnum, ph, subid) ={-1};
            
            assistance_req_mode_switch_all(trialnum, ph, subid) = {-1};
            cdim_ar_conf_all(trialnum, ph, subid) = {-1};
            cmode_ar_conf_all(trialnum, ph, subid) = {-1};
            
        end
%         disp(assistance_requested);
    end
end