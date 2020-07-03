function [truth_table] = get_truth_table(type, basis, active, N)
truth_table = zeros(N, 6);
truth_table(5:8, 1) = 1;
truth_table(3:4:8, 2) = 1;
truth_table(4:4:8, 2) = 1;
truth_table(2:2:8, 3) = 1;

%% Fill in Q[t+1] column
switch type
    case 'R'
        for row = 1 : N
            R = truth_table(row, 1);
            S = truth_table(row, 2);
            if R ~= active(1) && S ~= active(2)
                truth_table(row, 4) = truth_table(row, 3);
            end
            if R ~= active(1) && S == active(2)
                truth_table(row, 4) = 1;
            end
            if R == active(1) && S ~= active(2)
                truth_table(row, 4) = 0;
            end
            if R == active(1) && S == active(2)
                truth_table(row, 4) = 0;
            end
        end
    case 'S'
        for row = 1 : N
            R = truth_table(row, 1);
            S = truth_table(row, 2);
            if R ~= active(1) && S ~= active(2)
                truth_table(row, 4) = truth_table(row, 3);
            end
            if R ~= active(1) && S == active(2)
                truth_table(row, 4) = 1;
            end
            if R == active(1) && S ~= active(2)
                truth_table(row, 4) = 0;
            end
            if R == active(1) && S == active(2)
                truth_table(row, 4) = 1;
            end
        end
    case 'E'
        for row = 1 : N
            R = truth_table(row, 1);
            S = truth_table(row, 2);
            if R ~= active(1) && S ~= active(2)
                truth_table(row, 4) = truth_table(row, 3);
            end
            if R ~= active(1) && S == active(2)
                truth_table(row, 4) = 1;
            end
            if R == active(1) && S ~= active(2)
                truth_table(row, 4) = 0;
            end
            if R == active(1) && S == active(2)
                truth_table(row, 4) = truth_table(row, 3);
            end
        end
end

%% Fill in R* and S* columns
switch basis
    case 'NOR'
        for row = 1 : N
            if isequal(truth_table(row, 3:4), [0 0])
                truth_table(row, 5:6) = [NaN 0];
            end
            if isequal(truth_table(row, 3:4), [0 1])
                truth_table(row, 5:6) = [0 1];
            end
            if isequal(truth_table(row, 3:4), [1 0])
                truth_table(row, 5:6) = [1 0];
            end
            if isequal(truth_table(row, 3:4), [1 1])
                truth_table(row, 5:6) = [0 NaN];
            end
        end
    case 'NAND'
        for row = 1 : N
            if isequal(truth_table(row, 3:4), [0 0])
                truth_table(row, 5:6) = [NaN 1];
            end
            if isequal(truth_table(row, 3:4), [0 1])
                truth_table(row, 5:6) = [1 0];
            end
            if isequal(truth_table(row, 3:4), [1 0])
                truth_table(row, 5:6) = [0 1];
            end
            if isequal(truth_table(row, 3:4), [1 1])
                truth_table(row, 5:6) = [1 NaN];
            end
        end
end
end