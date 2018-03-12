function X=x_springmass_func(K,d,m,Xn_1,Xn_2,L)
    M=length(K);
    X=zeros(M,L);

    P=p_func(K);

    X(:,1)=Xn_2;
    X(:,2)=Xn_1;

    % calculando iterativamente
    for n=3:L
        X(:,n) = x_func(P,d,m,X(:,n-1),X(:,n-2));
    end

end
