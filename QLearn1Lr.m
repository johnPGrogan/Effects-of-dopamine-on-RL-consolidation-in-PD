function [negLogLike, subjAcc, POK] = QLearn1Lr (param, chosen, notChosen, correct,initP)
% function [negloglike, subj_acc, POK] = QLearn1Lr (param, chosen, notchosen, correct, initP)
%
% Calculates lieklihood of the data given Q-learning model with one learning rate
% Inputs:
% param = vector of parameters: [learning rate, beta]
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
elseif (param(1)) > 1 %or learning rate > 1
    negLogLike = 1000000 + (param(1)) * 100;
else%if pars are in bounds, run model
    
    lr = param(1);%get learning rate
    if length(param) < 2%if beta is given, get beta, else set to 1
        beta = 1;
    else
        beta = param(2);
    end
    N = length (chosen);%number of trials
    if nargin==5%if initP is given
        POK = zeros(1,6);  %initialise expected probabilities to 0
    else
        POK = ones(1,6)/2;  %initialise expected probabilities to 0.5
    end
    
    negLogLike = -log(betapdf(lr,1,2)) - log(betapdf(lr,1,2));%starting penalty for larger learning rates

    %iterate through trials
    for i = 1:N
        P1i = POK(chosen(i));%get expected probs for each stim shown
        P2i = POK(notChosen(i));
        P1 = exp(beta*P1i) / (exp(beta*P1i) + exp(beta*P2i));%softmax them 
        P2 = exp(beta*P2i) / (exp(beta*P1i) + exp(beta*P2i));
	    negLogLike = negLogLike - log(P1);%update nll by log of probability of chosen stim being chosen
        subjAcc = subjAcc + (P1 > P2);  %increase subjAcc if chosen stim has larger probability

        %update expected prob for chosen stim
        POK(chosen(i)) = POK(chosen(i)) + lr * (correct(i) - POK(chosen(i)));%last bit is delta
    end

    subjAcc = subjAcc / N;%average subjAcc to get percentage
end