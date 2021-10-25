function FB_normalWidthComp(FitData)

%Import data for 100uM IPTG MeshI Induction Before Induction (4) Min media
beforeInduction4 = FitData.Time4<0 & FitData.Time4>-100;
normalizedWidth4 = FitData.Width1/mean(FitData.Width1(beforeInduction4));
%Divide data to before spike mean, normalize to 1.

%Import data for 2ng/ml DOX RelA Induction (2) Rich media
beforeInduction = FitData.Time<0 & FitData.Time>-150;
normalizedWidth = FitData.Width/mean(FitData.Width(beforeInduction)); 
%Divide data to before spike mean, normalize to 1.

figure
scatter(FitData.Time,normalizedWidth)
hold on
scatter(FitData.Time4,normalizedWidth4)

[binnedX,binnedY]=xBinAverager(FitData.Time,normalizedWidth, 14);
plot(binnedX,binnedY,'blue')

[binnedX,binnedY]=xBinAverager(FitData.Time4,normalizedWidth4, 14);
plot(binnedX,binnedY,'red')
hold off

xlim([-150,500])
ylim([0.7,1.5])

end