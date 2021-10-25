function FB_schnitzPlotter_M100uM
clc
close all

load('C:\Users\ferha\OneDrive\Desktop\PubFigures\Data\Minimal Media 100uM.mat')
%%Configured for Min Media 2ng Induction Experiment 2018-10-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstFrame = 100; % First frame of the analysis
endFrame = 1100;  % Last frame of the analysis
spikeFrame = 553; % FRAME Where Spike Hits the Cells
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spikeTime=512.0333;

allAvC=[];
allSizeAtBirth=[];
allAvMu=[];
allBirthFrame=[];
allCycleDuration=[];
allFrame=[];
allDivisionFrame=[];

FullschnitzMu=[];
FullschnitzMuAv=[];
FullsizeAtBirth=[];
FullsizeAtDivision=[];
FullbirthFrame=[];
FullTimeofDivision=[];
FullAddedSize=[];
FullschnitzTime=[];
FullschnitzC=[];
FullschnitzCEnd=[];
FullschnitzCAv=[];
FullschnitzCFrames=[];
FullCycleDuration=[];
FullCyclevsExpansion=[];
FullschnitzLabel=[];
FullschnitzWidth=[];

SpikeAddedSizeAll=[];
SpikeHitAgeAll=[];

count=0;
testList=[];
for i=1:length(schnitzcells)
    
    avMu = mean(schnitzcells(i).av_mu_rp);
    maxInsMu = max(schnitzcells(i).muP9_fitNew_all);
    minInsMu = min(schnitzcells(i).muP9_fitNew_all);
    allAvMu = [allAvMu,avMu];
    
    avC = mean([schnitzcells(i).C4_mean]);
    allAvC = [allAvC,avC];
    
    schnitzFrame = schnitzcells(i).frame_nrs-spikeFrame;
    allFrame = [allFrame,schnitzFrame];
    
    schnitzDivisionFrame = schnitzFrame(end);
    allDivisionFrame=[allDivisionFrame,schnitzDivisionFrame];
    
    schnitzBirthFrame = schnitzFrame(1);
    allBirthFrame = [allBirthFrame,schnitzBirthFrame];
    
    schnitzSize = schnitzcells(i).length_fitNew;
    schnitzSizeAtBith = schnitzSize(1);
    allSizeAtBirth = [allSizeAtBirth,schnitzSizeAtBith];
    
    schnitzCycleDuration = schnitzcells(i).interDivTime;
    allCycleDuration = [allCycleDuration,schnitzCycleDuration];
    
    schnitzCenterY = schnitzcells(i).ceny_cent;
    schnitzCFrames = schnitzcells(i).C_frames;
    schnitzWidthAv = mean(schnitzcells(i).rp_width);
    
    %%PARAMETERS TO KEEP SCHNITZSES IN ANALYSIS (Different ones compared to
    %(R2ng), the main detaily commented sift code.
    
    %schnitzCycleDuration > 15. This was 5 in the R2ng experiment
    %however here the average growth rate is ~45min/doubling so a 15min
    %cycle allows for mistracking/segmentation issues removal.
    
    %max(schnitzcells(i).muP9_fitNew_all)<3. This was 4 in the R2ng experiment since growth
    %is slower here decreasing this value helps catch errors without removing real cells.
    
    if schnitzcells(i).completeCycle && schnitzBirthFrame>firstFrame-spikeFrame && schnitzCycleDuration > 15 && length(schnitzCFrames)>0 && schnitzDivisionFrame<endFrame-spikeFrame && max(schnitzcells(i).muP9_fitNew_all)<3 && min(schnitzcells(i).muP9_fitNew_all)>-1.5
        
        FullschnitzMuAv = [FullschnitzMuAv,avMu]; 
        
        schnitzC=schnitzcells(i).C4_mean(~isnan(schnitzcells(i).C4_mean));
        FullschnitzC = [FullschnitzC,schnitzC];
        schnitzCEnd  = schnitzC(end);
        FullschnitzCEnd = [FullschnitzCEnd,schnitzCEnd];
        schnitzCAv = mean(schnitzC);
        FullschnitzCAv = [FullschnitzCAv,schnitzCAv];

        
        FullbirthFrame = [FullbirthFrame,schnitzFrame(1)];
        
        FullschnitzCFrames =[FullschnitzCFrames,schnitzCFrames];
        
        FullschnitzMu =[FullschnitzMu,schnitzcells(i).muP9_fitNew_all];
        
        FullschnitzTime = [FullschnitzTime,schnitzcells(i).time-spikeTime];

        FullsizeAtBirth = [FullsizeAtBirth,schnitzSizeAtBith];
        
        FullschnitzLabel = [FullschnitzLabel,i];
        
        schnitzsizeAtDivision = schnitzSize(end);
        FullsizeAtDivision = [FullsizeAtDivision,schnitzsizeAtDivision];
        
        schnitzAddedSize = schnitzsizeAtDivision-schnitzSizeAtBith;
        FullAddedSize = [FullAddedSize,schnitzAddedSize];
        FullschnitzWidth = [FullschnitzWidth,schnitzWidthAv];    
        
        schnitzTimeofDivision = schnitzcells(i).time(end)-spikeTime;
        FullTimeofDivision = [FullTimeofDivision,schnitzTimeofDivision];
               
        FullCycleDuration = [FullCycleDuration,schnitzCycleDuration];
        schnitzCyclevsExpansion = (60/avMu)/schnitzCycleDuration;
        FullCyclevsExpansion = [FullCyclevsExpansion,schnitzCyclevsExpansion];
    end
end
binSize = 22;
%%PLOT MU Average AND Binned Average
figure('rend','painters','pos',[1200 500 300 300])         
scatter(FullTimeofDivision,FullschnitzMuAv,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','b','MarkerEdgeColor','b');
legend('Average μ')
line([0,0],[10,-5],'Color','black','HandleVisibility','off')
xlim([-150,600])
ylim([0.7,2])
hold on
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzMuAv, binSize);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue','DisplayName','Average μ binned 22 min)')
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('Mu(Doublings/Hr)','FontSize',12,'FontWeight','bold')
%NOTE 22min binsize is selected because BeforeSpikeTcyc/2 ~=22min. Bins are
%half a cell cycle basically. No particular reason other than consistency.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Minute 400+, average Mu appears stable. This is used as after induction
%stable zone in further analysis.

beforeSpike = FullTimeofDivision<0 & FullTimeofDivision>-100;
afterSpike = FullTimeofDivision>400;

%Here average Mu and Dl are calculated to use in the Python model. Inital
%and Final Mu, Dl and the exp. decay constant of Instant Mu between the 2 zones are needed.

beforeSpikeMuAverage = mean(FullschnitzMuAv(beforeSpike));
afterSpikeMuAverage  = mean(FullschnitzMuAv(afterSpike));

beforeSpikeDlAverage = mean(FullAddedSize(beforeSpike));
afterSpikeDlAverage  = mean(FullAddedSize(afterSpike));

xMuFit = FullschnitzTime(FullschnitzTime>0 & FullschnitzTime<400); %All time points of cells
yMuFit = FullschnitzMu(FullschnitzTime>0 & FullschnitzTime<400); %Instantaneous growth rate p9
beta=FB_expDecayFitandStats(xMuFit,yMuFit,beforeSpikeMuAverage,afterSpikeMuAverage);

%Double normalize Mu and the added size by using 2Y axes. Note this is
%mathematically exactly the same as double normalizing the data and 
%labelling a single Y-axis as "Normalized parameters" which we also do in
%other figures and panels for clarity.

%%Add Added Size to the Average Mu plot
yyaxis right
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullAddedSize, 22);
plot(binnedX,binnedY,'LineWidth',3,'color','red','DisplayName','Dl binned (22 min)')
scatter(FullTimeofDivision,FullAddedSize,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','r','MarkerEdgeColor','r','DisplayName','Dl');
ylim([0,4])
ylabel('Added Size (uM)','FontSize',12,'FontWeight','bold')
hold off
title('Mu DL, Figure 2F')
xlim([-150 500])

figure()            %%PLOT CFP
scatter(FullschnitzCFrames-spikeFrame,FullschnitzC)
hold on
title('CFP')
xlim([-150,150])
line([0,0],[400,-100],'Color','black')
[binnedX,binnedY]=xBinAverager(FullschnitzCFrames-spikeFrame, FullschnitzC, 22);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)','Binned (22min)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

%%PLOT 60/Tcyc
figure()            
scatter(FullTimeofDivision,FullCycleDuration,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','b','MarkerEdgeColor','b');
legend('60/Tcyc')
line([0,0],[0,120],'Color','black','HandleVisibility','off')
xlim([firstFrame-spikeFrame,endFrame-spikeFrame])

hold on
[binnedX,binnedY, binnedStd]=xBinAverager(FullTimeofDivision, FullCycleDuration, 15);
errorbar(binnedX,binnedY,binnedStd)
xlabel('Time (min.)','FontSize',12,'FontWeight','bold')
ylabel('Tcyc (min.)','FontSize',12,'FontWeight','bold')
ylim([30,70])
xlim([-50,100])
headers ={'Time','Mu','Dl','Lb','Tcyc','YFP','schnitzNum','Width'};
writeMatrix =[FullTimeofDivision;
    FullschnitzMuAv;
    FullAddedSize;
    FullsizeAtBirth;
    FullCycleDuration;
    FullschnitzCAv;
    FullschnitzLabel;
    FullschnitzWidth]';
finalMatrix(1,:)=headers;
finalMatrix(2:length(FullschnitzLabel)+1,:) = num2cell(writeMatrix);
xlswrite('M100.xlsx',finalMatrix)
end