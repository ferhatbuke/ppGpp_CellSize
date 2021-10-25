function [binnedX,binnedY,binnedStd]=xBinAverager(inputX, inputY, binSize)

binnedX=[];
binnedY=[];
binnedStd=[];
count=0;

    for i=min(inputX):binSize:max(inputX)
        count=count+1;
        binPositionFind = inputX>=i & inputX<i+binSize;
        binnedX(count)=i+binSize/2;
        binnedY(count)=mean(inputY(binPositionFind));
        binnedStd(count) = std(inputY(binPositionFind));
    end
end