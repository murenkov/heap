function [int] = right_rect(fun, left, right, n)
    step = (right - left) / n;
    members_sum = 0;
    for i = 1:n
        current = left + i * step;
        members_sum = members_sum + fun(current);
    end
    int = step * members_sum;
end
