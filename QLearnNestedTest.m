function QLearnNestedTest()
% function QLearnNestedTest()
% get Bayesian Information Criteria for each model and compare across 
% model types, for each experiment

    
    load('QLearnNestedOutput.mat')%experiment 1
    subplot(2,2,1)
    title('experiment 1')
    [BIC, BICAll, minBIC, modelPars, modelParsMeans] = QLearnNestedBIC(modelFits,nTrials,nPts);%compare BICs
    
    load('QLearnNestedOutputF1.mat')%experiment 2
    subplot(2,2,2)
    title('experiment 2')
    [BICF1, BICAllF1, minBICF1, modelParsF1, modelParsMeansF1] = QLearnNestedBIC(modelFits,nTrials,nPts);
    
    load('QLearnNestedOutputF2.mat')%experiment 3
    subplot(2,2,3)
    title('experiment 3')    
    [BICF2, BICAllF2, minBICF2, modelParsF2, modelParsMeansF2] = QLearnNestedBIC(modelFits,nTrials,nPts);

    saveas(figure(1),'QLearnNestedBestByPp.fig')%save figure
    saveas(figure(1),'QLearnNestedBestByPp.jpg')
    clf
    
    %% combine all into one
    
    allBIC = [BIC;BICF1;BICF2];
    models = {'1lr','2lr','1lrConds','2lrConds'};
    [minBIC,bestModelInd] = min(nanmean(allBIC)); 
    fprintf('model %s has the smallest BIC: %d\n',models{bestModelInd},minBIC)
    
    
    %% save
    save('QLearnNestedTestOutput.mat','BIC','BICAll','minBIC','modelPars', 'modelParsMeans',...
        'BICF1','BICAllF1','minBICF1','modelParsF1', 'modelParsMeansF1',...
        'BICF2','BICAllF2','minBICF2','modelParsF2', 'modelParsMeansF2')
end

function [BIC, BICAll, minBIC, modelPars, modelParsMeans] = QLearnNestedBIC(modelFits,nTrials,nPts)
% function [BIC, BICAll, minBIC, modelPars, modelParsMeans] = QLearnNestedBIC(modelFits,nTrials,nPts)
% calculates BIC for each participant for each model, finds smalelst mean
% BIC and also smallest BIC for each participant
% draws histogram of best fitting model per participant
% gets model parameters for each model into cell array
% inputs: modelFits = cell with nlls and parameters from model fitting
% nTrials = number of trials per participant
% nPts = number of participants
% outputs: BIC = BIC for each participant and model
% BICAll = mean BIC for each model
% minBIC = min BIC for each participant
% modelPars = parameters for each participant per model
% modelParsMeans = mean parameters for each model

    models = {'1lr','2lr','1lrConds','2lrConds'};%model names
    
    %% get negLogLikelihoods in one matrix
    nlls = [modelFits{:,1,1};modelFits{:,1,2}; modelFits{:,1,3}; modelFits{:,1,4}]';
    nPars = [2,3,3,5];%matrix of number of parameters for each model


    %% calculate Bayesian Information Criteria

    BIC = 2.*nlls + repmat(nPars,nPts,1).*log(repmat(nTrials,1,4));
    BICAll = nanmean(BIC);%take mean
    BICd = BICAll - min(BICAll);%get difference
    BICw = exp(-0.5*BICd)./sum(exp(-0.5*BICd));%get BIC weight
    [minBIC,bestModelInd] = min(BICAll); %find smallest BIC
    fprintf('model %s has the smallest BIC: %d\n',models{bestModelInd},minBIC)%print it


    %% plot hist of which model is best for each pp
    indexBIC = zeros(length(BIC),1);
    minBIC = zeros(length(BIC),1);
    for i = 1:nPts
        [minBIC(i),indexBIC(i)] = min(BIC(i,:));
    end

    hist(indexBIC)
    set(gca,'XTick',1:4,'XTickLabel',models)
    axis([0.5 4.5 0 length(nlls)])
%     xticklabel_rotate%rotates labels by 90 degrees - https://uk.mathworks.com/matlabcentral/fileexchange/3486-xticklabel-rotate
    xlabel('Model')
    ylabel('# best fitting models')

    %% parameter analysis
    modelPars = cell(1,4);
    modelParsMeans = modelPars;
    for i = 1:4%for each model
        nPars(i) = size(modelFits{1,2,i},2);%get number of pars
        a = [modelFits{:,2,i}];%put all pars into vector (only way to get them out of cell)
        for j = 1:nPars(i)%pull out each par into separate column
            a1(:,j) = a(j:nPars(i):end);
        end
        modelPars{i} = a1;%save in cell
        modelParsMeans{i} = mean(modelPars{i});
    end    
end