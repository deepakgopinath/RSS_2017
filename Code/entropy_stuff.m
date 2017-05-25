clear all; clc;

ng = 4;
% pd = rand(ng, 1);
pd = ones(ng, 1);
% pd = [0.9, 0.05, 0.03, 0.02];
pd = pd/sum(pd); 
ent = -sum(pd.*log2(pd));
fprintf('The entropy is %f \n', ent);