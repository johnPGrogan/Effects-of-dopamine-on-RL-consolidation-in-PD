function F2BehLoad(i,pF2DataFiles)
% function F2BehLoad(i,pF2DataFiles)
% loads up learning and novel pairs data from F2 experiment
% inputs: i = index for this session
% pF2DataFiles = cell array of file names
% saves outputs

    lData = load(pF2DataFiles{i,1});%load learning data from textfile
    nData = load(pF2DataFiles{i,2});%novel pairs data
    
    nData((nData(:,2) == 0),:) = NaN;%remove non repsonse trials
    lData((lData(:,4) == 0),:) = NaN;%remove non repsonse trials
    
    stimuli(:,1) = mod (lData(:,1)-1, 6) + 1;%get pair shown
    feedback(:,1) = lData(:,4);%feedback given
    choices(:,1) = lData(:,2);%choice made (left/right)
    lRT(:,1) = lData(:,3);%RT
    
    nTrials = length(stimuli);%number of trials
    nBlock = nTrials/60;%number of blocks
    %sort data to get chosen,notChosen,correct (fb as 1 or 0) and optimal
    %choices
    [chosen,notChosen,correct, optimal] = DataSortF2(stimuli,feedback,choices,nTrials);
    s1 = stimuli == 1;%vector of stim 1
    s2 = stimuli == 2;
    s3 = stimuli == 3;
    s4 = stimuli == 4;
    s5 = stimuli == 5;
    s6 = stimuli == 6;
       
        
    nStimuli = nData(:,1);%novel pairs
    nChoices = nData(:,2);
    nRT = nData(:,3);
    save('F2BehDataLoad.mat')
end