%% Plotting for Figure 1

% The following plots are used for Figure 4. All other figures were plotted
% using other scripts found in the GitHub folder: https://github.com/caitlynmn/BIOE464_Final_Project

% Simulations were run, and resulting Numb_MT, Tubulin, and Avg_MT_Length
% variables were changed to XCount, XTub, and XLen, respectively, with X
% being the name of the variable being changed, or just SetA if it is the
% control group
%% Plotting A

figure(1)
plot([0:1200-1],SetACount(10001:end))
hold on
plot([0:1200-1],NucCount(10001:end))
hold off
xlim([0 1200])
xlabel('Time in State 2 (s)')
ylabel('Number of MTs')
set(gca,'FontSize',20)
legend('Nuc Rate = 0.0005','Nuc Rate = 0.0025')

figure(2)
plot([0:1200-1],SetATub(10001:end))
hold on
plot([0:1200-1],NucTub(10001:end))
hold off
xlim([0 1200])
xlabel('Time in State 2 (s)')
ylabel('Free Tb (�M)')
set(gca,'FontSize',20)
legend('Nuc Rate = 0.0005','Nuc Rate = 0.0025')

figure(3)
hold on
plot([0:1200-1],SetALen(10001:end))
plot([0:1200-1],NucLen(10001:end))
hold off
xlim([0 1200])
xlabel('Time in State 2 (s)')
ylabel('Avg. MT Length (�m)')
set(gca,'FontSize',20)
legend('Nuc Rate = 0.0005','Nuc Rate = 0.0025')

%% Plotting B
figure(4)
plot([0:1200-1],SetACount(10001:end))
hold on
plot([0:1200-1],CatCount(10001:end))
plot([0:1200-1],ResCount(10001:end))
hold off
xlim([0 1200])
xlabel('Time in State 2 (s)')
ylabel('Number of MTs')
set(gca,'FontSize',20)
legend('NEBD','Interphase k_c','Interphace k_r')

figure(5)
plot([0:1200-1],SetATub(10001:end))
hold on
plot([0:1200-1],CatTub(10001:end))
plot([0:1200-1],ResTub(10001:end))
hold off
xlim([0 1200])
xlabel('Time in State 2 (s)')
ylabel('Free Tb (�M)')
set(gca,'FontSize',20)
legend('NEBD','Interphase k_c','Interphace k_r')

figure(6)
hold on
plot([0:1200-1],SetALen(10001:end))
plot([0:1200-1],CatLen(10001:end))
plot([0:1200-1],ResLen(10001:end))
hold off
xlim([0 1200])
xlabel('Time in State 2 (s)')
ylabel('Avg. MT Length (�m)')
set(gca,'FontSize',20)
legend('NEBD','Interphase k_c','Interphace k_r')