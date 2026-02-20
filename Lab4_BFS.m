%% Ques Max z = 6*x1 + 5*x2
% st -> x1 + x2 <= 5
% -> 3*x1 + 2*x2 <= 12
% -> x1 * x2 >= 0

% Maximize z = 6*x1 + 5*x2
% Subject to: 
% x1 + x2 + x3 = 5
% 3*x1 + 2*x2 + x4 = 12
% x1, x2, s3, x4 >= 0

%% Phase 1, Input parameters

clc; 
clear all;
clear figure;


C = [6 5 0 0];
A = [1 1 1 0;
    3 2 0 1]; 
b = [5; 12]; 

z = @(X) C*X;

m = size(A, 1); % Number of contraints
n = size(A, 2); % Number of variables 

%% Phase 2, Finding Basic Solution set and basic feasable set 
basicsol = [];
bfsol = [];
ncm = nchoosek(n, m); 
pair = nchoosek(1:n, m); 

for i = 1:ncm
    basicvar_index = pair(i, :);
    y = zeros(n, 1);
    % Solve for the basic feasible solution
    X = A(:, basicvar_index) \ b; 
    y(basicvar_index) = X;
    basicsol = [basicsol y];
    if(X >= 0)
        bfsol = [bfsol y];
    end
end

disp(basicsol)
disp(bfsol)

%% Phase 3 Optimal Solution and Optimal Value 
cost = z(bfsol);
[opt_val index] = max(cost);
optsol = bfsol(: , index);
disp('Optimal Solution:');

disp(optsol);
