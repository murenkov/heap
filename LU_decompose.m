function [L, U] = LU_decompose(A)
N = length(A);

%% Get upper triangular matrix using matrix operations
U = A;
coefficient_matrix = zeros(N);
for j = 1 : N-1
    multipliers = U(j+1:N, j) / U(j, j);
    U(j+1:N, j:N) = U(j+1:N, j:N) ...
        - repmat(multipliers, 1, N-(j-1)) .* repmat(U(j, j:N), N-j, 1);
    
    coefficient_matrix(j+1:N, j) = multipliers;
end

%% Get lower unitriangular matrix
L = coefficient_matrix + eye(N);

end