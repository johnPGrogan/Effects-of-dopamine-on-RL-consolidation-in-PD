% F2BehDataAnalysis
% loads up and processes F2 behavioural data (from experiment 3)

clear all

load('FDataFiles.mat');%load pps data 

alpha = 0.05;   %alpha criterion for stats
[pr, pc] = size(pF2DataFiles);
N=pr; %number of sessions

ch80F2 = zeros(N,1);%preallocate
av20F2 = zeros(N,1);
ch70F2 = zeros(N,1);  
av30F2 = zeros(N,1);
ch60F2 = zeros(N,1);  
av40F2 = zeros(N,1);
ch80F2Old = zeros(N,1);
av20F2Old = zeros(N,1);
ch70F2Old = zeros(N,1);  
av30F2Old = zeros(N,1);
ch60F2Old = zeros(N,1);  
av40F2Old = zeros(N,1);

novelPairsOld = zeros(N,6);
p8020F2 = zeros(90,N);
p7030F2 = zeros(90,N);
p6040F2 = zeros(90,N);
p8070F2 = zeros(90,N);
p8060F2 = zeros(90,N);
p8040F2 = zeros(90,N);
p8030F2 = zeros(90,N);
p7060F2 = zeros(90,N);
p7040F2 = zeros(90,N);
p7020F2 = zeros(90,N);
p6030F2 = zeros(90,N);
p6020F2 = zeros(90,N);
p4030F2 = zeros(90,N);
p4020F2 = zeros(90,N);
p3020F2 = zeros(90,N);

blockAccF2 = NaN(N,3,7);
nBlocksF2 = zeros(N,1);
lAccF2 = cell(N,3);
lFinalF2 = zeros(N,3);

%rt
allLRT = NaN(420,N);
allLAcc = NaN(420,N);
allLChosen = NaN(420,N);
allLNotChosen = NaN(420,N);
allLCorrect = NaN(420,N);
allLStimuli = NaN(420,N);
allNRT = NaN(90,N);
allNAcc = NaN(90,N);
allNStimuli = NaN(90,N);
allNChoices = NaN(90,N);
allNChosen = NaN(90,N);
allNNotChosen = NaN(90,N);
ch8020 = zeros(N,1);
ch8020 = ch8020;
ch8070 = ch8020;
ch8030 = ch8020;
ch8060 = ch8020;
ch8040 = ch8020;
ch7030 = ch8020;
ch7060 = ch8020;
ch7040 = ch8020;
ch7020 = ch8020;
ch6040 = ch8020;
ch6030 = ch8020;
ch6020 = ch8020;
ch4030 = ch8020;
ch4020 = ch8020;
ch3020 = ch8020;

lowConflict = zeros(N,1);
highConflict = zeros(N,3);

for i = 1:N%for each session
    F2BehLoad(i,pF2DataFiles);%loads data into vars
    load('F2BehDataLoad.mat')%load up that data
    
    nBlocksF2(i,1) = nBlock;%number of blocks completed
    n = length(stimuli);%number of trials
    
    lAccF2(i,1) = {(s1 & optimal) | (s2 & optimal)};%learning acc on pair AB
    lAccF2(i,2) = {(s3 & optimal) | (s4 & optimal)};%CD
    lAccF2(i,3) = {(s5 & optimal) | (s6 & optimal)};%EF
        
    for blockCount = 1:nBlocksF2(i)%for each block
        for pairCount = 1:3%get acc on each pair per block
            blockAccF2(i,pairCount,blockCount) = nansum(lAccF2{i,pairCount}((blockCount-1)*60+1:blockCount*60,:))*5;
        end
    end
    allLAcc(1:n,i) = optimal;%store acc for l1-3 in each col
    allLStimuli(1:n,i) = stimuli;%same for stim etc
    allLChosen(1:n,i) = chosen;
    allLNotChosen(1:n,i) = notChosen;
    allLCorrect(1:n,i) = correct;
    allLRT(1:n,i) = lRT;
    
    %%novel pairs%%%
    if isempty(nData) == 0  %if novel pairs data present
        %get number of optimal for each novel pair
        p8020F2(:,i) = (nStimuli == 1 & nChoices == 1) | (nStimuli == 2 & nChoices == 2);%1
        p7030F2(:,i) = (nStimuli == 3 & nChoices == 1) | (nStimuli == 4 & nChoices == 2);%2
        p6040F2(:,i) = (nStimuli == 5 & nChoices == 1) | (nStimuli == 6 & nChoices == 2);%3
        p8070F2(:,i) = (nStimuli == 7 & nChoices == 1) | (nStimuli == 8 & nChoices == 2);%4
        p8060F2(:,i) = (nStimuli == 9 & nChoices == 1) | (nStimuli == 10 & nChoices == 2);%5
        p8040F2(:,i) = (nStimuli == 11 & nChoices == 1) | (nStimuli == 12 & nChoices == 2);%6
        p8030F2(:,i) = (nStimuli == 13 & nChoices == 1) | (nStimuli == 14 & nChoices == 2);%7
        p7060F2(:,i) = (nStimuli == 15 & nChoices == 1) | (nStimuli == 16 & nChoices == 2);%8
        p7040F2(:,i) = (nStimuli == 17 & nChoices == 1) | (nStimuli == 18 & nChoices == 2);%9
        p7020F2(:,i) = (nStimuli == 19 & nChoices == 1) | (nStimuli == 20 & nChoices == 2);%10
        p6030F2(:,i) = (nStimuli == 21 & nChoices == 1) | (nStimuli == 22 & nChoices == 2);%11
        p6020F2(:,i) = (nStimuli == 23 & nChoices == 1) | (nStimuli == 24 & nChoices == 2);%12
        p4030F2(:,i) = (nStimuli == 25 & nChoices == 1) | (nStimuli == 26 & nChoices == 2);%13
        p4020F2(:,i) = (nStimuli == 27 & nChoices == 1) | (nStimuli == 28 & nChoices == 2);%14
        p3020F2(:,i) = (nStimuli == 29 & nChoices == 1) | (nStimuli == 30 & nChoices == 2);%15
        
        ch8020(i,1) = sum(p8020F2(:,i))/6*100;%as percentage
        ch8070(i,1) = sum(p8070F2(:,i))/6*100;
        ch8030(i,1) = sum(p8030F2(:,i))/6*100;
        ch8060(i,1) = sum(p8060F2(:,i))/6*100;
        ch8040(i,1) = sum(p8040F2(:,i))/6*100;
        ch7030(i,1) = sum(p7030F2(:,i))/6*100;
        ch7060(i,1) = sum(p7060F2(:,i))/6*100;
        ch7040(i,1) = sum(p7040F2(:,i))/6*100;
        ch7020(i,1) = sum(p7020F2(:,i))/6*100;
        ch6040(i,1) = sum(p6040F2(:,i))/6*100;
        ch6030(i,1) = sum(p6030F2(:,i))/6*100;
        ch6020(i,1) = sum(p6020F2(:,i))/6*100;
        ch4030(i,1) = sum(p4030F2(:,i))/6*100;
        ch4020(i,1) = sum(p4020F2(:,i))/6*100;
        ch3020(i,1) = sum(p3020F2(:,i))/6*100;
        
        
        %sum to get number of choices and avoids
        ch80F2(i) = nansum(p8070F2(:,i) + p8030F2(:,i) + p8060F2(:,i) + p8040F2(:,i));
        av20F2(i) = nansum(p7020F2(:,i) + p3020F2(:,i) + p6020F2(:,i) + p4020F2(:,i));
        ch70F2(i) = nansum(p7020F2(:,i) + p7040F2(:,i) + p7060F2(:,i)) + (6 - nansum(p8070F2(:,i)));
        av30F2(i) = nansum(p8030F2(:,i) + p6030F2(:,i) + p4030F2(:,i)) + (6 - nansum(p3020F2(:,i)));
        ch60F2(i) = nansum(p6020F2(:,i) + p6030F2(:,i)) + (12 - nansum(p8060F2(:,i) + p8060F2(:,i)));
        av40F2(i) = nansum(p8040F2(:,i) + p7040F2(:,i)) + (12 - nansum(p4020F2(:,i) + p4030F2(:,i)));
        
        %now with learning pairs included   
        ch80F2Old(i) = nansum(p8020F2(:,i) + p8070F2(:,i) + p8030F2(:,i) + p8060F2(:,i) + p8040F2(:,i));
        av20F2Old(i) = nansum(p8020F2(:,i) + p7020F2(:,i) + p3020F2(:,i) + p6020F2(:,i) + p4020F2(:,i));
        ch70F2Old(i) = nansum(p7030F2(:,i) + p7020F2(:,i) + p7040F2(:,i) + p7060F2(:,i)) + (6 - nansum(p8070F2(:,i)));
        av30F2Old(i) = nansum(p7030F2(:,i) + p8030F2(:,i) + p6030F2(:,i) + p4030F2(:,i)) + (6 - nansum(p3020F2(:,i)));
        ch60F2Old(i) = nansum(p6040F2(:,i) + p6020F2(:,i) + p6030F2(:,i)) + (12 - nansum(p8060F2(:,i) + p7060F2(:,i)));
        av40F2Old(i) = nansum(p6040F2(:,i) + p8040F2(:,i) + p7040F2(:,i)) + (12 - nansum(p4020F2(:,i) + p4030F2(:,i)));

        lowConflict(i,1) = sum(p8030F2(:,i) + p8040F2(:,i) + p7020F2(:,i) + p6020F2(:,i));%big difference between probs of cards
        highConflict(i,1:3) = [sum(p8070F2(:,i) + p8060F2(:,i) + p7060F2(:,i) + p3020F2(:,i) + p4020F2(:,i) + p4030F2(:,i)),sum(p8070F2(:,i) +...
            p8060F2(:,i) + p7060F2(:,i)), sum(p3020F2(:,i) + p4020F2(:,i) + p4030F2(:,i))];%little difference = high conflict

        n = length(nStimuli);%number of trials
        [nChosen,nNotChosen,nAcc] = DataSortNPF28020(nStimuli,nChoices,n);%get chosen,notchosen,acc
        
        allNStimuli(1:n,i) = nStimuli;%put in matrices
        allNChoices(1:n,i) = nChoices;
        allNChosen(1:n,i) = nChosen;
        allNNotChosen(1:n,i) = nNotChosen;
        allNRT(1:n,i) = nRT;
        allNAcc(1:n,i) = nAcc;
    end
end

%get accuracy of last learning block per pp
for i = 1:N
    lFinalF2(i,:) = blockAccF2(i,:,nBlocksF2(i));
end
lFinalF2(:,4) = mean(lFinalF2,2);


ch80F2100 = ch80F2./24.*100;%percentages
av20F2100 = av20F2./24.*100;
ch70F2100 = ch70F2./24.*100;
av30F2100 = av30F2./24.*100;
ch60F2100 = ch60F2./24.*100;
av40F2100 = av40F2./24.*100;

ch80F2Old100 = ch80F2Old./30.*100;
av20F2Old100 = av20F2Old./30.*100;
ch70F2Old100 = ch70F2Old./30.*100;
av30F2Old100 = av30F2Old./30.*100;
ch60F2Old100 = ch60F2Old./30.*100;
av40F2Old100 = av40F2Old./30.*100;

p8020F2100 = sum(p8020F2)'/6*100;%learning pairs from novel pairs task
p7030F2100 = sum(p7030F2)'/6*100;
p6040F2100 = sum(p6040F2)'/6*100;
npF2LP = mean([p8020F2100,p7030F2100,p6040F2100],2);
npF2LP_Final = npF2LP-lFinalF2(:,4);%change in learning pairs from learning to novel pairs test

accFiltF2 = p8020F2100>50;%indices to keep only those aboe 50% on p8020
ch80FiltF2 = ch80F2100(accFiltF2);
av20FiltF2 = av20F2100(accFiltF2);
f2CondsFilt = f2Conds(accFiltF2);
npF2LPFilt = npF2LP(accFiltF2);
npF2LPFilt_Final = npF2LP_Final(accFiltF2);
nFiltPass = sum(p8020F2100>50);%get number of blocks that pass
nFiltPassOn = sum(p8020F2100(f2On)>50);%number of on blocks to pass
nFiltPassOF2 = sum(p8020F2100(f2Off)>50);%num off blocks to pass

lowConflictAcc = lowConflict./24.*100;%percentages
highConflictAcc = highConflict(:,1)./36.*100;
highConflictPos = highConflict(:,2)./18.*100;
highConflictNeg = highConflict(:,3)./18.*100;

chDiff60 = ch8020;%difference in probs
chDiff50 = (ch8030 + ch7030)/2;
chDiff40 = (ch8040 + ch6020)/2;
chDiff30 = (ch6030 + ch7040)/2;
chDiff20 = (ch8060 + ch4020 + ch6040)/3;
chDiff10 = (ch8070 + ch7060 + ch4030 + ch3020)/4;

npAccF2 = [nanmean(allNAcc)*100]';%overall np accuracy
npAccF2Filt = npAccF2(accFiltF2);%filter

nPts = length(pF2Num);%number of patients
nCont = length(cF2Num);%number of controls

sessVec = [repmat([1;2],nPts,1);NaN(nCont,1)];%session order
save('F2BehDataOutput.mat')