function [X varargout]=x_springmass_u_func(K,d,m,V1,X1,L)
    M=length(K);
    U=zeros(2*M,L);

    P=p_func(K);

    U([1    :M    ],1)=X1;
    U([(M+1):(2*M)],1)=V1;


    % calculando iterativamente
    for n=2:L
        U(:,n) = u_func(P,d,m,U(:,n-1));
    end

    X=U(1:M,:);

    if (nargout>1)
        varargout{1}=U([(M+1):(2*M)],:);
    end
end
