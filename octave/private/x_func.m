function [X varargout]=x_func(P,d,m,Xn_1,Xn_2)
    M=length(Xn_1);

    X=(2.0*eye(M)-P*d*d/m)*Xn_1-Xn_2;

    if nargout>1
        varargout{1}=Xn_1;
    end
end
