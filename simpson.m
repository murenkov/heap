function [int] = simpson(fun, left, right, n)
    step = (right - left) / n;
    int = 0;
    cur = left;
    for i = 1:n
        member = (fun(cur) + 4 * fun(cur+step/2) + fun(cur+step)) * step / 6;
        int = int + member;
        cur = cur + step;
    end
end
