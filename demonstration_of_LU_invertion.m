%% Clearing workspace and command window
clc
clear all
close all
format rat

%% Setting up matrices
A = [
    4 3
    6 3
    ];
B = [
     1 4 -3
    -2 8  5
     3 4  7
    ];
C = [
     2 4 1
    -1 1 3
     3 2 5
    ];

%% Choosing current matrix
matrix = C;

%% LU-decomposition
[L, U, P] = lu(matrix);
disp(table(P, L, U, inv(P)*L*U))
[L, U] = LU_decompose(matrix);
disp(table(L, U, L*U, matrix))

%% LU-inversion
bi_inv = inv(matrix);
my_inv = LU_invert(matrix);
difference = bi_inv - my_inv;
disp(table(bi_inv, my_inv, difference))
