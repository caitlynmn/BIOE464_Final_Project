function [MT_State MT_Length LLmt Avg_MT_Length One_MT_Length Sim_Time Tubulin sstate MT_Count MT_Std]=fun(initial,N,growth_length,MT_Length,LLmt,Avg_MT_Length,One_MT_Length,MT_State,V_g,Sim_Time,Tubulin,sstate,V_s,k_c,k_r);

Tot_Tub_Conc = 35; % total tubulin concentration (µM)
Vcell = 1000; % volume of the cell (µm^3)
Tot_Tub_Num = Tot_Tub_Conc*(602)*Vcell; % total # of tubulins

kon = 1/60; % slope (µm/s per µM)
C = 0; % intercept (µm/s)
dt = 1; % time step (s)
k_nuc = 0.0005; % nucleation rate (s-1)

prob_nuc = 1-exp(-k_nuc*dt); % probability of MT nucleation
prob_c = 1-exp(-k_c*dt); % probability of MT catastrophe
prob_r = 1-exp(-k_r*dt); % probability of MT rescue

Cell_Radius = 25; % cell radius (µm)
R_periph = 10; % peripheral zone length minimum (µm)
R_interior = Cell_Radius - R_periph; % cell interior length (µm)

MAX_NMT = 500; % maximum number of microtubules
MT_Count = 0;
MT_Std = 0;

short_length = V_s*dt; % length lost in one step (µm)

for j=initial:N
    
    [MT_Length MT_State sstate LLmt One_MT_Length Avg_MT_Length Sim_Time MT_Count MT_Std]= leng(j,prob_nuc,MT_State,growth_length,MT_Length,LLmt,One_MT_Length,Avg_MT_Length,sstate,Sim_Time,prob_c,R_interior,Cell_Radius,short_length,prob_r,MT_Count,MT_Std);
   
    % Calculate new free tubulin concentration
    Sum_MT_Length = sum(MT_Length); % find total MT length in µm
    Numb_Free_Tub = Tot_Tub_Num - 1624*Sum_MT_Length; % find number of free tubulin
    Tubulin(j) = Numb_Free_Tub/(602*Vcell); % free tubulin conc (µM)
    V_g = kon*Tubulin(j)+C; % find new growth rate (µm/s)
    growth_length = V_g*dt; % find new growth length (µm)
end