function FB_LbvsMuandTcyc(FitData)

plotVectorLb =[];
plotVectorMu=[];
plotVectorTcyc=[];
plotVectorDl=[];
plotType=[];

%Import data for 100uM IPTG MeshI Induction After Induction (4) Min media
afterInduction4 = (FitData.Time4'>400 & FitData.Time4'<600 & FitData.Dl4'<10); %FitData.Dl4'<10 Eliminates a single cell which appears to have excedingly long Dl (>10uM!)
plotVectorLb = [plotVectorLb,FitData.Lb4(afterInduction4)'];
plotVectorMu = [plotVectorMu,FitData.Mu4(afterInduction4)'];
plotVectorTcyc = [plotVectorTcyc,FitData.Tcyc4(afterInduction4)'];
plotVectorDl = [plotVectorDl,FitData.Dl4(afterInduction4)'];
plotType(1:sum(afterInduction4)) = 1;

%Import data for 100uM IPTG MeshI Induction Before Induction (4) Min media
beforeInduction4 = (FitData.Time4'<0 & FitData.Time4'>-100);
plotVectorLb = [plotVectorLb,FitData.Lb4(beforeInduction4)'];
plotVectorMu = [plotVectorMu,FitData.Mu4(beforeInduction4)'];
plotVectorTcyc = [plotVectorTcyc,FitData.Tcyc4(beforeInduction4)'];
plotVectorDl = [plotVectorDl,FitData.Dl4(beforeInduction4)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction4)) = 2;

%Import data for 2ng/ml DOX RelA Induction Before Induction (2) Min media
beforeInduction2 = (FitData.Time2'<0 & FitData.Time2'>-150);
plotVectorLb = [plotVectorLb,FitData.Lb2(beforeInduction2)'];
plotVectorMu = [plotVectorMu,FitData.Mu2(beforeInduction2)'];
plotVectorTcyc = [plotVectorTcyc,FitData.Tcyc2(beforeInduction2)'];
plotVectorDl = [plotVectorDl,FitData.Dl2(beforeInduction2)'];
plotType(length(plotType)+1:length(plotType)+sum(beforeInduction2)) = 3;

%Import data for 1ng/ml DOX RelA Induction After Induction (5) Min media
afterInduction3 = (FitData.Time5'>250 & FitData.Time5'<600);
plotVectorLb = [plotVectorLb,FitData.Lb3(afterInduction3)'];
plotVectorMu = [plotVectorMu,FitData.Mu3(afterInduction3)'];
plotVectorTcyc = [plotVectorTcyc,FitData.Tcyc3(afterInduction3)'];
plotVectorDl = [plotVectorDl,FitData.Dl3(afterInduction3)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction3)) = 4;

%Import data for 2ng/ml DOX RelA Induction After Induction (2) Min media
afterInduction2 = (FitData.Time2'>400 & FitData.Time2'<680);
plotVectorLb = [plotVectorLb,FitData.Lb2(afterInduction2)'];
plotVectorMu = [plotVectorMu,FitData.Mu2(afterInduction2)'];
plotVectorTcyc = [plotVectorTcyc,FitData.Tcyc2(afterInduction2)'];
plotVectorDl = [plotVectorDl,FitData.Dl2(afterInduction2)'];
plotType(length(plotType)+1:length(plotType)+sum(afterInduction2)) = 5;

%Type = 2 will not be shows since it overlaps with before induction DOX
%data. Type = 2 is before induction Mesh1 data. Data is seen it other
%boxplots.

[binnedX1,binnedYTcyc1,binnedStdTcyc1]=FB_xBinAverager(plotVectorLb(plotType==1), plotVectorTcyc(plotType==1), 0.12, 5);
[binnedX1,binnedYDl1,binnedStdDl1]=FB_xBinAverager(plotVectorLb(plotType==1), plotVectorDl(plotType==1), 0.12, 5);
[binnedX1,binnedYMu1,binnedStdMu1]=FB_xBinAverager(plotVectorLb(plotType==1), plotVectorMu(plotType==1), 0.12, 5);

%Before induction Mesh1 data, not shown to decrease clutter.
%[binnedX2,binnedYTcyc2,binnedStdTcyc2]=FB_xBinAverager(plotVectorLb(plotType==2), plotVectorTcyc(plotType==2), 0.12, 5);
%[binnedX2,binnedYDl2,binnedStdDl2]=FB_xBinAverager(plotVectorLb(plotType==2), plotVectorDl(plotType==2), 0.12, 5);
%[binnedX2,binnedYMu2,binnedStdMu2]=FB_xBinAverager(plotVectorLb(plotType==2), plotVectorMu(plotType==2), 0.12, 5);

[binnedX3,binnedYTcyc3,binnedStdTcyc3]=FB_xBinAverager(plotVectorLb(plotType==3), plotVectorTcyc(plotType==3), 0.1, 5);
[binnedX3,binnedYDl3,binnedStdDl3]=FB_xBinAverager(plotVectorLb(plotType==3), plotVectorDl(plotType==3), 0.1, 5);
[binnedX3,binnedYMu3,binnedStdMu3]=FB_xBinAverager(plotVectorLb(plotType==3), plotVectorMu(plotType==3), 0.1, 5);

[binnedX4,binnedYTcyc4,binnedStdTcyc4]=FB_xBinAverager(plotVectorLb(plotType==4), plotVectorTcyc(plotType==4), 0.12, 5);
[binnedX4,binnedYDl4,binnedStdDl4]=FB_xBinAverager(plotVectorLb(plotType==4), plotVectorDl(plotType==4), 0.12, 5);
[binnedX4,binnedYMu4,binnedStdMu4]=FB_xBinAverager(plotVectorLb(plotType==4), plotVectorMu(plotType==4), 0.12, 5);

[binnedX5,binnedYTcyc5,binnedStdTcyc5]=FB_xBinAverager(plotVectorLb(plotType==5), plotVectorTcyc(plotType==5), 0.1, 5);
[binnedX5,binnedYDl5,binnedStdDl5]=FB_xBinAverager(plotVectorLb(plotType==5), plotVectorDl(plotType==5), 0.1, 5);
[binnedX5,binnedYMu5,binnedStdMu5]=FB_xBinAverager(plotVectorLb(plotType==5), plotVectorMu(plotType==5), 0.1, 2);


figure
hold
scatter(plotVectorLb(plotType==1),plotVectorTcyc(plotType==1))
%scatter(plotVectorLb(plotType==2),plotVectorTcyc(plotType==2))
scatter(plotVectorLb(plotType==3),plotVectorTcyc(plotType==3))
scatter(plotVectorLb(plotType==4),plotVectorTcyc(plotType==4))
scatter(plotVectorLb(plotType==5),plotVectorTcyc(plotType==5))
xlim([0.85 2.85])

errorbar(binnedX1,binnedYTcyc1,binnedStdTcyc1,'black')
%errorbar(binnedX2,binnedYTcyc2,binnedStdTcyc2,'black')
errorbar(binnedX3,binnedYTcyc3,binnedStdTcyc3,'black')
errorbar(binnedX4,binnedYTcyc4,binnedStdTcyc4,'black')
errorbar(binnedX5,binnedYTcyc5,binnedStdTcyc5,'black')

xlim([0.85 2.85])
ylim([20,500])

figure
hold
scatter(plotVectorLb(plotType==1),plotVectorDl(plotType==1))
%scatter(plotVectorLb(plotType==2),plotVectorDl(plotType==2))
scatter(plotVectorLb(plotType==3),plotVectorDl(plotType==3))
scatter(plotVectorLb(plotType==4),plotVectorDl(plotType==4))
scatter(plotVectorLb(plotType==5),plotVectorDl(plotType==5))


errorbar(binnedX1,binnedYDl1,binnedStdDl1,'black')
%errorbar(binnedX2,binnedYDl2,binnedStdDl2)
errorbar(binnedX3,binnedYDl3,binnedStdDl3,'black')
errorbar(binnedX4,binnedYDl4,binnedStdDl4,'black')
errorbar(binnedX5,binnedYDl5,binnedStdDl5,'black')

xlim([0.85 2.85])
ylim([0,5])
end

function [binnedX,binnedY,binnedStd]=FB_xBinAverager(inputX, inputY, binSize, ignoreLimit)

binnedX=[];
binnedY=[];
binnedStd=[];
count=0;

    for i=min(inputX):binSize:max(inputX)
        count=count+1;
        binPositionFind = inputX>=i & inputX<i+binSize;
        binnedX(count)=i+binSize/2;
        
        testY = inputY(binPositionFind);
        
        binnedY(count)=mean(testY);
        binnedStd(count) = std(testY);
        
        if length(testY)<ignoreLimit
            binnedY(count)=NaN;
            binnedStd(count) = NaN;
            binnedX(count)=NaN;
        end
    end
end















