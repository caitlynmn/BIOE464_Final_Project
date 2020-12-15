function [state Lmt LLmt Lmtmean Lmtone ttime Tub sstate LmtCount Lmtstd]=fun(start, Nsteps,krespermin,krespermax,kresintmin,kresintmax,Lg,Lmt,LLmt, Lmtmean,Lmtone,state,growthr, ttime, Tub, sstate)
TubulinTotalConc=35; % total concentration of tubulin (µM)
Vcell=1000; % volume of the cell (µm^3)
kon=1/60; % slope (µm/s per µM)
C1=0; % intercept (µm/s)
dt=1;
TubulinTotalNumb=TubulinTotalConc*(602)*Vcell; % total # of tubulins
knuc=0.0005; % nucleation rate (s-1)
pnuc=1-exp(-knuc*dt); % probability of nucleation
kcintmin=0.026;
kcintmax=0.026;
kcpermin=0.026;
kcpermax=0.026;
% cell radius extremes
Rcellmin=25; % cell radius minimum (µm)
Rcellmax=25; % cell radius maximum (µm)
% peripheral zone extremes
Rpermin=10; % periphery length minimum (µm)
Rpermax=10; % periphery length maximum (µm)
Nmtmax=500; % maximum number of microtubules
% Vs extremes
Vsmin=0.218;
Vsmax=0.218;
LmtCount = 0;
Lmtstd = 0;
for j=start:Nsteps
    % update shortening rate (µm/s)
    % select rand values b/w extremes
    Vs=Vsmin+(Vsmax-Vsmin).*rand(1,1);
    Ls=Vs*dt; % length lost in one step (µm)
    % update kcat & kres
    % select rand values b/w extremes
    kcint=kcintmin+(kcintmax-kcintmin).*rand(1,1);
    kcper=kcpermin+(kcpermax-kcpermin).*rand(1,1);
    kresint=kresintmin+(kresintmax-kresintmin).*rand(1,1);
    kresper=krespermin+(krespermax-krespermin).*rand(1,1);
    pcint=1-exp(-kcint*dt); % probability of catastrophe in cell interior
    pcper=1-exp(-kcper*dt); % probability of catastrophe in cell periphery
    presint=1-exp(-kresint*dt); % probability of catastrophe in cell interior
    presper=1-exp(-kresper*dt); % probability of catastrophe in cell periphery
    % update cell radius
    % select rand values b/w extremes
    Rcell=Rcellmin+(Rcellmax-Rcellmin).*rand(1,1);
    % update zones
    % Rper select rand value b/w extremes
    Rper=Rpermin+(Rpermax-Rpermin).*rand(1,1); % periphery length (µm)
    Rint=Rcell-Rper; % cell interior length (µm)
    
    [Lmt state sstate LLmt Lmtone Lmtmean ttime LmtCount Lmtstd]= leng(j,pnuc,state, Lg, Lmt, LLmt, Lmtone, Lmtmean, sstate, ttime, pcper,pcint,Rint,Rcell,Ls,presint,presper, LmtCount,Lmtstd);
   
    % update free tubulin concentration
    TotalMTlength=sum(Lmt); %µm
    TubulinFreeNumb=TubulinTotalNumb-1624*TotalMTlength;
    Tub(j)=TubulinFreeNumb/(602*Vcell); % free tubulin conc (µM)
    growthr=kon*Tub(j)+C1;
    Lg=growthr*dt;
end