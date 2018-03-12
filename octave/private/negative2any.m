function Vout=negative2any(Vin,VinOld)
    M=length(Vin);
    Vout=Vin;
    
    for II=1:M
        if(Vout(II)<0)
        Vout(II)=rand(1)*VinOld(II);
        end
    end
end
