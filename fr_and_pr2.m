%% Clearing workspace
clc
clear all
close all

%% Parametres of the scheme
R1 = 1;
R2 = 1;
R3 = 1;
L = 1;
C = 1;

%% Defining coefficients
k_res = (R1 + R2) / (R1 * R2) * R3 + 1;
k_inf = 0;
R_eq = R2;

z_0 = sqrt(L / C);
w_0 = 1 / sqrt(L * C);
Q = z_0 / R_eq;

%% Plotting frequency and phase responses
figure(1)
w = 0 : 0.01 : 1000;

subplot(2, 1, 1)
K_abs = sqrt( ...
    (k_res^2 + k_inf^2 * Q^2 * (w ./ w_0 - w_0 ./ w).^2) ...
    ./ (1 + (w ./ w_0 - w_0 ./ w).^2) ...
    );
semilogx(w, K_abs)
grid on
title('юву')

subplot(2, 1, 2)
phi = atan(k_inf / k_res * Q * (w ./ w_0 - w_0 ./ w)) ...
    - atan(Q * (w ./ w_0 - w_0 ./ w));
semilogx(w, phi)
grid on
title('тву')
