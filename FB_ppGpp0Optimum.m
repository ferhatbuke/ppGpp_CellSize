data = xlsread('Excel Based\2017-12-19 ppGpp0(Cashel) psRelY psMeshC OD.xlsx');

%Plots the figure S1B
%%512uMIPTG%%%%
figure
subplot(4,6,1)
plot([0:10:960],data(1:97,2)-0.078,'Linewidth',2,'Color','k') %16ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,2)
plot([0:10:960],data(1:97,3)-0.078,'Linewidth',2,'Color','k') %4ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])


subplot(4,6,3)
plot([0:10:960],data(1:97,4)-0.078,'Linewidth',2,'Color','k') %1ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])


subplot(4,6,4)
plot([0:10:960],data(1:97,5)-0.078,'Linewidth',2,'Color','k') %0.25ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,5)
plot([0:10:960],data(1:97,6)-0.078,'Linewidth',2,'Color','k') %0.08ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,6)
plot([0:10:960],data(1:97,7)-0.078,'Linewidth',2,'Color','k') %0ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])
%%%%%}

%%128uMIPTG%%%%
subplot(4,6,7)
plot([0:10:960],data(1:97,14)-0.078,'Linewidth',2,'Color','k') %16ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,8)
plot([0:10:960],data(1:97,15)-0.078,'Linewidth',2,'Color','k') %4ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,9)
plot([0:10:960],data(1:97,16)-0.078,'Linewidth',2,'Color','k') %1ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,10)
plot([0:10:960],data(1:97,17)-0.078,'Linewidth',2,'Color','k') %0.25ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,11)
plot([0:10:960],data(1:97,18)-0.078,'Linewidth',2,'Color','k') %0.08ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,12)
plot([0:10:960],data(1:97,19)-0.078,'Linewidth',2,'Color','k') %0ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])
%%%%%%}

%%%%%32uMIPTG
subplot(4,6,13)
plot([0:10:960],data(1:97,26)-0.078,'Linewidth',2,'Color','k') %16ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,14)
plot([0:10:960],data(1:97,27)-0.078,'Linewidth',2,'Color','k') %4ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,15)
plot([0:10:960],data(1:97,28)-0.078,'Linewidth',2,'Color','k') %1ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,16)
plot([0:10:960],data(1:97,29)-0.078,'Linewidth',2,'Color','k') %0.25ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,17)
plot([0:10:960],data(1:97,30)-0.078,'Linewidth',2,'Color','k') %0.08ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,18)
plot([0:10:960],data(1:97,31)-0.078,'Linewidth',2,'Color','k') %0ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])
%%%%%}

%%%%0uMIPTG
subplot(4,6,19)
plot([0:10:960],data(1:97,38)-0.078,'Linewidth',2,'Color','k') %16ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,20)
plot([0:10:960],data(1:97,39)-0.078,'Linewidth',2,'Color','k') %4ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,21)
plot([0:10:960],data(1:97,40)-0.078,'Linewidth',2,'Color','k') %1ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,22)
plot([0:10:960],data(1:97,41)-0.078,'Linewidth',2,'Color','k') %0.25ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])

subplot(4,6,23)
plot([0:10:960],data(1:97,42)-0.078,'Linewidth',2,'Color','k') %0.08ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])


subplot(4,6,24)
plot([0:10:960],data(1:97,43)-0.078,'Linewidth',2,'Color','k') %0ngDOX
xlim([0,900])
ylim([0,0.5])
set(gca, 'YScale', 'log')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'xtick',[])
set(gca,'ytick',[])
%}