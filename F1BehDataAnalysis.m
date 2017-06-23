% F1BehDataAnalysis
% This loads up and processes the behavioural data from the F1 experiment
% (experiment 2 in the manuscript). 

clear all
load('FDataFiles.mat');%load pps data 
alpha = 0.05;   %alpha criterion for stats
N = length(pF1DataFiles); %number of patients + controls
stimuli = zeros(240,1);%preallocation
choices = zeros(240,1);
mStimuli = zeros(120,1);
mChoices = zeros(120,1);
l1P1 = zeros(N,1);%preallocation
l1P2 = zeros(N,1);
l2P1 = zeros(N,1);
l2P2 = zeros(N,1);
l3P1 = zeros(N,1);
l3P2 = zeros(N,1);
m1P1 = zeros(N,1);
m1P2 = zeros(N,1);
m2P1 = zeros(N,1);
m2P2 = zeros(N,1);
m3P1 = zeros(N,1);
m3P2 = zeros(N,1);
ch80 = zeros(N,1);
av20 = zeros(N,1);
ch65 = zeros(N,1);  
av35 = zeros(N,1);
novelPairs = zeros(N,4);
ch80Old = zeros(N,1);
av20Old = zeros(N,1);
ch65Old = zeros(N,1);  
av35Old = zeros(N,1);
novelPairsOld = zeros(N,6);
p8020 = zeros(48,N);
p8065 = zeros(48,N);
p8035 = zeros(48,N);
p6520 = zeros(48,N);
p6535 = zeros(48,N);
p3520 = zeros(48,N);
allLRT = zeros(240,N);
allLAcc = zeros(240,N);
allLChosen = zeros(240,N);
allLNotChosen = zeros(240,N);
allLCorrect = zeros(240,N);
allLStimuli = zeros(240,N);
allNRT = zeros(48,N);
allNAcc = zeros(48,N);
allNStimuli = zeros(48,N);
allNChoices = zeros(48,N);
allNChosen = zeros(48,N);
allNNotChosen = zeros(48,N);
ch8020 = zeros(N,1);
ch8065 = zeros(N,1);
ch8035 = zeros(N,1);
ch6520 = zeros(N,1);
ch6535 = zeros(N,1);
ch3520 = zeros(N,1);
lowConflict = zeros(N,1);
highConflict = zeros(N,3);
for i = 1:N%for each session
    F1BehLoad(i,pF1DataFiles);%loads data into vars
    load('F1BehDataLoad.mat')%load up that data
    
    %use these to get num optimal choices for pair 1 & 2, each block
    l1P1(i) = sum(lOpt1(s1(1:80)))+sum(lOpt1(s2(1:80)));%learning block1, pair 1
    l1P2(i) = sum(lOpt1(s3(1:80)))+sum(lOpt2(s4(1:80)));
    l2P1(i) = sum(lOpt2(s1(81:160)))+sum(lOpt2(s2(81:160)));
    l2P2(i) = sum(lOpt2(s3(81:160)))+sum(lOpt2(s4(81:160)));
    if isempty(lData3) == 0 %if L3 block was done
        l3P1(i) = sum(lOpt3(s1(161:240)))+sum(lOpt3(s2(161:240)));
        l3P2(i) = sum(lOpt3(s3(161:240)))+sum(lOpt3(s4(161:240)));
    else %if L3 block missing
        l3P1(i) = 0;
        l3P2(i) = 0;
    end
    
    allLAcc(:,i) = [lOpt1;lOpt2;lOpt3];%store acc for l1-3 in each col
    allLStimuli(:,i) = stimuli;%same for stim etc
    allLChosen(:,i) = chosen;
    allLNotChosen(:,i) = notChosen;
    allLCorrect(:,i) = correct;
    allLRT(:,i) = lRT;
    
    
    %%novel pairs%%%
    if isempty(nData) == 0  %if not missing
        %get number of optimal for each novel pair
        p8020(:,i) = (nStimuli == 1 & nChoices == 1) | (nStimuli == 2 & nChoices == 2);
        p6535(:,i) = (nStimuli == 3 & nChoices == 1) | (nStimuli == 4 & nChoices == 2);
        p8065(:,i) = (nStimuli == 5 & nChoices == 1) | (nStimuli == 6 & nChoices == 2);
        p8035(:,i) = (nStimuli == 7 & nChoices == 1) | (nStimuli == 8 & nChoices == 2);
        p6520(:,i) = (nStimuli == 9 & nChoices == 2) | (nStimuli == 10 & nChoices == 1);
        p3520(:,i) = (nStimuli == 11 & nChoices == 2) | (nStimuli == 12 & nChoices == 1);
        
        ch8020(i,1) = sum(p8020(:,i))/8*100;%as percentage
        ch8065(i,1) = sum(p8065(:,i))/8*100;
        ch8035(i,1) = sum(p8035(:,i))/8*100;
        ch6520(i,1) = sum(p6520(:,i))/8*100;
        ch6535(i,1) = sum(p6535(:,i))/8*100;
        ch3520(i,1) = sum(p3520(:,i))/8*100;
        
        %sum to get variables
        ch80(i) = sum(p8065(:,i) + p8035(:,i));
        av20(i) = sum(p6520(:,i) + p3520(:,i));
        ch65(i) = sum(p6520(:,i)) + (8 - sum(p8065(:,i)));
        av35(i) = sum(p8035(:,i)) + (8 - sum(p3520(:,i)));
        novelPairs(i,:) = [sum(p8065(:,i)), sum(p8035(:,i)),...
            sum(p6520(:,i)), sum(p3520(:,i))];%put in columns
        
        ch80Old(i) = sum(p8020(:,i) + p8065(:,i) + p8035(:,i));%measures including learning pairs
        av20Old(i) = sum(p8020(:,i) + p6520(:,i) + p3520(:,i));
        ch65Old(i) = sum(p6535(:,i) + p6520(:,i)) + (8 - sum(p8065(:,i)));
        av35Old(i) = sum(p6535(:,i) + p8035(:,i)) + (8 - sum(p3520(:,i)));
        novelPairsOld(i,:) = [sum(p8020(:,i)), sum(p6535(:,i)), sum(p8065(:,i)),...
            sum(p8035(:,i)), sum(p6520(:,i)), sum(p3520(:,i))];
        
        lowConflict(i,1) = sum(p8035(:,i) + p6520(:,i));%low conflict between probabilities
        highConflict(i,1:3) = [sum(p8065(:,i) + p3520(:,i)),sum(p8065(:,i)),sum(p3520(:,i))];%high conflict
        
        [nChosen,nNotChosen,allNAcc(:,i)] = DataSortNP8020(nStimuli,nChoices,48);%get novel pairs chosen, not chosen and optimal

        allNStimuli(:,i) = nStimuli;%store in matrices
        allNChoices(:,i) = nChoices;
        allNChosen(:,i) = nChosen;
        allNNotChosen(:,i) = nNotChosen;
        allNRT(:,i) = nRT;
    end
end

%turn summed optimal scores into percentages
l1P1 = l1P1./40.*100;
l1P2 = l1P2./40.*100;
l2P1 = l2P1./40.*100;
l2P2 = l2P2./40.*100;
l3P1 = l3P1./40.*100;
l3P2 = l3P2./40.*100;
%all pairs
l1 = (l1P1+l1P2)./2;
l2 = (l2P1+l2P2)./2;
l3 = (l3P1+l3P2)./2;


ch80 = ch80./16.*100;
av20 = av20./16.*100;
ch65 = ch65./16.*100;
av35 = av35./16.*100;

novelPairs = sum(novelPairs,2);
novelPairs = novelPairs/32*100;
% novelPairs = novelPairs';
novelPairsNoCont = novelPairs(1:length(pF1Num),:);



ch80Old = ch80Old./24.*100;
av20Old = av20Old./24.*100;
ch65Old = ch65Old./24.*100;
av35Old = av35Old./24.*100;

novelPairsOld = sum(novelPairsOld,2);
novelPairsOld = novelPairsOld/48*100;
novelPairsNoContOld = novelPairsOld(1:length(pF1Num),:);

p8020 = sum(p8020)'/8*100;%learning pairs from novel pairs task
p6535 = sum(p6535)'/8*100;

accFilt = p8020>50;%filtering vector - keep those above 50% on AB in novel pairs
ch80Filt = ch80(accFilt);%keep only ones that pass filtering
av20Filt = av20(accFilt);
fCondsFilt = f1Conds(accFilt);%filter conditions too

%collate into matrices
learningBlockMeans = [l1,l2,l3];

lowConflictAcc = lowConflict./16.*100;
highConflictAcc = highConflict(:,1)./16.*100;
highConflictPos = highConflict(:,2)./8.*100;
highConflictNeg = highConflict(:,3)./8.*100;

chDiff60 = ch8020;%difference in scores
chDiff45 = (ch8035 + ch6520)/2;
chDiff30 = ch6535;
chDiff15 = (ch8065 + ch3520)/2;

npAccF1 = [nanmean(allNAcc)*100]';%overall np accuracy
npAccF1Filt = npAccF1(accFilt);%filtered blocks only

save('F1BehDataOutput.mat')%save