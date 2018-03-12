function P=p_func(K)

    M=length(K);
    P=zeros(M,M);

    for II=1:M
        if((II-1)>=1)
            P(II,II-1)=-K(II);
        end

        if(II<M)
            P(II,II  )=K(II)+K(II+1);
        else
            P(II,II  )=K(II);
        end

        if((II+1)<=M)
            P(II,II+1)=-K(II+1);
        end
    end
end
