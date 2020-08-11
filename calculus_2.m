clc;

a = 1;
x1 = @(t) 1 * (t - sin(t));
y1 = @(t) 1 * (t - sin(t));

x2 = @(t) t;
y2 = @(t) t.^2;

ezplot(x2, y2, 0, [0 2*pi])