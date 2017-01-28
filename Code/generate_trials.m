clear all; clc; close all;
% 

sub = 8;
tasks = {'t1', 't2'};
assis = {'w', 'wo'}; repc = 8; trials = 12;
% assis = {'od'}; repc = 4; trials = 4;
ci = {'j2','hA'};
combi = length(assis)*length(ci);
num = sub*length(tasks);
tpercombo = trials/combi;
blocks = zeros(num, trials);
for i=1:num
    [M, R] = latin_square(combi); %ABCD refer to interface, assistance combo
    R = R(randsample(combi ,trials/combi), :); %sample 3 from the latin square
    R =  R';
    R = R(:);
    blocks(i, :) = R';
end
blocks = blocks'; %each column is a trial for each person each task.

ngt1 = 4; %num of goals in task 1 
ngt2 = 5; %num of goals in task 2
t1goal = zeros(repc*num, tpercombo); %8 originally generate goal order for 3 trials of each combination of interface and assistance. A new one to be used for a new subject
t2goal = zeros(repc*num, tpercombo); %each subject has 24 trials. 3 each of 4 different interface-assis combos for two tasks. There 8 different groups of 3 goal orders are needed.

for i=1:size(t1goal, 1)
    t1goal(i, :) = randsample(ngt1, tpercombo);
    t2goal(i, :) = randsample(ngt2, tpercombo);
end

tcombo = zeros(trials, 2, num); %column 1 is the interface-assis combo id, column 2 is the goal itself. 
for i=1:num
    t = blocks(:,i); %
    if mod(i, 2) == 1 %if task 1
        o = t1goal(combi*(i-1)+1 : combi*i , :);
    else
        o = t2goal(combi*(i-1)+1 : combi*i , :);
    end
    tcombo(:, 1, i) = t;
    for j=1:combi
        ind = find(t == j);
        tcombo(ind, 2, i) = o(j, :)';
    end
end

