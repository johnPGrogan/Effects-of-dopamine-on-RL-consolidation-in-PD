function [nChosen, nNotChosen, nOptimal] = DataSortNPF28020(stimuli,choices,n)
% function [nChosen, nNotChosen, nOptimal] = DataSortNPF28020(stimuli,choices,n)
% changes stim&choice to chosen,notchosen & optimal
%inputs:    stimuli = pair shown on each trial
%           choices = left/right choice made
%           n = number of trials
%outputs:   nChosen = stim chosen on each trial
%           nNotchosen = stim unchosen
%           nOptimal: 1 for optimal choices (choosing higher rewarded
%           card),else 0 

nChosen = NaN(n,1);%preallocate
nNotChosen = nChosen;
nOptimal = nChosen;
for i = 1:n%for each trial
if stimuli(i) == 1%if pair 1 (AB) shown
    if choices(i) == 1%if left card chosen
        nChosen(i) = 80;%chosen was A=80%
        nNotChosen(i) = 20;%not chosen was B=20%
        nOptimal(i) = 1;%optimal card chosen
    else%if right chosen
        nChosen(i) = 20;%chosen was B=20%
        nNotChosen(i) = 80;%notChosen was A=80%
        nOptimal(i) = 0;%non-optimal card chosen
    end 
elseif stimuli(i) == 2%BA pair
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
        nChosen(i) = 70;
        nNotChosen(i) = 30;
        nOptimal(i) = 1;
    else
        nChosen(i) = 30;
        nNotChosen(i) = 70;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 4
    if choices(i) == 2
        nChosen(i) = 70;
        nNotChosen(i) = 30;
        nOptimal(i) = 1;
    else
        nChosen(i) = 30;
        nNotChosen(i) = 70;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 5
    if choices(i) == 1
        nChosen(i) = 60;
        nNotChosen(i) = 40;
        nOptimal(i) = 1;
    else
        nChosen(i) = 40;
        nNotChosen(i) = 60;    
        nOptimal(i) = 0;
    end 
elseif stimuli(i) == 6
    if choices(i) == 2
        nChosen(i)= 60;
        nNotChosen(i) = 40;
        nOptimal(i) = 1;
    else
        nChosen(i) = 40;
        nNotChosen(i) = 60;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 7
    if choices(i) == 1
        nChosen(i) = 80;
        nNotChosen(i) = 70;
        nOptimal(i) = 1;
    else
        nChosen(i) = 70;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 8
    if choices(i) == 2
        nChosen(i) = 80;
        nNotChosen(i) = 70;
        nOptimal(i) = 1;
    else
        nChosen(i) = 70;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end    
elseif stimuli(i) == 9
    if choices(i) == 1
        nChosen(i) = 80;
        nNotChosen(i) = 30;
        nOptimal(i) = 1;
    else
        nChosen(i) = 30;
        nNotChosen(i) = 80;    
        nOptimal(i) = 0;
    end 
elseif stimuli(i) == 10
    if choices(i) == 2
        nChosen(i)= 80;
        nNotChosen(i) = 30;
        nOptimal(i) = 1;
    else
        nChosen(i) = 30;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 11
    if choices(i) == 1
        nChosen(i) = 80;
        nNotChosen(i) = 60;
        nOptimal(i) = 1;
    else
        nChosen(i) = 60;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 12
    if choices(i) == 2
        nChosen(i) = 80;
        nNotChosen(i) = 60;
        nOptimal(i) = 1;
    else
        nChosen(i) = 60;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end  
elseif stimuli(i) == 13
    if choices(i) == 1
        nChosen(i) = 80;
        nNotChosen(i) = 40;
        nOptimal(i) = 1;
    else
        nChosen(i) = 40;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 14
    if choices(i) == 2
        nChosen(i) = 80;
        nNotChosen(i) = 40;
        nOptimal(i) = 1;
    else
        nChosen(i) = 40;
        nNotChosen(i) = 80;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 15
    if choices(i) == 2
        nChosen(i) = 70;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 70;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 16
    if choices(i) == 1
        nChosen(i) = 70;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 70;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 17
    if choices(i) == 2
        nChosen(i) = 30;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 30;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 18
    if choices(i) == 1
        nChosen(i) = 30;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 30;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 19
    if choices(i) == 2
        nChosen(i) = 60;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 60;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 20
    if choices(i) == 1
        nChosen(i) = 60;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 60;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 21
    if choices(i) == 2
        nChosen(i) = 40;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 40;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 22
    if choices(i) == 1
        nChosen(i) = 40;
        nNotChosen(i) = 20;
        nOptimal(i) = 1;
    else
        nChosen(i) = 20;
        nNotChosen(i) = 40;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 23
    if choices(i) == 1
        nChosen(i) = 70;
        nNotChosen(i) = 60;
        nOptimal(i) = 1;
    else
        nChosen(i) = 60;
        nNotChosen(i) = 70;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 24
    if choices(i) == 2
        nChosen(i) = 70;
        nNotChosen(i) = 60;
        nOptimal(i) = 1;
    else
        nChosen(i) = 60;
        nNotChosen(i) = 70;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 25
    if choices(i) == 1
        nChosen(i) = 70;
        nNotChosen(i) = 40;
        nOptimal(i) = 1;
    else
        nChosen(i) = 40;
        nNotChosen(i) = 70;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 26
    if choices(i) == 2
        nChosen(i) = 70;
        nNotChosen(i) = 40;
        nOptimal(i) = 1;
    else
        nChosen(i) = 40;
        nNotChosen(i) = 70;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 27
    if choices(i) == 2
        nChosen(i) = 60;
        nNotChosen(i) = 30;
        nOptimal(i) = 1;
    else
        nChosen(i) = 30;
        nNotChosen(i) = 60;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 28
    if choices(i) == 1
        nChosen(i) = 60;
        nNotChosen(i) = 30;
        nOptimal(i) = 1;
    else
        nChosen(i) = 30;
        nNotChosen(i) = 60;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 29
    if choices(i) == 2
        nChosen(i) = 40;
        nNotChosen(i) = 30;
        nOptimal(i) = 1;
    else
        nChosen(i) = 30;
        nNotChosen(i) = 40;
        nOptimal(i) = 0;
    end
elseif stimuli(i) == 30
    if choices(i) == 1
        nChosen(i) = 40;
        nNotChosen(i) = 30;
        nOptimal(i) = 1;
    else
        nChosen(i) = 30;
        nNotChosen(i) = 40;
        nOptimal(i) = 0;
    end
end
end