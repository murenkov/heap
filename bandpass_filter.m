%% Clearing workspace
clc
clear all
close all
format short

%% Scheme parametres
type = 'butterworth';
central_frequency = 5e6;
bandwidth = 0.15e6;
pulsations_level = 3;
stopband = 0.375e6;
stop_level = 20;
resistance = 50;

%% Calculating coefficents
k_pass = stopband / bandwidth;
k_selective ...
    = sqrt((10^(stop_level / 10) - 1) / (10^(pulsations_level / 10) - 1));
table(k_pass, k_selective)

%% Get order
order = ceil(log10(k_selective) / log10(k_pass));
fprintf('Порядок равен %d\n', order);

%% Get general elements of prototype filter
g = zeros(1, order);
for k = 1 : order
    g(k) = 2 * sin(((2 * k - 1) * pi) / (2 * order));
end
g = [1 g 1];
disp('Обобщённые элементы:');
disp(g);

%% Get values
Q_generator = (g(1) * g(2)) / (bandwidth / central_frequency);
Q_workload = (g(order+1) * g(order+2)) / (bandwidth / central_frequency);
k_connection = zeros(1, order - 1);
for k = 1 : (order - 1)
    k_connection(k) = (bandwidth / central_frequency) / sqrt(g(k+1) * g(k+2));
end
disp('Коэффициенты связи:');
disp(k_connection);
table(Q_generator, Q_workload, k_connection)

%% Get parametres
L = resistance / (2 * pi * central_frequency * Q_generator);
C = Q_generator / (2 * pi * central_frequency * resistance);
table(L, C)

%% Get capacities
C_connection = zeros(1, length(k_connection));
for k = 1 : length(C_connection)
    C_connection(k) = k_connection(k) * C;
end
disp('Ёмкости связи:');
disp(C_connection);

%% Correcting values
Ci = C - sum(C_connection) / 2;
fprintf('Скорректированное значение ёмкости: %d\n', Ci);