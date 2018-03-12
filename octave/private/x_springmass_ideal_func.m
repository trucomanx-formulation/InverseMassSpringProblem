function [X W varargout]=x_springmass_ideal_func(K,d,m,V1,X1,L)
    M=length(K);
    X=zeros(M,L);
    P=p_func(K);
    C1=zeros(M,M);
    C2=zeros(M,M);

    [V, lambda] = eig (P/m);

    W=sqrt(lambda); 
    c1=inv(V)*X1;
    c2=inv(V*W)*V1;


    w=zeros(M,1);
    for II=1:M
        w(II)=W(II,II);
        C1(II,II)=c1(II);
        C2(II,II)=c2(II);
    end

    for n=[1:L]
        X(:,n)=V*( C1*cos(w*d*(n-1))+C2*sin(w*d*(n-1)) );
    end

    if (nargout>1)
        XX=zeros(M,L);
        for n=[1:L]
            XX(:,n)=V*( -C1*W*sin(w*d*(n-1))+C2*W*cos(w*d*(n-1)) );
        end
        varargout{1}=XX;
    end

    if (nargout>2)
        XXX=zeros(M,L);
        for n=[1:L]
            XXX(:,n)=-P*X(:,n)/m;
        end
        varargout{2}=XXX;
    end
end
