%% Clearing workspace
clc
clear all
close all
format rat

%% Setting up random linear system
A = randi([3 10], 2);
A(1, 2) = randi([0 A(1, 1)-1]);
A(2, 1) = randi([0 A(2, 2)-1]);
b = randi(15, 2, 1);
x = randi(2, 2, 1); % starting approximation
table(A, b, x)

%% Example
% A = [
%     5 1
%     3 6
%     ];
% b = [10 8]'; 
% x = [1 1]'; % starting approximation

%% Jacobi method
D = diag(diag(A));
LU = A - D;
table(D, LU)

B = - inv(D) * LU
g = D \ b
table(B, g)

for k = 1 : 2
    fprintf('%dth iteration:\n', k);
    x = B * x + g
end
