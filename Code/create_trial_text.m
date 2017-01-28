clear all; clc; close all;
generate_trials;
create_home_initmode;
T1_Trials = cell(trials, 5, sub); %interface, assistance, goal, home position, initial mode. 
T2_Trials = cell(trials, 5, sub);


for i=1:sub
    curr_c = tcombo(:,:,2*i - 1);
    jt = 1;
    ht = 1;
    for j=1:size(curr_c, 1)
        if curr_c(j, 1) == 1 || curr_c(j, 1) == 3
            him_ind = home_init_mode_j2(jt,i);
            T1_Trials{j, 4, i} = homes{hci_list_j2(him_ind, 1)}; 
            T1_Trials{j, 5, i} = j2modes{hci_list_j2(him_ind, 2)};
            jt = jt + 1;
        else
            him_ind = home_init_mode_ha(ht,i);
            T1_Trials{j, 4, i} = homes{hci_list_ha(him_ind, 1)}; 
            T1_Trials{j, 5, i} = hamodes{hci_list_ha(him_ind, 2)};
            ht = ht + 1;
        end
       
        if curr_c(j, 1) == 1
            T1_Trials{j, 1, i} = ci{1}; T1_Trials{j, 2, i} = assis{1}; T1_Trials{j, 3, i} = curr_c(j, 2);
        elseif curr_c(j, 1) == 3
            T1_Trials{j, 1, i} = ci{1}; T1_Trials{j, 2, i} = assis{2}; T1_Trials{j, 3, i} = curr_c(j, 2);
        elseif curr_c(j, 1) == 2
            T1_Trials{j, 1, i} = ci{2}; T1_Trials{j, 2, i} = assis{1}; T1_Trials{j, 3, i} = curr_c(j, 2);
        else
            T1_Trials{j, 1, i} = ci{2}; T1_Trials{j, 2, i} = assis{2}; T1_Trials{j, 3, i} = curr_c(j, 2);
        end
    end
    
    curr_c = tcombo(:,:,2*i);
    
    
    for j=1:size(curr_c, 1)
        
        if curr_c(j, 1) == 1 || curr_c(j, 1) == 3
            him_ind = home_init_mode_j2(jt,i);
            T2_Trials{j, 4, i} = homes{hci_list_j2(him_ind, 1)}; 
            T2_Trials{j, 5, i} = j2modes{hci_list_j2(him_ind, 2)};
            jt = jt + 1;
        else
            him_ind = home_init_mode_ha(ht,i);
            T2_Trials{j, 4, i} = homes{hci_list_ha(him_ind, 1)}; 
            T2_Trials{j, 5, i} = hamodes{hci_list_ha(him_ind, 2)};
            ht = ht + 1;
        end
        
        
        if curr_c(j, 1) == 1
            T2_Trials{j, 1, i} = ci{1}; T2_Trials{j, 2, i} = assis{1}; T2_Trials{j, 3, i} = curr_c(j, 2);
        elseif curr_c(j, 1) == 3
            T2_Trials{j, 1, i} = ci{1}; T2_Trials{j, 2, i} = assis{2}; T2_Trials{j, 3, i} = curr_c(j, 2);
        elseif curr_c(j, 1) == 2
            T2_Trials{j, 1, i} = ci{2}; T2_Trials{j, 2, i} = assis{1}; T2_Trials{j, 3, i} = curr_c(j, 2);
        else
            T2_Trials{j, 1, i} = ci{2}; T2_Trials{j, 2, i} = assis{2}; T2_Trials{j, 3, i} = curr_c(j, 2);
        end
    end
end
% for i=1:num
%     curr_c = tcombo(:,:,i);
%     if mod(i,2) == 1 %TASK 1
%         for j=1:size(curr_c, 1)
%             if curr_c(j, 1) == 1
%                 T1_Trials{j, 1, i} = ci{1}; T1_Trials{j, 2, i} = assis{1}; T1_Trials{j, 3, i} = curr_c(j, 2);
%             elseif curr_c(j, 1) == 3
%                 T1_Trials{j, 1, i} = ci{1}; T1_Trials{j, 2, i} = assis{2}; T1_Trials{j, 3, i} = curr_c(j, 2);
%             elseif curr_c(j, 1) == 2
%                 T1_Trials{j, 1, i} = ci{2}; T1_Trials{j, 2, i} = assis{1}; T1_Trials{j, 3, i} = curr_c(j, 2);
%             else
%                 T1_Trials{j, 1, i} = ci{2}; T1_Trials{j, 2, i} = assis{2}; T1_Trials{j, 3, i} = curr_c(j, 2);
%             end
%         end
%         i = i + 1; %subject number, 
%     else %TASK 2
%         for j=1:size(curr_c, 1)
%             if curr_c(j, 1) == 1
%                 T2_Trials{j, 1, i} = ci{1}; T2_Trials{j, 2, i} = assis{1}; T2_Trials{j, 3, i} = curr_c(j, 2);
%             elseif curr_c(j, 1) == 3
%                 T2_Trials{j, 1, i} = ci{1}; T2_Trials{j, 2, i} = assis{2}; T2_Trials{j, 3, i} = curr_c(j, 2);
%             elseif curr_c(j, 1) == 2
%                 T2_Trials{j, 1, i} = ci{2}; T2_Trials{j, 2, i} = assis{1}; T2_Trials{j, 3, i} = curr_c(j, 2);
%             else
%                 T2_Trials{j, 1, i} = ci{2}; T2_Trials{j, 2, i} = assis{2}; T2_Trials{j, 3, i} = curr_c(j, 2);
%             end
%         end
%         i = i + 1;
%     end
% end

for i=1:sub
    fileID = fopen(strcat('T1_OD_', int2str(i), '.txt'),'w');
    formatSpec = '%s %s %d %s %s\n';
    [nrows,ncols] = size(T1_Trials(:,:,i));
    for row = 1:nrows
        fprintf(fileID,formatSpec,T1_Trials{row,:, i});
    end
    fclose(fileID);
end

for i=1:sub
    fileID = fopen(strcat('T2__OD_', int2str(i), '.txt'),'w');
    formatSpec = '%s %s %d %s %s\n';
    [nrows,ncols] = size(T2_Trials(:,:,i));
    for row = 1:nrows
        fprintf(fileID,formatSpec,T2_Trials{row,:, i});
    end
    fclose(fileID);
end