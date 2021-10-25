function FB_modelsvsExperiments(FitData)

    %Rich media experiment, negative and positive model comparison
    %Import data for 2ng/ml DOX RelA Induction Rich media    
    beforeInduction = (FitData.Time'>-150 & FitData.Time'<0);
    afterInduction = (FitData.Time'>400 & FitData.Time'<500);
    
    plotVectorLb = FitData.Lb;
    plotVectorMu = FitData.Mu;
    plotVectorDl = FitData.Dl;
    plotVectorTcyc = FitData.Tcyc;
    plotVectorDivTime = FitData.Time;    

    muBef = mean(plotVectorMu(beforeInduction));
    muAf = mean(plotVectorMu(afterInduction));
    DlBef = mean(plotVectorDl(beforeInduction));
    DlAf = mean(plotVectorDl(afterInduction));
    
    %Normalize LB to 2 and 1 (before and after) Note Lb is plotted at birth
    %hence the X of the plot is FitData.Time-FitData.Tcyc. Subtract
    %cycleDur to get Tbirth.
    [plotVectorLbNorm]=FB_doubleNormalize(plotVectorLb,DlBef,DlAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime-plotVectorTcyc,plotVectorLbNorm, 14);
    
    %Plots 3B
    figure()
    plot(binnedX, binnedY);
    hold on
    
    %Normalize Mu to 2 and 1 (before and after)
    [plotVectorMuNorm]=FB_doubleNormalize(plotVectorMu,muBef,muAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorMuNorm, 14);
    plot(binnedX, binnedY);
    
    %Normalize Dl to 2 and 1 (before and after)
    [plotVectorDlNorm]=FB_doubleNormalize(plotVectorDl,DlBef,DlAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorDlNorm, 14);
    plot(binnedX, binnedY);
    
    %Normalize 60/Tcyc(division frequency (1/hr) to 2 and 1 (before and after)
    [plotVectorTcycNorm]=FB_doubleNormalize(60./plotVectorTcyc,muBef, muAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorTcycNorm, 14);    
    
    plot(binnedX, binnedY);
    xlim([-100,350])
    ylim([0.5,2.5])
    line([-150,500],[1.5,1.5],'Color','black')
    line([-150,500],[1,1],'Color','black')
    line([-150,500],[2,2],'Color','black')
    line([0,0],[0.5,2.5],'Color','black')
    hold off
    
    %---------------------------------%
    %Import data for 2ng/ml DOX RelA Induction POSITIVE MODEL(7)

    plotVectorLb = FitData.Lb7;
    plotVectorMu = FitData.Mu7;
    plotVectorDl = FitData.Dl7;
    plotVectorTcyc = FitData.Tcyc7;    
    plotVectorDivTime = FitData.Time7;
    
    %Normalize LB to 2 and 1 (before and after) Note Lb is plotted at birth
    %hence the X of the plot is FitData.Time-FitData.Tcyc. Subtract
    %cycleDur to get Tbirth.
    %Note both the models are normalized using the Dl, Mu and 60/Tcyc of
    %the experimental data.
    [plotVectorLbNorm]=FB_doubleNormalize(plotVectorLb,DlBef,DlAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime-plotVectorTcyc,plotVectorLbNorm, 14);
    
    %Plots 3C
    figure()
    plot(binnedX, binnedY);
    hold on
    
    %Normalize Mu to 2 and 1 (before and after)
    [plotVectorMuNorm]=FB_doubleNormalize(plotVectorMu,muBef,muAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorMuNorm, 14);
    plot(binnedX, binnedY);
    
    %Normalize Dl to 2 and 1 (before and after)
    [plotVectorDlNorm]=FB_doubleNormalize(plotVectorDl,DlBef,DlAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorDlNorm, 14);
    plot(binnedX, binnedY);
    
    %Normalize 60/Tcyc(division frequency (1/hr) to 2 and 1 (before and after)
    [plotVectorTcycNorm]=FB_doubleNormalize(60./plotVectorTcyc,muBef, muAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorTcycNorm, 14);    
    
    plot(binnedX, binnedY);
    xlim([-100,350])
    ylim([0.5,2.5])
    line([-150,500],[1.5,1.5],'Color','black')
    line([-150,500],[1,1],'Color','black')
    line([-150,500],[2,2],'Color','black')
    line([0,0],[0.5,2.5],'Color','black')
    hold off
    
    %---------------------------------%
    %Import data for 2ng/ml DOX RelA Induction NEGATIVE MODEL(8)
    plotVectorLb = FitData.Lb8;
    plotVectorMu = FitData.Mu8;
    plotVectorDl = FitData.Dl8;
    plotVectorTcyc = FitData.Tcyc8;    
    plotVectorDivTime = FitData.Time8;
    
    %Normalize LB to 2 and 1 (before and after) Note Lb is plotted at birth
    %hence the X of the plot is FitData.Time-FitData.Tcyc. Subtract
    %cycleDur to get Tbirth.
    %Note both the models are normalized using the Dl, Mu and 60/Tcyc of
    %the experimental data.
    [plotVectorLbNorm]=FB_doubleNormalize(plotVectorLb,DlBef,DlAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime-plotVectorTcyc,plotVectorLbNorm, 14);
    figure()
    
    %Plots 3A
    plot(binnedX, binnedY);
    hold on
    
    %Normalize Mu to 2 and 1 (before and after)
    [plotVectorMuNorm]=FB_doubleNormalize(plotVectorMu,muBef,muAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorMuNorm, 14);
    plot(binnedX, binnedY);
    
    %Normalize Dl to 2 and 1 (before and after)
    [plotVectorDlNorm]=FB_doubleNormalize(plotVectorDl,DlBef,DlAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorDlNorm, 14);
    plot(binnedX, binnedY);
    
    %Normalize 60/Tcyc(division frequency (1/hr) to 2 and 1 (before and after)
    [plotVectorTcycNorm]=FB_doubleNormalize(60./plotVectorTcyc,muBef, muAf);
    [binnedX,binnedY]=xBinAverager(plotVectorDivTime,plotVectorTcycNorm, 14);
    plot(binnedX, binnedY);
    xlim([-100,350])
    ylim([0.5,2.5])
    line([-150,500],[1.5,1.5],'Color','black')
    line([-150,500],[1,1],'Color','black')
    line([-150,500],[2,2],'Color','black')
    line([0,0],[0.5,2.5],'Color','black')
    hold off
    legend({'LB','Mu','Dl','60/Tcyc'})
    
    %Import data from 4 experiments (2 1 ng Rich, 2 1 ng Min and their
    %correcponding positive and negative model parameters (Dl and Mu).
    %Below block plots S3A for 4 different experiments
    
    %2ng rich exp.
    beforeInduction = FitData.Time<0 & FitData.Time>-150;
    afterInduction = FitData.Time>400 & FitData.Time<500;
    plotTime = FitData.Time;
    plotVectorMuExp = FitData.Mu;
    plotVectorDlExp = FitData.Dl;
    plotVectorDlPosTime = FitData.Time7;
    plotVectorDlPosMod = FitData.Dl7;
    plotVectorDlNegTime = FitData.Time8;
    plotVectorDlNegMod = FitData.Dl8;
    
    muBef = mean(plotVectorMuExp(beforeInduction));
    muAf = mean(plotVectorMuExp(afterInduction));
    DlBef = mean(plotVectorDlExp(beforeInduction));
    DlAf = mean(plotVectorDlExp(afterInduction));
    
    muNormExp = FB_doubleNormalize(plotVectorMuExp,muBef, muAf);
    DlNormExp = FB_doubleNormalize(plotVectorDlExp,DlBef, DlAf);
    
    DlNormPosMod = FB_doubleNormalize(plotVectorDlPosMod,DlBef, DlAf);
    DlNormNegMod = FB_doubleNormalize(plotVectorDlNegMod,DlBef, DlAf);
    
    [binnedX,binnedY]=xBinAverager(plotTime,muNormExp, 14);
    figure()
    plot(binnedX,binnedY)
    hold on
    [binnedX,binnedY]=xBinAverager(plotTime,DlNormExp, 14);
    plot(binnedX,binnedY)
    [binnedX,binnedY]=xBinAverager(plotVectorDlPosTime,DlNormPosMod, 14);
    plot(binnedX,binnedY)
    [binnedX,binnedY]=xBinAverager(plotVectorDlNegTime,DlNormNegMod, 14);
    plot(binnedX,binnedY)
    xlim([-100,350])
    ylim([0.5,2.5])
    title('Rich 2ng')
    legend({'MuExp','DlExp','DlPos','DlNeg'})
    line([-150,500],[1.5,1.5],'Color','black')
    line([0,0],[0,5],'Color','black')
    axis square
    hold off
    
    %1ng rich exp.
    beforeInduction = FitData.Time1<0 & FitData.Time1>-100;
    afterInduction = FitData.Time1>250 & FitData.Time1<350;
    plotTime = FitData.Time1;
    plotVectorMuExp = FitData.Mu1;
    plotVectorDlExp = FitData.Dl1;
    plotVectorDlPosTime = FitData.Time9;
    plotVectorDlPosMod = FitData.Dl9;
    plotVectorDlNegTime = FitData.Time10;
    plotVectorDlNegMod = FitData.Dl10;
    
    muBef = mean(plotVectorMuExp(beforeInduction));
    muAf = mean(plotVectorMuExp(afterInduction));
    DlBef = mean(plotVectorDlExp(beforeInduction));
    DlAf = mean(plotVectorDlExp(afterInduction));
    
    muNormExp = FB_doubleNormalize(plotVectorMuExp,muBef, muAf);
    DlNormExp = FB_doubleNormalize(plotVectorDlExp,DlBef, DlAf);
    
    DlNormPosMod = FB_doubleNormalize(plotVectorDlPosMod,DlBef, DlAf);
    DlNormNegMod = FB_doubleNormalize(plotVectorDlNegMod,DlBef, DlAf);
    
    [binnedX,binnedY]=xBinAverager(plotTime,muNormExp, 14);
    figure()
    plot(binnedX,binnedY)
    hold on
    [binnedX,binnedY]=xBinAverager(plotTime,DlNormExp, 14);
    plot(binnedX,binnedY)
    [binnedX,binnedY]=xBinAverager(plotVectorDlPosTime,DlNormPosMod, 14);
    plot(binnedX,binnedY)
    [binnedX,binnedY]=xBinAverager(plotVectorDlNegTime,DlNormNegMod, 14);
    plot(binnedX,binnedY)
    xlim([-100,350])
    ylim([0.5,2.5])
    title('Rich 1ng')
    line([-150,500],[1.5,1.5],'Color','black')
    line([0,0],[0,5],'Color','black')
    legend({'MuExp','DlExp','DlPos','DlNeg'})
    axis square
    hold off   
    
    %2ng min exp.
    beforeInduction = FitData.Time2<0 & FitData.Time2>-150;
    afterInduction = FitData.Time2>400 & FitData.Time2<680;
    plotTime = FitData.Time2;
    plotVectorMuExp = FitData.Mu2;
    plotVectorDlExp = FitData.Dl2;
    plotVectorDlPosTime = FitData.Time11;
    plotVectorDlPosMod = FitData.Dl11;
    plotVectorDlNegTime = FitData.Time12;
    plotVectorDlNegMod = FitData.Dl12;
    
    muBef = mean(plotVectorMuExp(beforeInduction));
    muAf = mean(plotVectorMuExp(afterInduction));
    DlBef = mean(plotVectorDlExp(beforeInduction));
    DlAf = mean(plotVectorDlExp(afterInduction));
    
    muNormExp = FB_doubleNormalize(plotVectorMuExp,muBef, muAf);
    DlNormExp = FB_doubleNormalize(plotVectorDlExp,DlBef, DlAf);
    
    DlNormPosMod = FB_doubleNormalize(plotVectorDlPosMod,DlBef, DlAf);
    DlNormNegMod = FB_doubleNormalize(plotVectorDlNegMod,DlBef, DlAf);
    
    [binnedX,binnedY]=xBinAverager(plotTime,muNormExp, 24);
    figure()
    plot(binnedX,binnedY)
    hold on
    [binnedX,binnedY]=xBinAverager(plotTime,DlNormExp, 24);
    plot(binnedX,binnedY)
    [binnedX,binnedY]=xBinAverager(plotVectorDlPosTime,DlNormPosMod, 24);
    plot(binnedX,binnedY)
    [binnedX,binnedY]=xBinAverager(plotVectorDlNegTime,DlNormNegMod, 24);
    plot(binnedX,binnedY)
    xlim([-100,350])
    ylim([0.5,2.5])
    title('Min 2ng')
    line([-150,500],[1.5,1.5],'Color','black')
    line([0,0],[0,5],'Color','black')
    legend({'MuExp','DlExp','DlPos','DlNeg'})
    axis square
    hold off
    
    %1ng min exp.
    beforeInduction = FitData.Time3<0 & FitData.Time3>-100;
    afterInduction = FitData.Time3>250 & FitData.Time3<600;
    plotTime = FitData.Time3;
    plotVectorMuExp = FitData.Mu3;
    plotVectorDlExp = FitData.Dl3;
    plotVectorDlPosTime = FitData.Time13;
    plotVectorDlPosMod = FitData.Dl13;
    plotVectorDlNegTime = FitData.Time14;
    plotVectorDlNegMod = FitData.Dl14;
    
    muBef = mean(plotVectorMuExp(beforeInduction));
    muAf = mean(plotVectorMuExp(afterInduction));
    DlBef = mean(plotVectorDlExp(beforeInduction));
    DlAf = mean(plotVectorDlExp(afterInduction));
    
    muNormExp = FB_doubleNormalize(plotVectorMuExp,muBef, muAf);
    DlNormExp = FB_doubleNormalize(plotVectorDlExp,DlBef, DlAf);
    
    DlNormPosMod = FB_doubleNormalize(plotVectorDlPosMod,DlBef, DlAf);
    DlNormNegMod = FB_doubleNormalize(plotVectorDlNegMod,DlBef, DlAf);
    
    [binnedX,binnedY]=xBinAverager(plotTime,muNormExp, 24);
    figure()
    plot(binnedX,binnedY)
    hold on
    [binnedX,binnedY]=xBinAverager(plotTime,DlNormExp, 24);
    plot(binnedX,binnedY)
    [binnedX,binnedY]=xBinAverager(plotVectorDlPosTime,DlNormPosMod, 24);
    plot(binnedX,binnedY)
    [binnedX,binnedY]=xBinAverager(plotVectorDlNegTime,DlNormNegMod, 24);
    plot(binnedX,binnedY)
    xlim([-100,350])
    ylim([0.5,2.5])
    title('Min 1ng')
    line([-150,500],[1.5,1.5],'Color','black')
    line([0,0],[0,5],'Color','black')
    legend({'MuExp','DlExp','DlPos','DlNeg'})
    axis square
    hold off
end