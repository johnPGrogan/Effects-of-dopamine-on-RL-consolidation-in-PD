function F1BehLoad(i,pF1DataFiles)
% function F1BehLoad(i,pF1DataFiles)
% loads up data from the textfiles, processes them to get stimuli chosen
% and not chosen, and feedback given. 
% inputs: i = index for this session
% pF1DataFiles = cell array of text file names
% saves output

lData1 = load(pF1DataFiles{i,1});%load 1st block of learning data
lData2 = load(pF1DataFiles{i,2});%2nd block
lData3 = load(pF1DataFiles{i,3});%3rd block
nData = load(pF1DataFiles{i,4});%novel pairs block
    
stimuli(1:80) = mod (lData1(:,1)-1, 4) + 1;%transform to get stim pair shown
stimuli(81:160) = mod (lData2(:,1)-1, 4) + 1;
stimuli(161:240) = mod (lData3(:,1)-1, 4) + 1;
feedback(1:80) = lData1(:,4);%turn fb into vector
feedback(81:160) = lData2(:,4);
feedback(161:240) = lData3(:,4);
choices(1:80) = lData1(:,2);%get choice made (left/right)
choices(81:160) = lData2(:,2);
choices(161:240) = lData3(:,2);
lRT(1:80,1) = lData1(:,3)-400;%RT - correct for prestimulus interval
lRT(81:160,1) = lData2(:,3)-400;
lRT(161:240,1) = lData3(:,3)-400;

nTrials = length(stimuli);%number of trials

%get stim chosen and not chosen, fb as 1 or 0 and whether a choice was
%optimal or not
[chosen,notChosen,correct,optimal] = DataSort(stimuli,feedback,choices,nTrials);
s1 = stimuli == 1;%vector of stim 1
s2 = stimuli == 2;
s3 = stimuli == 3;
s4 = stimuli == 4;
lOpt1 = optimal(1:80);%vector of optimal choices for each L block
lOpt2 = optimal(81:160);
lOpt3 = optimal(161:240);

nStimuli = nData(:,1);%novel pairs data
nChoices = nData(:,2);
nRT = nData(:,3)-400;
save('F1BehDataLoad.mat')
end