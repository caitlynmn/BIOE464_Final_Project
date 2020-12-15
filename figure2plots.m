mtcount = [359 428 478 499; 238 290 357 416];
freetb = [2.4290 2.5515 2.9842 4.2817; 9.1001 10.3328 11.0617 11.9721];
avglen = [18.1432 19.4425 20.9508 22.8196; 16.9768 18.7481 19.6645 20.5197];

tbconc = [20 25 30 35];

figure(1)
plot(tbconc,mtcount(1,:),'.','MarkerSize',20)
hold on
plot(tbconc,mtcount(2,:),'s','MarkerSize',10,'MarkerFaceColor','r')
hold off
xlabel('Total Tb (然)')
ylabel('Number of MTs')
legend('Set A','Set B')
xlim([0 40])
ylim([0 500])

figure(2)
plot(tbconc,freetb(1,:),'.','MarkerSize',20)
hold on
plot(tbconc,freetb(2,:),'s','MarkerSize',10,'MarkerFaceColor','r')
hold off
xlabel('Total Tb (然)')
ylabel('Free Tb (然)')
legend('Set A','Set B')
xlim([0 40])
ylim([0 14])

figure(3)
plot(tbconc,avglen(1,:),'.','MarkerSize',20)
hold on
plot(tbconc,avglen(2,:),'s','MarkerSize',10,'MarkerFaceColor','r')
hold off
xlabel('Total Tb (然)')
xlim([0 40])
ylabel('Avg Length (痠)')
legend('Set A','Set B')
ylim([0 25])
