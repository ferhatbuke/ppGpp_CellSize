function FB_schnitzPlotter_R1ng
clc
%%Configured for Rich Media 1ng Induction Experiment
%%Datafile Rich Media Medium Induction New.mat 2019-04-11

%NOTE ADJUST THE DIRECTORY ACCORDINGLY!
load('C:\Users\ferha\OneDrive\Desktop\PubFigures\Data\Rich Media 1ng.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
firstFrame = 450; % First frame of the analysis
endFrame = 1000;  % Last frame of the analysis
spikeFrame = 663; % Frame at which YFP signal starts to increase.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spikeTime = 217; % Found manually, check "spikeFrame"th frame's time stamp.

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
OKYFPAv=[];
OKYFPTime=[];
OKYFPCheck=[];

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
    schnitzYFrames = schnitzcells(i).Y_frames-spikeFrame; %YFP image frames for the cell, since YFP is taken every 5 mins and Phase every minute, need to check if YFP was taken for the cell later.
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
        
        %Filter cells within the frames with bad YFP signal. Discuss below.
        %Some frames have low YFP signal after schnitzcells analysis even
        %though the images do not show sudden decrease in signal.
        %Create a new YFP average vector with only cells that complete
        %their cycles fully outside of these problematic frames hence their
        %YFP signal will be correct.
        
        %problemYFPFrames = 583,668 and aything less than 543;
        OKYFPCheck=[OKYFPCheck,0];
        if ~(sum(schnitzFrame==583-spikeFrame)>0) && ~(sum(schnitzFrame==668-spikeFrame)>0) && min(schnitzFrame)>543-spikeFrame
            OKYFPAv = [OKYFPAv,schnitzYAv];
            OKYFPTime = [OKYFPTime,schnitzTimeofDivision];
            OKYFPCheck(end)=1;
        end        
    end
end

%%PLOT MU Average AND Binned Average
figure()            
scatter(FullTimeofDivision,FullschnitzMuAv,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','b','MarkerEdgeColor','b');
legend('Average μ')
line([0,0],[10,-5],'Color','black','HandleVisibility','off')
xlim([-100,350])
ylim([-1,4])
hold on
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzMuAv, 14);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue','DisplayName','Average μ binned 14 min)')
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('Mu(Doublings/Hr)','FontSize',12,'FontWeight','bold')
%NOTE 14min binsize is selected because BeforeSpikeTcyc/2 ~=14min. Bins are
%half a cell cycle basically. No particular reason other than consistency.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Minute 250+, average Mu appears stable. This is used as after induction
%stable zone in further analysis.

beforeSpike = FullTimeofDivision<0 & FullTimeofDivision>-100;
afterSpike = FullTimeofDivision>250;

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

%%Add Added Size to the Average Mu plot
yyaxis right
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullAddedSize, 14);
plot(binnedX,binnedY,'LineWidth',3,'color','red','DisplayName','Dl binned (14 min)')
scatter(FullTimeofDivision,FullAddedSize,15,'MarkerFaceAlpha',0.1,'MarkerEdgeAlpha',0.1,'MarkerFaceColor','r','MarkerEdgeColor','r','DisplayName','Dl');
ylim([-0.5,4])
ylabel('Added Size (uM)','FontSize',12,'FontWeight','bold')
hold off
title('Mu DL')
xlim([-100 350])

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

%PLot all the YFP frames showing the broken ones and spike reach time
figure()            %%PLOT YFP All
scatter(FullschnitzYFrames,FullschnitzY)
hold on
title('YFP All')
xlim([-100,150])
line([0,0],[400,-100],'Color','black')
line([-80,-80],[400,-100],'Color','red')
line([5,5],[400,-100],'Color','red')
legend('YFP (AU)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

%Plot average YFP's of all cells. 
figure()            %%PLOT YFP Av
scatter(FullTimeofDivision,FullschnitzYAv)
hold on
title('YFP Av All')
xlim([-100,150])
line([0,0],[400,-100],'Color','black')
line([-80,-80],[400,-100],'Color','red')
line([5,5],[400,-100],'Color','red')
[binnedX,binnedY]=xBinAverager(FullTimeofDivision, FullschnitzYAv, 14);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)','Binned (14min)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off

%Plot average YFP's of cells not affected by the broken frames. 
figure()            %%PLOT YFP Av Filtered
scatter(OKYFPTime,OKYFPAv)
hold on
title('YFP Av Filtered')
xlim([-100,150])
line([0,0],[400,-100],'Color','black')
line([-80,-80],[400,-100],'Color','red')
line([5,5],[400,-100],'Color','red')
[binnedX,binnedY]=xBinAverager(OKYFPTime, OKYFPAv, 14);
plot(binnedX,binnedY,'LineWidth',3,'Color','black')
legend('YFP (AU)','Binned (14min)')
xlabel('Time[Min]','FontSize',12,'FontWeight','bold')
ylabel('YFP (AU)','FontSize',12,'FontWeight','bold')
hold off
%Note this problem can be fixed more elegantly by removing the single
%bugged frame's data from each pixel. However here we only need to know an
%average YFP before ppGpp spike. After the spike there are no bugged frames
%(see plot title('YFP All')). Eliminating all the cells which existed on
%these problematic frames we still have 68 cells to get a good average YFP
%before spike distribution. Note that all of them are really close in value
%(see title('YFP Av Filtered')).

headers ={'Time','Mu','Dl','Lb','Tcyc','YFP','schnitzNum','OK YFP'};
writeMatrix =[FullTimeofDivision;
    FullschnitzMuAv;
    FullAddedSize;
    FullsizeAtBirth;
    FullCycleDuration;
    FullschnitzYAv;
    FullschnitzLabel;
    OKYFPCheck]';
finalMatrix(1,:)=headers;
finalMatrix(2:length(FullschnitzLabel)+1,:) = num2cell(writeMatrix);
xlswrite('R1ng.xlsx',finalMatrix)
end

