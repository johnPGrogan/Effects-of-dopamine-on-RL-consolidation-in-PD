function [winStayPerc,loseShiftPerc,winStay,winShift,numWins,loseStay,loseShift,numLosses] = WinStayLoseShift(allLStimuli,allLChosen,allLCorrect)
% [winStayPerc,loseShiftPerc,winStay,winShift,numWins,loseStay,loseShift,numLosses] = WinStayLoseShift(allLStimuli,allLChosen,allLCorrect)
% calculates percentage of win-stay and lose-shift for each stimulus for
% each participant
% inputs: allLStimuli = matrix of stimulus (1-6) presented on each trial
% in learning phase [nTrials x nSessions]. NaNs can be used for missing
% data
% allLChosen = matrix of which stimulus was chosen on each trial per
% session
% allLCorrect = matrix of feedback received on each trial (1 for win, 0 for
% loss)
% outputs: winStayPerc = % of win stay for each session
% loseShiftPerc = % of lose shift for each session
% winStay = number of win-stays per stimulus [columns] per session [rows]
% winShift = number of win-shifts per stimulus per session
% numWins = number of wins per stimulus per session
% loseStay = number of lose-stays per stimulus [columns] per session [rows]
% loseShift = number of lose-shifts per stimulus per session
% numlosses = number of losses per stimulus per session


    [nTrials,nSessions] = size(allLStimuli);%get size
    
    nStimuli = max(max(allLStimuli));%get the max stim number
    
    winStay = zeros(nSessions,nStimuli);%preallocate
    loseShift = winStay;
    winShift = winStay;
    loseStay = winStay;
    numWins = winStay;
    numLosses = winStay;
        
    %for each pp
    for iParticipant = 1:nSessions

        %get the pair shown for each trial
        pair = round(allLStimuli(:,iParticipant)/2);
        %get the stimulus chosen
        stimChosen = allLChosen(:,iParticipant);

        %get the outcome for that stimulus
        outcome = allLCorrect(:,iParticipant);
        
        for iTrial = 1:nTrials%for each trial

            %get stim chosen on this trial
            thisChosen = stimChosen(iTrial);
            %get the pair shown on this trial
            thisPair = pair(iTrial);
            %get outcome for this trial
            thisOutcome = outcome(iTrial);
            
            %get next presentation of this pair
            nextPair = find(pair(iTrial+1:end) == thisPair,1) + iTrial;
            %see if same stim chosen
            nextChosen = stimChosen(nextPair);

            if nextChosen%if there is a nextChosen
                if thisOutcome == 1%if it was a win
                    %increase the number of stays or shifts, and the number
                    %of wins
                    winStay(iParticipant,thisChosen) = winStay(iParticipant,thisChosen) + (thisChosen==nextChosen);
                    winShift(iParticipant,thisChosen) = winShift(iParticipant,thisChosen) + (thisChosen~=nextChosen);
                    numWins(iParticipant,thisChosen) = numWins(iParticipant,thisChosen) + 1;
                else
                    %if it was a lose trial, count shifts and stays and
                    %number of losses
                    loseShift(iParticipant,thisChosen) = loseShift(iParticipant,thisChosen) + (thisChosen~=nextChosen);
                    loseStay(iParticipant,thisChosen) = loseStay(iParticipant,thisChosen) + (thisChosen==nextChosen);
                    numLosses(iParticipant,thisChosen) = numLosses(iParticipant,thisChosen) + 1;
                end%thisOutcome
            end%nextChosen
        end%trial
    end%participant
    
    winStayPerc = nansum(winStay,2) ./ nansum(numWins,2) * 100;%get winStays as a percentage of win trials with a next choice
    loseShiftPerc = nansum(loseShift,2) ./ nansum(numLosses,2) * 100;%get loseShifts as a percentage of lose trials with a next choice
    
    %do some error checks
    if ~all(all((loseStay + loseShift) == numLosses))
        error('lose trials do not add up')
    elseif ~all(all((winStay + winShift) == numWins))
        error('win trials do not add up')
    end
    
end%function