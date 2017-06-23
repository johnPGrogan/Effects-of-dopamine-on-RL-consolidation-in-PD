function CreateFakeData()
% function CreateFakeData()
% Creates fake sample data to mimic participant data, although with just
% random selections and feedback (i.e. not actual learning data)
% creates it for all three experiments, for PD patients in all conditions
% and controls 

    %% experiment 1
    
    lPars = [8,10,1];
    mPars = [4,10,0];
    npPars = [12,4,0];
    numLBlocks = 3;
    FileNameMaker(101:102,'A':'D', lPars, numLBlocks, npPars, mPars);
    
    %controls
    FileNameMaker(201:202,'A', lPars, numLBlocks, npPars, mPars);
    
    %% experiment 2
    
    FileNameMaker(152:153,'E':'F', lPars, numLBlocks, npPars);
    
    %controls
    FileNameMaker(250:251,'F', lPars, numLBlocks, npPars);
    
    %% experiment 3
    
    lPars = [12,5,1];
    numLBlocks  = 1;
    npPars = [30,3,0];
    
    FileNameMaker(131:132,'A':'B', lPars, numLBlocks, npPars);
    
    %controls
    FileNameMaker(270:271,'A', lPars, numLBlocks, npPars);

end

function FileNameMaker(ppNumbers, conds, lPars, numLBlocks, npPars, mPars)
% FileNameMaker(ppNumbers, conds, lPars, randNumLBlocks, npPars, mPars)
% Makes the file names for participants and conditions, passing arguments
% of number of stimuli, repetitions, learning blocks and feedback to
% WriteExptData, which writes it to the file.
% inputs: ppNumbers = vector of participant numbers e.g. 101:102
% conds = vector of letters for conditions e.g. 'A':'D'
% lPars = learning block pars [nStim, nReps, fb]
% randNumLBlocks = 1 if there are a random number of learning blocks, else
% 0
% npPars = novel pairs test pars [nStim, nReps, fb]
% mPars (OPTIONAL) = memory test pars (if there were memory tests) in 
% format[nStim,nReps, fb]

    counter = 1;
    for ppNum = ppNumbers %for each participant
        for letter = conds%for each condition
            for block = 1:numLBlocks%for each block
                %learning blocks
                fileNames{counter,block} = sprintf('P%d%cL%d.txt',ppNum,letter,block);
                if numLBlocks == 1%random number of learning blocks
                    WriteExptData(fileNames{counter, block}, lPars(1), lPars(2)*randi([1,7],1), lPars(3));
                else
                    WriteExptData(fileNames{counter, block}, lPars(1), lPars(2), lPars(3));
                end
                
                if nargin == 6
                    %memory blocks
                    fileNames{counter,block+3} = sprintf('P%d%cM%d.txt',ppNum,letter,block);
                    WriteExptData(fileNames{counter, block+3}, mPars(1), mPars(2), mPars(3));
                end
            end
            
            %novel pairs blocks
            fileNames{counter,7} = sprintf('P%d%cN1.txt',ppNum,letter);
            WriteExptData(fileNames{counter, 7}, npPars(1), npPars(2), npPars(3));
            
            counter = counter + 1;
        end
    end
end

function WriteExptData(fileName,nStim,nReps,fb)
% WriteExptData(fileName,nStim,nReps,fb)
% creates fake data, randomises order, writes to file
% inputs: fileName = string in format 'P101AL1.txt'
% nStim = number of different stimuli in block
% nReps = number of times each stimulus is shown
% fb = 1 if feedback is given, else 0

    nTrials = nStim * nReps;
    %create fake data
    dataBlock(:,1) = repmat([1:nStim]',nReps,1);%stim numbers
    
    dataBlock(:,2) = (rand(nTrials,1) > .5) + 1;%randomly choose left and right
    dataBlock(:,3) = randi([600 4000],nTrials,1);%random RT
    
    if fb==1%if feedback given
        dataBlock(:,4) = (rand(nTrials,1) > .5) + 1;%randomly give 1 or 2 as feedback
    else
        dataBlock(:,4) = zeros(nTrials,1);%no fb
    end
    
    %randomise order
    dataBlock = dataBlock(randperm(nTrials),:);
    
    %write to file
    dlmwrite(fileName,dataBlock,'delimiter','\t');
    
end