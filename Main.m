%% Define Parameters
growthr=0.192; % growth rate (µm/s)
dt=1;
Lg=growthr*dt;
% kres extremes
Kr=0.175;
Kc=0.026;

% Vs extremes
Vs=0.218;

Nmtmax=500; % maximum number of microtubules

% Initializing parameters
Lmt=zeros(1,Nmtmax); % initialize microtubules lengths (µm)
state=ones(1,Nmtmax); % initialize microtubules states
LLmt=zeros(1,1); 
Lmtone=zeros(1,1); % initilize length of one microtubule (µm)
Lmtmean=zeros(1,1); % iniltilize average length of microtubules (µm)
sstate=zeros(1,1);
ttime=zeros(1,1); % initilize time of the simulation
Tub=zeros(1,1); % initilize free tubulin concentration (µM)

% The first and last step 
start=1;
Nsteps=10000; % number of steps

[state Lmt LLmt Lmtmean Lmtone ttime Tub sstate LmtCount Lmtstd]=fun(start, Nsteps,Lg,Lmt,LLmt, Lmtmean,Lmtone,state,growthr, ttime, Tub, sstate, Vs, Kc, Kr);

% RE-define parameters

growthr=0.178; % growth rate (µm/s)
dt=1;
Lg=growthr*dt;

% kres extremes
Kr=0.175;

Kc=0.075;

% Vs extremes
Vs=0.205;

% The first and last step 
start=Nsteps+1;
Nsteps2=1200+Nsteps;

[state Lmt LLmt Lmtmean Lmtone ttime Tub sstate LmtCount Lmtstd]=fun(start, Nsteps2,Lg,Lmt,LLmt, Lmtmean,Lmtone,state,growthr, ttime, Tub, sstate, Vs, Kc, Kr);

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
FreeTB = Tub(end)
lengthmean=mean(length)
%% Plotting

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

%Initial Microtubule Growth
figure(4)
plot(ttime(1:500),Lmtone(1:500))
title("Length of one microtubule over first 500 s")
xlabel("Time (s)")
ylabel("Length (µm)")

%Microtubule and Free Tubulin Conc. Over Time
figure(5)
hold on
title('Number of microtubules and free tubulin concentration over time')
yyaxis left
plot(ttime,LmtCount)
xlabel("Time (s)")
ylabel("Number of microtubules")
ylim([400 500])

yyaxis right
plot(ttime,Tub)
ylabel("Free tubulin concentration (µM)")
ylim([0 10])
hold off

%STD of MT
figure(6)
hold on
title('STD of number of microtubules over time')
plot(ttime(2:end),Lmtstd(2:end))
xlabel("Time (s)")
ylabel("STD of number of microtubules")
ylim([0 10])