figure(1)
hold on
grid on
xlim([2 2.5])
x = 2:0.01:2.5;
circle = @(x) 0.25 * sqrt(1 - (4 .* x - 9).^2);
ezplot(circle, [2 2.5])

x = [2.0122358709262116, 2.1030536869268817, 2.25, 2.3969463130731183, 2.4877641290737884];
x1 = 2.0122358709262116;
x2 = 2.1030536869268817;
x3 = 2.25;
x4 = 2.3969463130731183; 
x5 = 2.4877641290737884; 

plot([x(1) x(1)], [0 circle(x(1))])
plot([x(2) x(2)], [0 circle(x(2))])
plot([x(3) x(3)], [0 circle(x(3))])
plot([x(4) x(4)], [0 circle(x(4))])
plot([x(5) x(5)], [0 circle(x(5))])


##plot([x1 x1], [0 circle(x1)])
##plot([x2 x2], [0 circle(x2)])
##plot([x3 x3], [0 circle(x3)])
##plot([x4 x4], [0 circle(x4)])
##plot([x5 x5], [0 circle(x5)])
