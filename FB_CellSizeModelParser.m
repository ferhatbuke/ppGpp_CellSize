function [birthTime,divisionTime,cycleDuration,lineageNo,finalSize,growthRate,addedSize,birthSize]=FB_CellSizeModelParser(fileName)
%Used from "FB_divFrequencySpikeStatsModels"
T = readtable(fileName);

lineageNo = T.cell;
birthTime = T.t0;
divisionTime = T.t;
finalSize = T.xf;
birthSize = T.x0;
growthRate = T.gratemean;

cycleDuration = divisionTime-birthTime;
addedSize = finalSize-birthSize;


allDivisionsAddedSizeBeforeSpike = [];
allDivisionsBirthSizeBeforeSpike = [];
firstDivisionAddedSizeAfterSpike = [];
firstDivisionBirthSizeAfterSpike = [];
secondDivisionAddedSizeAfterSpike = [];
secondDivisionBirthSizeAfterSpike = [];
thirdDivisionAddedSizeAfterSpike = [];
thirdDivisionBirthSizeAfterSpike = [];
fourthDivisionAddedSizeAfterSpike = [];
fourthDivisionBirthSizeAfterSpike = [];

for i=0:999    
    lineageLocation = lineageNo==i;
    
    addedSizeLineage = finalSize(lineageLocation)-birthSize(lineageLocation);
    birthSizeLineage = birthSize(lineageLocation);
    divisionTimeLineage = divisionTime(lineageLocation);
    
    beforeSpikeBirthSize = birthSizeLineage(divisionTimeLineage<0);
    beforeSpikeAddedSize = addedSizeLineage(divisionTimeLineage<0);
    
    
    afterSpikeBirthSize = birthSizeLineage(divisionTimeLineage>0);
    afterSpikeAddedSize = addedSizeLineage(divisionTimeLineage>0);
    
    allDivisionsBirthSizeBeforeSpike = [allDivisionsBirthSizeBeforeSpike;beforeSpikeBirthSize];
    allDivisionsAddedSizeBeforeSpike = [allDivisionsAddedSizeBeforeSpike;beforeSpikeAddedSize];
    
    firstDivisionAddedSizeAfterSpike(i+1) = afterSpikeAddedSize(1);
    firstDivisionBirthSizeAfterSpike(i+1) = afterSpikeBirthSize(1);
    secondDivisionAddedSizeAfterSpike(i+1) = afterSpikeAddedSize(2);
    secondDivisionBirthSizeAfterSpike(i+1) = afterSpikeBirthSize(2);
    thirdDivisionAddedSizeAfterSpike(i+1) = afterSpikeAddedSize(3);
    thirdDivisionBirthSizeAfterSpike(i+1) = afterSpikeBirthSize(3);
    fourthDivisionAddedSizeAfterSpike(i+1) = afterSpikeAddedSize(4);
    fourthDivisionBirthSizeAfterSpike(i+1) = afterSpikeBirthSize(4);
    fifthDivisionAddedSizeAfterSpike(i+1) = afterSpikeAddedSize(5);
    fifthDivisionBirthSizeAfterSpike(i+1) = afterSpikeBirthSize(5);
    
    divisionParsedBirthSize=[];
    divisionParsedFinalSize=[];
    divisionParsedAddedSize=[];
end


%{
figure('Name','Before Spike') %Plot Added Size vs Size At Birth Before Spike
scatter(birthSize(divisionTime<0 & divisionTime>-200),addedSize(divisionTime<0 & divisionTime>-200))
ylim([0,4])
xlim([0,4])
xlabel('Length at Birth (um)')
ylabel('Length at Division (um)')
title('Before the Spike')

figure('Name','0-25mins After Spike')%Plot Added Size vs Size At Birth 0-25mins after spike
scatter(birthSize(divisionTime>0 & divisionTime<25),addedSize(divisionTime>0 & divisionTime<25))
ylim([0,4])
xlim([0,4])
xlabel('Length at Birth (um)')
ylabel('Length at Division (um)')
title('0-25Mins After the Spike')

figure('Name','25-50mins After Spike')%Plot Added Size vs Size At Birth 25-50mins after spike
scatter(birthSize(divisionTime>25 & divisionTime<50),addedSize(divisionTime>25 & divisionTime<50))
ylim([0,4])
xlim([0,4])
xlabel('Length at Birth (um)')
ylabel('Length at Division (um)')
title('25-50Mins After the Spike')

figure('Name','50-75mins After Spike')%Plot Added Size vs Size At Birth 50-75mins after spike
scatter(birthSize(divisionTime>50 & divisionTime<75),addedSize(divisionTime>50 & divisionTime<75))
ylim([0,4])
xlim([0,4])
xlabel('Length at Birth (um)')
ylabel('Length at Division (um)')
title('50-75Mins After the Spike')

figure('Name','75-100mins After Spike')%Plot Added Size vs Size At Birth 75-100mins after spike
scatter(birthSize(divisionTime>75 & divisionTime<100),addedSize(divisionTime>75 & divisionTime<100))
ylim([0,4])
xlim([0,4])
xlabel('Length at Birth (um)')
ylabel('Length at Division (um)')
title('75-100Mins After the Spike')

figure('Name','100-125mins After Spike')%Plot Added Size vs Size At Birth 100-125mins after spike
scatter(birthSize(divisionTime>100 & divisionTime<125),addedSize(divisionTime>100 & divisionTime<125))
ylim([0,4])
xlim([0,4])
xlabel('Length at Birth (um)')
ylabel('Length at Division (um)')
title('100-125Mins After the Spike')

figure('Name','400+mins After Spike')%Plot Added Size vs Size At Birth 100-125mins after spike
scatter(birthSize(divisionTime>400),addedSize(divisionTime>400))
ylim([0,4])
xlim([0,4])
xlabel('Length at Birth (um)')
ylabel('Length at Division (um)')
title('400+Mins After the Spike')
%}


%Remove extra-short cycle durations <0mins
%Remove extra-long cycle durations >Infmins
%No cells are removed

minimumCycleDurationAllowed = 0; %Enter a value, 0 no filter
maximumCycleDurationAllowed = Inf; %Enter a value, Inf no filter

lineageNo = lineageNo(cycleDuration>minimumCycleDurationAllowed & cycleDuration<maximumCycleDurationAllowed);
birthTime = birthTime(cycleDuration>minimumCycleDurationAllowed & cycleDuration<maximumCycleDurationAllowed);
divisionTime = divisionTime(cycleDuration>minimumCycleDurationAllowed & cycleDuration<maximumCycleDurationAllowed);
finalSize = finalSize(cycleDuration>minimumCycleDurationAllowed & cycleDuration<maximumCycleDurationAllowed);
birthSize = birthSize(cycleDuration>minimumCycleDurationAllowed & cycleDuration<maximumCycleDurationAllowed);
growthRate = growthRate(cycleDuration>minimumCycleDurationAllowed & cycleDuration<maximumCycleDurationAllowed);
addedSize = addedSize(cycleDuration>minimumCycleDurationAllowed & cycleDuration<maximumCycleDurationAllowed);
cycleDuration = cycleDuration(cycleDuration>minimumCycleDurationAllowed & cycleDuration<maximumCycleDurationAllowed);

%Calculate doubling per hour
doublingRate = 60./(log(2)./growthRate);

%
limXExp = [-150 300];

figure('Renderer', 'painters', 'Position', [1000 10 600 450])  %Plot DeltaL and V0
scatter(divisionTime,addedSize,'filled','MarkerFaceColor','blue','MarkerFaceAlpha',0.02, 'MarkerEdgeColor', 'none','HandleVisibility','off')
hold on
scatter(birthTime,birthSize,'filled','MarkerFaceColor',[1, 0.5, 0],'MarkerFaceAlpha',0.02, 'MarkerEdgeColor', 'none','HandleVisibility','off')
[binnedX,binnedY,binnedStd]=xBinAverager(divisionTime, addedSize, 10, 5);
plot(binnedX,binnedY,'LineWidth',3,'Color','blue')
[binnedX,binnedY,binnedStd]=xBinAverager(birthTime, birthSize, 10, 5);
plot(binnedX,binnedY,'LineWidth',3,'Color',[1, 0.5, 0])
line([0,0],[450,0],'Color','black','LineStyle','--','HandleVisibility','off')
xlim(limXExp)
ylim([0,4])
legend('\DeltaL','L0','location','northeast')
xlabel('Time(min)')

figure('Renderer', 'painters', 'Position', [1000 10 600 450]) %Plot Mu vs 60/Tcyc
scatter(divisionTime,60./cycleDuration,'filled','MarkerFaceColor',[0.0784, 0.6078, 0.0588],'MarkerFaceAlpha',0.02, 'MarkerEdgeColor', 'none','HandleVisibility','off')
[binnedX,binnedY,binnedStd]=xBinAverager(divisionTime, 60./cycleDuration, 10, 5);
hold on
line([0,0],[450,0],'Color','black','LineStyle','--','HandleVisibility','off')
scatter(divisionTime,doublingRate,'filled','MarkerFaceColor','red','MarkerFaceAlpha',0.02, 'MarkerEdgeColor', 'none','HandleVisibility','off')
plot(binnedX,binnedY,'LineWidth',3,'Color',[0.0784, 0.6078, 0.0588])
[binnedX,binnedY,binnedStd]=xBinAverager(divisionTime, doublingRate, 10, 5);
plot(binnedX,binnedY,'LineWidth',3,'Color','red')
legend('60/Tcyc','Mu (Doubling/hr)','location','northeast')
xlim(limXExp)
ylim([0,5])
xlabel('Time(min)')

figure('Renderer', 'painters', 'Position', [1000 10 600 450])  %Plot 1+DeltaL + Delta0 vs 2^Mu/60*Tcyc
scatter(divisionTime,2.^((doublingRate./60).*cycleDuration),'filled','MarkerFaceColor',[0.2980, 0.1490, 0.0078],'MarkerFaceAlpha',0.02, 'MarkerEdgeColor', 'none','HandleVisibility','off')
hold on
scatter(divisionTime, 1+(addedSize./birthSize),'filled','MarkerFaceColor',[0.6157, 0.0863, 0.8784],'MarkerFaceAlpha',0.02, 'MarkerEdgeColor', 'none','HandleVisibility','off')
[binnedX,binnedY,binnedStd]=xBinAverager(divisionTime, (2.^((doublingRate./60).*cycleDuration)), 10, 5);
plot(binnedX,binnedY,'LineWidth',3,'Color',[0.2980, 0.1490, 0.0078])
line([0,0],[450,0],'Color','black','LineStyle','--','HandleVisibility','off')
[binnedX,binnedY,binnedStd]=xBinAverager(divisionTime, (1+(addedSize./birthSize)), 10, 5);
plot(binnedX,binnedY,'LineWidth',3,'Color',[0.6157, 0.0863, 0.8784])
legend('1+\Delta/\Delta0','2^M^u^/^6^0^*^T^c^y^c','location','northeast')
xlabel('Time(min)')
xlim(limXExp)
ylim([1,3])

figure('Renderer', 'painters', 'Position', [1000 10 600 450]) %60/Tcyc Alone
scatter(divisionTime,60./cycleDuration,'filled','MarkerFaceColor',[0.0784, 0.6078, 0.0588],'MarkerFaceAlpha',0.02, 'MarkerEdgeColor', 'none','HandleVisibility','off')
hold on
[binnedX,binnedY,binnedStd]=xBinAverager(divisionTime, 60./cycleDuration, 10, 5);
line([0,0],[450,0],'Color','black','LineStyle','--','HandleVisibility','off')
plot(binnedX,binnedY,'LineWidth',3,'Color',[0.0784, 0.6078, 0.0588])
xlabel('Time(min)')
ylabel('Division Frequency (1/hr)')
xlim(limXExp)
ylim([0,5])
%}
end

function [binnedX,binnedY,binnedStd]=xBinAverager(inputX, inputY, binSize, ignoreLimit)

binnedX=[];
binnedY=[];
binnedStd=[];
count=0;

    for i=min(inputX):binSize:max(inputX)
        count=count+1;
        binPositionFind = inputX>=i & inputX<i+binSize;
        binnedX(count)=i+binSize/2;
        
        testY = inputY(binPositionFind);
        parsedY = testY(testY<ignoreLimit);
        
        binnedY(count)=mean(parsedY);
        binnedStd(count) = std(parsedY);
        
        if length(parsedY)<3
            binnedY(count)=NaN;
            binnedStd(count) = NaN;
            binnedX(count)=NaN;
        end
    end
end