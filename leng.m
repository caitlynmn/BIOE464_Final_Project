function [Lmt state sstate LLmt Lmtone Lmtmean ttime LmtCount Lmtstd]= leng(j,pnuc,state, Lg, Lmt, LLmt, Lmtone, Lmtmean, sstate, ttime, pc,Rint,Rcell,Ls,pr,LmtCount,Lmtstd)

Nmtmax=500;
dt=1;
for i=1:Nmtmax
        if state(i)==0 %test for nucleation
            if rand<pnuc
                state(i)=1; %put into growing state if nucleated
                Lmt(i)=Lg;
            end
        elseif state(i)==1 % if growing state
            Lmt(i)=Lmt(i)+Lg;
            if Lmt(i)<Rint
                if rand<pc
                    state(i)=2;
                end
            elseif Lmt(i)>Rint
                if rand<pc
                    state(i)=2;
                end
            end
        elseif state(i)==2 %if catastrophe state
            Lmt(i)=Lmt(i)-Ls;
            if Lmt(i)<Rint
                if rand<pr 
                    state(i)=1;
                end
            elseif Lmt(i)>Rint
                if rand<pr
                    state(i)=1;
                end
            end
        end
        if Lmt(i)>Rcell %check boundaries
            Lmt(i)=Rcell;
            state(i)=2;
        elseif Lmt(i)<0
            Lmt(i)=0;
            state(i)=0;
        end
        LLmt(i,j)=Lmt(i);
        sstate(i,j)=state(i);
        LmtCount(j)=sum(LLmt(:,j)~=0);
        Lmtmean(j)=mean(LLmt(:,j));
        Lmtstd(j)=std(LLmt(:,j));
        if i==1
            Lmtone(j)=Lmt(i);
            ttime(j)=dt*j;
        end
end
end