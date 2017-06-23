function [chosen, notChosen, correct, optimal] = DataSort(stimuli,feedback,choices,n)
% function [chosen, notChosen, correct, optimal] = DataSort(stimuli,feedback,choices,n)
% takes in the output from Presentation modified PST experiment and converts it into
% more useful variables
% inputs:   stimuli = vector of stimulus number presented on each trial
%           (there are two stim number for each pair, left/right reversed)
%           feedback = feedback given on each trial
%           choices = choice made (left or right) on each trial
%           n = number of trials
% Outputs:  chosen = stim chosen on each trial
%           notchosen = stim unchosen
%           correct: 1 for positive feedback, 0 for negative
%           optimal: 1 for optimal choices (choosing higher rewarded
%           card),else 0 #

    chosen = NaN(n,1);%preallocate
    notChosen = chosen;
    correct = chosen;
    optimal = chosen;
    for i = 1:n%for each trial
        if stimuli(i) == 1%stimulus pair 1 - A&B
            if choices(i) == 1%if left stim chosen
                chosen(i) = 1;%chosen stim was 1
                notChosen(i) = 2;%unchosen was 2
                optimal(i) = 1;%optimal choice
            else%if right stim chosen
                chosen(i) = 2;%chosen was 2
                notChosen(i) = 1;%unchosen was 1
                optimal(i) = 0;%not optimal choice
            end 
        elseif stimuli(i) == 2%same pair as stim 1 but left/right reversed
            if choices(i) == 2
                chosen(i)= 1;
                notChosen(i) = 2;
                optimal(i) = 1;
            else
                chosen(i) = 2;
                notChosen(i) = 1;
                optimal(i) = 0;
            end
        elseif stimuli(i) ==3%stim pair 2 - C&D
            if choices(i) == 1
                chosen(i) = 3;
                notChosen(i) = 4;
                optimal(i) = 1;
            else
                chosen(i) = 4;
                notChosen(i) = 3;
                optimal(i) = 0;
            end
        elseif stimuli(i) == 4%same pair as stim 3 but l/r reversed
            if choices(i) == 2
                chosen(i) = 3;
                notChosen(i) = 4;
                optimal(i) = 1;
            else
                chosen(i) = 4;
                notChosen(i) = 3;
                optimal(i) = 0;
            end
        end
        if feedback(i) == 1%if smiley face shown
            correct(i) = 1;
        elseif feedback(i) == 2;%if frowny face shown
            correct(i) = 0;
        end
    end
end