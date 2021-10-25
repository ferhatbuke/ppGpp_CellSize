function FB_schnitzPlotter_ppGpp0
clc
close all

load('C:\Users\ferha\OneDrive\Desktop\PubFigures\Data\Minimal Media ppGpp0.mat')

%%Configured for ppGpp0 Minimal Media Heterogeneity Experiment 2019-10-20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstFrame = 5; % First frame of the analysis
endFrame = 55;  % Last frame of the analysis
spikeFrame = 5; % There is no spike in this experiment however easier to run the code this way.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Spike in first frame.

%Note here single cells were analyzed however complete cell cycle was not
%used as a sifting parameter since we only have a small window of analysis
%due to large cells moving and making tracking extremely challengind. This
%means that cells without full cycles are also included and only their
%final available size is used as Cell size (not size at division since some/many don't divide within
%the short observation duration).

allAvY=[];
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
FullschnitzFrame=[];

FullschnitzY=[];
FullschnitzYEnd=[];
FullschnitzYAv=[];
FullschnitzYFrames=[];

FullschnitzC=[];
FullschnitzCEnd=[];
FullschnitzCAv=[];
FullschnitzCFrames=[];

FullCycleDuration=[];
FullCyclevsExpansion=[];

SpikeAddedSizeAll=[];
SpikeHitAgeAll=[];

count=0;
testList=[];
c=0;

for i=1:length(schnitzcells)
    
    avMu = schnitzcells(i).av_mu_rp;
    maxInsMu = max(schnitzcells(i).muP9_fitNew_all);
    minInsMu = min(schnitzcells(i).muP9_fitNew_all);
    allAvMu = [allAvMu,avMu];
    
    avY = mean([schnitzcells(i).Y4_mean]);
    allAvY = [allAvY,avY];

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
    
    schnitzYFrames = schnitzcells(i).Y_frames-spikeFrame;
    schnitzCFrames = schnitzcells(i).C_frames-spikeFrame;
 
    
    if  length(schnitzCFrames)>1 && length(schnitzYFrames)>1 && minInsMu>-1.5 && maxInsMu<3 && avY>0 && avC>0 && avMu>0 && avMu<4;

        FullschnitzMuAv = [FullschnitzMuAv,avMu]; 
        
        schnitzY=schnitzcells(i).Y4_mean(~isnan(schnitzcells(i).Y4_mean));
        FullschnitzY = [FullschnitzY,schnitzY];
        schnitzYEnd  = schnitzY(end);
        FullschnitzYEnd = [FullschnitzYEnd,schnitzYEnd];
        schnitzYAv = mean(schnitzY);
        FullschnitzYAv = [FullschnitzYAv,schnitzYAv];
        
        schnitzC=schnitzcells(i).C4_mean(~isnan(schnitzcells(i).C4_mean));
        FullschnitzC = [FullschnitzC,schnitzC];
        schnitzCEnd  = schnitzC(end);
        FullschnitzCEnd = [FullschnitzCEnd,schnitzCEnd];
        schnitzCAv = mean(schnitzC);
        FullschnitzCAv = [FullschnitzCAv,schnitzCAv];
        

        
        FullbirthFrame = [FullbirthFrame,schnitzFrame(1)];
        
        FullschnitzYFrames =[FullschnitzYFrames,schnitzYFrames];
        FullschnitzCFrames =[FullschnitzCFrames,schnitzCFrames];
        
        FullschnitzMu =[FullschnitzMu,schnitzcells(i).muP9_fitNew_all];
        
        FullschnitzFrame = [FullschnitzFrame,schnitzFrame];

        FullsizeAtBirth = [FullsizeAtBirth,schnitzSizeAtBith];
        
        schnitzsizeAtDivision = schnitzSize(end);
        FullsizeAtDivision = [FullsizeAtDivision,schnitzsizeAtDivision]; %Not actual size at division since
        %cells without full cycles are also included. We do this simply to
        %check a general size of cells vs growth rate as a response to
        %YFP/CFP
        
        schnitzAddedSize = schnitzsizeAtDivision-schnitzSizeAtBith;
        FullAddedSize = [FullAddedSize,schnitzAddedSize];
        
        if sum(schnitzFrame==spikeFrame)==1
            schnitzSpikeHit = find(schnitzFrame==spikeFrame);
            schnitzAgeSpikeHit = schnitzSpikeHit/length(schnitzFrame);
            SpikeAddedSizeAll = [SpikeAddedSizeAll,schnitzAddedSize];
            SpikeHitAgeAll=[SpikeHitAgeAll,schnitzAgeSpikeHit];
        end      
        
        schnitzTimeofDivision = schnitzFrame(end);
        FullTimeofDivision = [FullTimeofDivision,schnitzTimeofDivision];
               
        FullCycleDuration = [FullCycleDuration,schnitzCycleDuration];
        schnitzCyclevsExpansion = (60/avMu)/schnitzCycleDuration;
        FullCyclevsExpansion = [FullCyclevsExpansion,schnitzCyclevsExpansion];
    end
end

YC =(FullschnitzYAv./FullschnitzCAv);
figure
scatter(log10(YC),FullschnitzMuAv)
title('YFP/CFP vs Mu')
xlim([-2,2])
[binnedX,binnedY,stddev]=xBinAverager(log10(YC), FullschnitzMuAv, 0.3);
hold on
errorbar(binnedX,binnedY,stddev)

figure
scatter(log10(YC),FullsizeAtDivision) %Note not real size at division as explained above.
title('YFP/CFP vs Cell Size')
xlim([-2,2])
[binnedX,binnedY,stddev]=xBinAverager(log10(YC), FullsizeAtDivision, 0.3);
hold on
errorbar(binnedX,binnedY,stddev)
