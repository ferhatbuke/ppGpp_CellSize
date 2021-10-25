function FB_divFrequencySpikeStatsModels
fileName = {'ModelOutput\simpos_adder_84.0336_10_100_R2ng.dat',...
    'ModelOutput\simpos_adder_74.6269_10_100_R1ng.dat',...
    'ModelOutput\simpos_adder_98.0392_10_100_M2ng.dat',...
    'ModelOutput\simpos_adder_84.0336_10_100_M1ng.dat'};

reduced=[];
typeReduced=[];
allData=[];
typeAll=[];


dataPointsBef = 300;
dataPointsAf = 300;

count=0;
pAll = zeros(1,4);
while count <1
    count = count+1;
    disp(count)
    for i=1:length(fileName)
        [birthTime,divisionTime,cycleDuration,lineageNo,finalSize,growthRate,addedSize,birthSize]=FB_CellSizeModelParser(fileName{i});

        beforeSpikeTimer = (divisionTime>-150 & divisionTime<0);
        afterSpikeTimer = (divisionTime>0 & divisionTime<(2*mean(cycleDuration(beforeSpikeTimer))));

        bef = length(cycleDuration(beforeSpikeTimer));
        af = length(cycleDuration(afterSpikeTimer));

        typeReduced(length(typeReduced)+1:length(typeReduced)+dataPointsBef) = 2*i-1;
        typeReduced(length(typeReduced)+1:length(typeReduced)+dataPointsAf) = 2*i;

        typeAll(length(typeAll)+1:length(typeAll)+bef) = 2*i-1;
        typeAll(length(typeAll)+1:length(typeAll)+af) = 2*i;

        reducedBefore = datasample(cycleDuration(beforeSpikeTimer),dataPointsBef);
        allBefore = cycleDuration(beforeSpikeTimer);

        reducedAfter = datasample(cycleDuration(afterSpikeTimer),dataPointsAf);
        allAfter = cycleDuration(afterSpikeTimer);

        reduced = [reduced,reducedBefore',reducedAfter'];
        allData = [allData,allBefore',allAfter'];

        [h,p,ci,stats] = ttest2(allBefore,allAfter);   
        pAll(count,i) = p;
        %
        disp('=========')
        disp(60/mean(allBefore))
        disp(60/mean(allAfter))
        disp(p)
        disp('=========')
        %}
    end
end
%
figure()
boxplot(60./allData,typeAll,'Colors','k','Symbol','')
title('Before and During Spike 60/Tcyc Comparison Model')
%figure
%boxplot(allData,typeAll,'Colors','k','Symbol','')
ylim([0,5])
%}