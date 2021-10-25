data = xlsread('2020-07-16 NCM3722 pRelY pMeshC Optimal Test Reviewer.xlsx');

%A1 OD data(39,3)
%A1 CFP data(182,3)
%A1 YFP data(325,3)
%exp. length 120

%{
%%TOO MUCH DOX 4ng/ml
figure
hold
scatter([0:10:1190],data(39:158,3)-0.078)
%scatter([0:10:1190],data(39:158,4)-0.078)
scatter([0:10:1190],data(39:158,5)-0.078)
scatter([0:10:1190],data(39:158,6)-0.078)
%scatter([0:10:1190],data(39:158,7)-0.078)
scatter([0:10:1190],data(39:158,8)-0.078)
xlim([0.001,300])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')

figure
hold
scatter([0:10:1190],data(39:158,9)-0.078)
%scatter([0:10:1190],data(39:158,10)-0.078)
scatter([0:10:1190],data(39:158,11)-0.078)
scatter([0:10:1190],data(39:158,12)-0.078)
%scatter([0:10:1190],data(39:158,13)-0.078)
scatter([0:10:1190],data(39:158,14)-0.078)
xlim([0.001,300])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')
%}

%{
%%NO DOX 0ng/ml
figure
hold
scatter([0:10:1190],data(39:158,87)-0.078)
%scatter([0:10:1190],data(39:158,88)-0.078)
scatter([0:10:1190],data(39:158,89)-0.078)
scatter([0:10:1190],data(39:158,90)-0.078)
%scatter([0:10:1190],data(39:158,91)-0.078)
scatter([0:10:1190],data(39:158,92)-0.078)
xlim([0.001,300])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')

figure
hold
scatter([0:10:1190],data(39:158,93)-0.078)
%scatter([0:10:1190],data(39:158,94)-0.078)
scatter([0:10:1190],data(39:158,95)-0.078)
scatter([0:10:1190],data(39:158,96)-0.078)
%scatter([0:10:1190],data(39:158,97)-0.078)
scatter([0:10:1190],data(39:158,98)-0.078)
xlim([0.001,300])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')


%}

%
%%LOW DOX 0.5ng/ml
figure
hold
scatter([0:10:1190],data(39:158,63)-0.078)
%scatter([0:10:1190],data(39:158,64)-0.078)
scatter([0:10:1190],data(39:158,65)-0.078)
scatter([0:10:1190],data(39:158,66)-0.078)
%scatter([0:10:1190],data(39:158,67)-0.078)
scatter([0:10:1190],data(39:158,68)-0.078)
xlim([0.001,300])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')

figure
hold
scatter([0:10:1190],data(39:158,69)-0.078)
%scatter([0:10:1190],data(39:158,70)-0.078)
scatter([0:10:1190],data(39:158,71)-0.078)
scatter([0:10:1190],data(39:158,72)-0.078)
%scatter([0:10:1190],data(39:158,73)-0.078)
scatter([0:10:1190],data(39:158,74)-0.078)
xlim([0.001,300])
ylim([0,0.1])
legend('400','100','50','0')
legend('Location','northwest')
set(gca, 'YScale', 'log')
%}


%
%4ng DOX Reps
dataWrite(:,1) = log2(data(39:158,3)'*5.5181-0.4221);
dataWrite(:,2) = log2(data(39:158,5)'*5.5181-0.4221);
dataWrite(:,3) = log2(data(39:158,6)'*5.5181-0.4221);
dataWrite(:,4) = log2(data(39:158,8)'*5.5181-0.4221);
dataWrite(:,5) = log2(data(39:158,9)'*5.5181-0.4221);
dataWrite(:,6) = log2(data(39:158,11)'*5.5181-0.4221);
dataWrite(:,7) = log2(data(39:158,12)'*5.5181-0.4221);
dataWrite(:,8) = log2(data(39:158,14)'*5.5181-0.4221);

%0ng DOX Reps
dataWrite(:,9) = log2(data(39:158,63)'*5.5181-0.4221);
dataWrite(:,10) = log2(data(39:158,65)'*5.5181-0.4221);
dataWrite(:,11) = log2(data(39:158,66)'*5.5181-0.4221);
dataWrite(:,12) = log2(data(39:158,68)'*5.5181-0.4221);
dataWrite(:,13) = log2(data(39:158,69)'*5.5181-0.4221);
dataWrite(:,14) = log2(data(39:158,71)'*5.5181-0.4221);
dataWrite(:,15) = log2(data(39:158,72)'*5.5181-0.4221);
dataWrite(:,16) = log2(data(39:158,74)'*5.5181-0.4221);

%0.5ng DOX Reps
dataWrite(:,17) = log2(data(39:158,87)'*5.5181-0.4221);
dataWrite(:,18) = log2(data(39:158,89)'*5.5181-0.4221);
dataWrite(:,19) = log2(data(39:158,90)'*5.5181-0.4221);
dataWrite(:,20) = log2(data(39:158,92)'*5.5181-0.4221);
dataWrite(:,21) = log2(data(39:158,93)'*5.5181-0.4221);
dataWrite(:,22) = log2(data(39:158,95)'*5.5181-0.4221);
dataWrite(:,23) = log2(data(39:158,96)'*5.5181-0.4221);
dataWrite(:,24) = log2(data(39:158,98)'*5.5181-0.4221);

xlswrite('NCMOptimumData',dataWrite)
%}