function [DK E]=regularization_e_landweber(Kold,d,m,X2,X1,J2,J1,y,alpha)
    L=length(y);
    M=length(Kold);

    %SUM1=zeros(M,M);
    SUM2=zeros(M,1);
    P=p_func(Kold);

    B=zeros(M,1); B(M)=1;

    for n=1:L
        if (n==1)
            XK=X1;
            JK=J1;
        elseif (n==2)
            XK=X2;  XK1=X1;
            JK=J2;  JK1=J1;
        else
            [XK XK1]= x_func(P,d,m,XK,XK1);
            [JK JK1]= j_func(P,d,m,XK1,JK,JK1);
        end
        %SUM1=SUM1+(B'*JK)'*(B'*JK);
        SUM2=SUM2+(B'*JK)'*(y(n)-B'*XK);
    end
    DK=alpha*rand(1)*2*SUM2/norm(SUM2);%

end
