function BehDataLoad(i,pDataFilesNoF,pMDataFiles)
% function BehDataLoad(i,pDataFilesNoF,pMDataFiles)
% load all data into vars for this pp cond
% inputs: i = patient counter
% pDataFilesNoF = cell array of learning block datafile names
% pMDataFiles = cell array of memory block datafile names
% variables are saved

lData1 = load (pDataFilesNoF{i,1});%load learning block 1 data from txt
lData2 = load (pDataFilesNoF{i,2});%learning block 2
lData3 = load (pDataFilesNoF{i,3});%3

mData1 = load(pMDataFiles{i,1});%0 min memory data
mData2 = load(pMDataFiles{i,2});%30 min memory
mData3 = load(pMDataFiles{i,3});%24hr memory block

nData = load(pMDataFiles{i,4});%novel pairs data

if isempty(lData3) == 0 %if 3rd learning block is missing
    stimuli(1:80) = mod (lData1(:,1)-1, 4) + 1;%transform to get stim number
    stimuli(81:160) = mod (lData2(:,1)-1, 4) + 1;
    stimuli(161:240) = mod (lData3(:,1)-1, 4) + 1;
    feedback(1:80) = lData1(:,4);%get feedback vec
    feedback(81:160) = lData2(:,4);
    feedback(161:240) = lData3(:,4);
    choices(1:80) = lData1(:,2);%choices vec
    choices(81:160) = lData2(:,2);
    choices(161:240) = lData3(:,2);
    lRT(1:80,1) = lData1(:,3)-400;%RT: correct for prestimulus interval
    lRT(81:160,1) = lData2(:,3)-400;
    lRT(161:240,1) = lData3(:,3)-400;

else
    %if block 3 is empty, still works - fills extra with NaNs    
    stimuli(1:80) = mod (lData1(:,1)-1, 4) + 1;
    stimuli(81:160) = mod (lData2(:,1)-1, 4) + 1;
    stimuli(161:240) = NaN;
    feedback(1:80) = lData1(:,4);
    feedback(81:160) = lData2(:,4);
    feedback(161:240) = NaN;
    choices(1:80) = lData1(:,2);
    choices(81:160) = lData2(:,2);
    choices(161:240) = NaN;
    lRT(1:80,1) = lData1(:,3)-400;
    lRT(81:160,1) = lData2(:,3)-400;
    lRT(161:240,1) = NaN;

end

N=length(stimuli);%number of trials

%transform into stim chosen & unchosen, put fb as 1 or 0, get whether it was an optimal choice
[chosen,notChosen,correct, optimal] = DataSort(stimuli,feedback,choices,N);
s1 = stimuli == 1;%vector of stim 1
s2 = stimuli == 2;%stim 2
s3 = stimuli == 3;%stim 3
s4 = stimuli == 4;%stim 4
lOpt1 = optimal(1:80);%vector of optimal choices for each learning block
lOpt2 = optimal(81:160);
if isempty(lData3) == 0
    lOpt3 = optimal(161:240);
else 
    lOpt3 = NaN(80,1);
end

%% memory data
mStimuli(1:40,1) = mData1(:,1);%memory blocks stimuli
mChoices(1:40,1) = mData1(:,2);%mem choices
mRT(1:40,1) = mData1(:,3)-400;%RT: correct for prestimulus time
if isempty(mData2) == 0%if 30min memory is missing
    mStimuli(41:80,1) = mData2(:,1);
    mStimuli(81:120,1) = mData3(:,1);
    mChoices(41:80,1) = mData2(:,2);  
    mChoices(81:120,1) = mData3(:,2);
    mRT(41:80,1) = mData2(:,3)-400;
    mRT(81:120,1) = mData3(:,3)-400;
else
    mStimuli(41:80,1) = NaN;
    mStimuli(81:120,1) = mData3(:,1);
    mChoices(41:80,1) = NaN;
    mChoices(81:120,1) = mData3(:,2);
    mRT(41:80,1) = NaN;
    mRT(81:120,1) = mData3(:,3)-400;
end

mN=length(mStimuli);%number of memory trials

%get optimal choice, stim chosen and not chosen
[mOptimal,mChosen,mNotChosen] = MDataSort(mStimuli,mChoices,mN);
mS1 = mStimuli == 1;%stim1
mS2 = mStimuli == 2;
mS3 = mStimuli == 3;
mS4 = mStimuli == 4;   
mOpt1 = mOptimal(1:40);%mem1 optimals
mOpt2 = mOptimal(41:80);

if length(mOptimal) == 120%if missing block
    mOpt3 = mOptimal(81:120);
else
    mOpt3 = NaN(40,1);
end

if isempty(nData) == 0%if not missing novel pairs
    nStimuli = nData(:,1);%stim
    nChoices = nData(:,2);%choices
    nRT = nData(:,3)-400;%RT
end

%RT


save('BehDataLoadOutput.mat')
end