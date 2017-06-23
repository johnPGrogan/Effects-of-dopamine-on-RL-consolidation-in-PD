% BehDataAnalysis
% This script loads up all the behavioural data from experiment 1 and
% processes it to some extent

clear all

%get datanames etc from datafiles
load('DataFilesData.mat')
alpha = 0.05;   %alpha criterion for stats
n=length(pDataFilesNoF); %number of sessions
stimuli = NaN(240,1);%preallocation
choices = stimuli;
mStimuli = stimuli;
mChoices = stimuli;
l1P1 = NaN(n,1);%preallocation
l1P2 = l1P1;
l2P1 = l1P1;
l2P2 = l1P1;
l3P1 = l1P1;
l3P2 = l1P1;
m1P1 = l1P1;
m1P2 = l1P1;
m2P1 = l1P1;
m2P2 = l1P1;
m3P1 = l1P1;
m3P2 = l1P1;
ch80 = l1P1;
av20 = l1P1;
ch65 = l1P1;
av35 = l1P1;
novelPairs = NaN(n,4);
ch80Old = l1P1;
av20Old = l1P1;
ch65Old = l1P1;
av35Old = l1P1;
novelPairsOld = NaN(n,6);
ch8020 = l1P1;
ch8065 = l1P1;
ch8035 = l1P1;
ch6520 = l1P1;
ch6535 = l1P1;
ch3520 = l1P1;
lowConflict = l1P1;
highConflict = NaN(n,3);
ch80RT = l1P1;
av20RT = l1P1;
ch65RT = l1P1;
av35RT = l1P1;
p8020RT = l1P1;
p6535RT = l1P1;
p8065RT = l1P1;
p8035RT = l1P1;
p6520RT = l1P1;
p3520RT = l1P1;
allLRT = NaN(240,n);
allLAcc = allLRT;
allLChosen = allLRT;
allLNotChosen = allLRT;
allLCorrect = allLRT;
allLStimuli = allLRT;
allNRT = NaN(48,n);
allNAcc = allNRT;
allNStimuli = allNRT;
allNChoices = allNRT;
allNChosen = allNRT;
allNNotChosen = allNRT;
allMAcc = NaN(120,n);
allMStimuli = allMAcc;
allMChoices = allMAcc;
allMChosen = allMAcc;
allMNotChosen = allMAcc;
allMRT = allMAcc;
%%
for i = 1:n%for each session
    BehDataLoad(i,pDataFilesNoF,pMDataFiles);%load raw data, transform it
    load('BehDataLoadOutput.mat')%load up file made
    
    %use these to get num optimal choices for pair 1 & 2, each block
    l1P1(i) = sum(lOpt1(s1(1:80)))+sum(lOpt1(s2(1:80)));%learning block1, pair 1
    l1P2(i) = sum(lOpt1(s3(1:80)))+sum(lOpt2(s4(1:80)));
    l2P1(i) = sum(lOpt2(s1(81:160)))+sum(lOpt2(s2(81:160)));
    l2P2(i) = sum(lOpt2(s3(81:160)))+sum(lOpt2(s4(81:160)));
    if isempty(lData3) == 0 %if 3rd learning block present
        l3P1(i) = sum(lOpt3(s1(161:240)))+sum(lOpt3(s2(161:240)));
        l3P2(i) = sum(lOpt3(s3(161:240)))+sum(lOpt3(s4(161:240)));
    else 
        l3P1(i) = NaN;
        l3P2(i) = NaN;
    end
    allLAcc(:,i) = [lOpt1;lOpt2;lOpt3];%store acc for l1-3 in one column
    allLStimuli(:,i) = stimuli;%same for stim etc
    allLChosen(:,i) = chosen;
    allLNotChosen(:,i) = notChosen;
    allLCorrect(:,i) = correct;
    allLRT(:,i) = lRT;
    %%  memory blocks
    %num optimal choices for pair 1 & 2, each block
    m1P1(i) = sum(mOpt1(mS1(1:40)))+sum(mOpt1(mS4(1:40)));
    m1P2(i) = sum(mOpt1(mS2(1:40)))+sum(mOpt1(mS3(1:40)));
    if isempty(mData2) == 0%if 30min memory is there
        m2P1(i) = sum(mOpt2(mS1(41:80)))+sum(mOpt2(mS4(41:80)));
        m2P2(i) = sum(mOpt2(mS3(41:80)))+sum(mOpt2(mS2(41:80)));
    else
        m2P1(i) = NaN;
        m2P2(i) = NaN;
    end
    m3P1(i) = sum(mOpt3(mS1(81:120)))+sum(mOpt3(mS4(81:120)));
    m3P2(i) = sum(mOpt3(mS3(81:120)))+sum(mOpt3(mS2(81:120)));
   
    allMAcc(:,i) = mOptimal;
    allMStimuli(:,i) = mStimuli;
    allMChosen(:,i) = mChosen;
    allMNotChosen(:,i) = mNotChosen;
    allMRT(:,i) = mRT;%reaction times
    
    %% novel pairs
    if isempty(nData) == 0  %if data present    
        %get number of optimal choices for each novel pair shown
        %chosen on left in varName below
        p8020 = (nStimuli == 1 & nChoices == 1) | (nStimuli == 2 & nChoices == 2);
        p6535 = (nStimuli == 3 & nChoices == 1) | (nStimuli == 4 & nChoices == 2);
        p8065 = (nStimuli == 5 & nChoices == 1) | (nStimuli == 6 & nChoices == 2);
        p8035 = (nStimuli == 7 & nChoices == 1) | (nStimuli == 8 & nChoices == 2);
        p6520 = (nStimuli == 9 & nChoices == 2) | (nStimuli == 10 & nChoices == 1);
        p3520 = (nStimuli == 11 & nChoices == 2) | (nStimuli == 12 & nChoices == 1);
        p6580 = (nStimuli == 5 & nChoices == 2) | (nStimuli == 6 & nChoices == 1);
        p2035 = (nStimuli == 11 & nChoices == 1) | (nStimuli == 12 & nChoices == 2);
        
        %sum to get number of choices in block
        ch80(i) = sum(p8065 + p8035);
        av20(i) = sum(p6520 + p3520);
        ch65(i) = sum(p6520) + (8 - sum(p8065));
        av35(i) = sum(p8035) + (8 - sum(p3520));
        novelPairs(i,:) = [sum(p8065), sum(p8035), sum(p6520), sum(p3520)];%put into columns
        
        ch8020(i,1) = sum(p8020)/8*100;%make percentages
        ch8065(i,1) = sum(p8065)/8*100;
        ch8035(i,1) = sum(p8035)/8*100;
        ch6520(i,1) = sum(p6520)/8*100;
        ch6535(i,1) = sum(p6535)/8*100;
        ch3520(i,1) = sum(p3520)/8*100;
               
        lowConflict(i,1) = sum(p8035 + p6520);%low conflict trials
        highConflict(i,1:3) = [sum(p8065 + p3520),sum(p8065),sum(p3520)];%high conflict trials
        
        ch80Old(i) = sum(p8020 + p8065 + p8035);%including learning pairs
        av20Old(i) = sum(p8020 + p6520 + p3520);
        ch65Old(i) = sum(p6535 + p6520) + (8 - sum(p8065));
        av35Old(i) = sum(p6535 + p8035) + (8 - sum(p3520));
        novelPairsOld(i,:) = [sum(p8020), sum(p6535), sum(p8065),...
            sum(p8035), sum(p6520), sum(p3520)];
        
        [nChosen,nNotChosen,allNAcc(:,i)] = DataSortNP8020(nStimuli,nChoices,48);%get card chosen, avoided, optimal choices
        
        %put into matrices
        allNStimuli(:,i) = nStimuli;
        allNChoices(:,i) = nChoices;
        allNChosen(:,i) = nChosen;
        allNNotChosen(:,i) = nNotChosen;
        allNRT(:,i) = nRT;
        
        ch80RT(i) = mean(nRT(p8065 | p8035));%RT per choice
        av20RT(i) = mean(nRT(p6520 | p3520));
        ch65RT(i) = mean(nRT(p6520 | p6580));
        av35RT(i) = mean(nRT(p8035 | p2035));

        p8020RT = mean(nRT(nStimuli == 1 | nStimuli == 2));%RT per pair
        p6535RT = mean(nRT(nStimuli == 3 | nStimuli == 4));
        p8065RT = mean(nRT(nStimuli == 5 | nStimuli == 6));
        p8035RT = mean(nRT(nStimuli == 7 | nStimuli == 8));
        p6520RT = mean(nRT(nStimuli == 9 | nStimuli == 10));
        p3520RT = mean(nRT(nStimuli == 11 | nStimuli == 12));
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

m1P1 = m1P1./20.*100;
m1P2 = m1P2./20.*100;
m2P1 = m2P1./20.*100;
m2P2 = m2P2./20.*100;
m3P1 = m3P1./20.*100;
m3P2 = m3P2./20.*100;
%all pairs
mem1 = (m1P1 + m1P2)./2;
mem2 = (m2P1 + m2P2)./2;
mem3 = (m3P1 + m3P2)./2;


ch80 = ch80./16.*100;
av20 = av20./16.*100;
ch65 = ch65./16.*100;
av35 = av35./16.*100;
chAv = ch80 - av20;%difference of two choices
novelPairs = sum(novelPairs,2);
novelPairs = novelPairs/32*100;
novelPairsNoCont = novelPairs(1:length(pNum)*4,:);%no controls data

lowConflictAcc = lowConflict./16.*100;
highConflictAcc = highConflict(:,1)./16.*100;
highConflictPos = highConflict(:,2)./8.*100;
highConflictNeg = highConflict(:,3)./8.*100;

ch80Old = ch80Old./24.*100;
av20Old = av20Old./24.*100;
ch65Old = ch65Old./24.*100;
av35Old = av35Old./24.*100;

novelPairsOld = sum(novelPairsOld,2);
novelPairsOld = novelPairsOld/48*100;
novelPairsNoContOld = novelPairsOld(1:length(pNum)*4,:);

%collate into matrices
learningBlockMeans = [l1,l2,l3];
memoryBlockMeans = [mem1,mem2,mem3];

m0L3 = mem1 - l3;
m30M0 = mem2 - mem1;
m24M0 = mem3 - mem1;
m24M30 = mem3 - mem2;

%RT
oldPairs = (p8020RT + p6535RT)/2;%for learning pairs
newPairs = (p8035RT + p8065RT + p6520RT + p3520RT)/4;%for new pairs


d1On = strcmp('ON', day1);%get boolean vectors for conditions
d1Off = strcmp('OFF', day1);
d2On = strcmp('ON', day2);
d2Off = strcmp('OFF', day2);
dCont = strcmp('CONT', day1);
onOn = strcmp('ONON', bothDays);
onOff = strcmp('ONOFF', bothDays);
offOn = strcmp('OFFON', bothDays);
offOff = strcmp('OFFOFF', bothDays);
cont = strcmp('CONTCONT', bothDays);

nPP = length(pNum) + length(cNum);%number of unique participants
sqrtP = sqrt(length(pNum));%sqrt(number of patients)
sqrtC = sqrt(length(cNum));

save('BehDataOutput.mat')%save