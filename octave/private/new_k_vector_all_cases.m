function [K ERROR DK]=new_k_vector_all_cases(BETA,JUMP,Kcurrent,DKcurrent,KMIN,DKMIN,d,m,X2,X1,y,II)

    L=length(y);
    M=length(KMIN);

    K=Kcurrent;
    DK=DKcurrent;

    X=x_springmass_func(Kcurrent,d,m,X2,X1,L);
    ERROR=norm(X(M,:)-y);

    if (JUMP==true) 

        [K ERROR]=new_k_vector(BETA,KMIN,DKMIN,d,m,X2,X1,y,II);

    else
            
        ACTIVE_ERROR_NAN=isnan(ERROR);

        if(ACTIVE_ERROR_NAN>0)
            [K ERROR]=new_k_vector(BETA,KMIN,DKMIN,d,m,X2,X1,y,II);
        end

    end
end
