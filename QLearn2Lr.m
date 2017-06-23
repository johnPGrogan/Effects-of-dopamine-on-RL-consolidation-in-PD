function [negLogLike, subjAcc, POK] = QLearn2Lr (param, chosen, notChosen, correct,initP)
% function [negloglike, subj_acc, POK] = QLearn2Lr (param, chosen, notchosen, correct, initP)
%
% Calculates lieklihood of the data given Q-learning model with two
% learning rates
% Inputs:
% param = vector of parameters: [positive learning rate, negative learning
% rate, beta]
% chosen = vector of the stimulus chosen on each trial
% notChosen = vector of the stim not chosen on each trial
% correct = vector of 1 if correct (positive feedback), 0 if not
% initP = optional argument, if passed it initialises the expected
% probabilities to 0 rather than 0.5
% Outputs:
% negloglike - negative log likelihood
% subjAcc - subjective accuracy, defined as a fraction of trials in which the stimulus with higher 
%             probability was chosen
% POK - subjective probabilities at the end of the learing session

%set these now in case the parameters are out of bounds
negLogLike=1000000;
subjAcc=0;
POK = 0;
if min (param) < 0  %penalty for negative parameters 
    negLogLike = 1000000 - min (param) * 100;
elseif max (param(1:2)) > 1 %or lrs > 1
    negLogLike = 1000000 + max (param(1:2)) * 100;
else %otherwise run model fitting
    
    lrPos = param(1);%get pos learning rate
    lrNeg = param(2);%get neg learning rate
    
    if length(param) < 3 %if beta not given
        beta = 1;%set to 1
    else    %otherwise use beta given
        beta = param(3);
    end
    
    N = length(chosen);%number of trials
    
    if nargin==5%if initP given,
        POK = zeros(N+1,6);  %initialise expected probabilities to 0
    else
        POK = ones(N+1,6)/2;  %else initialise expected probabilities to 0.5
    end
    
    negLogLike = -log(betapdf(lrPos,1,2)) - log(betapdf(lrNeg,1,2));%biases initial nll - lower lrs = lower nll (better)

    %iterate through trials;
    for i = 1:N
        P1i = POK(i,chosen(i));%get expected probabilities of presented stimuli
        P2i = POK(i,notChosen(i));
        P1 = exp(beta*P1i) / (exp(beta*P1i) + exp(beta*P2i));%softmax them to make them sum to 1
        P2 = exp(beta*P2i) / (exp(beta*P1i) + exp(beta*P2i));
	    negLogLike = negLogLike - log(P1);%minus the log expected prob of chosen stim
        subjAcc = subjAcc + (P1 > P2);  %increase subjAcc if chosen has larger P

        if correct(i) > 0
            lr = lrPos;%+ve lr for +ve fb            
        else
            lr = lrNeg;%-ve lr for -ve fb
        end
        
        delta = correct(i) - POK(i,chosen(i));%reward prediction error
        POK(i+1,:) = POK(i,:);%copy all expected probabilities for next trial
        POK(i+1,chosen(i)) = POK(i,chosen(i)) + lr * delta;%update the expected probability of the chosen stim
    end

    subjAcc = subjAcc / N;%average subjacc to get percentage
end