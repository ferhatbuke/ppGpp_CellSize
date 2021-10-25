data = xlsread('Excel Based\2020-12-16 NCM3722 pMeshC Rich Minimal.xlsx');

%C1 OD data(1,27)
%exp. length 74

%{
%%Rich Media  Exponential growth after min 150 REP1
figure
hold on
scatter([0:10:730],data(1:74,39)-0.078) %800
scatter([0:10:730],data(1:74,40)-0.078) %400
scatter([0:10:730],data(1:74,41)-0.078) %200
scatter([0:10:730],data(1:74,42)-0.078) %100
scatter([0:10:730],data(1:74,43)-0.078) %50
scatter([0:10:730],data(1:74,44)-0.078) %0
xlim([0.001,300])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')
hold off
%}

%%Minimal Media  Exponential growth after min 250 REP1
figure
hold on
scatter([0:10:730],data(1:74,45)-0.078) %800
scatter([0:10:730],data(1:74,46)-0.078) %400
scatter([0:10:730],data(1:74,47)-0.078) %200
scatter([0:10:730],data(1:74,48)-0.078) %100
scatter([0:10:730],data(1:74,49)-0.078) %50
scatter([0:10:730],data(1:74,50)-0.078) %0
xlim([0.001,600])
ylim([0,0.1])
legend('800','400','200','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')
hold off

%{
%%Rich Media  Exponential growth after min 150 REP2
figure
hold on
scatter([0:10:730],data(1:74,51)-0.078) %800
scatter([0:10:730],data(1:74,52)-0.078) %400
scatter([0:10:730],data(1:74,53)-0.078) %200
scatter([0:10:730],data(1:74,54)-0.078) %100
scatter([0:10:730],data(1:74,55)-0.078) %50
scatter([0:10:730],data(1:74,56)-0.078) %0
xlim([0.001,300])
ylim([0,0.2])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')
hold off

%%Minimal Media  Exponential growth after min 250 REP2
figure
hold on
scatter([0:10:730],data(1:74,57)-0.078) %800
scatter([0:10:730],data(1:74,58)-0.078) %400
scatter([0:10:730],data(1:74,59)-0.078) %200
scatter([0:10:730],data(1:74,60)-0.078) %100
scatter([0:10:730],data(1:74,61)-0.078) %50
scatter([0:10:730],data(1:74,62)-0.078) %0
xlim([0.001,600])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')
hold off

%%Rich Media  Exponential growth after min 150 REP3
figure
hold on
scatter([0:10:730],data(1:74,63)-0.078) %800
scatter([0:10:730],data(1:74,64)-0.078) %400
scatter([0:10:730],data(1:74,65)-0.078) %200
scatter([0:10:730],data(1:74,66)-0.078) %100
scatter([0:10:730],data(1:74,67)-0.078) %50
scatter([0:10:730],data(1:74,68)-0.078) %0
xlim([0.001,300])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')
hold off

%%Minimal Media  Exponential growth after min 250 REP3
figure
hold on
scatter([0:10:730],data(1:74,69)-0.078) %800
scatter([0:10:730],data(1:74,70)-0.078) %400
scatter([0:10:730],data(1:74,71)-0.078) %200
scatter([0:10:730],data(1:74,72)-0.078) %100
scatter([0:10:730],data(1:74,73)-0.078) %50
scatter([0:10:730],data(1:74,74)-0.078) %0
xlim([0.001,600])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')
hold off
%}

%y=x*5.5181-0.4221
%y-> OD Bench Spectrophotometer
%x-> OD BioTek
%2017-11-02 OD MOPS calibration with Lid

% Rich Media 1
dataWrite(:,1) = log2(data(1:74,40)'*5.5181-0.4221);
dataWrite(:,2) = log2(data(1:74,42)'*5.5181-0.4221);
dataWrite(:,3) = log2(data(1:74,43)'*5.5181-0.4221);
dataWrite(:,4) = log2(data(1:74,44)'*5.5181-0.4221);

%Rich Media 2
dataWrite(:,5) = log2(data(1:74,52)'*5.5181-0.4221);
dataWrite(:,6) = log2(data(1:74,54)'*5.5181-0.4221);
dataWrite(:,7) = log2(data(1:74,55)'*5.5181-0.4221);
dataWrite(:,8) = log2(data(1:74,56)'*5.5181-0.4221);

%Rich Media 3
dataWrite(:,9) = log2(data(1:74,64)'*5.5181-0.4221);
dataWrite(:,10) = log2(data(1:74,66)'*5.5181-0.4221);
dataWrite(:,11) = log2(data(1:74,67)'*5.5181-0.4221);
dataWrite(:,12) = log2(data(1:74,68)'*5.5181-0.4221);

%Min Media 1
dataWrite(:,13) = log2(data(1:74,46)'*5.5181-0.4221);
dataWrite(:,14) = log2(data(1:74,48)'*5.5181-0.4221);
dataWrite(:,15) = log2(data(1:74,49)'*5.5181-0.4221);
dataWrite(:,16) = log2(data(1:74,50)'*5.5181-0.4221);

%Min Media 2
dataWrite(:,17) = log2(data(1:74,58)'*5.5181-0.4221);
dataWrite(:,18) = log2(data(1:74,60)'*5.5181-0.4221);
dataWrite(:,19) = log2(data(1:74,61)'*5.5181-0.4221);
dataWrite(:,20) = log2(data(1:74,62)'*5.5181-0.4221);

%Min Media 3
dataWrite(:,21) = log2(data(1:74,70)'*5.5181-0.4221);
dataWrite(:,22) = log2(data(1:74,72)'*5.5181-0.4221);
dataWrite(:,23) = log2(data(1:74,73)'*5.5181-0.4221);
dataWrite(:,24) = log2(data(1:74,74)'*5.5181-0.4221);

xlswrite('MeshCRichMinData',dataWrite)
%}