function FB_normalizer(FitData)

afterInduction4 = (FitData.Time4'>400 & FitData.Time4'<600);
beforeInduction4 = (FitData.Time4'>-150 & FitData.Time4'<0);

afterLb4 = FitData.Lb4(afterInduction4);
afterMu4 = FitData.Mu4(afterInduction4);
afterDl4 = FitData.Dl4(afterInduction4);
after60Tcyc4 = 60./FitData.Dl4(afterInduction4);

beforeLb4 = FitData.Lb4(beforeInduction4);
beforeMu4 = FitData.Mu4(beforeInduction4);
beforeDl4 = FitData.Dl4(beforeInduction4);
before60Tcyc4 = 60./FitData.Dl4(beforeInduction4);

x = mean(beforeLb4) - mean(afterLb4)*2;
y = mean(beforeLb4) - mean(afterLb4);
normalizedLb = (FitData.Lb4+x)/y;

[binnedX,binnedY,~]=FB_xBinAverager(FitData.Time4, normalizedLb, 50, 3, 0);
figure
plot(binnedX,binnedY)
hold on

x = mean(beforeMu4) - mean(afterMu4)*2;
y = mean(beforeMu4) - mean(afterMu4);
normalizedMu = (FitData.Mu4+x)/y;
[binnedX,binnedY,~]=FB_xBinAverager(FitData.Time4, normalizedMu, 50, 3, 0);
plot(binnedX,binnedY)

[binnedX,binnedY,~]=FB_xBinAverager(FitData.Time4, 60./FitData.Tcyc4, 25, 3, 0);
figure
plot(binnedX,binnedY)


end

function [binnedX,binnedY,binnedStd]=FB_xBinAverager(inputX, inputY, binSize, ignoreLimit,offset)

binnedX=[];
binnedY=[];
binnedStd=[];
count=0;

    for i=min(inputX):binSize:max(inputX)
        count=count+1;
        binPositionFind = inputX>=i+offset & inputX<i+binSize+offset;
        binnedX(count)=i+offset+binSize/2;
        
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