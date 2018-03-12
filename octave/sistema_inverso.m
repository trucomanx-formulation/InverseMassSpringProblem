% data
clear all
addpath(genpath(fullfile(pwd,'private')));

Kopt = load('datak.dat');

% modelo do sistema
y=load('dataxm.dat');
L=length(y);
M=length(Kopt);
m=1.0;
d=0.02;



K0 = 0.1*ones(M,1);%[1:M]';
K1 = K0;%abs(K0 + 1.0*abs(K0).*(rand(M,1)-0.5)/0.5 );


%% variables iniciais
X1=load('dataxn1.dat');
X2=load('dataxn2.dat');
  

%% vParametros de simulacion
NTESTS=1000;
K=zeros(M,NTESTS);
DK=zeros(M,NTESTS);
ERROR=zeros(1,NTESTS);



%% consecuencias de las variables iniciais
J1=j_func(p_func(K1),d,m,X1,zeros(M,M),zeros(M,M));%eye(M,M)*0.1;
J2=j_func(p_func(K1),d,m,X1,J1        ,zeros(M,M));%eye(M,M)*0.1;


%% 
X=x_springmass_func(K1,d,m,X2,X1,L);
ERROR(1)=norm(X(M,:)-y);
K(:,1)=K1;
DK(:,1)=K1;

% Valores minimos
KMIN=K(:,1);
ERRORMIN=ERROR(1);
DKMIN=DK(:,1);
XMIN=zeros(M,size(y,2));
Kvalle{1}=zeros(M,1);
Evalle{1}=1.0;


ACTIVE_MONOTONE_JUMP=false;
alpha=0.05;
for II=2:NTESTS
    
    DK(:,II)=regularization_e_tikhonov(K(:,II-1),d,m,X2,X1,J2,J1,y,alpha,Kvalle,Evalle);
    %DK(:,II)=regularization_e_landweber(K(:,II-1),d,m,X2,X1,J2,J1,y,alpha);
    DK(:,II)=nan2any(DK(:,II),DKMIN);
    if(II==2)
        DK(:,1)=DK(:,2);
    end


    K(:,II)=K(:,II-1)+DK(:,II);
    K(:,II)=negative2any(K(:,II),KMIN);

    BETA=2.5;
    [K(:,II) ERROR(II) DK(:,II)]=new_k_vector_all_cases(BETA,ACTIVE_MONOTONE_JUMP,K(:,II),DK(:,II),KMIN,DKMIN,d,m,X2,X1,y,II);

    if ERROR(II)<ERRORMIN
        KMIN     = K(:,II);
        ERRORMIN = ERROR(II);
        DKMIN    = DK(:,II);
        XMIN     = x_springmass_func(KMIN,d,m,X2,X1,L);
    end

    disp(['DKCURRENT: ' num2str(norm(DK(:,II)))]);  
    KCURRENT='KCURRENT: ';
    for KK=1:M
        KCURRENT=[KCURRENT ' ' num2str(K(KK,II))];
    end  
    disp(KCURRENT);    
        
    ACTIVE_MONOTONE_JUMP=detect_stop(ERROR(1:II),100);
    if(ACTIVE_MONOTONE_JUMP==true)
        Kvalle{end+1}=K(:,II);
        Evalle{end+1}=ERROR(II);
    end

    h=plot_error(y,ERROR,Kopt,K,DK,II,XMIN);

end


%plot(ERROR,'-o')
