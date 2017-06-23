function QLearnNestedAuto
% function QLearnNestedAuto
% This function runs the QLearn model fitting to all conditions' data for
% each participant. It fits 4 versions of the model (1 learning rate, 2
% learning rates, 1 learning rate per medication state, 2 learning
% rates per medication state)
% calls QLearnNestedPerPp for every separate patient for each experiment
% gets back the best fitting pars and min neg log likelihood for each model
% type

    %% set up progressbar - requires progressbar function
    % https://uk.mathworks.com/matlabcentral/fileexchange/6922-progressbar
%     progressbar('expt','pp','model')
   
    %% 4 conds expt
    load('DataFilesData.mat','pNum','bothDays')%get pNum & bothDays
    condNames = {'ONON';'ONOFF';'OFFON';'OFFOFF'};%conditions in this order
    condLetters = ['A','B','C','D'];%letters for datafiles
    nFits = 1;%number of times to run fitting
    saveName = 'QLearnNestedOutput.mat';%name to save data to
    QLearnNestedSetup(pNum,bothDays,condNames,condLetters,nFits,0,saveName);%run model fitting
%     progressbar(1/3,[],[])%advance progressbar
    
    %% F1
    load('FDataFiles.mat','pF1Num','f1Conds')%get pNum & bothDays
    condNames = {'ON';'OFF'};%conditions
    condLettersF1 = ['E','F'];%version letters
    saveNameF1 = 'QLearnNestedOutputF1.mat';%for saving data
    QLearnNestedSetup(pF1Num,f1Conds,condNames,condLettersF1,nFits,0,saveNameF1);%run fitting
%     progressbar(2/3,[],[])%advance
    
    %% F2
    load('FDataFiles.mat','pF2Num','f2Conds')%get pNum & bothDays
    condNamesF2 = {'ON';'OFF'};%conditions
    condLettersF2 = ['A','B'];%versions
    saveNameF2 = 'QLearnNestedOutputF2.mat';%for saving
    QLearnNestedSetup(pF2Num,f2Conds,condNamesF2,condLettersF2,nFits,1,saveNameF2);%run fits
%     progressbar(3/3,[],[])%advance
end

function QLearnNestedSetup(pNum,conditions,condNames,condLetters,nFits,f2,saveName)
% function QLearnNestedSetup(pNum,conditions,condNames,condLetters,nFits,f2,saveName)
% This function sorts the different sessions into order by medication
% condition, passes these to QLearnNestedPerPp to run the model fitting to
% all conditions of a single participant.
% saves output with saveName
% inputs:
% pNum=participant number
% conditions=cell array of conditions that each participants are in
% condNames = names of conditions in order desired
% condLetters = version letters of experiment
% nFits = number of fits to run
% f2 = 1 if data is from f2 experiment, 0 otherwise
% saveName = string of name to save file as
    
    nPts = length(pNum);%get number of participants
    
    nConds = length(condNames);%get number of conditions per pp
    condsOrder = char(zeros(1,nConds));%preallocate
    modelFits = cell(nPts,2,4);
    nTrials = NaN(nPts,1);
    for i = 1:nPts%for each participant
        for j = 1:nConds%for each condition
            %sort into order given in condNames
            condsOrder(j) = condLetters(strcmp(conditions(i*nConds-(nConds-1):i*nConds),condNames(j)));
        end
        %run the model fitting on those conditions
        [modelFits(i,:,:),nTrials(i)] = QLearnNestedPerPp(nFits,pNum(i),condsOrder,f2);
%         progressbar([],i/nPts,[])%advance
    end
    
    save(saveName,'modelFits','nTrials','nPts')%save these variables
end