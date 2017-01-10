clear; clc;

% numTrials_PerTask = 18;
% interface_type = {'j2', 'hA'};
% IT_Order = cell(numTrials_PerTask, 1);
% 
% j2loc = randsample(numTrials_PerTask, numTrials_PerTask/2);
% hAloc = setdiff([1:numTrials_PerTask]', j2loc);
% 
% IT_Order(j2loc,1) = cellstr(interface_type{1});
% IT_Order(hAloc,1) = cellstr(interface_type{2});


n = 18;
A = [1, -1];
B = [1, 0, -1];
C = [1, 0, -1];

A_Full = repmat(A, n/length(A), 1);
A_Full = A_Full(:);

B_Full = repmat(B', n/length(B), 1);

C_Full = repmat(C, n/length(C), 1);
C_Full = repmat(C_Full(1:3, :), 1,2);
C_Full = C_Full(:);

TrialMatrix = [A_Full, B_Full, C_Full];


TrialMatrix_Shuffled = TrialMatrix(randperm(n), :);