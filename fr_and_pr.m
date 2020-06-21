%% Clearing workspace
clc
clear all
close all

%% Parametres of the scheme
R1 = 1;
R2 = 1;
R3 = 1;
C = 1;

%% Defining coefficients
k_0 = 0;
k_inf = (R1 + R2) / (R1 * R2) * R3 + 1;
R_eq = R2;
tau = C * R_eq;

%% Plotting frequency and phase responses
figure(1)
w = 0 : 0.01 : 1000;

subplot(2, 1, 1)
K_abs = sqrt((k_0^2 + k_inf^2 * (w * tau).^2) ./ (1 + (w * tau).^2));
semilogx(w, K_abs)
grid on
title('АЧХ')

subplot(2, 1, 2)
phi = atan(k_inf / k_0 * w * tau) - atan(w * tau);
semilogx(w, phi)
grid on
title('ФЧХ')
