function [Jmat varargout]=j_func(P,d,m,Xn_1,Jn_1,Jn_2)
    M=length(Jn_1);

    for II=1:M
        DP=zeros(M,M);
        DP(II,II)=1;
        if(II>1)
            DP(II-1,II-1)=1;
            DP(II,II-1)=-1;
            DP(II-1,II)=-1;
        end
        C(:,II)=DP*Xn_1;
    end
    Jmat=-d*d*C/m+(2.0*eye(M)-P*d*d/m)*Jn_1-Jn_2;

    if nargout>1
        varargout{1}=Jn_1;
    end
end
