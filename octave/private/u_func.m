function [U varargout]=u_func(P,d,m,Un_1)
    M=size(P,1);

    A=[zeros(M,M), eye(M); (-P/m),zeros(M,M)];

    U=inv(eye(2*M)-d*A)*Un_1;

    if nargout>1
        varargout{1}=Un_1;
    end
end
