function [chosen, notChosen, correct, optimal] = DataSortF2(stimuli,feedback,choices,n)
% function [chosen, notChosen, correct, optimal] = DataSortF2(stimuli,feedback,choices,n)
% takes in the output from Presentation experiment F2 and converts it into
% more useful variables
% inputs:   stimuli = vector of stimulus number presented on each trial
%           (there are two stim number for each pair, left/right reversed)
%           feedback = feedback given on each trial
%           choices = choice made (left or right) on each trial
%           n = number of trials
% Outputs:  chosen = stim chosen on each trial
%           notchosen = stim unchosen
%           correct: 1 for correct feedback, 0 for incorrect
%           optimal: 1 for optimal choices (choosing higher rewarded
%           card),else 0 #

    correct = NaN(length(feedback),1);%preallocate
    correct(feedback == 1) = 1;%correct feedback
    correct(feedback == 2) = 0;%incorrect feedback
    correct(feedback == 0) = NaN;%no feedback - no response

    chosen = NaN(n,1);%preallocate
    notChosen = NaN(n,1);
    optimal = zeros(n,1);
    for i = 1:n%for each trial
        if stimuli(i) == 1%stimulus pair 1 - A&B
            if choices(i) == 1%if left stim chosen
                chosen(i) = 1;%then stim 1 was chosen
                notChosen(i) = 2;%stim 2 avoided
                optimal(i) = 1;%optimal one chosen
            else%if right stim chosen
                chosen(i) = 2;%then stim 2 was chosen
                notChosen(i) = 1;%stim 1 avoided
                optimal(i) = 0;%optimal one not chosen
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
        elseif stimuli(i) == 5%stim pair 3 - E&F
            if choices(i) == 1
                chosen(i) = 5;
                notChosen(i) = 6;
                optimal(i) = 1;
            else
                chosen(i) = 6;
                notChosen(i) = 5;
                optimal(i) = 0;
            end
        elseif stimuli(i) == 6%same pair as stim 5 but l/r reversed
            if choices(i) == 2
                chosen(i) = 5;
                notChosen(i) = 6;
                optimal(i) = 1;
            else
                chosen(i) = 6;
                notChosen(i) = 5;
                optimal(i) = 0;
            end
        end
    end
end
