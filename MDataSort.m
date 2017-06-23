function [mOptimal,mChosen,mNotChosen] = MDataSort(mStimuli,mChoices,N)
% function [mOptimal,mChosen,mNotChosen] = MDataSort(mStimuli,mChoices,N)
% sorts memory block data from modified PST
% gets stim chosen, stim not chosen, and whether it was the optimal choice
% inputs: mStimuli = stim pair shown each trial
% mChoices = choice made (left or right) on each trial
% N = number of trials
% outputs: mOptimal = 1 if optimal stim chosen on each trial, else 0
% mChosen = stim chosen on each trial
% mNotChosen = stim not chosen on each trial

mOptimal = NaN(N,1);%preallocate
mChosen = mOptimal;
mNotChosen = mOptimal;
for i = 1:N%for each trial
    if mStimuli(i) == 1%pair 1 - A&B
        if mChoices(i) == 1%if left stim chosen
            mOptimal(i) = 1;%optimal choice
            mChosen(i) = 1;%chose stim 1
            mNotChosen(i) = 2;%didn't choose stim 2
        else%if right stim chosen
            mOptimal(i) = 0;%not optimal choice
            mChosen(i) = 2;%chosen stim 2
            mNotChosen(i) = 1;%didn't choose stim 1
        end 
    elseif mStimuli(i) == 2%pair 1 = B&A
        if mChoices(i) == 1
            mOptimal(i) = 1;
            mChosen(i) = 3;
            mNotChosen(i) = 4;
        else 
            mOptimal(i) = 0;
            mChosen(i) = 4;
            mNotChosen(i) = 3;
        end
    elseif mStimuli(i) == 3%pair 2 C&D
        if mChoices(i) == 2
            mOptimal(i) = 1;
            mChosen(i) = 3;
            mNotChosen(i) = 4;
        else 
            mOptimal(i) = 0;
            mChosen(i) = 4;
            mNotChosen(i) = 3;
        end
    elseif mStimuli(i) == 4%pair 2 D&C
        if mChoices(i) == 2
            mOptimal(i) = 1;
            mChosen(i)= 1;
            mNotChosen(i) = 2;
        else 
            mOptimal(i) = 0;
            mChosen(i) = 2;
            mNotChosen(i) = 1;
        end                
    end
end
end