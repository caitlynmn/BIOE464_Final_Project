%% Plotting for Figure 1

% The following plots are used for Figure 1. All other figures were plotted
% using other scripts found in the GitHub folder: https://github.com/caitlynmn/BIOE464_Final_Project

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