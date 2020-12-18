function [MT_Length MT_State sstate LLmt One_MT_Length Avg_MT_Length Sim_Time MT_Count MT_Std]= leng(j,prob_nuc,MT_State,growth_length,MT_Length,LLmt,One_MT_Length,Avg_MT_Length,sstate,Sim_Time,prob_c,R_interior,Cell_Radius,short_length,prob_r,MT_Count,MT_Std)

Max_NMT = 500;
dt=1;

for i=1:Max_NMT
    
        % Nucleation state
        if MT_State(i) == 0 % check if nucleation site is open
            if rand < prob_nuc % check if random number from 0 to 1 is less than probability of nucleation
                MT_State(i)= 1; % put into growing state if nucleated
                MT_Length(i)= growth_length; % add one growth unit
            end
            
        % Growing state
        elseif MT_State(i) == 1 % check if in growing state
            MT_Length(i) = MT_Length(i) + growth_length; % add one growth unit
            if MT_Length(i) < R_interior % checks if MT length less than cell's interior boundary
                if rand < prob_c % check if random number from 0 to 1 is less than probability of catastrophe
                    MT_State(i) = 2; % puts MT into shortening state
                end
            elseif MT_Length(i) > R_interior % check if MT is in cell peripheral
                if rand < prob_c
                    MT_State(i) = 2; % puts MT into shortening state
                end
            end
            
        % Shortening state
        elseif MT_State(i) == 2 % check if MT is in shortening state
            MT_Length(i) = MT_Length(i) - short_length; % take out one shortening unit
            if MT_Length(i) < R_interior % check if MT in cell interior
                if rand < prob_r % check if random number is less than probablility of recovery
                    MT_State(i) = 1; % puts MT into growing state
                end
            elseif MT_Length(i) > R_interior % check if MT is in cell periphery
                if rand < prob_r % check if random number is less than probability of recovery
                    MT_State(i)=1; % puts MT into growing state
                end
            end
        end
        
        % Boundary conditions
        if MT_Length(i) > Cell_Radius % checks boundary conditions
            MT_Length(i) = Cell_Radius; % restricts MT length to cell radius length
            MT_State(i) = 2; % puts MT into catastrophe state
        elseif MT_Length(i) < 0 % checks if MT length is negative
            MT_Length(i) = 0; % resets MT length to 0
            MT_State(i) = 0; % resets MT state to open site
        end
        
        LLmt(i,j) = MT_Length(i); % adds MT length to all lengths array
        sstate(i,j) = MT_State(i); % adds state to all states array
        MT_Count(j) = sum(LLmt(:,j)~=0); % adds number of MT to count
        Avg_MT_Length(j) = mean(LLmt(:,j)); % stores mean number of MT length
        MT_Std(j) = std(LLmt(:,j)); % calculate and store std of MT length
        
        if i == 1
            One_MT_Length(j) = MT_Length(i); % takes length of first MT
            Sim_Time(j) = dt*j; % assigns corresponding simulation time
        end
end
end