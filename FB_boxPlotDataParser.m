function FB_boxPlotDataParser(FitData)

%{
***
main data file=>(SiftedData->2021-07-10 FitData.xlsx).
Import the main data file and run the function on the command line as: 
	>>'FB_boxPlotDataParser(FitData)'
-'drag and drop' the excel file on the command line to read the file 
then select the entire spreadsheet area (CTRL+A) and cliock "Import Selection". 
-This creates "FitData" which is used for some functions. 
%}

%Create empty vectors to hold data.
plotVectorLb =[];
plotVectorMu=[];
plotVectorDl=[];
plotType=[];

PlotVectorFrequencySpike = [];
PlotVectorFrequencySpikeType = [];

%All of the data is imported into a single vector.
%A secondeary plotType vector "remembers" where each seperate experiment's
%data is and later used for plotting.

%Import data for 100uM IPTG MeshI Induction After Induction (4) Min media
afterInduction4 = (FitData.Time4'>400 & FitData.Time4'<600);
plotVectorLb = [plotVectorLb,FitData.Lb4(afterInduction4)'];
plotVectorMu = [plotVectorMu,FitData.Mu4(afterInduction4)'];
plotVectorDl = [plotVectorDl,FitData.Dl4(afterInduction4)'];
plotType(1:sum(afterInduction4)) = 1;

%Import data for 100uM IPTG MeshI Induction Before Induction (4) Min media
beforeInduction4 = (FitData.Time4'<0 & FitData.Time4'>-100);
plotVectorLb = [plotVectorLb,FitData.Lb4(beforeInduction4)'];
plotVectorMu = [plotVectorMu,FitData.Mu4(beforeInduction4)'];
plotVectorDl = [plotVectorDl,FitData.Dl4(beforeInduction4)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction4)) = 2;

%Import data for 2ng/ml DOX RelA Induction Before Induction (2) Min media
beforeInduction2 = (FitData.Time2'<0 & FitData.Time2'>-150);
plotVectorLb = [plotVectorLb,FitData.Lb2(beforeInduction2)'];
plotVectorMu = [plotVectorMu,FitData.Mu2(beforeInduction2)'];
plotVectorDl = [plotVectorDl,FitData.Dl2(beforeInduction2)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction2)) = 3;

%Import data for 1ng/ml DOX RelA Induction After Induction (5) Min media
afterInduction5 = (FitData.Time5'>250 & FitData.Time5'<600);
plotVectorLb = [plotVectorLb,FitData.Lb5(afterInduction5)'];
plotVectorMu = [plotVectorMu,FitData.Mu5(afterInduction5)'];
plotVectorDl = [plotVectorDl,FitData.Dl5(afterInduction5)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction5)) = 4;

%Import data for 2ng/ml DOX RelA Induction After Induction (2) Min media
afterInduction2 = (FitData.Time2'>400 & FitData.Time2'<680);
plotVectorLb = [plotVectorLb,FitData.Lb2(afterInduction2)'];
plotVectorMu = [plotVectorMu,FitData.Mu2(afterInduction2)'];
plotVectorDl = [plotVectorDl,FitData.Dl2(afterInduction2)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction2)) = 5;

%Import data for 2ng/ml DOX RelA Induction After Induction () Rich media
afterInduction = (FitData.Time'>400 & FitData.Time'<500);
plotVectorLb = [plotVectorLb,FitData.Lb(afterInduction)'];
plotVectorMu = [plotVectorMu,FitData.Mu(afterInduction)'];
plotVectorDl = [plotVectorDl,FitData.Dl(afterInduction)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction)) = 6;

%
%Import data for 1ng/ml DOX RelA Induction After Induction (1) Rich media
afterInduction1 = (FitData.Time1'>250 & FitData.Time1'<350);
plotVectorLb = [plotVectorLb,FitData.Lb1(afterInduction1)'];
plotVectorMu = [plotVectorMu,FitData.Mu1(afterInduction1)'];
plotVectorDl = [plotVectorDl,FitData.Dl1(afterInduction1)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction1)) = 7;
%}

%Import data for 2ng/ml DOX RelA Induction Before Induction () Rich media
beforeInduction = (FitData.Time'>-150 & FitData.Time'<0);
plotVectorLb = [plotVectorLb,FitData.Lb(beforeInduction)'];
plotVectorMu = [plotVectorMu,FitData.Mu(beforeInduction)'];
plotVectorDl = [plotVectorDl,FitData.Dl(beforeInduction)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction)) = 8;


%Plots figure 1F using single cell data in the FitData, See README.txt ***
figure
hold on
scatter(plotVectorMu(plotType==3),plotVectorLb(plotType==3));
scatter(plotVectorMu(plotType==4),plotVectorLb(plotType==4));
scatter(plotVectorMu(plotType==5),plotVectorLb(plotType==5));
scatter(plotVectorMu(plotType==2),plotVectorLb(plotType==2));
scatter(plotVectorMu(plotType==1),plotVectorLb(plotType==1));
scatter(plotVectorMu(plotType==8),plotVectorLb(plotType==8));
scatter(plotVectorMu(plotType==7),plotVectorLb(plotType==7));
scatter(plotVectorMu(plotType==6),plotVectorLb(plotType==6));
xlim([0,2.75])
ylim([0,4])
axis square

%Calculate 60/Tcyc immediately after the spike and compare to before spike.
%For different media and indiction conditions.

%Data holder for boxplots. For each experiment cells' 1/Tcyc before and during 
%spike data is saved along with "Type" for boxplotting.
plotDataSpike=[];
plotTypeSpike=[];

    %Rich Media 2ng/ml
beforeInductionSpike = (FitData.Time'<0 & FitData.Time'>-150);
afterInduction = (FitData.Time'>400 & FitData.Time'<500);
meanTcycBeforeSpike = mean(FitData.Tcyc(beforeInductionSpike));
duringInductionSpike = (FitData.Time'>0 & FitData.Time'<2*meanTcycBeforeSpike);

%Calculate and print on the command line t-stats for the before and during spike 1/Tcyc data.
[~,p,~,~] = ttest2(FitData.Tcyc(beforeInductionSpike),FitData.Tcyc(duringInductionSpike));
    disp('=========Rich Media 2ng/ml')
    disp(mean(60./FitData.Tcyc(beforeInductionSpike)))
    disp(mean(60./FitData.Tcyc(duringInductionSpike)))
    disp(strcat('Number of cells before: ',num2str(sum(beforeInductionSpike))))
    disp(strcat('Number of cells during: ',num2str(sum(duringInductionSpike))))
    disp(p)
    disp('=========')

plotTypeSpike = [plotTypeSpike,ones(1,sum(beforeInductionSpike))]; %Type=1 same length as Data below.
plotTypeSpike = [plotTypeSpike,ones(1,sum(duringInductionSpike))+1]; %Type=2

plotDataSpike = [plotDataSpike,60./FitData.Tcyc(beforeInductionSpike)'];
plotDataSpike = [plotDataSpike,60./FitData.Tcyc(duringInductionSpike)'];

    %Rich Media 1ng/ml
beforeInductionSpike1 = (FitData.Time1'<0 & FitData.Time1'>-100);
meanTcycBeforeSpike1 = mean(FitData.Tcyc1(beforeInductionSpike1));
duringInductionSpike1 = (FitData.Time1'>0 & FitData.Time1'<2*meanTcycBeforeSpike1);
afterInduction1 = (FitData.Time1'>250 & FitData.Time1'<350);

plotTypeSpike = [plotTypeSpike,ones(1,sum(beforeInductionSpike1))+2]; %Type=3
plotTypeSpike = [plotTypeSpike,ones(1,sum(duringInductionSpike1))+3]; %Type=4

plotDataSpike = [plotDataSpike,60./FitData.Tcyc1(beforeInductionSpike1)'];
plotDataSpike = [plotDataSpike,60./FitData.Tcyc1(duringInductionSpike1)'];

%Calculate and print on the command line t-stats for the before and during spike 1/Tcyc data.
[~,p,~,~] = ttest2(FitData.Tcyc1(beforeInductionSpike1),FitData.Tcyc1(duringInductionSpike1));
    disp('=========Rich Media 1ng/ml')
    disp(mean(60./FitData.Tcyc1(beforeInductionSpike1)))
    disp(mean(60./FitData.Tcyc1(duringInductionSpike1)))
    disp(strcat('Number of cells before: ',num2str(sum(beforeInductionSpike1))))
    disp(strcat('Number of cells during: ',num2str(sum(duringInductionSpike1))))
    disp(p)
    disp('=========')
    
    %Min Media 2ng/ml
beforeInductionSpike2 = (FitData.Time2'<0 & FitData.Time2'>-150);
meanTcycBeforeSpike2 = mean(FitData.Tcyc2(beforeInductionSpike2));
duringInductionSpike2 = (FitData.Time2'>0 & FitData.Time2'<2*meanTcycBeforeSpike2);

plotTypeSpike = [plotTypeSpike,ones(1,sum(beforeInductionSpike2))+4]; %Type=5
plotTypeSpike = [plotTypeSpike,ones(1,sum(duringInductionSpike2))+5]; %Type=6

plotDataSpike = [plotDataSpike,60./FitData.Tcyc2(beforeInductionSpike2)'];
plotDataSpike = [plotDataSpike,60./FitData.Tcyc2(duringInductionSpike2)'];

%Calculate and print on the command line t-stats for the before and during spike 1/Tcyc data.
[~,p,~,~] = ttest2(FitData.Tcyc2(beforeInductionSpike2),FitData.Tcyc2(duringInductionSpike2));
    disp('=========Min Media 2ng/ml')
    disp(mean(60./FitData.Tcyc2(beforeInductionSpike2)))
    disp(mean(60./FitData.Tcyc2(duringInductionSpike2)))
    disp(strcat('Number of cells before: ',num2str(sum(beforeInductionSpike2))))
    disp(strcat('Number of cells during: ',num2str(sum(duringInductionSpike2))))
    disp(p)
    disp('=========')

    %Min Media 1ng/ml
beforeInductionSpike3 = (FitData.Time3'<0 & FitData.Time3'>-150);
meanTcycBeforeSpike3 = mean(FitData.Tcyc3(beforeInductionSpike3));
duringInductionSpike3 = (FitData.Time3'>0 & FitData.Time3'<2*meanTcycBeforeSpike3);

plotTypeSpike = [plotTypeSpike,ones(1,sum(beforeInductionSpike3))+6]; %Type=7
plotTypeSpike = [plotTypeSpike,ones(1,sum(duringInductionSpike3))+7]; %Type=8

plotDataSpike = [plotDataSpike,60./FitData.Tcyc3(beforeInductionSpike3)'];
plotDataSpike = [plotDataSpike,60./FitData.Tcyc3(duringInductionSpike3)'];

%Calculate and print on the command line t-stats for the before and during spike 1/Tcyc data.
[~,p,~,~] = ttest2(FitData.Tcyc3(beforeInductionSpike3),FitData.Tcyc3(duringInductionSpike3));
    disp('=========Min Media 1ng/ml')
    disp(mean(60./FitData.Tcyc3(beforeInductionSpike3)))
    disp(mean(60./FitData.Tcyc3(duringInductionSpike3)))
    disp(strcat('Number of cells before: ',num2str(sum(beforeInductionSpike3))))
    disp(strcat('Number of cells during: ',num2str(sum(duringInductionSpike3))))
    disp(p)
    disp('=========')

%Plots 3E
figure()
boxplot(plotDataSpike,plotTypeSpike,'Colors','k','Symbol','')
title('Before and During Spike 60/Tcyc Comparison Experiments')

%Plots 1D only minimal media data was shown x=(1,2,3,4,5), 
%rich data was not included for clarity x=(6,7,8)
%Rich media data is instead visible in figure 1F plotted above
figure()
boxplot(plotVectorMu,plotType,'Colors','k','Symbol','')
ylabel('Elongation Rate (doubling/hr)')
ylim([0,2])

%Plots 1E only minimal media data was shown x=(1,2,3,4,5)
figure()
boxplot(plotVectorLb,plotType,'Colors','k','Symbol','')
ylabel('Birth Length (um)')
ylim([0.5,3.5])

%Plots S2B only minimal media data was shown x=(1,2,3,4,5)
figure()
boxplot(plotVectorDl,plotType,'Colors','k','Symbol','')
ylabel('Added Length (um)')
ylim([0.5,3.5])

%Erase data from above and reimport data only of Minimal media.
plotVectorLb =[];
plotVectorMu=[];
plotType=[];

%All Minimal media below. Reimport and calculate values for code clarity.
%Import data for 2ng/ml DOX Induction Before Induction (2)
beforeInduction2 = (FitData.Time2'<0 & FitData.Time2'>-150);
plotVectorLb = [plotVectorLb,FitData.Lb2(beforeInduction2)'];
plotVectorMu = [plotVectorMu,FitData.Mu2(beforeInduction2)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction2)) = 1;
 
%Import data for 1ng/ml DOX Induction Before Induction (5)
beforeInduction5 = (FitData.Time5'<0 & FitData.Time5'>-150);
plotVectorLb = [plotVectorLb,FitData.Lb5(beforeInduction5)'];
plotVectorMu = [plotVectorMu,FitData.Mu5(beforeInduction5)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction5)) = 2;

%Import data for 1ng/ml DOX, 200uM IPTG(always present)->CFP Induction Before Induction (3)
beforeInduction3 = (FitData.Time3'<0 & FitData.Time3'>-100);
plotVectorLb = [plotVectorLb,FitData.Lb3(beforeInduction3)'];
plotVectorMu = [plotVectorMu,FitData.Mu3(beforeInduction3)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction3)) = 3;

%Import data for 100uM IPTG MeshI Induction Before Induction (4)
beforeInduction4 = (FitData.Time4'<0 & FitData.Time4'>-100);
plotVectorLb = [plotVectorLb,FitData.Lb4(beforeInduction4)'];
plotVectorMu = [plotVectorMu,FitData.Mu4(beforeInduction4)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction4)) = 4;

%Import data for 2ng/ml DOX Induction After Induction (2)
afterInduction2 = (FitData.Time2'>400 & FitData.Time2'<680);
plotVectorLb = [plotVectorLb,FitData.Lb2(afterInduction2)'];
plotVectorMu = [plotVectorMu,FitData.Mu2(afterInduction2)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction2)) = 5;

%Import data for 1ng/ml DOX RelA Induction After Induction (5)
afterInduction5 = (FitData.Time5'>250 & FitData.Time5'<600);
plotVectorLb = [plotVectorLb,FitData.Lb5(afterInduction5)'];
plotVectorMu = [plotVectorMu,FitData.Mu5(afterInduction5)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction5)) = 6;

%Import data for 1ng/ml DOX 200uM IPTG(CFP) Induction After Induction (3)
afterInduction3 = (FitData.Time3'>400 & FitData.Time3'<600);
plotVectorLb = [plotVectorLb,FitData.Lb3(afterInduction3)'];
plotVectorMu = [plotVectorMu,FitData.Mu3(afterInduction3)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction3)) = 7;

%Import data for 100uM IPTG MeshI Induction After Induction (4)
afterInduction4 = (FitData.Time4'>400 & FitData.Time4'<600);
plotVectorLb = [plotVectorLb,FitData.Lb4(afterInduction4)'];
plotVectorMu = [plotVectorMu,FitData.Mu4(afterInduction4)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction4)) = 8;
%Plots S1F
figure()
boxplot(plotVectorMu,plotType,'Colors','k','Symbol','')
ylabel('Elongation Rate (doubling/hr)')
ylim([0,2])
meanGrowthBeforeSpikeAll=mean(plotVectorMu(plotType<4.5));
line([0,10],[meanGrowthBeforeSpikeAll,meanGrowthBeforeSpikeAll],'Color','black')

%PLots S1G
figure()
boxplot(plotVectorLb,plotType,'Colors','k','Symbol','')
ylabel('Birth Length (um)')
ylim([0,4])
meanDLBeforeSpikeAll=mean(plotVectorLb(plotType<4.5));
line([0,10],[meanDLBeforeSpikeAll,meanDLBeforeSpikeAll],'Color','black')

%PLOT YFP and CFP Before and After Spike (Figure S1C)
%Note: histfit plots the numbers instead of population ratios. We adjust the yaxis to show
%population percentage for each plot and later superimpose the induced and uninduced plots in Adobe.
%Making sure the yaxis is not altered in value.
%Rich 2ng
beforeInductionSpikeY = (FitData.Time'>-100 & FitData.Time'<0);
figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.YFP(beforeInductionSpikeY),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(beforeInductionSpikeY))
yticks([0*sum(beforeInductionSpikeY), 0.2*sum(beforeInductionSpikeY), 0.4*sum(beforeInductionSpikeY)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(beforeInductionSpikeY)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})

figure('rend','painters','pos',[500 500 300 150])
xlim([-100,1200])
histfit(FitData.YFP(afterInduction),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(afterInduction))
yticks([0*sum(afterInduction), 0.2*sum(afterInduction), 0.4*sum(afterInduction)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(afterInduction)])
xlim([-100,1100])
xticks([0, 400, 1100])
xticklabels({'0','400','800'})

%Rich 1ng
figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.YFP1(beforeInductionSpike1),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(beforeInductionSpike1))
yticks([0*sum(beforeInductionSpike1), 0.2*sum(beforeInductionSpike1), 0.4*sum(beforeInductionSpike1)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(beforeInductionSpike1)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})

figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.YFP1(afterInduction1),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(afterInduction1))
yticks([0*sum(afterInduction1), 0.2*sum(afterInduction1), 0.4*sum(afterInduction1)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(afterInduction1)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})

%Min 2ng
figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.YFP2(beforeInduction2),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(beforeInduction2))
yticks([0*sum(beforeInduction2), 0.2*sum(beforeInduction2), 0.4*sum(beforeInduction2)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(beforeInduction2)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})


figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.YFP2(afterInduction2),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(afterInduction2))
yticks([0*sum(afterInduction2), 0.2*sum(afterInduction2), 0.4*sum(afterInduction2)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(afterInduction2)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})

%Min 1ng
figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.YFP3(beforeInduction3),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(beforeInduction3))
yticks([0*sum(beforeInduction3), 0.2*sum(beforeInduction3), 0.4*sum(beforeInduction3)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(beforeInduction3)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})

figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.YFP3(afterInduction3),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(afterInduction3))
yticks([0*sum(afterInduction3), 0.2*sum(afterInduction3), 0.4*sum(afterInduction3)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(afterInduction3)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})

%Min 100uM
figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.CFP(beforeInduction4),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(beforeInduction4))
yticks([0*sum(beforeInduction4), 0.2*sum(beforeInduction4), 0.4*sum(beforeInduction4)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(beforeInduction4)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})

figure('rend','painters','pos',[500 500 300 150])
histfit(FitData.CFP(afterInduction4),15)
yt = get(gca, 'YTick');
set(gca, 'YTick', yt, 'YTickLabel', yt/sum(afterInduction4))
yticks([0*sum(afterInduction4), 0.2*sum(afterInduction4), 0.4*sum(afterInduction4)])
yticklabels({'0','0.2','0.4'})
ylim([0,0.5*sum(afterInduction4)])
xlim([-100,1100])
xticks([0, 400, 800])
xticklabels({'0','400','800'})
xlim([-100,1100])
end
















