function [modelFits,nTrials] = QLearnNestedPerPp(nFits,ppNum,condsOrder,f2)
% function [modelFits,nTrials] = QLearnNestedPerPp(nFits,ppNum,condsOrder,f2)
% fits 4 versions of QLearn models to each condition for each participant
% inputs: nFits = number of iterations of model fitting
% ppNum = participant's number
% condsOrder = version letters for the conditions in the correct order
% f2 = 1 if f2 experiment, 1 otherwise
% outputs: modelFits = cell array of negloglikelihood and best fitting
% parameters for each model
% nTrials = number of learning trials done by each participant
    
    nPars = [2,3,3,5];%number of parameters fit in each model
    nLrs = [1,2,1,2];%number of learning rates in each model
    nConds = length(condsOrder);%number of conds per participant
    condsFit = 1:nConds;%number of conds
    
    chosen = NaN(420,nConds);%preallocate
    notChosen = NaN(420,nConds);
    correct = NaN(420,nConds);
    for i = 1:nConds%get vectors of stim chosen, not chosen and feedback for each condition
        [chosen(:,i), notChosen(:,i), correct(:,i)] = QLearnNestedLoadUp(ppNum,condsOrder(i),f2);
    end
    nTrials = sum(sum(~isnan(chosen)));%get number of trials fitted to for each cond, ignoring NaNs
    
    
    modelFits = cell(1,2,4);%preallocate
    
    % single learning rate QLearn
    [modelFits{1,1,1}, modelFits{1,2,1}] = fitModel(condsFit,nFits,nPars(1),nLrs(1),chosen,notChosen,correct,@runModel);
%     progressbar([],[],1/4)
    
    % dual learning rate QLearn
    [modelFits{1,1,2}, modelFits{1,2,2}] = fitModel(condsFit,nFits,nPars(2),nLrs(2),chosen,notChosen,correct,@runModel);
%     progressbar([],[],2/4)
    
    % single learning rate - diff lrs per d1 cond (beta is same)
    [modelFits{1,1,3}, modelFits{1,2,3}] = fitModel(condsFit,nFits,nPars(3),nLrs(3),chosen,notChosen,correct,@runModelSplit);
%     progressbar([],[],3/4)
    
    % dual learning rate - diff lrs per d1 cond
    [modelFits{1,1,4}, modelFits{1,2,4}] = fitModel(condsFit,nFits,nPars(4),nLrs(4),chosen,notChosen,correct,@runModelSplit);    
%     progressbar([],[],4/4)
    
end

function [chosen, notChosen, correct] = QLearnNestedLoadUp(ppNum,cond,f2)
% function [chosen, notChosen, correct] = QLearnNestedLoadUp(ppNum,cond,f2)
% loads up the learning data for each participant's condition
% inputs: ppNum = participant number
% cond = letter in datafile to be loaded
% f2 = 1 if f2 expt, 0 if not
% outputs: chosen = vector of stim chosen on each trial
% notChosen = vector of stim not chosen on each trial
% correct = vector of feedback received (1 or 0) for each trial

    data1 = load (sprintf('P%d%cL1.txt',ppNum,cond));%load up data
    if nargin == 3 && f2==1%if F2 experiment there is only one datafile
        
        data1((data1(:,4) == 0),:) = [];%remove 'no response' trials
        stimuli(:,1) = mod (data1(:,1)-1, 6) + 1;%get stimulus numbers (1-6)
        feedback(:,1) = data1(:,4);%get feedback received
        choices(:,1) = data1(:,2);%get choices made
        N = length(stimuli);%number of stim
        [chosen,notChosen,correct] = DataSortF2(stimuli,feedback,choices,N);%convert to stim chosen and not chosen, and convert feedback to 1 or 0
        
    else%if F1 or 4cond expt - modified PST - 3 datafiles per session
        
        data2 = load (sprintf('P%d%cL2.txt',ppNum,cond));%load 2nd block of data
        data3 = load (sprintf('P%d%cL3.txt',ppNum,cond));%3rd block

        
        stimuli(1:80) = mod (data1(:,1)-1, 4) + 1;%get stim numbers (1-4)
        stimuli(81:160) = mod (data2(:,1)-1, 4) + 1;%same for 2nd block
        feedback(1:80) = data1(:,4);%get fb received
        feedback(81:160) = data2(:,4);
        choices(1:80) = data1(:,2);%get choices made
        choices(81:160) = data2(:,2);

        if isempty(data3) == 1%is block 3 is missing, fill with NaN
            stimuli(161:240) = NaN(80,1);
            feedback(161:240) = NaN(80,1);
            choices(161:240) = NaN(80,1);
        else%if 3rd block present, get data as above
            stimuli(161:240) = mod (data3(:,1)-1, 4) + 1;
            feedback(161:240) = data3(:,4);
            choices(161:240) = data3(:,2);
        end
        
        N=length(stimuli);%number of trials
        [chosen, notChosen, correct] = DataSort(stimuli,feedback,choices,N);%get chosen and unchosen, plus feedback as 1 or 0
    end
    chosen = [chosen;NaN(420-N,1)];%fill to length 420 with NaN
    notChosen = [notChosen;NaN(420-N,1)];%fill to length 420 with NaN
    correct = [correct;NaN(420-N,1)];%fill to length 420 with NaN
end


function [minNLL,bestPars] = fitModel(condsFit,nFits,nPars,nLrs,chosen,notChosen,correct,fcnHandle)
% function [minNLL,bestPars] = fitModel(condsFit,nFits,nPars,nLrs,chosen,notChosen,correct,fcnHandle)
% passes all conditions to fminsearch as one, to minimse negloglikelihood 
% and return the parameters that give smallest nll
% inputs: condsFit = numbers of conditions to fit (1:4 or 1:2)
% nFits = number of iterations for fitting
% nPars = number of parameters for this model
% nLrs = number of learning rates
% chosen = vector of stim chosen
% notChosen = vector of stim not chosen
% correct = vector of feedback received (1 or 0)
% fcnHandle = function handle for model (@runModel or @runModelSplit)

    startPars = rand(nFits,nPars);%random starting parameters
    
    fitPars = zeros(nFits,nPars);%preallocate
    sumNLL = zeros(nFits,1);
    for i = 1:nFits%for each iteration of fitting
        %fun fitting across conditions
        [fitPars(i,:), sumNLL(i)] = fminsearch (fcnHandle, startPars(i,:), [], nLrs,chosen, notChosen, correct,condsFit);
    end
    [minNLL,i] = min (sumNLL); %get index of lowest negloglike
    bestPars = fitPars(i,:); %get parameters for that fit
    
    %now run for all 4 conds again to get minNLL
%     minNLL = fcnHandle(bestPars,nLrs,chosen,notChosen,correct,condsFit);
end

function sumNLL = runModel(startPars,nLrs,chosen,notChosen,correct,condsFit)
% function sumNLL = runModel(startPars,nLrs,chosen,notChosen,correct,condsFit)
% runs model with same pars for all conds
% inputs: startPars = starting parameters
% nLrs = number of learning rates
% chosen, notChosen, 
% chosen = vector of stim chosen
% notChosen = vector of stim not chosen
% correct = vector of feedback received (1 or 0)
% condsFit = numbers of conditions to fit (1:2 or 1:4)
% output: sumNLL = negloglikelihood summed across conditions

    
    nll = zeros(length(condsFit),1);%preallocate
    for i = condsFit%for each condition
        if sum(isnan(chosen(:,i))) > 0%if there is missing data
            zeroIndex = find(isnan(chosen(:,i)),1) - 1;%get index of last non-missing data (usually end of 2nd block)
        else
            zeroIndex = length(chosen(:,i));%otherwise go to last item
        end
        if nLrs == 1%1 learning rate model
            model = @QLearn1Lr;
        elseif nLrs == 2%2 learning rate model
            model = @QLearn2Lr;
        else
            error('nLrs is not 1 or 2')
        end
        %run model on each condition separately using startPars
        nll(i,:) = model(startPars,chosen(1:zeroIndex,i),notChosen(1:zeroIndex,i),correct(1:zeroIndex,i));
    end
    
    sumNLL = sum(nll);%sum nlls across conditions
    
end

function sumNLL = runModelSplit(startPars,nLrs,chosen,notChosen,correct,condsFit)
% function sumNLL = runModelSplit(startPars,nLrs,chosen,notChosen,correct,condsFit)
% runs model with different pars for different conds
% inputs: startPars = starting parameters
% nLrs = number of learning rates
% chosen, notChosen, 
% chosen = vector of stim chosen
% notChosen = vector of stim not chosen
% correct = vector of feedback received (1 or 0)
% condsFit = numbers of conditions to fit (1:2 or 1:4)
% output: sumNLL = negloglikelihood summed across conditions
    
    if nLrs == 1%if 1 learning rate
        startParsOn = [startPars(1),startPars(3)];%split startPars into two conditions
        startParsOff = [startPars(2),startPars(3)];
        model = @QLearn1Lr;%set model
    elseif nLrs == 2%if two learning rates
        startParsOn = [startPars(1:2),startPars(5)];%split startPars into two conditions
        startParsOff = [startPars(3:4),startPars(5)];
        model = @QLearn2Lr;
    else
        error('nLrs is not 1 or 2')
    end
    
    nll = zeros(length(condsFit),1);%preallocate
    for i = condsFit%for each condition
        if sum(isnan(chosen(:,i))) > 0%if there is missing data
            zeroIndex = find(isnan(chosen(:,i)),1) - 1;%get index of last non-missing data (usually end of 2nd block)
        else
            zeroIndex = length(chosen(:,i));%otherwise go to last item
        end
        if i <= max(condsFit)/2 %if condition is ON or day 1 ON
            %fit model
            nll(i,:) = model(startParsOn,chosen(1:zeroIndex,i),notChosen(1:zeroIndex,i),correct(1:zeroIndex,i));
        else%OFF or day 1 OFF
            nll(i,:) = model(startParsOff,chosen(1:zeroIndex,i),notChosen(1:zeroIndex,i),correct(1:zeroIndex,i));
        end
    end
    
    sumNLL = sum(nll);%sum nlls across condition
end