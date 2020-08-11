mu = 0;
sigma = 1;
sigma_square = sigma^2;

f = @(x) (2 * pi * sigma_square)^(-1/2) * exp(-(x - mu)^2 / (2 * sigma_square));
% F = @(x) integral(f, -inf, x);

figure(1)
hold on
grid on
% subplot(1, 2, 1)
ezplot(f)
% subplot(1, 2, 1)
% ezplot(F)