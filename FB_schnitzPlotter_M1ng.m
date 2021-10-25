function FB_schnitzPlotter_M1ng
clc
%close all
load('C:\Users\ferha\OneDrive\Desktop\PubFigures\Data\Minimal Media 1ng.mat')
%%Configured for Min Media 1ng Induction Experiment 2019-06-21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstFrame = 650; % First frame of the analysis
endFrame = 1550;  % Last frame of the analysis
spikeFrame = 967; % FRAME Where Spike Hits the Cells
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spikeTime=337.5833;

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
    
    if schnitzcells(i).completeCycle && schnitzBirthFrame>firstFrame-spikeFrame && schnitzCycleDuration > 15 && length(schnitzYFrames)>0 && schnitzDivisionFrame<endFrame-spikeFrame && max(schnitzcells(i).muP9_fitNew_all)<3 && min(schnitzcells(i).muP9_fitNew_all)>-1.5
        
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
xlim([-150,350])
ylim([-1,4])
hold on
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzMuAv, binSize);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue','DisplayName','Average μ binned 22 min)')
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('Mu(Doublings/Hr)','FontSize',12,'FontWeight','bold')
%NOTE 22min binsize is selected because BeforeSpikeTcyc/2 ~=22min. Bins are
%half a cell cycle basically. No particular reason other than consistency.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Minute 250+, average Mu appears stable. This is used as after induction
%stable zone in further analysis.

beforeSpike = FullTimeofDivision<0 & FullTimeofDivision>-100;
afterSpike = FullTimeofDivision>250 & FullTimeofDivision<450;

%Here average Mu and Dl are calculated to use in the Python model. Inital
%and Final Mu, Dl and the exp. decay constant of Instant Mu between the 2 zones are needed.

beforeSpikeMuAverage = mean(FullschnitzMuAv(beforeSpike));
afterSpikeMuAverage  = mean(FullschnitzMuAv(afterSpike));

beforeSpikeDlAverage = mean(FullAddedSize(beforeSpike));
afterSpikeDlAverage  = mean(FullAddedSize(afterSpike));

xMuFit = FullschnitzTime(FullschnitzTime>0 & FullschnitzTime<250); %All time points of cells
yMuFit = FullschnitzMu(FullschnitzTime>0 & FullschnitzTime<250); %Instantaneous growth rate p9
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
ylim([0.25,3.5])
ylabel('Added Size (uM)','FontSize',12,'FontWeight','bold')
hold off
title('Mu DL')
xlim([-150 350])

%Note in this analysis multiple pieces of blocks were added together which
%were done on different computers. This leads to weird behavior in YFP 
%calculation by schnitzcells. Below I correct for the error by adding the
%background YFP back where it was mistakenly substracted by schnitzcells code.
meanBGYFP = mean(FullschnitzY(FullschnitzYFrames<800 & FullschnitzYFrames>700));
FullschnitzYCorrected = FullschnitzY;
FullschnitzYCorrected(FullschnitzYFrames>1039) =  FullschnitzY(FullschnitzYFrames>1039)+meanBGYFP;
%Red line added to show where the addition of the background was performed,
%See in the second plot how there is a sharp dip at that point even though
%the images showed no such change in YFP.
%I tried many hours to figure out why this is happening in Schnitzcells but
%could not do it in reasonable time. This fix is good enough for our
%purposes, YFP does go up as seen in the images.

figure()            %%PLOT YFP Corrected
scatter(FullschnitzYFrames-spikeFrame,FullschnitzYCorrected)
hold on
title('YFP Corrected')
xlim([-150,500])
line([0,0],[800,-100],'Color','black')
line([75,75],[800,-100],'Color','red')
[binnedX,binnedY]=xBinAverager(FullschnitzYFrames, FullschnitzYCorrected, 22);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)','Binned (22min)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

figure()            %%PLOT YFP
scatter(FullschnitzYFrames-spikeFrame,FullschnitzY)
hold on
title('YFP Stitch Bug')
xlim([-150,500])
line([0,0],[800,-100],'Color','black')
line([75,75],[800,-100],'Color','red')
[binnedX,binnedY]=xBinAverager(FullschnitzYFrames, FullschnitzYCorrected, 22);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

%Correcting the average YFP. Note however cells alive during the problematic shift frame
%will not be corrected and this can be seen in the plot. However before and
%after ppGpp shift steady states are completelly fixed which is what we use
%in the publication (see YFP Corrected and YFP Stich Bug plots above).
FullschnitzYAvSemiCorrected=FullschnitzYAv;
FullschnitzYAvSemiCorrected(FullTimeofDivision>75) = FullschnitzYAv(FullTimeofDivision>75)+meanBGYFP/2;

figure()            %%PLOT YFP Mean
scatter(FullTimeofDivision,FullschnitzYAvSemiCorrected)
hold on
title('YFP')
xlim([-150,500])
line([0,0],[400,-100],'Color','black')
line([75,75],[800,-100],'Color','red')
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzYAvSemiCorrected, 22);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
%%Do not use cells after the red line (up to +200 min) as their mean YFP is broken due to the
%%stich bug. For us we need before and after steady state YFP mean
%%and we can get that with the fix mentioned above.


headers ={'Time','Mu','Dl','Lb','Tcyc','YFP','schnitzNum'};
writeMatrix =[FullTimeofDivision;
    FullschnitzMuAv;
    FullAddedSize;
    FullsizeAtBirth;
    FullCycleDuration;
    FullschnitzYAvSemiCorrected;
    FullschnitzLabel]';
finalMatrix(1,:)=headers;
finalMatrix(2:length(FullschnitzLabel)+1,:) = num2cell(writeMatrix);
xlswrite('M1ng.xlsx',finalMatrix)
end