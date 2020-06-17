function [X] = LU_invert(A)
[L, U] = LU_decompose(A);
N = length(A);

%% Forward substitution (solving LY = E)
Y = eye(N);
for i = 2 : N
    for j = 1 : (i-1)
        temp_sum = 0;
        for k = 1 : (i-1)
            temp_sum = temp_sum + L(i, k) * Y(k, j);
        end
        Y(i, j) = -temp_sum;
    end
end

%% Backward substitution (solving UX = Y)
X = Y ./ repmat(diag(U), 1, N);
for i = (N - 1) : -1 : 1
    for j = N : -1 : 1
        temp_sum = 0;
        for k = (i + 1) : N
            temp_sum = temp_sum + U(i, k) * X(k, j);
        end
        X(i, j) = X(i, j) - temp_sum / U(i, i);
    end
end

end