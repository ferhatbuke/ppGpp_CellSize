%Import data
beforeInduction = (FitData.Time'<0 & FitData.Time'>-150); %R2 Rich 2ng/ml
beforeInduction1 = (FitData.Time1'<0 & FitData.Time1'>-100); %R1 Rich 1ng/ml
beforeInduction2 = (FitData.Time2'<0 & FitData.Time2'>-150); %M2 Min 2ng/ml
beforeInduction3 = (FitData.Time3'<0 & FitData.Time3'>-100); %M1 Min 1ng/ml
beforeInduction6 = (FitData.Time6'<0 & FitData.Time6'>-100); %R10 Rich 10ng/ml

%defined before and after induction times from "2021-07-10 FitData"
afterInduction = (FitData.Time'>400 & FitData.Time'<500);
afterInduction1 = (FitData.Time1'>250 & FitData.Time1'<350);
afterInduction2 = (FitData.Time2'>400 & FitData.Time2'<680);
afterInduction3 = (FitData.Time3'>250 & FitData.Time3'<600);
afterInduction6 = (FitData.Time6'>300 & FitData.Time6'<450);

%Average Mu's before and after spike
muAvBefore = mean(FitData.Mu(beforeInduction));
muAvBefore1 = mean(FitData.Mu1(beforeInduction1));
muAvBefore2 = mean(FitData.Mu2(beforeInduction2));
muAvBefore3 = mean(FitData.Mu3(beforeInduction3));
muAvBefore6 = mean(FitData.Mu6(beforeInduction6));

muAvAfter = mean(FitData.Mu(afterInduction));
muAvAfter1 = mean(FitData.Mu1(afterInduction1));
muAvAfter2 = mean(FitData.Mu2(afterInduction2));
muAvAfter3 = mean(FitData.Mu3(afterInduction3));
muAvAfter6 = mean(FitData.Mu6(afterInduction6));

%Raw Mu data
muRaw = FitData.Mu;
muRaw1 = FitData.Mu1;
muRaw2 = FitData.Mu2;
muRaw3 = FitData.Mu3;
muRaw6 = FitData.Mu6;

%normalize the raw data such that before=2 and after=1 by doing
%(before+x)/y=2 and (after+x)/y=1 solving this gives below.
%corresponds to linear shifting (+x) and then scaling (/y).

x= muAvBefore - muAvAfter*2;
y= muAvBefore - muAvAfter;
muNormalized = (muRaw+x)/y;

x1= muAvBefore1 - muAvAfter1*2;
y1= muAvBefore1 - muAvAfter1;
muNormalized1 = (muRaw1+x1)/y1;

x2= muAvBefore2 - muAvAfter2*2;
y2= muAvBefore2 - muAvAfter2;
muNormalized2 = (muRaw2+x2)/y2;

x3= muAvBefore3 - muAvAfter3*2;
y3= muAvBefore3 - muAvAfter3;
muNormalized3 = (muRaw3+x3)/y3;

x6= muAvBefore6 - muAvAfter6*2;
y6= muAvBefore6 - muAvAfter6;
muNormalized6 = (muRaw6+x6)/y6;

[binnedX,binnedY,binnedStd]=FB_xBinAverager(FitData.Time, muNormalized, 50, 3, -2);
[binnedX1,binnedY1,binnedStd1]=FB_xBinAverager(FitData.Time1, muNormalized1, 50, 3, 0);
[binnedX2,binnedY2,binnedStd2]=FB_xBinAverager(FitData.Time2, muNormalized2, 50, 3, 15);
[binnedX3,binnedY3,binnedStd3]=FB_xBinAverager(FitData.Time3, muNormalized3, 50, 3, 5);
[binnedX6,binnedY6,binnedStd6]=FB_xBinAverager(FitData.Time6, muNormalized6, 50, 3, 3);

%Plots Figure 2C
figure()
hold on
errorbar(binnedX(~isnan(binnedX)),binnedY(~isnan(binnedX)),binnedStd(~isnan(binnedX)))
errorbar(binnedX1(~isnan(binnedX1)),binnedY1(~isnan(binnedX1)),binnedStd1(~isnan(binnedX1)))
errorbar(binnedX2(~isnan(binnedX2)),binnedY2(~isnan(binnedX2)),binnedStd2(~isnan(binnedX2)))
errorbar(binnedX3(~isnan(binnedX3)),binnedY3(~isnan(binnedX3)),binnedStd3(~isnan(binnedX3)))
errorbar(binnedX6(~isnan(binnedX6)),binnedY6(~isnan(binnedX6)),binnedStd6(~isnan(binnedX6)))
xlim([-50,300])
ylim([0.25,2.5])
legend('R2','R1','M2','M1','R10')

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
