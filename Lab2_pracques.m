%% Min z = 3x1 - 5x2 
% where s.t. are 
% x1 + x2 <= 6 
% 2x1 - x2 >= 9 
% x1 + 2x2 <= 6
% x1 >= 0
% x2 >= 0

clc ;
clear;

%% Phase 1, input parameter
C = [3 -5];
Z = @(x1, x2)3*x1 - 5*x2;


A = [1 1; 2 -1; 1 2];
b = [6; 9; 6];


C1 = @(x1, x2) x1 + x2 - 6;
C2 = @(x1, x2) 2*x1 - x2 - 9;
C3 = @(x1, x2) x1 + 2*x2 - 6;

% number of constraints 
[m, n] = size(A);

%% Phase 2 Plotting
x1 = 0:max(b./A(:, 1)); 
for i = 1:m
    x2 = (b(i) - A(i, 1) * x1) / A(i, 2);

    plot(x1, x2)
    hold on
end 

%% Phase 3 Find intersection & corner points
A = [A; eye(n)];
b = [b; zeros(2, 1)]; 

m = size(A, 1); 
pt = [];
for i = 1:m
    for j = i + 1: m 
        aa = [A(i, :); A(j, :)];
        bb = [b(i); b(j)];
        if (det(aa))
            X = aa \ bb;
            if(X >= 0)
                pt = [pt X];
            end
        end
    end
end

pt = unique(pt', "rows")';
disp(pt)

%% Phase 4 Find Feasable points 
FP = [];
z = [];
for i = 1:size(pt, 2) % 2 gives columns, i.e. loop in number of points
    pt1 = pt(1, i); % x1 of ith point
    pt2 = pt(2, i); % x2 of ith point
    if(C1(pt1, pt2) <= 0 && C2(pt1, pt2) >= 0 && C3(pt1, pt2) <= 0)
        FP = [FP pt(:, i)]; 
        plot(pt1, pt2, '*r', 'MarkerSize', 30);
        cost = Z(pt1, pt2);
        z = [z cost];
    end
end

disp(FP)
disp(z)

%% Phase 5 finding optimal solution and value
[optimal_val index] = min(z)
optimal_sol = FP(:, index)
fprintf('Optimal Solution: x1 = %.2f, x2 = %.2f\n', optimal_sol(1), optimal_sol(2));
fprintf('Optimal Value: Z = %.2f\n', optimal_val);


