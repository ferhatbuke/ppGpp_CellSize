function FB_schnitzPlotter_R2ng
clc
%close all
%%Configured for Rich Media 2ng Induction Experiment 2019-06-19
%%Datafile Rich Media Medium Induction New.mat

%NOTE ADJUST THE DIRECTORY ACCORDINGLY!
load('C:\Users\ferha\OneDrive\Desktop\PubFigures\Data\Rich Media 2ng.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstFrame = 750; % First frame of the analysis
endFrame = 1500;  % Last frame of the analysis
spikeFrame = 1000; % Frame at which YFP signal starts to increase.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spikeTime = 253.5667; % Found manually, check "spikeFrame"th frame's time stamp.

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
    %after the analysis end. After 500 mins (schnitzFrame) the segmentation and...
    %... tracking are not done as diligently. Use at your own risk.
    
    %max(schnitzcells(i).muP9_fitNew_all)<4 : removes cells with high...
    %...instant growth rate. Always tracking issues.
    
    %min(schnitzcells(i).muP9_fitNew_all)>-1.5 : Removes cells with some...
    %...negative instant growth rate. Always tracking issues. -0.5 can be
    %...tried but in some slow growth conditions sometimes eliminates real
    %...cells which rotate quickly between frames.
    
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
        
        FullschnitzYFrames =[FullschnitzYFrames,schnitzYFrames-spikeFrame];%YFP Frame numbers
        
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
        
        if sum(schnitzFrame==0)==1 %Checks if the cell was alive during the shift. Records data seperatelly for another analysis.
            %Pretex "SpikeHit" denotes cells alive during the spike.
            schnitzSpikeHit = find(schnitzFrame==0);
            schnitzAgeSpikeHit = schnitzcells(i).time(schnitzSpikeHit)-schnitzcells(i).time(1);
            SpikeHitLabel = [SpikeHitLabel,i];
            SpikeAddedSizeAll = [SpikeAddedSizeAll,schnitzAddedSize];
            SpikeHitAgeAll=[SpikeHitAgeAll,schnitzAgeSpikeHit];
            SpikeHitMinutes = [SpikeHitMinutes,schnitzSpikeHit];
            SpikeHitCycleDur = [SpikeHitCycleDur,schnitzCycleDuration];
        end  
        
        nullSpike1=-90; % Null spike at min -90 such that all the daughters are guaranteed to divide themselves before the actual spike.
        nullSpike2=-140; % Null spike at min -140 such that no same cells are used in the same bins as the above null spike.
        %These are used to test against the cells which experienced the
        %spike since there is a natural bias in old cells from any given
        %timepoint. Used to make sure observed differences in the cells
        %experiencing the real spike are significantly different than 
        %these cells which do not experience any shift.
        
        %Below code block pools the data from the above two null spikes. No
        %two cells can be used in the same bins since 50minutes (the
        %difference between -140 and -90) is larger than the longest cell
        %cycle observed.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if sum(schnitzFrame==nullSpike1)==1
            schnitzSpikeHit = find(schnitzFrame==nullSpike1);
            schnitzAgeSpikeHit = schnitzcells(i).time(schnitzSpikeHit)-schnitzcells(i).time(1);
            SpikeHitLabel1 = [SpikeHitLabel1,i];
            BeforeSpikeHitLabel = [BeforeSpikeHitLabel,i];
            BeforeSpikeAddedSizeAll = [BeforeSpikeAddedSizeAll,schnitzAddedSize];
            BeforeSpikeHitAgeAll=[BeforeSpikeHitAgeAll,schnitzAgeSpikeHit];
            BeforeSpikeHitMinutes = [BeforeSpikeHitMinutes,schnitzSpikeHit];
            BeforeSpikeHitCycleDur = [BeforeSpikeHitCycleDur,schnitzCycleDuration];        
            
        elseif sum(schnitzFrame==nullSpike2)==1
            schnitzSpikeHit = find(schnitzFrame==nullSpike2);
            schnitzAgeSpikeHit = schnitzcells(i).time(schnitzSpikeHit)-schnitzcells(i).time(1);
            SpikeHitLabel1 = [SpikeHitLabel1,i];
            BeforeSpikeHitLabel = [BeforeSpikeHitLabel,i];
            BeforeSpikeAddedSizeAll = [BeforeSpikeAddedSizeAll,schnitzAddedSize];
            BeforeSpikeHitAgeAll=[BeforeSpikeHitAgeAll,schnitzAgeSpikeHit];
            BeforeSpikeHitMinutes = [BeforeSpikeHitMinutes,schnitzSpikeHit];
            BeforeSpikeHitCycleDur = [BeforeSpikeHitCycleDur,schnitzCycleDuration];
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
    end
end

%Plotting cells alive during the spike.---------------------
%Young <=9min, Mid>10 <=18min, Late >18min.
earlyCells = SpikeHitAgeAll<=9;
midCells = (SpikeHitAgeAll<=18 & SpikeHitAgeAll>9);
lateCells = SpikeHitAgeAll>18;

a1 = zeros(1,sum(earlyCells))+2; %Labelling the groups. Left to right in the generated figure.
b1 = zeros(1,sum(midCells))+4; 
c1 = zeros(1,sum(lateCells))+6;

%FB_fullCycleDaughterFinder finds the daughters of the cells and outputs a
%list of daughter labels vector and same sized vector with parent labels.

[DaughterList, ParentList]= FB_fullCycleDaughterFinder(SpikeHitLabel,schnitzcells);
earlyDaughters=DaughterList(find(ismember(ParentList,SpikeHitLabel(earlyCells))));
midDaughters=DaughterList(find(ismember(ParentList,SpikeHitLabel(midCells))));
lateDaughters=DaughterList(find(ismember(ParentList,SpikeHitLabel(lateCells))));

%ismember(FullschnitzLabel,midDaughters) finds daughters who passed the
%filters in the first sifting for loop. (if on line 130)
earlyDaugtherCycleDur = FullCycleDuration(find(ismember(FullschnitzLabel,earlyDaughters)));
midDaugtherCycleDur = FullCycleDuration(find(ismember(FullschnitzLabel,midDaughters)));
lateDaugtherCycleDur = FullCycleDuration(find(ismember(FullschnitzLabel,lateDaughters)));

a2 = zeros(1,length(earlyDaugtherCycleDur))+2; %Labelling the groups. Left to right in the generated figure.
b2 = zeros(1,length(midDaugtherCycleDur))+4;
c2 = zeros(1,length(lateDaugtherCycleDur))+6;

%Sifting Cells @-90 and -140 min null spikes (negative control before spike)
%same checks as above with ismember(FullschnitzLabel,midDaughters)
BeforeearlyCells = BeforeSpikeHitAgeAll<=9;
BeforemidCells = (BeforeSpikeHitAgeAll<=18 & BeforeSpikeHitAgeAll>9);
BeforelateCells = BeforeSpikeHitAgeAll>18;

a3 = zeros(1,sum(BeforeearlyCells))+1; %Labelling the groups. Left to right in the generated figure.
b3 = zeros(1,sum(BeforemidCells))+3; 
c3 = zeros(1,sum(BeforelateCells))+5; 

[DaughterList1, ParentList1]= FB_fullCycleDaughterFinder(SpikeHitLabel1,schnitzcells);
earlyDaughters1=DaughterList1(find(ismember(ParentList1,SpikeHitLabel1(BeforeearlyCells))));
midDaughters1=DaughterList1(find(ismember(ParentList1,SpikeHitLabel1(BeforemidCells))));
lateDaughters1=DaughterList1(find(ismember(ParentList1,SpikeHitLabel1(BeforelateCells))));

BeforeearlyDaugtherCycleDur = FullCycleDuration(find(ismember(FullschnitzLabel,earlyDaughters1)));
BeforemidDaugtherCycleDur = FullCycleDuration(find(ismember(FullschnitzLabel,midDaughters1)));
BeforelateDaugtherCycleDur = FullCycleDuration(find(ismember(FullschnitzLabel,lateDaughters1)));

a4 = zeros(1,length(BeforeearlyDaugtherCycleDur))+1; %Labelling the groups. Left to right in the generated figure.
b4 = zeros(1,length(BeforemidDaugtherCycleDur))+3;
c4 = zeros(1,length(BeforelateDaugtherCycleDur))+5;

%plots cells experiencing the ppGpp shift compared to a... 
%... null shift as explained above. Stats as in publication
figure('rend','painters','pos',[1200 500 300 300])
boxplot([BeforeSpikeHitCycleDur(BeforeearlyCells)...
    SpikeHitCycleDur(earlyCells)...
    BeforeSpikeHitCycleDur(BeforemidCells)...
    SpikeHitCycleDur(midCells)...
    BeforeSpikeHitCycleDur(BeforelateCells)...
    SpikeHitCycleDur(lateCells)...
    ],[a3 a1 b3 b1 c3 c1],'Color','k','Symbol','')
ylim([0,50])
title('Cells exposed to shift, Figure 3G')
ylabel('Tcyc(min.)')
xticks([1 2 3 4 5 6])
xticklabels({'young-null','young-shift','mid-null','mid-shift','old-null','old-shift'})
xtickangle(90)

%Stats for null shift vs cells experiencing the shift
disp('Stats for null shift vs cells experiencing the shift')
disp('Early:_____________________________________')
[h,p,ci,stats] = ttest2(BeforeSpikeHitCycleDur(BeforeearlyCells),SpikeHitCycleDur(earlyCells))
disp('Mid:_____________________________________')
[h,p,ci,stats] = ttest2(BeforeSpikeHitCycleDur(BeforemidCells),SpikeHitCycleDur(midCells))
disp('Late:_____________________________________')
[h,p,ci,stats] = ttest2(BeforeSpikeHitCycleDur(BeforelateCells),SpikeHitCycleDur(lateCells))

%plots daughters of cells experiencing the ppGpp shift compared to a...
%... null shift as explained above. Stats as in publication
figure('rend','painters','pos',[1200 500 300 300])
boxplot([BeforeearlyDaugtherCycleDur...
    earlyDaugtherCycleDur...
    BeforemidDaugtherCycleDur...
    midDaugtherCycleDur...
    BeforelateDaugtherCycleDur...
    lateDaugtherCycleDur...
    ],[a4 a2 b4 b2 c4 c2],'Color','k','Symbol','')
ylim([0,50])
title('First progeny after shift, Figure 3H')
ylabel('Tcyc(min.)')
xticks([1 2 3 4 5 6])
xticklabels({'young-null','young-shift','mid-null','mid-shift','old-null','old-shift'})
xtickangle(90)

%Stats for null shift vs daughters of cells experiencing the shift
disp('Stats for null shift vs daughters of cells experiencing the shift')
disp('Early:_____________________________________')
[h,p,ci,stats] = ttest2(BeforeearlyDaugtherCycleDur,earlyDaugtherCycleDur)
disp('Mid:_____________________________________')
[h,p,ci,stats] = ttest2(BeforemidDaugtherCycleDur,midDaugtherCycleDur)
disp('Late:_____________________________________')
[h,p,ci,stats] = ttest2(BeforelateDaugtherCycleDur,lateDaugtherCycleDur)

%%PLOT MU Average AND Binned Average
figure()            
scatter(FullTimeofDivision,FullschnitzMuAv,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','b','MarkerEdgeColor','b');
legend('Average μ')
line([0,0],[10,-5],'Color','black','HandleVisibility','off')
xlim([firstFrame-spikeFrame,endFrame-spikeFrame])
ylim([-1,4])
hold on
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzMuAv, 14);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue','DisplayName','Average μ binned 14 min)')
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('Mu(Doublings/Hr)','FontSize',12,'FontWeight','bold')
%NOTE 14min binsize is selected because BeforeSpikeTcyc/2 ~=14min. Bins are
%half a cell cycle basically. No particular reason other than consistency.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Minute 400-500, average Mu appears stable. This is used as after induction
%stable zone in further analysis.

beforeSpike = FullTimeofDivision<0 & FullTimeofDivision>-150;
afterSpike = FullTimeofDivision<500 & FullTimeofDivision>400;

%Here average Mu and Dl are calculated to use in the Python model. Inital
%and Final Mu, Dl and the exp. decay constant of Instant Mu between the 2 zones are needed

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

%%Add Added Size to the Average Mu plot
yyaxis right
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullAddedSize, 14);
plot(binnedX,binnedY,'LineWidth',3,'color','red','DisplayName','Dl binned (14 min)')
scatter(FullTimeofDivision,FullAddedSize,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','r','MarkerEdgeColor','r','DisplayName','Dl');
ylim([0.4,3.2])
ylabel('Added Size (uM)','FontSize',12,'FontWeight','bold')
hold off
title('Figure 2C')
xlim([-150 500])

%Plot Cell Width---------------------------------------------
figure('rend','painters','pos',[500 500 400 400])
hold on
title('Width')
scatter(FullTimeofDivision,FullschnitzWidth)
xlim([-150,500])
ylim([0.5,1.2])
beforeSpikeWidth=mean(FullschnitzWidth(FullTimeofDivision<0&FullTimeofDivision>-150));
line([-150,500],[beforeSpikeWidth,beforeSpikeWidth],'HandleVisibility','off','Color','k')
line([0,0],[0,1.5],'HandleVisibility','off','Color','k','LineStyle','--')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('Cell Width (um)','FontSize',12,'FontWeight','bold')
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzWidth, 14);
plot(binnedX,binnedY,'LineWidth',2,'color','blue')
hold off

figure()            %%PLOT YFP All
scatter(FullschnitzYFrames,FullschnitzY)
hold on
title('YFP All')
xlim([-100,150])
line([0,0],[400,-100],'Color','black')
legend('YFP (AU)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

FullschnitzYAvFixed = FullschnitzYAv;
%-220frame and before are OK so used  as BG correction for the bad frame series (-220<->0)
%mean(FullschnitzY(FullschnitzYFrames<-220)) = BG added to frames between -220 and 0
FullschnitzYAvFixed(FullTimeofDivision<0 & FullTimeofDivision>-220) = FullschnitzYAv(FullTimeofDivision<0 & FullTimeofDivision>-220)+mean(FullschnitzY(FullschnitzYFrames<-220));
figure()            %%PLOT YFP All Fixed
scatter(FullTimeofDivision,FullschnitzYAvFixed)
hold on
title('YFP All Fixed')
xlim([-100,150])
line([0,0],[400,-100],'Color','black')
legend('YFP (AU)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

%%PLOT 60/Tcyc
figure()            
scatter(FullTimeofDivision,60./FullCycleDuration,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','b','MarkerEdgeColor','b');
legend('60/Tcyc')
line([0,0],[10,-5],'Color','black','HandleVisibility','off')
xlim([firstFrame-spikeFrame,endFrame-spikeFrame])
ylim([0,4])
hold on
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, 60./FullCycleDuration, 14);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue','DisplayName','Average μ binned 14 min)')
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('60/Tcyc(Doublings/Hr)','FontSize',12,'FontWeight','bold')
tCycx2 = 2*mean(FullCycleDuration(FullTimeofDivision<0&FullTimeofDivision>-150));
line([tCycx2,tCycx2],[0,4],'Color','black')

headers ={'Time','Mu','Dl','Lb','Tcyc','YFP','schnitzNum','Width'};
writeMatrix =[FullTimeofDivision;
    FullschnitzMuAv;
    FullAddedSize;
    FullsizeAtBirth;
    FullCycleDuration;
    FullschnitzYAvFixed;
    FullschnitzLabel;
    FullschnitzWidth]';
finalMatrix(1,:)=headers;
finalMatrix(2:length(FullschnitzLabel)+1,:) = num2cell(writeMatrix);
xlswrite('R2.xlsx',finalMatrix)
end

