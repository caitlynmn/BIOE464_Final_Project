function [state Lmt LLmt Lmtmean Lmtone ttime Tub sstate LmtCount Lmtstd]=fun(start, Nsteps,Lg,Lmt,LLmt, Lmtmean,Lmtone,state,growthr, ttime, Tub, sstate, Vs, Kc, Kr);

TubulinTotalConc=35; % total concentration of tubulin (�M)
Vcell=1000; % volume of the cell (�m^3)
kon=1/60; % slope (�m/s per �M)
C1=0; % intercept (�m/s)
dt=1;
TubulinTotalNumb=TubulinTotalConc*(602)*Vcell; % total # of tubulins
knuc=0.0005; % nucleation rate (s-1)
pnuc=1-exp(-knuc*dt); % probability of nucleation

% cell radius extremes
Rcell=25; % cell radius minimum (�m)

% peripheral zone extremes
Rper=10; % periphery length minimum (�m)

Nmtmax=500; % maximum number of microtubules
LmtCount = 0;
Lmtstd = 0;
pc=1-exp(-Kc*dt); % probability of catastrophe in cell
pr=1-exp(-Kr*dt); % probability of rescue in cell
Rint=Rcell-Rper; % cell interior length (�m)


for j=start:Nsteps
    
    Ls=Vs*dt; % length lost in one step (�m)
    % update kcat & kres
    % select rand values b/w extremes
    
    [Lmt state sstate LLmt Lmtone Lmtmean ttime LmtCount Lmtstd]= leng(j,pnuc,state, Lg, Lmt, LLmt, Lmtone, Lmtmean, sstate, ttime, pc,Rint,Rcell,Ls,pr, LmtCount,Lmtstd);
   
    % update free tubulin concentration
    TotalMTlength=sum(Lmt); %�m
    TubulinFreeNumb=TubulinTotalNumb-1624*TotalMTlength;
    Tub(j)=TubulinFreeNumb/(602*Vcell); % free tubulin conc (�M)
    growthr=kon*Tub(j)+C1;
    Lg=growthr*dt;
end