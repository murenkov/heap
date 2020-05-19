function bdz6(f,ab,epsilon)
  syms x;
  xx=ab(1):0.01:ab(2);
  disp('найдём n и Rx перебором')
  n=2;
  [difmax] = max(subs(diff(f, (n+1)), xx));
  difmax=sym2poly(difmax);
  Rx = (difmax/factorial(n+1))*((ab(2)-ab(1))^(n+1))*2^(1-2*(n+1));
  
  for n = 1:2
    [difmax]=max(subs(diff(f,(n+1)),xx));
    difmax=sym2poly(difmax);
    n, Rx=(difmax/factorial(n+1))*((ab(2)-ab(1))^(n+1))*2^(1-2*(n+1))
  endfor
disp(['n = ',num2str(n),' Rx = ', num2str(Rx)])
##syms k;
##xk=(ab(2)+ab(1))/2 + ((ab(2)-ab(1))/2)*cos(((2*k-1)*pi)/(2*n))
##for i=1:n
##  xxx(i)=(ab(2)+ab(1))/2 + ((ab(2)-ab(1))/2)*cos(((2*i-1)*pi)/(2*n));
##  disp(['x(', num2str(i), ') = ', num2str(xxx(i))])
##endfor
endfunction