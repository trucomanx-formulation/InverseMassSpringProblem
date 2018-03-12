function [K ERROR]=new_k_vector(BETA,KMIN,DKMIN,d,m,X2,X1,y,II)
    M=length(KMIN);
    L=length(y);
    do
        K=abs(KMIN+BETA*(1+0.5*(rand(M,1)-0.5)/0.5).*DKMIN/rms_val(DKMIN));

        X=x_springmass_func(K,d,m,X2,X1,L);
        ERROR=norm(X(M,:)-y);
    until (isnan(ERROR)==0) 

    disp(['Jumping in the iteration:' num2str(II)]);
end
