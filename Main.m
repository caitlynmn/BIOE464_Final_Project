%% BIOE464
% Final Project
% Sarvenaz Hedayati, Caitlyn Nguyen, Darshi Shah

%% Define Parameters
V_g = 0.192; % growth rate Vg, (µm/s)
V_s = 0.218; % shortening rate vs (µm/s)
k_r = 0.175; % rescue frequency (1/s)
k_c = 0.026; % catastrophe frequency (1/s)

dt = 1; % time step of 1 s
growth_length = V_g*dt; % length added in one step (µm)
Max_NMT=500; % maximum number of microtubules

%% Initialize Parameters
MT_Length = zeros(1,Max_NMT); % create empty microtubules lengths array (µm)
MT_State = ones(1,Max_NMT); % create microtubules states array
LLmt = zeros(1,1); 
One_MT_Length = zeros(1,1); % create empty length of one microtubule array (µm)
Avg_MT_Length = zeros(1,1); % create empty average length of microtubules array (µm)
sstate = zeros(1,1);
Sim_Time = zeros(1,1); % create empty simulation time array (s)
Tubulin = zeros(1,1); % create empty free tubulin concentration array(µM)
%% MC Simulation

initial = 1; % first simulation step in array
N = 10000; % number of steps

[MT_State MT_Length LLmt Avg_MT_Length One_MT_Length Sim_Time Tubulin sstate MT_Count MT_Std]=fun(initial, N,growth_length,MT_Length,LLmt, Avg_MT_Length,One_MT_Length,MT_State,V_g, Sim_Time, Tubulin, sstate, V_s, k_c, k_r);

%% Redefining Parameters for Second MC Simulation

% This is only used for when switching the parameters after interphase
% set-up, which was done for investigating switching to NEBD for Figure 4.
% Figures 1 - 3 were generated from one MC simulation above.

V_g = 0.178; % growth rate Vg, (µm/s)
V_s = 0.205; % shortening rate vs (µm/s)
k_r = 0.175; % rescue frequency (1/s)
k_c = 0.075; % catastrophe frequency (1/s)

dt = 1; % time step of 1 s
growth_length = V_g*dt; % length added in one step (µm)
Max_NMT=500; % maximum number of microtubules

%% Second MC Simulation

% This is only used for when switching the parameters after interphase
% set-up, which was done for investigating switching to NEBD for Figure 4.
% Figures 1 - 3 were generated from one MC simulation above.

initial = N + 1; % first simulation step in array
N2 = 1200 + N; % number of steps

[MT_State MT_Length LLmt Avg_MT_Length One_MT_Length Sim_Time Tubulin sstate MT_Count MT_Std]=fun(initial,N2,growth_length,MT_Length,LLmt,Avg_MT_Length,One_MT_Length,MT_State,V_g,Sim_Time,Tubulin,sstate,V_s,k_c,k_r);

counter = 0; % create empty counter for no. of MT

for i=1:Max_NMT
    if MT_State(i)~=0 % does not count for empty nucleation sites
        counter = counter + 1; % adds to MT counter if nucleated site
        All_Lengths(counter) = MT_Length(i); % adds MT length to all lengths array
    end
end

Numb_MT = counter % prints out ending number of MT
FreeTB = Tubulin(end) % prints out ending number of free tubulin
lengthmean=mean(All_Lengths) % prints out ending average length of MT
%% Plotting

% The following plots are used for Figure 1. All other figures were plotted
% using other scripts found in the GitHub folder: https://github.com/caitlynmn/BIOE464_Final_Project.git

% Plot of a single microtubule length over time
figure(1)
plot(Sim_Time,One_MT_Length)
title('Length of one microtuble over time')
xlabel('Time (s)');
ylabel('Length (µm)');

% Distribution of simulated microtubule length
figure(2)
xbins=0.5:24.5; %extreme centers for equally spaced bins
nbins=25; % number of bins
hist(All_Lengths,xbins,nbins) %plot histogram of lengths with above
xlim([0 25])
xlabel('Length (µm)')
ylabel('Frequency (No. of MT)')
title ('Microtubule length distribution')

% Average length of microtubules over time
figure(3)
plot(Sim_Time,Avg_MT_Length)
title('Average length of microtubules over time')
xlabel('Time (s)')
ylabel('Average length of microtubules (µm)')

%Initial Microtubule Growth
figure(4)
plot(Sim_Time(1:500),One_MT_Length(1:500))
title('Length of one microtubule over first 500 s')
xlabel('Time (s)')
ylabel('Length (µm)')

%Microtubule and Free Tubulin Conc. Over Time
figure(5)
hold on
title('Number of microtubules and free tubulin concentration over time')
yyaxis left
plot(Sim_Time,MT_Count)
xlabel('Time (s)')
ylabel('Number of microtubules')
ylim([400 500])

yyaxis right
plot(Sim_Time,Tubulin)
ylabel('Free tubulin concentration (µM)')
ylim([0 10])
hold off

%STD of MT
figure(6)
hold on
title('STD of number of microtubules over time')
plot(Sim_Time(2:end),MT_Std(2:end))
xlabel('Time (s)')
ylabel('STD of number of microtubules')
ylim([0 10])