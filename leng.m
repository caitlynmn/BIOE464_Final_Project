function [MT_Length MT_State sstate LLmt One_MT_Length Avg_MT_Length Sim_Time MT_Count MT_Std]= leng(j,prob_nuc,MT_State, growth_length, MT_Length, LLmt, One_MT_Length, Avg_MT_Length, sstate, Sim_Time, prob_c,R_interior,Cell_Radius,short_length,prob_r,MT_Count,MT_Std)

Nmtmax=500;
dt=1;
for i=1:Nmtmax
        if MT_State(i)==0 %test for nucleation
            if rand<prob_nuc
                MT_State(i)=1; %put into growing state if nucleated
                MT_Length(i)=growth_length;
            end
        elseif MT_State(i)==1 % if growing state
            MT_Length(i)=MT_Length(i)+growth_length;
            if MT_Length(i)<R_interior
                if rand<prob_c
                    MT_State(i)=2;
                end
            elseif MT_Length(i)>R_interior
                if rand<prob_c
                    MT_State(i)=2;
                end
            end
        elseif MT_State(i)==2 %if catastrophe state
            MT_Length(i)=MT_Length(i)-short_length;
            if MT_Length(i)<R_interior
                if rand<prob_r 
                    MT_State(i)=1;
                end
            elseif MT_Length(i)>R_interior
                if rand<prob_r
                    MT_State(i)=1;
                end
            end
        end
        if MT_Length(i)>Cell_Radius %check boundaries
            MT_Length(i)=Cell_Radius;
            MT_State(i)=2;
        elseif MT_Length(i)<0
            MT_Length(i)=0;
            MT_State(i)=0;
        end
        LLmt(i,j)=MT_Length(i);
        sstate(i,j)=MT_State(i);
        MT_Count(j)=sum(LLmt(:,j)~=0);
        Avg_MT_Length(j)=mean(LLmt(:,j));
        MT_Std(j)=std(LLmt(:,j));
        if i==1
            One_MT_Length(j)=MT_Length(i);
            Sim_Time(j)=dt*j;
        end
end
end