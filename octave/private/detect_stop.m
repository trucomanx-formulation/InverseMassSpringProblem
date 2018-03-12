function h=detect_stop(ERROR,FACTOR)
    N=24;
    if length(ERROR)>N
        V=ERROR((end-N+1):end);
        if(mean(V)>FACTOR*std(V))
            h=true;
        else
            h=false;
        end
    else
        h=false;
    end

end
