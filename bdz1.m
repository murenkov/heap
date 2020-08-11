clear, clc
random_series = [
    1.47 16.94 9.39 11.31 5.42 3.37 10.43 8.64 4.79 -1.52 ...
    16.39 16.08 1.81 12.51 5.39 3.89 1.96 4.64 7.52 0.13 ...
    7.28 -0.34 5.96 2.33 12.55 3.51 5.71 8.73 5.79 4.09 ...
    -1.40 4.93 12.02 8.69 1.40 11.16 6.11 10.17 7.45 -3.96 ...
    1.83 14.12 5.87 3.93 8.01 9.40 3.40 8.16 0.90 3.60 ...
    ];
disp('Ваш ряд:')
disp(random_series)
% sprintf('%.2f\t\n%.2f\t\n%.2f\t\n%.2f\t\n%.2f\t\n', ...
%     ISH(1:10), ISH(11:20), ISH(21:30), ISH(31:40), ISH(41:50))
% fprintf('%.2f\t\n', ISH(1:10))
% fprintf('%.2f\t\n', ISH(11:20))
% fprintf('%.2f\t\n', ISH(21:30))
% fprintf('%.2f\t\n', ISH(31:40))
% fprintf('%.2f\t\n', ISH(41:50))

disp('Вариационный ряд:')
variational_series = sort(random_series);
disp(variational_series)
% sprintf('%.2f\t\n%.2f\t\n%.2f\t\n%.2f\t\n%.2f\t\n', ...
%     A(1:10), A(11:20), A(21:30), A(31:40), A(41:50))
% fprintf('%.2f\t', A(1:10))
% fprintf('%.2f\t', A(11:20))
% fprintf('%.2f\t', A(21:30))
% fprintf('%.2f\t', A(31:40))
% fprintf('%.2f\t', A(41:50))

number_of_digits = 7;
volume = 50;
fprintf('Найдём размах(w) и delta\n')
sequence_range = range(variational_series);
delta = sequence_range / number_of_digits;
fprintf('w = %.3f\n', sequence_range)
fprintf('delta = %.3f\n', delta)
[N, Z] = hist(variational_series, number_of_digits)
N = N';
Z = Z';
N_relative = N ./ volume;
N_histogram = N_relative ./ delta;
Nc = cumsum(N);
Nc_rel = Nc ./ volume;
Nj = N ./ delta;
number_of_digits = 1:7;
rz(1) = min(variational_series);
for i = 2:8
    rz(i) = rz(i-1) + delta;
end
maxstr = 0;
cur = 0;
maxima = 0;
for i=1:7
    cur = length(sprintf('[%.3f %.3f)', rz(i), rz(i+1)));
    if(cur > maxima)
        maxima = cur;
    end
end

disp(['№             Разряд         Середина  Частота  Отн.Частота   Высота   Накопленная   Относительная   nj/' 916])
disp('Разряда                       разряда                         гистогр    частота        нак. част.      ')
for i=1:7
    a(1,1)=' ';
    b=' ';
    cur=length(sprintf('[%.3f %.3f)', rz(i), rz(i+1)));
    maxima - cur;
    for temp=0:(maxima-cur)
        temp;
        a((temp+1),1)=b;
    end
    a=a';
    s5=' ';
    s6=' ';
    sm3='';
    if(N(i) < 10)
        s5='  ';
    end
    if(N_relative(i) == 0)
        s6='    ';
    end
    if (Nc(i) < 10)
        sm3=' ';
    end
    if(i~=7)
        fprintf('%g          [%.3f %.3f)%s     %.3f      %g%s       %.2f       %.3f        %.3g%s             %.2f       %.3g\n',number_of_digits(i),rz(i),rz(i+1),a,Z(i),N(i),s5,N_relative(i),N_histogram(i),Nc(i),sm3,Nc_rel(i),Nj(i))
    else
        fprintf('%g          [%.3f %.3f]%s     %.3f      %g%s       %.2f       %.3f        %.3g             %.2f       %.3g\n',number_of_digits(i),rz(i),rz(i+1),a,Z(i),N(i),s5,N_relative(i),N_histogram(i),Nc(i),Nc_rel(i),Nj(i))
    end
    clear a
end

%% Построение гистограмм
figure(1)
clf
hold on
grid on
bar(Z, Nj, 1, 'g')
plot(Z, Nj, 'b', Z, Nj, 'bx')
title('гистограмма частот и полигон')
ylabel(['nj/' 916])

figure(2)
clf
hold on
bar(Z, N_histogram, 1, 'g')
grid on
ylabel(['nj / (n' 916 ')'])
title('гистограмма относительных частот')

figure(3)
clf
hold on
stairs([(min(random_series) - delta) Z' max(random_series) + delta], [0 N_relative' 1])
grid on
ylabel('F(x)')

%%
disp('  ')
disp('  ')
disp('оценки по негруппированным данным')
disp('оценка медианы')
hx=(random_series(25)+random_series(26))/2;
fprintf('hx = %.4f\n',hx)
disp('оценка среднего')
xn=sum(random_series)/volume;
fprintf('xn = %.4f\n',xn)
disp('выборочная смещенная дисперсия')
Dx=(sum(random_series.^2)-volume*xn^2)/volume;
fprintf('Dx = %.4f\n',Dx)
disp('несмещенная дисперсия')
S2 = (sum(random_series.^2)-volume*xn^2)/(volume-1);
fprintf('S2 = %.4f\n',S2)
disp('    оценка        оценка          смещенная        несмещенная')
disp('    медианы      среднего         дисперсия         дисперсия')
disp('      hx            xn               Dx                 S2')
fprintf('     %.4g        %.4g             %.4g             %.4g\n', hx, xn, Dx, S2)
disp('  ')
disp('  ')
disp('оценки по группированным данным')
disp('оценка среднего')
xnG=sum(Z.*N)/volume;
disp(sprintf('xnG = %.4f',xnG))
disp('выборочная смещенная дисперсия')
DxG=(sum(Z.^2.*N)-volume*xnG^2)/volume;
disp(sprintf('DxG = %.4f',DxG))
disp('несмещенная дисперсия')
S2G=(DxG*volume)/(volume-1);
disp(sprintf('S2G = %.4f',S2G))
disp('выборочная мода')

for i=1:(length(rz)-1)
    plotn(i)=length(find(random_series<rz(i+1)&random_series>rz(i)));
end
plotn(1)=plotn(1)+1;
if(sum(plotn)~=50)
    plotn(7)=plotn(7)+1;
    summplotnostey=sum(plotn)
end
[nd,adnum]=max(plotn);
ad=rz(adnum);
if(adnum-1==0)
    ndmin=0;
else
    ndmin=plotn(adnum-1);
end
if(adnum+1==8)
    ndplus=0;
else
    ndplus=plotn(adnum+1);
end
dxG=ad+((nd-ndmin)/(2*nd-ndmin-ndplus))*delta;
disp(sprintf('dxG = %.4f',dxG))

disp('оценка медианы')

h = 0;
aio = (random_series(25) + random_series(26)) / 2;

for i=1:7
    if rz(i) < aio && aio < rz(i + 1)
        ah = rz(i);
        h = i;
        break
    end
end
nh = plotn(h);
nhm = sum(plotn(1 : (h - 1)));
hxG = ah + ((volume / 2 - nhm) / nh) * delta;
fprintf('hxG = %.4f\n', hxG)
disp('    оценка        оценка          смещенная        несмещенная       выборочная')
disp('    медианы      среднего         дисперсия         дисперсия           мода')
disp('      hxG           xnG              DxG               S2G              dxG')
fprintf( ...
    '     %.4g        %.4g             %.4g             %.4g            %.4g', ...
    hxG, ...
    xnG, ...
    DxG, ...
    S2G, ...
    dxG ...
    )

text = {'Внимательно глянь на плотность(графики 3/4) и функцию(графики 4/5).'; 'Как думаешь, какое это распределение?'};
choice = menu(text, 'равномерное', 'нормальное', 'показательное');
switch choice
    case 1
        ypl=unifpdf([(min(random_series)-delta) random_series max(random_series)+delta],min(random_series),max(random_series));
        y=unifcdf([(min(random_series)-delta) random_series max(random_series)+delta],min(random_series)-delta,max(random_series)+delta);
    case 2
        ypl=normpdf([(min(random_series)-delta) random_series max(random_series)+delta],mean(random_series),sqrt(var(random_series)));
        y=normcdf([(min(random_series)-delta) random_series max(random_series)+delta],mean(random_series),sqrt(var(random_series)));
    case 3
        ypl=exppdf([(min(random_series)-delta) random_series max(random_series)+delta],mean(random_series));
        y=expcdf([(min(random_series)-delta) random_series max(random_series)+delta],mean(random_series));
    otherwise
        errordlg('Ты чево наделал? Ну, решу за тебя тогда','Ты сам куда-то не нажал')
        ypl=normpdf([(min(random_series)-delta) random_series max(random_series)+delta],mean(random_series),sqrt(var(random_series)));
        y=normcdf([(min(random_series)-delta) random_series max(random_series)+delta],mean(random_series),sqrt(var(random_series)));
end
figure(2)
plot([(min(random_series)-delta) random_series max(random_series)+delta],ypl)
figure(3)
plot([(min(random_series)-delta) random_series max(random_series)+delta],y)
axis([(min(random_series)-delta) (max(random_series)+delta) -0.1 1.1])
choice=menu('указать точные точки на графике?','ага','не, спасибо');
switch choice
    case 1
        figure(1)
        set(gca,'XTick',unique(sort([rz Z'])))
        set(gca,'YTick',unique((sort(Nj))'))
        figure(2)
        set(gca,'XTick',unique(sort([rz Z'])))
        set(gca,'YTick',unique((sort([Nhis' max(ypl)]))'))
        figure(3)
        set(gca,'XTick',unique(sort([rz Z'])))
        set(gca,'YTick',unique((sort([0 NcOtn' 1]))'))
    case 2
        errordlg('Ну ОК','Ну ОК')
    otherwise
        errordlg('Ты чево наделал? Ну, решу за тебя тогда','Ты сам куда-то не нажал')
end

%% Лабораторная 3
disp('')
dovver=input('Введите доверительную вероятность\n');
a=1-dovver;
disp('')
disp('доверительные интервалы')
nlowintm = xn - sqrt(S2 / volume) * tinv((1 - a / 2), (volume - 1));
nupintm = xn + sqrt(S2 / volume) * tinv((1 - a / 2), (volume - 1));
glowintm = xn - sqrt(S2G / volume) * tinv((1 - a / 2), (volume - 1));
gupintm = xn + sqrt(S2G / volume) * tinv((1 - a / 2), (volume - 1));

nlowintp = (volume - 1) * S2 / chi2inv((1-a/2), volume - 1);
nupintp = (volume - 1) * S2 / chi2inv((a/2), volume- 1);
glowintp = (volume - 1)* S2G / chi2inv((1-a/2), volume - 1);
gupintp = (volume - 1) * S2G / chi2inv((a/2), volume - 1);

disp('для негруппированной выборки')
fprintf( ...
    ['%.3g<m<%.3g            %.3g<' 963 '^2<%.3g\n'], ...
    nlowintm, ...
    nupintm, ...
    nlowintp, ...
    nupintp ...
    )

disp('для группированной выборки')
fprintf( ...
    ['%.3g<m<%.3g            %.3g<' 963 '^2<%.3g\n'], ...
    glowintm, ...
    gupintm, ...
    glowintp, ...
    gupintp ...
    )

disp('')
disp('_________________Проверка Гипотез_________________')
disp('Гипотезы:')
disp('H01: mx = xn + 0.5sqrt(S2)')
M0 = xn + 0.5 * sqrt(S2);
fprintf('M0 = %.3f\n', M0)
if M0 > nlowintm && M0 < nupintm
    disp('Гипотеза принята')
else
    disp('Гипотеза не принята')
end
disp('H02: Dx = 2 * S2')
A0=2*S2;
fprintf('A0 = %.3f\n', A0)
if A0 > nlowintp && A0 < nupintp
    disp('Гипотеза принята')
else
    disp('Гипотеза не принята')
end
disp('______________')
disp('H01: mx = xn + 0.5sqrt(S2G)')
M0 = xn + 0.5 * sqrt(S2G);
fprintf('M0 = %.3f\n', M0)
if M0 > glowintm && M0 < gupintm
    disp('Гипотеза принята')
else
    disp('Гипотеза не принята')
end
disp('H02: Dx = 2*S2G')
A0 = 2 * S2G;
fprintf('A0 = %.3f\n',A0)
if A0 > glowintp && A0 < gupintp
    disp('Гипотеза принята')
else
    disp('Гипотеза не принята')
end

disp(['____________________вычисление статистики ' 967 '^2____________________'])
disp('')
rzsz=rz;
for i = 1 : (length(rzsz) - 1)
    chplotn(i) = length(find(random_series < rzsz(i + 1) & random_series > rzsz(i)));
end
nums = find(chplotn < 5);
for i = 1 : length(nums)
    if(nums(i) == 1)
        nums(i) = nums(i) + 1;
    end
end
rzsz(nums) = [];
clear chplotn;
for i = 1 : (length(rzsz) - 1)
    chplotn(i) = length(find(random_series < rzsz(i + 1) & random_series > rzsz(i)));
end
pnum = length(rzsz) - 1;
rzsz(1) = -inf;
rzsz(length(rzsz)) = inf;
for i = 1 : pnum
    p(i) ...
        = normcdf(((rzsz(i + 1) - xnG) / sqrt(S2G)), 0, 1) ...
        - normcdf(((rzsz(i) - xnG) / sqrt(S2G)), 0, 1);
end
for i=1:(length(rzsz)-1)
    chplotn(i) = length(find(random_series < rzsz(i+1) & random_series > rzsz(i)));
end
numer = 1 : pnum;
nj = p .* 50;
njdif = ((chplotn - nj).^2) ./ nj;
disp('Номер      Интервал         nj       njtheor      ((nj - njtheor)^2) / njtheor')
fprintf( ...
    '%g        (%g %.3f)       %.3f       %.3f                 %.3f\n', ...
    numer(1), ...
    rzsz(1), ...
    rzsz(1+1), ...
    chplotn(1), ...
    nj(1), ...
    njdif(1) ...
    )
for i = 2:(pnum-1)
    fprintf( ...
        '%g        [%.3f %.3f)       %.3f       %.3f                 %.3f\n', ...
        numer(i), ...
        rzsz(i), ...
        rzsz(i+1), ...
        chplotn(i), ...
        nj(i), ...
        njdif(i) ...
        )
end
fprintf( ...
    '%g        [%.3f %.3f)       %.3f       %.3f                 %.3f\n', ...
    numer(pnum), ...
    rzsz(pnum), ...
    rzsz(pnum+1), ...
    chplotn(pnum), ...
    nj(pnum), ...
    njdif(pnum) ...
    )

chism=sum(njdif);
fprintf(['(' 967 '^2)в = %.4f\n'], chism)
kchi = length(number) - length(numer);
chichi = chi2inv(1-a, pnum-kchi-1);
fprintf(['(' 967 '^2)[%g][%g] = %.4f\n'], (1 - a), pnum-kchi-1, chichi)

if chism < chichi
    disp('Гипотеза о нормальном распределении не отвергается')
else
    disp('Гипотеза о нормальном распределении отвергается')
end