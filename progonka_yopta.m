%% Clearing workspace
clc
clear all
close all
format rat

%% Matrix DeGenerator
MIN = 10;
MAX = 20;
N = input('������� ���������� ��������� ��� ����������: ');
matrix = diag(randi([MIN MAX], N, 1));

matrix(1, 2) = randi([1 matrix(1, 1)-1]);
matrix(N, N-1) = randi([1 matrix(N, N)-1]);
for k = 2 : N-1
    LOCAL_MAX = matrix(k, k) - 1;
    matrix(k, k-1) = randi([1 LOCAL_MAX]);
    matrix(k, k+1) = randi([1 LOCAL_MAX-matrix(k, k-1)]);
end
free = randi(MAX, 5, 1);

%% Setting matrices
A = matrix;
f = free;
fprintf('���� ����: \n')
A, f

%% Xui znaet
f(1) = - f(1) / A(1, 1);
A(1, :) = - A(1, :) / A(1, 1);
f(N) = - f(N) / A(N, N);
A(N, :) = - A(N, :) / A(N, N);
fprintf('������� � ������ ����: \n')
A, f

%% Forward substitution
alpha = zeros(N-1, 1);
beta = zeros(N-1, 1);
alpha(1) = A(1, 2);
beta(1) = -f(1);
for k = 2 : N-1
    alpha(k) = A(k, k+1) / (-A(k, k) - alpha(k-1) * A(k, k-1));
    beta(k) = (A(k, k-1) * beta(k-1) - f(k)) / (-A(k, k) - alpha(k-1) * A(k, k-1));
end
fprintf('����� �� ���� �� 1-�� �� n-���: \n')
alpha, beta

%% Backward substitution
x = zeros(N, 1);
x(N) = (A(N, N-1) * beta(N-1) - f(N)) / (1 - A(N, N-1) * alpha(N-1));

for k = N-1 : -1 : 1
    x(k) = x(k+1) * alpha(k) + beta(k);
end
fprintf('���� �� 0-�� �� n-����: \n')
x

%% Error
format long
fprintf('��� ������ �� ����, ������ ���� ��� ���������� �� ������� � ���� �����, ����� �������������: \n')
average_error = sum(abs(A \ f - x)) / N;
disp(average_error)