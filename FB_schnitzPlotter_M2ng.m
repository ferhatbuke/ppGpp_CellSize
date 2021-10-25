function FB_schnitzPlotter_M2ng
clc
%close all

load('C:\Users\ferha\OneDrive\Desktop\PubFigures\Data\Minimal Media 2ng.mat')
%%Configured for Min Media 2ng Induction Experiment 2018-10-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstFrame = 750; % First frame of the analysis
endFrame = 1650;  % Last frame of the analysis
spikeFrame = 990; % FRAME Where Spike Hits the Cells
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spikeTime=245.0667;

allAvY=[];
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
FullschnitzY=[];
FullschnitzYEnd=[];
FullschnitzYAv=[];
FullschnitzYFrames=[];
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
    
    avY = mean([schnitzcells(i).Y4_mean]);
    allAvY = [allAvY,avY];
    
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
    schnitzYFrames = schnitzcells(i).Y_frames;
    schnitzWidthAv = mean(schnitzcells(i).rp_width);
    
    %%PARAMETERS TO KEEP SCHNITZSES IN ANALYSIS (Different ones compared to
    %(R2ng), the main detaily commented sift code.
    
    %schnitzCycleDuration > 15. This was 5 in the R2ng experiment
    %however here the average growth rate is 45min/doubling so a 15min
    %cycle allows for mistracking/segmentation issues removal.
    
    %max(schnitzcells(i).muP9_fitNew_all)<3. This was 4 in the R2ng experiment since growth
    %is slower here decreasing this value helps catch errors.
    
    schnitzIgnoreList = [541,750,831,1493,1884]; %Specific problematic schnitzses I found during visual inspection.
    
    if schnitzcells(i).completeCycle && schnitzBirthFrame>firstFrame-spikeFrame && schnitzCycleDuration > 15 && length(schnitzYFrames)>0 && schnitzDivisionFrame<endFrame-spikeFrame && max(schnitzcells(i).muP9_fitNew_all)<3 && min(schnitzcells(i).muP9_fitNew_all)>-1.5 && ~sum(i==schnitzIgnoreList)
        
        FullschnitzMuAv = [FullschnitzMuAv,avMu]; 
        
        schnitzY=schnitzcells(i).Y4_mean(~isnan(schnitzcells(i).Y4_mean));
        FullschnitzY = [FullschnitzY,schnitzY];
        schnitzYEnd  = schnitzY(end);
        FullschnitzYEnd = [FullschnitzYEnd,schnitzYEnd];
        schnitzYAv = mean(schnitzY);
        FullschnitzYAv = [FullschnitzYAv,schnitzYAv];

        
        FullbirthFrame = [FullbirthFrame,schnitzFrame(1)];
        
        FullschnitzYFrames =[FullschnitzYFrames,schnitzYFrames];
        
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
figure()            
scatter(FullTimeofDivision,FullschnitzMuAv,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','b','MarkerEdgeColor','b');
legend('Average μ')
line([0,0],[10,-5],'Color','black','HandleVisibility','off')
xlim([-150,700])
ylim([-1,4])
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

beforeSpike = FullTimeofDivision<0 & FullTimeofDivision>-150;
afterSpike = FullTimeofDivision>400 & FullTimeofDivision<680;

%Here average Mu and Dl are calculated to use in the Python model. Inital
%and Final Mu, Dl and the exp. decay constant of Instant Mu between the 2 zones are needed.

beforeSpikeMuAverage = mean(FullschnitzMuAv(beforeSpike));
afterSpikeMuAverage  = mean(FullschnitzMuAv(afterSpike));

beforeSpikeDlAverage = mean(FullAddedSize(beforeSpike));
afterSpikeDlAverage  = mean(FullAddedSize(afterSpike));

xMuFit = FullschnitzTime(FullschnitzTime>0 & FullschnitzTime<350); %All time points of cells
yMuFit = FullschnitzMu(FullschnitzTime>0 & FullschnitzTime<350); %Instantaneous growth rate p9
beta=FB_expDecayFitandStats(xMuFit,yMuFit,beforeSpikeMuAverage,afterSpikeMuAverage);

%Double normalize Mu and the added size by using 2Y axes. Note this is
%mathematically exactly the same as double normalizing the data and 
%labelling a single Y-axis as "Normalized parameters" which we also do in
%other figures and panels for clarity.

figure()            %%PLOT YFP
scatter(FullschnitzYFrames-spikeFrame,FullschnitzY)
hold on
title('YFP')
xlim([-150,150])
line([0,0],[400,-100],'Color','black')
[binnedX,binnedY]=xBinAverager(FullschnitzYFrames-spikeFrame, FullschnitzY, 22);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)','Binned (22min)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

headers ={'Time','Mu','Dl','Lb','Tcyc','YFP','schnitzNum'};
writeMatrix =[FullTimeofDivision;
    FullschnitzMuAv;
    FullAddedSize;
    FullsizeAtBirth;
    FullCycleDuration;
    FullschnitzYAv;
    FullschnitzLabel]';
finalMatrix(1,:)=headers;
finalMatrix(2:length(FullschnitzLabel)+1,:) = num2cell(writeMatrix);
xlswrite('M2ng.xlsx',finalMatrix)
end