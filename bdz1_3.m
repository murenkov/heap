figure(1)
hold on
grid on
xlim([-7 3])
ezplot(@(x) x.^4 + 5 .* x.^3 - 5 .* x.^2 + 0.5, [-7 3])