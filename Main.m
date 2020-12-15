clear

%% Define Parameters
growthr=0.192; % growth rate (�m/s)
dt=1;
Lg=growthr*dt;
% kres extremes
kresintmin=0.175;
kresintmax=0.175;
krespermin=0.175;
krespermax=0.175;

Nmtmax=500; % maximum number of microtubules

% Initializing parameters
Lmt=zeros(1,Nmtmax); % initialize microtubules lengths (�m)
state=ones(1,Nmtmax); % initialize microtubules states
LLmt=zeros(1,1); 
Lmtone=zeros(1,1); % initilize length of one microtubule (�m)
Lmtmean=zeros(1,1); % iniltilize average length of microtubules (�m)
sstate=zeros(1,1);
ttime=zeros(1,1); % initilize time of the simulation
Tub=zeros(1,1); % initilize free tubulin concentration (�M)

% The first and last step 
start=1;
Nsteps=10000; % number of steps

[state Lmt LLmt Lmtmean Lmtone ttime Tub sstate LmtCount Lmtstd]=fun(start, Nsteps,krespermin,krespermax,kresintmin,kresintmax,Lg,Lmt,LLmt, Lmtmean,Lmtone,state,growthr, ttime, Tub, sstate);

% RE-define parameters

% kres extremes
kresintmin=0.105;
kresintmax=0.105;
krespermin=0.105;
krespermax=0.105;

% The first and last step 
start=Nsteps+1;
Nsteps=Nsteps*2;

%[state Lmt LLmt Lmtmean Lmtone ttime Tub sstate LmtCount Lmtstd]=fun(start, Nsteps,krespermin,krespermax,kresintmin,kresintmax,Lg,Lmt,LLmt, Lmtmean ,Lmtone,state,growthr,ttime, Tub, sstate);

figure(1)
plot(ttime,Lmtone)
title("Length of one microtuble over time")
xlabel("Time (s)");
ylabel("Length (�m)");
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
%% Plotting

% Distribution of simulated microtubule length
figure(2)
xbins=0.5:24.5; %extreme centers for equally spaced bins
nbins=25; % number of bins
hist(length,xbins,nbins) %plot histogram of lengths with above
xlim([0 25])
xlabel("length (�m)")
ylabel("frequency (# of microtubules)")
title ("Microtubule length distribution")

% Average length of microtubules over time
figure(3)
plot(ttime,Lmtmean)
title("Average length of microtubules over time")
xlabel("Time (s)")
ylabel("Average length of microtubules (�m)")

%Initial Microtubule Growth
figure(4)
plot(ttime(1:500),Lmtone(1:500))
title("Length of one microtubule over first 500 s")
xlabel("Time (s)")
ylabel("Length (�m)")

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
ylabel("Free tubulin concentration (�M)")
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