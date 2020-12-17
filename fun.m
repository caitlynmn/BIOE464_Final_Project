function [state Lmt LLmt Lmtmean Lmtone ttime Tub sstate LmtCount Lmtstd]=fun(start, Nsteps,Lg,Lmt,LLmt, Lmtmean,Lmtone,state,growthr, ttime, Tub, sstate, Vs, Kc, Kr);

TubulinTotalConc=35; % total concentration of tubulin (µM)
Vcell=1000; % volume of the cell (µm^3)
kon=1/60; % slope (µm/s per µM)
C1=0; % intercept (µm/s)
dt=1;
TubulinTotalNumb=TubulinTotalConc*(602)*Vcell; % total # of tubulins
knuc=0.0005; % nucleation rate (s-1)
pnuc=1-exp(-knuc*dt); % probability of nucleation

% cell radius extremes
Rcell=25; % cell radius minimum (µm)

% peripheral zone extremes
Rper=10; % periphery length minimum (µm)

Nmtmax=500; % maximum number of microtubules
LmtCount = 0;
Lmtstd = 0;
pc=1-exp(-Kc*dt); % probability of catastrophe in cell
pr=1-exp(-Kr*dt); % probability of rescue in cell
Rint=Rcell-Rper; % cell interior length (µm)


for j=start:Nsteps
    
    Ls=Vs*dt; % length lost in one step (µm)
    % update kcat & kres
    % select rand values b/w extremes
    
    [Lmt state sstate LLmt Lmtone Lmtmean ttime LmtCount Lmtstd]= leng(j,pnuc,state, Lg, Lmt, LLmt, Lmtone, Lmtmean, sstate, ttime, pc,Rint,Rcell,Ls,pr, LmtCount,Lmtstd);
   
    % update free tubulin concentration
    TotalMTlength=sum(Lmt); %µm
    TubulinFreeNumb=TubulinTotalNumb-1624*TotalMTlength;
    Tub(j)=TubulinFreeNumb/(602*Vcell); % free tubulin conc (µM)
    growthr=kon*Tub(j)+C1;
    Lg=growthr*dt;
end