function [daughterSchnitzList,parentSchnitzList] = FB_fullCycleDaughterFinder(schnitzList,schnitzcells)
%Input a list of schnitz labels (numbers) and the schnitz data file (main .mat data files)
%finds all their daughters who completed a cycle and outputs 2 vectors with
%the mothers and daughters names seperatelly in the same location in each
%vector.

%Initialize the vectors required.
daughterSchnitzList=[];
parentSchnitzList=[];
sizeAtBirth=[];
sizeAtDivision=[];
addedSize=[];

count = 0; %Counts found daughters.
for i=1:length(schnitzList) %Goes through the list
    if schnitzcells(schnitzList(i)).D ~= 0 %Check daughter #1 through the list
        daughter1 = schnitzcells(schnitzList(i)).D; %Finds daughter in schnitzcells file
        if schnitzcells(daughter1).completeCycle %Check if daughter #1 has a complete cycle
            count = count+1;
            daughterSchnitzList(count) = daughter1; %If so save it... 
            parentSchnitzList(count) = schnitzList(i); %... and its mother.
        end
    end 
    
    if schnitzcells(schnitzList(i)).E ~= 0 %Same as above for the second daughter. Some cells will only
        %have 1 daughter cell which could complete its cycle while other is
        %carried away or mistracked etc.
        daughter2 = schnitzcells(schnitzList(i)).E;
        if schnitzcells(daughter2).completeCycle
            count = count+1;
            daughterSchnitzList(count) = daughter2;
            parentSchnitzList(count) = schnitzList(i);
        end
    end 
    
end
end