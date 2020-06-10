%% Очистка экрана
clc
clear
close all

%% Входные данные
n = 50;
N = transpose(1:n);
X = [ ...
    9.39 10.27 11.77 11.45 8.94 5.05 10.36 15.86 10.26 14.12 ...
    14.37 11.79 10.16 11.58 8.11 9.00 11.64 12.93 14.73 8.99 ...
    12.19 14.82 15.52 8.60 8.84 9.91 12.64 10.58 13.34 7.40 ...
    13.59 12.19 11.93 13.88 11.45 11.84 7.31 9.32 8.24 7.55 ...
    10.67 9.58 10.14 12.78 11.23 10.78 11.29 9.98 9.32 11.64 ...
    ]';
Y = [ ...
    20.27 28.41 25.82 23.01 20.43 18.14 28.38 31.57 23.80 31.98 ...
    38.48 27.51 29.30 25.79 18.40 25.34 26.05 27.78 30.12 20.24 ...
    26.12 36.88 31.49 20.70 20.54 13.89 31.30 26.81 28.46 9.94 ...
    27.27 29.04 29.14 29.05 29.38 25.75 17.62 17.43 24.34 18.51 ...
    18.89 13.79 24.06 28.92 26.45 23.23 25.60 22.34 21.78 29.06 ...
    ]';
A = [X'; Y']';
input_table = table(N, X, Y);
disp(input_table)

%% Изображение точек на плоскости
plot(X, Y, '.')
hold on
grid on
xlabel('X');
ylabel('Y');

%% Таблица частот
% TODO: Fix extendet variance table
variance_table = zeros(5, 10);
delta_x = 3;
delta_y = 3;
x_group = 4.5:delta_x:16.5;
y_group = 10.5:delta_y:37.5;
for i = 1:length(x_group)
    for j = 1:length(y_group)
        variance_table(i, j) = length(find( ...
            (A(:, 1) >= x_group(i) - delta_x / 2) & ...
            (A(:, 1) < x_group(i) + delta_x / 2) & ...
            (A(:, 2) >= y_group(j) - delta_y / 2) & ...
            (A(:, 2) < y_group(j) + delta_y / 2) ...
        ));
    end
end
extended_variance_table = [ ...
    0 y_group 0;
    x_group' variance_table zeros(5, 1);
    zeros(1, 12);
    ];
for i = 2:11
    extended_variance_table(7, i) = sum(extended_variance_table(2:6, i));
end
for j = 2:7
    extended_variance_table(j, 12) = sum(extended_variance_table(j, 2:11));
end
disp(extended_variance_table)

%% Вычисление числовых характеристик негруппированных данных
% TODO: Fix formulas
average_ungroupped_x = sum(X) / n;
average_ungroupped_y = sum(Y) / n;
unbiased_ungroupped_variance_x = ...
    (sum(X.^2) - n * average_ungroupped_x^2) / (n - 1);
unbiased_ungroupped_variance_y = ...
    (sum(Y.^2) - n * average_ungroupped_y^2) / (n - 1);
ungroupped_covariance = ...
    (sum(X .* Y) - n * average_ungroupped_x * average_ungroupped_y) / (n - 1);
ungroupped_correlation = ...
    ungroupped_covariance / sqrt(unbiased_ungroupped_variance_y * unbiased_ungroupped_variance_x);

%% Вычисление числовых характеристик группированных данных
average_groupped_x = sum(x_group .* extended_variance_table(2:6, 12)') / n;
average_groupped_y = sum(y_group .* extended_variance_table(7, 2:11)) / n;
unbiased_groupped_variance_x = ...
    (sum((x_group.^2) .* extended_variance_table(2:6, 12)') ...
    - n * (average_groupped_x^2)) / (n-1);
unbiased_groupped_variance_y = ...
    (sum((y_group.^2) .* extended_variance_table(7, 2:11)) ...
    - n * (average_groupped_y^2)) / (n-1);
groupped_covariance = ...
    (sum(sum(variance_table ...
    .* repmat(extended_variance_table(2:6, 1), 1, 10) ...
    .* repmat(extended_variance_table(1, 2:11), 5, 1))) ...
    - n * average_groupped_x * average_groupped_y) / (n - 1);
groupped_correlation = ...
    groupped_covariance ...
    / sqrt(unbiased_groupped_variance_y * unbiased_groupped_variance_x);

%% Вывод таблицы с числовыми характеристиками
disp('Числовые характеристики')
charachteristics = table( ...
    [average_ungroupped_x; average_groupped_x], ...
    [average_ungroupped_y; average_groupped_y], ...
    [unbiased_ungroupped_variance_x; unbiased_groupped_variance_x], ...
    [unbiased_ungroupped_variance_y; unbiased_groupped_variance_y], ...
    [ungroupped_covariance; groupped_covariance], ...
    [ungroupped_correlation; groupped_correlation], ...
    'RowNames', {'Негрупированные'; 'Группированные'}, ...
    'VariableNames', {'xsr', 'ysr', 'sx', 'sy', 'kxy', 'pxy'} ...
    );
disp(charachteristics);

%% 
disp(['Проверка гипотезы H0: ' 961 ' = 0'])
alpha = 0.05;
fprintf('\n\nПроверка статистикой Z\n\n')
stud = tinv((1 - alpha / 2), n - 2);
fprintf('t(%g)[%g] = %g\n', (1-alpha / 2), (n - 2), stud)

Zv = ungroupped_correlation * sqrt(n - 2) / sqrt(1 - ungroupped_correlation^2);
disp(Zv)

if (abs(Zv) > stud)
    disp('гипотеза отклоняется в пользу H1. Корреляция значима')
else
    disp('гипотеза принята')
end

fprintf('\n\n Проверка статистикой U\n\n')
U = norminv(1 - alpha / 2);
fprintf('u(%g)=%g\n', (1 - alpha / 2), U)
Uv = sqrt(n - 3) * atanh(ungroupped_correlation);
disp(Uv)


if (abs(Uv) > U)
    disp('гипотеза отклоняется в пользу H1. Корреляция значима')
else
    disp('гипотеза принята')
end

fprintf('\n\nИнтервальная оценка:\n')
left=tanh(atanh(ungroupped_correlation)-U/sqrt(n-3)-ungroupped_correlation/(2*(n-1)));
right=tanh(atanh(ungroupped_correlation)+U/sqrt(n-3)-ungroupped_correlation/(2*(n-1)));
fprintf(['\n%.4f<' 961 '[x,y]<%.4f\n'],left,right)
if(left>0||right<0)
    disp('Интервал не содержит 0, т.е. с доверительной вероятностью')
    disp('1-a существует корреляция между X и Y и имеет смысл уравнение регрессии')
    syms x y x0;
    nyx=average_ungroupped_y+ungroupped_correlation*sqrt(unbiased_ungroupped_variance_y/unbiased_ungroupped_variance_x)*(x-average_ungroupped_x);
    fprintf('\nungroupped y(x)=%s\n with coeffs: %g\t%g',char(nyx),double(coeffs(nyx)))
    nxy=average_ungroupped_x+ungroupped_correlation*sqrt(unbiased_ungroupped_variance_x/unbiased_ungroupped_variance_y)*(y-average_ungroupped_y);
    fprintf('\nungroupped x(y)=%s\n with coeffs: %g\t%g',char(nxy),double(coeffs(nxy)))
    gyx=average_groupped_y+groupped_correlation*sqrt(unbiased_groupped_variance_y/unbiased_groupped_variance_x)*(x-average_groupped_x);
    fprintf('\ngroupped y(x)=%s\n with coeffs: %g\t%g',char(gyx),double(coeffs(gyx)))
    gxy=average_groupped_x+groupped_correlation*sqrt(unbiased_groupped_variance_x/unbiased_groupped_variance_y)*(y-average_groupped_y);
    fprintf('\ngroupped x(y)=%s\n with coeffs: %g\t%g\n',char(gxy),double(coeffs(gxy)))
    plot(X,subs(nyx,X),'k')
    plot(X,subs(nxy,X),'b')
%     plot(X,subs(gyx,X),'r')
%     plot(X,subs(gxy,X),'g')
    legend('диаграмма распределения','y(x) негрупп','x(y) негрупп')%,'y(x) групп','x(y) групп')
 conyx=double(coeffs(nyx));anyx=conyx(2);bnyx=conyx(1);
 Qy=sum(Y.^2)-n*average_ungroupped_y^2;
 Qr=(n-1)*(ungroupped_covariance^2)/unbiased_ungroupped_variance_x;
 Qe=Qy-Qr;
 sOst=Qe/(n-2);
 R=Qr/Qy;
 fprintf('\na=%f,b=%f\n',anyx,bnyx)
 fprintf('\nQy=%f, Qr=%f, Qe=%f, оценка s^2=%f, \nR^2=%f\n',Qy,Qr,Qe,sOst,R)
 fprintf('\n проверка %f = %f\n',ungroupped_correlation,sign(anyx)*sqrt(R))
 fprintf('\n найдём квантили распределения\n')
 ti = tinv(1-alpha/2,n-2)
 xi1 = chi2inv(1-alpha/2,n-2)
 xi2 = chi2inv(alpha/2,n-2)
 fprintf('\n\n')
 aleft=anyx-ti*sqrt(sOst/((n-1)*unbiased_ungroupped_variance_x));
 aright=anyx+ti*sqrt(sOst/((n-1)*unbiased_ungroupped_variance_x));
 bleft=bnyx-ti*sqrt(sOst*sum(X.^2)/(n*(n-1)*unbiased_ungroupped_variance_x));
 bright=bnyx+ti*sqrt(sOst*sum(X.^2)/(n*(n-1)*unbiased_ungroupped_variance_x));
 dleft=(n-2)*sOst/(xi1);
 dright=(n-2)*sOst/(xi2);
 fprintf(['%.4f < a < %.4f \t %.4f < b < %.4f \t %.4f < ' 963 ' < %.4f\n'],aleft,aright,bleft,bright,dleft,dright)
 disp('границы доверительных интервалов для среднего значения Y при х = х0')
 fprintf(['\ny0' 177 '%.4f' 8730 '%.4f*(1/%g + (x0-%.4f)^2/%.4f)\n'],ti,sOst,n,average_ungroupped_x,(n-1)*unbiased_ungroupped_variance_x)
 disp('проверим значимость линейной регрессии Y на x:')
 if(aleft>0||aright<0)
     fprintf('Гипотеза H0: a = 0 отклоняется на уровне значимости a = %g ,\nтак как доверительный интервал не накрывает нуль с доверительной вероятностью %g\n',alpha,1-alpha)
     disp('попробуем получить этот результат, используя статистику F')
     fv = (n-2)*Qr/Qe
     fprintf(['как видим, fv ' 8713 '(%.4f;%.4f)\n'],finv(alpha/2,1,48),finv(1-alpha/2,1,48))
     disp('Таким образом, линейная регрессия Y на x статистически значима')
 else
     fprintf('Гипотеза H1: a = 0 принимается на уровне значимости a = %g',alpha)
 end 
else
    disp('интервал содержит 0')
end