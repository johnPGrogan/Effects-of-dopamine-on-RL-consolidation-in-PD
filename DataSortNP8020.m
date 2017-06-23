function [nChosen, nNotChosen, nOptimal] = DataSortNP8020(stimuli,choices,n)
% function [nChosen, nNotChosen, nOptimal] = DataSortNP8020(stimuli,choices,n)
% transforms raw data from textfile into chosen, notchosen and optimal
% choices
% inputs:   stimuli = stim pair shown on each trial
%           choices = choice made (left/right)
%           n = number of trials
% outputs:  nChosen = stim chosen on each trial
%           nNotChosen = stim unchosen
%           nOptimal: 1 for optimal choices (choosing higher rewarded
%           card),else 0 

nChosen = NaN(n,1);%preallocate
nNotChosen = nChosen;
nOptimal = nChosen;
for i = 1:n%for each trial
if stimuli(i) == 1%if pair 1 (A&B) shown
    if choices(i) == 1%if left chosen
        nChosen(i) = 80;%chosen was A=80%
        nNotChosen(i) = 20;%not chosen was B = 20%
        nOptimal(i) = 1;%optimal symbol chosen
    else%if right was chosen
        nChosen(i) = 20;%chosen was B=20%
        nNotChosen(i) = 80;%not chosen was a=80%
        nOptimal(i) = 0;%not-optimal symbol chosen
    end 
elseif stimuli(i) == 2%pair B&A
    if choices(i) == 2
        nChosen(i)= 80;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end
elseif stimuli(i) ==3
    if choices(i) == 1
        nChosen(i) = 65;
        nNotChosen(i) = 35;
        nOptimal(i) = 1;
    else
        nChosen(i) = 35;
        nNotChosen(i) = 65;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 4
    if choices(i) == 2
        nChosen(i) = 65;
        nNotChosen(i) = 35;
        nOptimal(i) = 1;
    else
        nChosen(i) = 35;
        nNotChosen(i) = 65;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 5
    if choices(i) == 1
        nChosen(i) = 80;
        nNotChosen(i) = 65;
        nOptimal(i) = 1;
    else
        nChosen(i) = 65;
        nNotChosen(i) = 80;    
        nOptimal(i) = 0;
    end 
elseif stimuli(i) == 6
    if choices(i) == 2
        nChosen(i)= 80;
        nNotChosen(i) = 65;
        nOptimal(i) = 1;
    else
        nChosen(i) = 65;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 7
    if choices(i) == 1
        nChosen(i) = 80;
        nNotChosen(i) = 35;
        nOptimal(i) = 1;
    else
        nChosen(i) = 35;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 8
    if choices(i) == 2
        nChosen(i) = 80;
        nNotChosen(i) = 35;
        nOptimal(i) = 1;
    else
        nChosen(i) = 35;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end    
elseif stimuli(i) == 9
    if choices(i) == 2
        nChosen(i) = 65;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 65;    
        nOptimal(i) = 0;
    end 
elseif stimuli(i) == 10
    if choices(i) == 1
        nChosen(i)= 65;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 65;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 11
    if choices(i) == 2
        nChosen(i) = 35;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 35;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 12
    if choices(i) == 1
        nChosen(i) = 35;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 35;
        nOptimal(i) = 0;
    end
end
end
