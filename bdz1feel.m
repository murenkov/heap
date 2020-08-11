clear;clc
path=input('������� ���� �� ����� (� ��������)\n');
load(path,'AA');
variant=input('������� ��� �������\n��� �������: ');
ISH=(AA(:,variant))';
disp('��� ���:')
fprintf('%.3g    \n',ISH(1:16))
fprintf('%.3g    \n',ISH(16:32))
fprintf('%.3g    \n',ISH(32:48))
fprintf('%.3g    \n',ISH(49:50))
disp('����������� ���:')
A=sort(ISH);
disp(sprintf('%.3g    ',A(1:16)))
disp(sprintf('%.3g    ',A(16:32)))
disp(sprintf('%.3g    ',A(32:48)))
disp(sprintf('%.3g    ',A(49:50)))
m=7;
V=50;
disp(['����� ������(w) �' 916])
w=range(A);
delta=w/m;
disp(sprintf('w = %.3f',w))
disp(sprintf([916 ' = %.3f'],delta))
[N,Z]=hist(A,m);
N=(N)';
Z=(Z)';
Notn=N./V;
Nhis=Notn./delta;
Nc=cumsum(N);
NcOtn=Nc./V;
Nj=N./delta;
number=1:7;
rz(1)=min(A);
for i=2:8
rz(i)=rz(i-1)+delta;
end
maxstr=0;
cur=0;maxima=0;
for i=1:7
    cur=length(sprintf('[%.3f %.3f)',rz(i),rz(i+1)));
    if(cur>maxima)
        maxima=cur;
    end
end

disp(['�             ������         ��������  �������  ���.�������   ������   �����������   �������������   nj/' 916])
disp(['�������                       �������                         �������    �������        ���. ����.      '])
for i=1:7
a(1,1)=' ';
b=' ';
cur=length(sprintf('[%.3f %.3f)',rz(i),rz(i+1)));
maxima-cur;
for temp=0:(maxima-cur)
    temp;
    a((temp+1),1)=b;
end
a=a';
s5=' ';s6=' ';sm3='';
if(N(i)<10)
    s5='  ';
end
if(Notn(i)==0)
    s6='    ';
end
if(Nc(i)<10)
    sm3=' ';
end
if(i~=7)
    fprintf('%g          [%.3f %.3f)%s     %.3f      %g%s       %.2f       %.3f        %.3g%s             %.2f       %.3g\n',number(i),rz(i),rz(i+1),a,Z(i),N(i),s5,Notn(i),Nhis(i),Nc(i),sm3,NcOtn(i),Nj(i))
else
    fprintf('%g          [%.3f %.3f]%s     %.3f      %g%s       %.2f       %.3f        %.3g             %.2f       %.3g\n',number(i),rz(i),rz(i+1),a,Z(i),N(i),s5,Notn(i),Nhis(i),Nc(i),NcOtn(i),Nj(i))
end
clear a
end
%%%%%%%%%%%
figure(1);clf
hold on
grid on
bar(Z,Nj,1,'g')
plot(Z,Nj,'b',Z,Nj,'bx')
title('����������� ������ � �������')
ylabel(['nj/' 916])

%%%%%%%%%%%%%%
figure(2);clf;hold on
bar(Z,Nhis,1,'g')
grid on
ylabel(['nj/(n' 916 ')'])
title('����������� ������������� ������')


%%%%%%%%%%%%%%
figure(3);clf;hold on
stairs([(min(A)-delta) Z' max(A)+delta],[0 NcOtn' 1])
grid on
ylabel('F(x)')
%%%%%%%%%%%%%%

disp('������ �� ���������������� ������')
disp('������ �������')
hx=(A(25)+A(26))/2;
disp(sprintf('hx = %.4f',hx))
disp('������ ��������')
xn=sum(A)/V;
disp(sprintf('xn = %.4f',xn))
disp('���������� ��������� ���������')
Dx=(sum(A.^2)-V*xn^2)/V;
disp(sprintf('Dx = %.4f',Dx))
disp('����������� ���������')
S2=(sum(A.^2)-V*xn^2)/(V-1);
disp(sprintf('S2 = %.4f',S2))
disp(' ')
disp(' ')
disp('������ �� �������������� ������')
disp('������ ��������')
xnG=sum(Z.*N)/V;
disp(sprintf('xnG = %.4f',xnG))
disp('���������� ��������� ���������')
DxG=(sum(Z.^2.*N)-V*xnG^2)/V;
disp(sprintf('DxG = %.4f',DxG))
disp('����������� ���������')
S2G=(DxG*V)/(V-1);
disp(sprintf('S2G = %.4f',S2G))
disp('���������� ����')

for i=1:7
plotn(i)=length(find(A<rz(i+1)&A>rz(i)));
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

disp('������ �������')

h=0;
aio=(A(25)+A(26))/2;

for i=1:7
    if(rz(i)<aio&&aio<rz(i+1))
        ah=rz(i);
        h=i;
        break
    end
end
nh=plotn(h);
nhm=sum(plotn(1:(h-1)));
hxG=ah+((V/2-nhm)/nh)*delta;
disp(sprintf('hxG = %.4f',hxG))

text={'����������� ����� �� ���������(������� 3/4) � �������(������� 4/5).';'��� �������, ����� ��� �������������?'};
choice=menu(text,'�����������', '����������', '�������������');
switch choice 
    case 1
        ypl=unifpdf([(min(A)-delta) A max(A)+delta],min(A),max(A));
        y=unifcdf([(min(A)-delta) A max(A)+delta],min(A)-delta,max(A)+delta);
    case 2
        ypl=normpdf([(min(A)-delta) A max(A)+delta],mean(A),sqrt(var(A)));
        y=normcdf([(min(A)-delta) A max(A)+delta],mean(A),sqrt(var(A)));
    case 3
        ypl=exppdf([(min(A)-delta) A max(A)+delta],mean(A));
        y=expcdf([(min(A)-delta) A max(A)+delta],mean(A));
    otherwise
        errordlg('�� ���� �������? ��, ���� �� ���� �����','�� ��� ����-�� �� �����')
        ypl=normpdf([(min(A)-delta) A max(A)+delta],mean(A),sqrt(var(A)));
        y=normcdf([(min(A)-delta) A max(A)+delta],mean(A),sqrt(var(A)));
end
figure(2)
plot([(min(A)-delta) A max(A)+delta],ypl)
figure(3)
plot([(min(A)-delta) A max(A)+delta],y)
axis([(min(A)-delta) (max(A)+delta) -0.1 1.1])
choice=menu('������� ������ ����� �� �������?','���','��, �������');
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
        errordlg('�� ��','�� ��')
    otherwise
        errordlg('�� ���� �������? ��, ���� �� ���� �����','�� ��� ����-�� �� �����')
end
