% data

addpath(genpath(fullfile(pwd,'private')));

% modelo do sistema
M=2;
K0=[1:M]'+1;
m=1.0;
d=0.02;
L=1024;

N=20;
NN=2*N+1;
E1=zeros(NN,NN);
E2=zeros(NN,NN);
E3=zeros(NN,NN);
K=zeros(NN,NN,M);
KNORM=zeros(NN,NN);

PP=2.0;
for II=1:NN
for JJ=1:NN
    FACTOR=(max(K0)/N);
    K(II,JJ,:)=FACTOR*[II;JJ];
    KNORM(II,JJ)=sum(K(II,JJ,:).^PP);
end
end

%% variables iniciais
I1=10;
X1=zeros(M,1);  X1(end)=I1;
V1=zeros(M,1);  V1(end)=0;
[X0 V0 A0]=x_springmass_ideal_func(K0,d,m,V1,X1,L);
%X2=Z(:,2);

%X0=x_springmass_func(K0,d,m,X2,X1,L);

for II=1:NN
for JJ=1:NN
    [X V A]=x_springmass_ideal_func(K(II,JJ,:),d,m,V1,X1,L);
    E1(II,JJ)= norm(X0(M,:)-X(M,:));
    E2(II,JJ)= norm(V0(M,:)-V(M,:));
    E3(II,JJ)= norm(A0(M,:)-A(M,:)); 
    fprintf(stdout,'(%3d,%3d) of (%3d,%3d)\r',II,JJ,NN,NN);
end
end



figure(1)
surf(K(:,:,1),K(:,:,2),E1)
xlim([0 max(max(K(:,:,1)))])
ylim([0 max(max(K(:,:,2)))])
colormap(jet)

figure(2)
surf(K(:,:,1),K(:,:,2),E2)
xlim([0 max(max(K(:,:,1)))])
ylim([0 max(max(K(:,:,2)))])
colormap(jet)

figure(3)
surf(K(:,:,1),K(:,:,2),E3)
xlim([0 max(max(K(:,:,1)))])
ylim([0 max(max(K(:,:,2)))])
colormap(jet)

DATA.K=K;
DATA.E1=E1;
DATA.E2=E2;
DATA.E3=E3;
save('data2d.dat','DATA')

