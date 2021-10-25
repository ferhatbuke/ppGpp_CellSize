function beta=FB_expDecayFitandStats(xValues,yValues,init,final)
%Outputs the beta of the exp. decay fit below. Note since we know the
%initial value, we only fit the decay constant (b) below.
f = @(b,x) (init-final).*exp(b.*x) + final;

B0 = -0.01;

[beta,R,J,CovB,MSE,] = nlinfit(xValues,yValues,f,B0);

%Can plot the fit alone between the indicated timepoints (min and max
%xValues) if you decomment below. Doing single parameter exp decay fit
%since the inital and final steadystates are known (init, final)

%{
figure()
scatter(xValues,yValues)
hold on
timePeriod = 0:max(xValues);
plot(timePeriod,(init-final).*exp(beta.*timePeriod) + final);
xlabel('Time (Min)','FontSize',12,'FontWeight','bold')
ylabel('Mu (1/hr)','FontSize',12,'FontWeight','bold')
hold off
%}

confidenceIntervals = nlparci(beta,R,'Jacobian',J);

disp('Estimated Parameters and Their 95% Confidence Intervals:')
disp('function = a*exp(b*x)+c')
disp(strcat('Parameter b:', num2str(beta)));
disp(strcat('95% Confidence Interval:',num2str(confidenceIntervals(1,1)), '<=>',num2str(confidenceIntervals(1,2))));