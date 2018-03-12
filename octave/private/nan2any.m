function Vout=nan2any(Vin,VinOld)
    M=length(Vin);
    Vout=Vin;
    
    for II=1:M
        if(isnan(Vout(II)))
        Vout(II)=rand(1)*VinOld(II);
        end
    end
end
