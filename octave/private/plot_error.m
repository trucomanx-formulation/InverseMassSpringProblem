function h=plot_error(y,ERROR,Kopt,K,DK,II,XMIN )

    NTESTS=length(ERROR);
    M=size(DK,1);
    NORMDK=zeros(1,NTESTS);
    NORMKERROR=zeros(1,NTESTS);
    L=length(y);

    for JJ=1:NTESTS
        NORMDK(JJ)=norm(DK(:,JJ));
        NORMKERROR(JJ)=100*rms_val((K(:,JJ)-Kopt)./Kopt);
    end

    h=figure(1);

    subplot(4,1,1)
    plot([1:II],ERROR(1:II),'-o',[1:NTESTS],norm(y)*ones(1,NTESTS),'-o')
    title('Error (E)');
    xlim([0 NTESTS])
    ylim([0 ERROR(1)*1.5])

    subplot(4,1,2)
    plot([1:II],NORMDK(1:II),'-o')
    title('Norm of DK');
    xlim([0 NTESTS])
    %ylim([0 abs(20*log10(NORMDK(1))*1.5)])

    subplot(4,1,3)
    plot([1:II],NORMKERROR(1:II),'-o')
    title('RMS[100*(K-Kopt)/(Kopt)]');
    xlim([0 NTESTS])
    ylim([0 abs(NORMKERROR(1)*1.5)])

    subplot(4,1,4)
    plot([1:L],y,'-o',[1:L],XMIN(M,:),'->')
    title('y vs. X_M');
    xlim([0 L])
    ylim([-max(y)*1.5 max(y)*1.5])

    drawnow()
    refresh(h)

end
