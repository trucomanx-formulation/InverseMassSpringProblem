% data

addpath(genpath(fullfile(pwd,'private')));
%graphics_toolkit ("gnuplot")
% modelo do sistema
M=8;
F=100/1;
K=(2*pi*F)*(2*pi*F)*M*ones(M,1);%[1:M]';
save('datak.dat','K','-ascii')
m=1.0/M;
d=0.005/F;
L=8*M*F;

%% variables iniciais
I1=10/max(K);
X1=zeros(M,1);  X1(end)=I1;
V1=zeros(M,1);  V1(end)=0;
[Z W]=x_springmass_ideal_func(K,d,m,V1,X1,L);
X2=Z(:,2);

Y=x_springmass_u_func(K,d,m,V1,X1,L);


X=x_springmass_func(K,d,m,X2,X1,L);

% ploting
figure(1)
subplot(3,1,1)
plot([1:L]*d,X','-o');
title('All')
grid on

subplot(3,1,2)
if M==1
    plot([1:L]*d,X,'-o');
else
    plot([1:L]*d,sum(X),'-o');
end
title('Sum of all')
grid on

subplot(3,1,3)
plot([1:L]*d,X(M,:),'-o',[1:L]*d,Y(M,:),'-s',[1:L]*d,Z(M,:),'->');
title('X(M,:) vs Y(M,:)  vs Z(M,:)')
legend('X(n)=f(X(n-1),X(n-2))','U(n)=f(U(n-1))','X(d*n)')
ylim([1.5*min(X(M,:)) 1.5*max(X(M,:))])
grid on

figure(2)
plot([1:L]*d,X(M,:),'-or',[1:L]*d,Y(M,:),'-sg',[1:L]*d,Z(M,:),'->b');
title('X(M,:) vs Y(M,:)  vs Z(M,:)')
legend('X(n)=f(X(n-1),X(n-2))','U(n)=f(U(n-1))','X(d*n)')
ylim([1.2*min(X(M,:)) 1.2*max(X(M,:))])
grid on

Y=X;
for II=1:M
    Y(II,:)=abs(fft(Z(II,:)));
end
[MAXY IDY]=max(max(Y(:,1:round(end/2))));
figure(3)
dfs=1/(d*L);
plot([1:round(3*M*F/dfs)]*dfs,Y(:,1:round(3*M*F/dfs)),'-o');




XM=X(M,:);
Xn1=X(:,1);
Xn2=X(:,2);

save('dataxn1.dat','Xn1','-ascii')
save('dataxn2.dat','Xn2','-ascii')
save('dataxm.dat','XM','-ascii')

