close all

MT = [496 498 480 442;409 380 476 492];
TB = [4.7036 3.9583 6.8392 9.9701; 12.5837 14.4628 7.822 5.5995];
Len = [22.6422 23.1061 21.7478 20.9917; 20.3166 20.0340 21.1650 22.1513];

Parameters = categorical({'V_g','V_s','k_c','k_r'});

%% Initial parameters of Set A with one variable changed
figure(1)
bar(Parameters,MT(1,1:4))
hold on
yline(498,'k','LineWidth',2.5)
yline(416,':r','LineWidth',2.5)
hold off
xlabel('Parameter Exchanged')
ylabel('Numer of MTs')
ylim([0 550])
set(gca,'FontSize',20)

figure(2)
bar(Parameters,TB(1,1:4))
hold on
yline(4.5024,'k','LineWidth',2.5)
yline(11.9721,':r','LineWidth',2.5)
hold off
xlabel('Parameter Exchanged')
ylabel('Free Tb (µM)')
ylim([0 14])
set(gca,'FontSize',20)

figure(3)
bar(Parameters,Len(1,1:4))
hold on
yline(22.7011,'k','LineWidth',2.5)
yline(20.5197,':r','LineWidth',2.5)
hold off
xlabel('Parameter Exchanged')
ylabel('Avg. MT Length (µm)')
ylim([0 25])
set(gca,'FontSize',20)

%% Initial parameters of Set B with one variable changed
figure(4)
bar(Parameters,MT(2,1:4))
hold on
yline(498,':r','LineWidth',2.5)
yline(416,'k','LineWidth',2.5)
hold off
xlabel('Parameter Exchanged')
ylabel('Numer of MTs')
ylim([0 550])
set(gca,'FontSize',20)

figure(5)
bar(Parameters,TB(2,1:4))
hold on
yline(4.5024,':r','LineWidth',2.5)
yline(11.9721,'k','LineWidth',2.5)
hold off
xlabel('Parameter Exchanged')
ylabel('Free Tb (µM)')
ylim([0 14])
set(gca,'FontSize',20)

figure(6)
bar(Parameters,Len(2,1:4))
hold on
yline(22.7011,':r','LineWidth',2.5)
yline(20.5197,'k','LineWidth',2.5)
hold off
xlabel('Parameter Exchanged')
ylabel('Avg. MT Length (µm)')
ylim([0 25])
set(gca,'FontSize',20)