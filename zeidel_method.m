%% Clearing workspace
clc
clear all
close all
format rat

%% Setting up random linear system
% A = randi([3 10], 2);
% A(1, 2) = randi([0 A(1, 1)-1]);
% A(2, 1) = randi([0 A(2, 2)-1]);
% f = randi(15, 2, 1);
% x = randi(2, 2, 1); % starting approximation
% table(A, f, x)

%% Example
A = [
    4 2
    1 6
    ];
f = [1 2]'; 
x = [1 1]'; % starting approximation
table(A, f, x)

%% Zeidel method
D = diag(diag(A));
A_plus = [
    0 A(3)
    0 0
    ];
A_minus = [
    0 0
    A(2) 0
    ];
table(D, A_plus, A_minus)

P = - inv(A_minus + D) * A_plus
g = inv(A_minus + D) * f
table(P, g)

for k = 1 : 2
    fprintf('%dth iteration:\n', k);
    x = P * x + g
end