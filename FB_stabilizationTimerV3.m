function FB_stabilizationTimerV3(FitData)

%Split the data into 3 by keeping data concentration through time similar
%between the 3 parts. Achieved by the findStabilizationThirds function
%detailed description below within the function code
[stabilizationPointMuA,stabilizationPointMuB,stabilizationPointMuC] =...
    findStabilizationThirds(FitData.Time,FitData.Mu,0.05,400,500,13);
[stabilizationPointDlA,stabilizationPointDlB,stabilizationPointDlC] =...
    findStabilizationThirds(FitData.Time,FitData.Dl,0.05,400,500,13);

[stabilizationPointMu1A,stabilizationPointMu1B,stabilizationPointMu1C] =...
    findStabilizationThirds(FitData.Time1,FitData.Mu1,0.05,250,350,13);
[stabilizationPointDl1A,stabilizationPointDl1B,stabilizationPointDl1C] =...
    findStabilizationThirds(FitData.Time1,FitData.Dl1,0.05,250,350,13);

[stabilizationPointMu2A,stabilizationPointMu2B,stabilizationPointMu2C] =...
    findStabilizationThirds(FitData.Time2,FitData.Mu2,0.05,400,680,23);
[stabilizationPointDl2A,stabilizationPointDl2B,stabilizationPointDl2C] =...
    findStabilizationThirds(FitData.Time2,FitData.Dl2,0.05,400,680,23);

[stabilizationPointMu3A,stabilizationPointMu3B,stabilizationPointMu3C] =...
    findStabilizationThirds(FitData.Time3,FitData.Mu3,0.05,250,600,23);
[stabilizationPointDl3A,stabilizationPointDl3B,stabilizationPointDl3C] =...
    findStabilizationThirds(FitData.Time3,FitData.Dl3,0.05,250,600,23);

[stabilizationPointMu4A,stabilizationPointMu4B,stabilizationPointMu4C] =...
    findStabilizationThirds(FitData.Time4,FitData.Mu4,0.05,400,600,23);
[stabilizationPointDl4A,stabilizationPointDl4B,stabilizationPointDl4C] =...
    findStabilizationThirds(FitData.Time4,FitData.Dl4,0.05,400,600,23);


meanMu = mean([stabilizationPointMuA,stabilizationPointMuB,stabilizationPointMuC]);
meanDl = mean([stabilizationPointDlA,stabilizationPointDlB,stabilizationPointDlC]);

meanMu1 = mean([stabilizationPointMu1A,stabilizationPointMu1B,stabilizationPointMu1C]);
meanDl1 = mean([stabilizationPointDl1A,stabilizationPointDl1B,stabilizationPointDl1C]);

meanMu2 = mean([stabilizationPointMu2A,stabilizationPointMu2B,stabilizationPointMu2C]);
meanDl2 = mean([stabilizationPointDl2A,stabilizationPointDl2B,stabilizationPointDl2C]);

meanMu3 = mean([stabilizationPointMu3A,stabilizationPointMu3B,stabilizationPointMu3C]);
meanDl3 = mean([stabilizationPointDl3A,stabilizationPointDl3B,stabilizationPointDl3C]);

meanMu4 = mean([stabilizationPointMu4A,stabilizationPointMu4B,stabilizationPointMu4C]);
meanDl4 = mean([stabilizationPointDl4A,stabilizationPointDl4B,stabilizationPointDl4C]);


bar([1,3,5,7,9],[meanMu,meanMu1,meanMu2,meanMu3,meanMu4])
hold on
bar([2,4,6,8,10],[meanDl,meanDl1,meanDl2,meanDl3,meanDl4])

scatter([1,1,1,3,3,3,5,5,5,7,7,7,9,9,9],...
[stabilizationPointMuA,stabilizationPointMuB,stabilizationPointMuC,...
stabilizationPointMu1A,stabilizationPointMu1B,stabilizationPointMu1C,...
stabilizationPointMu2A,stabilizationPointMu2B,stabilizationPointMu2C,...
stabilizationPointMu3A,stabilizationPointMu3B,stabilizationPointMu3C,...
stabilizationPointMu4A,stabilizationPointMu4B,stabilizationPointMu4C],'HandleVisibility','off')

scatter([2,2,2,4,4,4,6,6,6,8,8,8,10,10,10],...
[stabilizationPointDlA,stabilizationPointDlB,stabilizationPointDlC,...
stabilizationPointDl1A,stabilizationPointDl1B,stabilizationPointDl1C,...
stabilizationPointDl2A,stabilizationPointDl2B,stabilizationPointDl2C,...
stabilizationPointDl3A,stabilizationPointDl3B,stabilizationPointDl3C,...
stabilizationPointDl4A,stabilizationPointDl4B,stabilizationPointDl4C],'HandleVisibility','off')
ylim([0,500])
end


function [stabilizationPoint1,stabilizationPoint2,stabilizationPoint3] = findStabilizationThirds(xData, yData, pLimit,afterSpikeTimeLeft,afterSpikeTimeRight, windowSize)
    %First the data is sorted through time
    [~,xSort] = sort(xData);
    sortedY = yData(xSort);
    sortedX = xData(xSort);
    dataPointCount = length(sortedX);
    
    %Then the cells are picked 1 by one from the time ordered list. Since
    %in each frame there are multiple division we reduce the data
    %concentration in each new 3 part by 1/3 compared to the full dataset 
    %while keeping their desity through time mostly similar between
    %themselves avoiding bias.
    splitX1 = sortedX(1:3:dataPointCount);
    splitX2 = sortedX(2:3:dataPointCount);
    splitX3 = sortedX(3:3:dataPointCount);
    
    splitY1 = sortedY(1:3:dataPointCount);
    splitY2 = sortedY(2:3:dataPointCount);
    splitY3 = sortedY(3:3:dataPointCount);
    
    afterSpikeData1 = splitY1(splitX1>afterSpikeTimeLeft & splitX1<afterSpikeTimeRight);
    afterSpikeData2 = splitY2(splitX2>afterSpikeTimeLeft & splitX2<afterSpikeTimeRight);
    afterSpikeData3 = splitY3(splitX3>afterSpikeTimeLeft & splitX3<afterSpikeTimeRight);
    
    for i=1:500 %Moves minute by minute and checks if each time a 'windowSize' wide window
        %shows significant deviation from the final stabilized data.
        duringSpikeTime1 = (splitX1>i-windowSize & splitX1<i+windowSize);
        duringSpikeTime2 = (splitX2>i-windowSize & splitX2<i+windowSize);
        duringSpikeTime3 = (splitX3>i-windowSize & splitX3<i+windowSize);

        xWindowData1 = splitY1(duringSpikeTime1);
        xWindowData2 = splitY2(duringSpikeTime2);
        xWindowData3 = splitY3(duringSpikeTime3);
        
        [h1,~,~] = ttest2(xWindowData1,afterSpikeData1,'Alpha',pLimit);
        [h2,~,~] = ttest2(xWindowData2,afterSpikeData2,'Alpha',pLimit);
        [h3,~,~] = ttest2(xWindowData3,afterSpikeData3,'Alpha',pLimit);
        
        hIndex1(i) = h1;
        hIndex2(i) = h2;
        hIndex3(i) = h3;
        
        
    end
    %Finds the first 3 consequential time points where the data in the
    %window is not significantly different from the data after
    %stabilization. Outputs the centers of the windows for each 3rd.
    firstReaching1 = strfind(hIndex1, [0,0,0]);
    firstReaching2 = strfind(hIndex2, [0,0,0]);
    firstReaching3 = strfind(hIndex3, [0,0,0]);
    
    stabilizationWindowCenter1 = firstReaching1(1);
    stabilizationWindowCenter2 = firstReaching2(1);
    stabilizationWindowCenter3 = firstReaching3(1);
    
    stabilizationWindowTime1 = (splitX1>stabilizationWindowCenter1-windowSize & splitX1<stabilizationWindowCenter1+windowSize);
    stabilizationWindowTime2 = (splitX2>stabilizationWindowCenter2-windowSize & splitX2<stabilizationWindowCenter2+windowSize);
    stabilizationWindowTime3 = (splitX3>stabilizationWindowCenter3-windowSize & splitX3<stabilizationWindowCenter3+windowSize);
    
    stabilizationPoint1 = mean(splitX1(stabilizationWindowTime1));
    stabilizationPoint2 = mean(splitX2(stabilizationWindowTime2));
    stabilizationPoint3 = mean(splitX3(stabilizationWindowTime3));   
    
end