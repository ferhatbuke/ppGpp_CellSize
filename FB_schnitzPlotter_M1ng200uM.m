function FB_schnitzPlotter_M1ng200uM
clc
%close all

%In this experiment CFP is constantly induced with 200uM IPTG to test the
%effects of this on RelA spike induction.

load('C:\Users\ferha\OneDrive\Desktop\PubFigures\Data\Minimal Media 1ng 200uM.mat')
%%Configured for Min Media 2ng 100uM Induction Experiment 2018-08-02
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstFrame = 750; % First frame of the analysis
endFrame = 1669;  % Last frame of the analysis
spikeFrame = 1014; % FRAME Where Spike Hits the Cells
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spikeTime=264.5833;

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
    
    %schnitzFrame>-140 -> Due to a bug in the YFP calculation which is
    %discussed below. Only use cells which are borne after this timepoint.
    %NOTE you can disable this by commenting out the last check in the if
    %below. This way you can see how Mu and other parameters are behaving.
    %They are nominal. Only YFP is affected due to stiching bug.
     
    if schnitzcells(i).completeCycle && schnitzBirthFrame>firstFrame-spikeFrame && schnitzCycleDuration > 15 && length(schnitzYFrames)>0 && schnitzDivisionFrame<endFrame-spikeFrame && max(schnitzcells(i).muP9_fitNew_all)<3 && min(schnitzcells(i).muP9_fitNew_all)>-1.5 && schnitzBirthFrame>-140
        
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
xlim([-100,350])
ylim([-1,4])
hold on
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzMuAv, binSize);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue','DisplayName','Average μ binned 22 min)')
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('Mu(Doublings/Hr)','FontSize',12,'FontWeight','bold')
%NOTE 22min binsize is selected because BeforeSpikeTcyc/2 ~=22min. Bins are
%half a cell cycle basically. No particular reason other than consistency.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Minute 250-600min, average Mu appears stable. This is used as after induction
%stable zone in further analysis.

beforeSpike = FullTimeofDivision<0 & FullTimeofDivision>-100;
afterSpike = FullTimeofDivision>250 & FullTimeofDivision<600;

%Here average Mu and Dl are calculated to use in the Python model. Inital
%and Final Mu, Dl and the exp. decay constant of Instant Mu between the 2 zones are needed.

beforeSpikeMuAverage = mean(FullschnitzMuAv(beforeSpike));
afterSpikeMuAverage  = mean(FullschnitzMuAv(afterSpike));

beforeSpikeDlAverage = mean(FullAddedSize(beforeSpike));
afterSpikeDlAverage  = mean(FullAddedSize(afterSpike));

xMuFit = FullschnitzTime(FullschnitzTime>0 & FullschnitzTime<350); %All time points of cells
yMuFit = FullschnitzMu(FullschnitzTime>0 & FullschnitzTime<350); %Instantaneous growth rate p9
beta=FB_expDecayFitandStats(xMuFit,yMuFit,beforeSpikeMuAverage,afterSpikeMuAverage);

xMuFit = FullschnitzTime(FullschnitzTime>0 & FullschnitzTime<350); %All time points of cells
yMuFit = FullschnitzMu(FullschnitzTime>0 & FullschnitzTime<350); %Instantaneous growth rate p9
beta=FB_expDecayFitandStats(xMuFit,yMuFit,beforeSpikeMuAverage,afterSpikeMuAverage);

%Note in this analysis multiple pieces of blocks were added together which
%were done on different computers. This leads to weird behavior in YFP 
%calculation by schnitzcells (I think). Below I correct for the error by adding the
%background YFP back where it was mistakenly substracted by schnitzcells code.
meanBGYFP = mean(FullschnitzY(FullschnitzYFrames<spikeFrame & FullschnitzYFrames>spikeFrame-100));
FullschnitzYCorrected = FullschnitzY;
FullschnitzYCorrected(FullschnitzYFrames<spikeFrame-140) =  FullschnitzY(FullschnitzYFrames<spikeFrame-140)+meanBGYFP;
%Red line added to show where the addition of the background was performed,
%See in the second plot how there is a sharp dip at that point even though
%the images showed no such change in YFP.
%I tried many hours to figure out why this is happening in Schnitzcells but
%could not do it in reasonable time. This fix is good enough for our
%purposes, YFP does go up as seen in the images.

figure()            %%PLOT YFP Stich Bug
scatter(FullschnitzYFrames-spikeFrame,FullschnitzY)
hold on
title('YFP Stitch Bug')
xlim([-250,500])
ylim([0 300])
line([0,0],[800,-100],'Color','black')
line([-140,-140],[800,-100],'Color','red')
[binnedX,binnedY]=xBinAverager(FullschnitzYFrames, FullschnitzYCorrected, 22);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)')
xlabel('Frames[#]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

figure()            %%PLOT YFP Corrected
scatter(FullschnitzYFrames-spikeFrame,FullschnitzYCorrected)
hold on
title('YFP Corrected')
xlim([-250,500])
ylim([0 300])
line([-140,-140],[800,-100],'Color','red')
[binnedX,binnedY]=xBinAverager(FullschnitzYFrames, FullschnitzYCorrected, 22);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)','Binned (22min)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

figure()            %%PLOT YFP Mean
scatter(FullTimeofDivision,FullschnitzYAv)
hold on
title('YFP')
xlim([-150,500])
line([0,0],[400,-100],'Color','black')
line([-140,-140],[200,-100],'Color','red')
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzYAv, 22);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
%%Do not use cells alive at the broken frame. Only cells which are borne
%%after min 140 are used in the analysis everywhere.

%%PLOT 60/Tcyc
figure()            
scatter(FullTimeofDivision,60./FullCycleDuration,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','b','MarkerEdgeColor','b');
legend('60/Tcyc')
line([0,0],[10,-5],'Color','black','HandleVisibility','off')
xlim([firstFrame-spikeFrame,endFrame-spikeFrame])
ylim([-1,4])
hold on
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, 60./FullCycleDuration, 14);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue','DisplayName','Average μ binned 14 min)')
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('60/Tcyc(Doublings/Hr)','FontSize',12,'FontWeight','bold')

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
xlswrite('M1ng200uM.xlsx',finalMatrix)
end