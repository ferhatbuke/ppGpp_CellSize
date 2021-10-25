function FB_schnitzPlotter_R10ng
close all
clc
%%Configured for Rich Media 10ng Induction Experiment 2019-02-20
load('C:\Users\ferha\OneDrive\Desktop\PubFigures\Data\Rich Media 10ng.mat')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstFrame = 760; % First frame of the analysis
endFrame = 1260;  % Last frame of the analysis
spikeFrame = 850; % Frame at which the YFP starts to increase.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spikeTime = 92.7000; % Found manually, check "spikeFrame"th frame's time stamp.

%Initialization of vectors for sifting and plotting the cells (schnitzs/schnitzes ?)
%There is a tidier way of doing this, check later.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
SpikeHitMinutes=[];
SpikeHitLabel=[];
SpikeHitCycleDur=[];
SpikeHitDaugters=[];
parentAgeAtSpike=[];
daughterCellCycleDur=[];
SpikeHitLabel1=[];

BeforeSpikeAddedSizeAll=[];
BeforeSpikeHitAgeAll=[];
BeforeSpikeHitMinutes=[];
BeforeSpikeHitLabel=[];
BeforeSpikeHitCycleDur=[];
BeforeSpikeHitDaugters=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Each is explained as data populates...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ...the vectors in the loop below.

%Loop through all the identified cells. Note some are bound to be bad...
%...tracking/segmentation. Many won't have completed a full cycle in view. Filters are applied to sift these.
for i=1:length(schnitzcells)
    
    avMu = mean(schnitzcells(i).av_mu_rp); %Average mu of the cell calculated by schintzcells
    maxInsMu = max(schnitzcells(i).muP5_fitNew_all); %Max instant mu of the cell calculated by schintzcells
    minInsMu = min(schnitzcells(i).muP5_fitNew_all); %Min instant mu of the cell calculated by schintzcells
    allAvMu = [allAvMu,avMu]; %Added to sift vector.
    
    avY = mean([schnitzcells(i).Y4_mean]);  %Average YFP of the cell calculated by schintzcells
    allAvY = [allAvY,avY]; %Added to sift vector.
    
    schnitzFrame = schnitzcells(i).frame_nrs-spikeFrame; %Frames the cells are present subtracted spike frame such that Frame0=spike.
    allFrame = [allFrame,schnitzFrame]; %Added to sift vector.
    
    schnitzDivisionFrame = schnitzFrame(end); %Division frame of the cell
    allDivisionFrame=[allDivisionFrame,schnitzDivisionFrame]; %Added to sift vector.
    
    schnitzBirthFrame = schnitzFrame(1); %Birth frame of the cell
    allBirthFrame = [allBirthFrame,schnitzBirthFrame]; %Added to ift vector.
    
    schnitzSize = schnitzcells(i).length_fitNew; %Length vector of the cell in all the visible frames.
    schnitzSizeAtBith = schnitzSize(1); %First frame "size at birth".
    allSizeAtBirth = [allSizeAtBirth,schnitzSizeAtBith]; %Added to sift vector.
    
    schnitzCycleDuration = schnitzcells(i).interDivTime; %Cycle duration calculated by schnitzcells using the timestamps on the images.
    allCycleDuration = [allCycleDuration,schnitzCycleDuration]; %Added to sift vector.
    
    schnitzCenterY = schnitzcells(i).ceny_cent; %The "depth" of the cell in the well in pixels (sort of, 0 is not the bottom of the well but the picture)
    schnitzYFrames = schnitzcells(i).Y_frames; %YFP image frames for the cell, since YFP is taken every 5 mins and Phase every minute, need to check if YFP was taken for the cell later.
    schnitzWidthAv = mean(schnitzcells(i).rp_width); %Average width of the cell
    
    %Note: not all of the above are not necessary. Used in the past for...
    %...different purposes or in versions of the code which analyze...
    %...other experiments with different analysis/sift parameters.
    
    %%PARAMETERS TO KEEP SCHNITZSES IN ANALYSIS in the if clause below.
    
    %completeCycle=1 : Makes sure the cycle is complete (borne from a...
    %...tracked mother cell and divided itself to give rise to daughters.
    
    %schnitzBirthFrame>firstFrame-spikeFrame : Discounts cells borne
    %before the analysis starts. Before -150 mins (schnitzFrame) the segmentation and...
    %... tracking are not done as diligently. Use at your own risk.
    
    %schnitzCycleDuration > 5  : Discards cells with less than 5 min...
    %...cycles. No true cell was observed with 5 min cycles, always...
    %...tracking issues.
    
    %length(schnitzYFrames)>0 : Makes sure there are YFP images.
    
    %schnitzDivisionFrame<endFrame-spikeFrame Discounts cells divide...
    %...after the analysis ends.
    
    %schnitzDivisionFrame<endFrame-spikeFrame : Discounts cells which divide
    %after the analysis end. 
    
    
    %max(schnitzcells(i).muP9_fitNew_all)<4 : removes cells with high...
    %...instant growth rate. Always tracking issues.
    
    %min(schnitzcells(i).muP9_fitNew_all)>-1.5 : Removes cells with some...
    %...negative instant growth rate. Always tracking issues. -0.5 can be
    %...tried but in some slow growth conditions sometimes eliminates real
    %...cells which rotate between frames.
    
    if schnitzcells(i).completeCycle && schnitzBirthFrame>firstFrame-spikeFrame && schnitzCycleDuration > 5 && length(schnitzYFrames)>0 && schnitzDivisionFrame<endFrame-spikeFrame && max(schnitzcells(i).muP9_fitNew_all)<4 && min(schnitzcells(i).muP9_fitNew_all)>-1.5 
        
        %Vectors starting with "Full" ex. FullschnitzMuAv indicate full
        %cycle cells passing the filters above. These are used for plots
        %and analyses. Vectors named as decribed aboce (Other than the
        %"Full" pretex)        
        FullschnitzMuAv = [FullschnitzMuAv,avMu]; %Added to plot vector.
        
        schnitzY=schnitzcells(i).Y4_mean(~isnan(schnitzcells(i).Y4_mean)); %YFP of the cell in each frame.
        FullschnitzY = [FullschnitzY,schnitzY]; %Added to plot vector. Note larger size due to each frame being used and not the average.
        
        schnitzYEnd  = schnitzY(end); %Final YFP signal
        FullschnitzYEnd = [FullschnitzYEnd,schnitzYEnd]; 
        
        schnitzYAv = mean(schnitzY); %Average YFP signal
        FullschnitzYAv = [FullschnitzYAv,schnitzYAv]; 
        
        FullschnitzWidth = [FullschnitzWidth,schnitzWidthAv]; %Width
        
        FullbirthFrame = [FullbirthFrame,schnitzFrame(1)]; %FrameNubers
        
        FullschnitzYFrames =[FullschnitzYFrames,schnitzYFrames];%YFP Frame numbers
        
        FullschnitzMu =[FullschnitzMu,schnitzcells(i).muP9_fitNew_all]; %muP9 is instant Mu found by schnitzcells fitting 9 points.
        
        FullschnitzTime = [FullschnitzTime,schnitzcells(i).time-spikeTime]; %Real time of frames.

        FullsizeAtBirth = [FullsizeAtBirth,schnitzSizeAtBith]; %Size at birth
        
        FullschnitzLabel = [FullschnitzLabel,i]; %Label of the schnitz in the videos and in the schnitzcells.mat file.
        
        schnitzsizeAtDivision = schnitzSize(end); %Size at division
        FullsizeAtDivision = [FullsizeAtDivision,schnitzsizeAtDivision]; 
        
        schnitzAddedSize = schnitzsizeAtDivision-schnitzSizeAtBith; %Added size is calculated
        FullAddedSize = [FullAddedSize,schnitzAddedSize];
        
        schnitzTimeofDivision = schnitzcells(i).time(end)-spikeTime; %Time of division
        FullTimeofDivision = [FullTimeofDivision,schnitzTimeofDivision];
               
        FullCycleDuration = [FullCycleDuration,schnitzCycleDuration];
        schnitzCyclevsExpansion = (60/avMu)/schnitzCycleDuration;
        FullCyclevsExpansion = [FullCyclevsExpansion,schnitzCyclevsExpansion];
    end
end

%%PLOT MU Average AND Binned Average
figure()            
scatter(FullTimeofDivision,FullschnitzMuAv,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','b','MarkerEdgeColor','b');
legend('Average μ')
line([0,0],[10,-5],'Color','black','HandleVisibility','off')
xlim([-150,350])
ylim([-1,4])
hold on
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzMuAv, 14);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue','DisplayName','Average μ binned 14 min)')
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('Mu(Doublings/Hr)','FontSize',12,'FontWeight','bold')
%NOTE 14min binsize is selected because BeforeSpikeTcyc/2 ~=14min. Bins are
%half a cell cycle basically. No particular reason other than consistency.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()            %%PLOT YFP
scatter(FullTimeofDivision,FullschnitzYAv)
hold on
title('YFP')
xlim([-150,150])
line([0,0],[400,-100],'Color','black')
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzYAv, 14);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)','Binned (14min)')
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
xlswrite('R10ng.xlsx',finalMatrix)
end
