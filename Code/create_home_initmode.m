j2modes = {'xy','xz','rp','y'};
hamodes = {'x','yt','z','r','p','yr'};
homes_task1_1= {'h1', 'h2', 'h3', 'h4'};
homes_task2_2 = {'h1', 'h2', 'h3', 'h4', 'h5'};
hci_list_j2 = [1 1;
               1 2;
               1 3; 
               1 4;
               2 1;
               2 2;
               2 3;
               2 4;
               3 1; 
               3 2;
               3 3;
               3 4;
               4 1;
               4 2;
               4 3;
               4 4;
    ];
hci_list_ha = [1 1;
               1 2;
               1 3; 
               1 4;
               1 5;
               1 6;
               2 1;
               2 2;
               2 3;
               2 4;
               2 5;
               2 6;
               3 1; 
               3 2;
               3 3;
               3 4;
               3 5;
               3 6;
               4 1;
               4 2;
               4 3;
               4 4;
               4 5;
               4 6;
    ];


mult = 12;
total_trials = sub * mult; 

home_init_mode_j2 = repmat((1:length(j2modes)*length(homes))', floor(total_trials/(length(j2modes)*length(homes))) , 1);
home_init_mode_j2 = home_init_mode_j2(randperm(length(home_init_mode_j2)), 1);
home_init_mode_j2 = [home_init_mode_j2; randsample(length(j2modes)*length(homes),  total_trials - length(home_init_mode_j2))];

home_init_mode_j2 = reshape(home_init_mode_j2, mult, sub);

home_init_mode_ha = repmat((1:length(hamodes)*length(homes))', floor(total_trials/(length(hamodes)*length(homes))) , 1);
home_init_mode_ha = home_init_mode_ha(randperm(length(home_init_mode_ha)), 1);
home_init_mode_ha = [home_init_mode_ha; randsample(length(hamodes)*length(homes),  total_trials - length(home_init_mode_ha))];
home_init_mode_ha = reshape(home_init_mode_ha, mult, sub);

figure;
histogram(home_init_mode_j2(:));
figure;
histogram(home_init_mode_ha(:));

