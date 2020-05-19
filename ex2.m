syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
X = [x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20];
n = length(X);
p = 10;

rep_X = repmat(X, p, 1);
powers = repmat(transpose(1:p), 1, n);
pow_X = rep_X .^ powers;
facts = repmat(transpose(factorial(1:p)), 1, n);
preresult = pow_X ./ facts;
result = transpose(sum(preresult, 1))