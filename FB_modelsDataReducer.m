function FB_modelsDataReducer
%This function saves a 5min window averaged version of the single cell data
%provided by the model.
fileName = {'ModelOutput\simpos_adder_84.0336_10_100_R2ng.dat',...
    'ModelOutput\simpos_adder_74.6269_10_100_R1ng.dat',...
    'ModelOutput\simpos_adder_98.0392_10_100_M2ng.dat',...
    'ModelOutput\simpos_adder_84.0336_10_100_M1ng.dat'...
    'ModelOutput\simneg_adder_84.0336_10_100_R2ng.dat',...
    'ModelOutput\simneg_adder_74.6269_10_100_R1ng.dat',...
    'ModelOutput\simneg_adder_98.0392_10_100_M2ng.dat',...
    'ModelOutput\simneg_adder_84.0336_10_100_M1ng.dat'};

for i=1:length(fileName)
    [birthTime,divisionTime,cycleDuration,lineageNo,finalSize,growthRate,addedSize,birthSize]=FB_CellSizeModelPlotter(fileName{i});

    [binnedDivisionTime,binnedDoublRate,binnedDoublRateSTD]=xBinAverager(divisionTime, (growthRate*60)/log(2), 5);
    [~,binnedAddedSize,binnedAddedSizeSTD]=xBinAverager(divisionTime, addedSize, 5);
    [~,binnedBirthSize,binnedBirthSizeSTD]=xBinAverager(divisionTime, birthSize, 5);
    [~,binnedCycleDuration,binnedCycleDurationSTD]=xBinAverager(divisionTime, cycleDuration, 5);

    %
    headers ={'Time','Mu','MuStd','Dl','DlStd','Lb','LbStd','Tcyc','TcycStd'};
    writeMatrix =[binnedDivisionTime;
    binnedDoublRate;
    binnedDoublRateSTD;
    binnedAddedSize;
    binnedAddedSizeSTD;
    binnedBirthSize;
    binnedBirthSizeSTD;
    binnedCycleDuration;
    binnedCycleDurationSTD]';
    finalMatrix(1,:)=headers;
    finalMatrix(2:length(binnedDivisionTime)+1,:) = num2cell(writeMatrix);
    xlswrite(strcat(fileName{i}(1:end-4),'.xlsx'),finalMatrix)
    %}
end


end