clear

% Define Parameters
Vg=0.192; % growth rate (µm/s)

% kres extremes
kresintmin=0.175;
kresintmax=0.175;
krespermin=0.175;
krespermax=0.175;

Nmtmax=500; % maximum number of microtubules
Nsteps=1000; % number of steps
Lmt=zeros(1,Nmtmax); % initialize MT lengths
state=ones(1,Nmtmax); % initialize MT states
start=1;
LLmt=zeros(1,1);
Lmtone=zeros(1,1);
Lmtmean=zeros(1,1);
ttime=zeros(1,1);
Tub=zeros(1,1);

[Vg state Lmt LLmt Lmtmean Lmtone ttime Tub]=fun(start, Nsteps,krespermin,krespermax,kresintmin,kresintmax,Lmt,LLmt, Lmtmean,Lmtone,state,Vg, ttime, Tub);

% RE-define parameters

% kres extremes
kresintmin=0.105;
kresintmax=0.105;
krespermin=0.105;
krespermax=0.105;

% The first and last step 
start=Nsteps+1;
Nsteps=Nsteps*2;

[Vg state Lmt LLmt Lmtmean Lmtone ttime Tub]=fun(start, Nsteps,krespermin,krespermax,kresintmin,kresintmax,Lmt,LLmt, Lmtmean ,Lmtone,state,Vg,ttime, Tub);

figure(1)
plot(ttime,Lmtone)
title("Length of one microtuble over time")
xlabel("Time (s)");
ylabel("Length (µm)");
count=0;
for i=1:Nmtmax
    if state(i)==0
    else
        count=count+1;
        length(count)=Lmt(i);
    end
end
count
lengthmean=mean(length)

% Distribution of simulated microtubule length
figure(2)
xbins=0.5:24.5; %extreme centers for equally spaced bins
nbins=25; % number of bins
hist(length,xbins,nbins) %plot histogram of lengths with above
xlim([0 25])
xlabel("length (µm)")
ylabel("frequency (# of microtubules)")
title ("Microtubule length distribution")

% Average length of microtubules over time
figure(3)
plot(ttime,Lmtmean)
title("Average length of microtubules over time")
xlabel("Time (s)")
ylabel("Average length of microtubules (µm)")

% Free tubulin concentration over time
figure(4)
plot(ttime,Tub)
title("Free tubulin concentration over time")
xlabel("Time (s)")
ylabel("Free tubulin concentration (µM)")
ac=length';
