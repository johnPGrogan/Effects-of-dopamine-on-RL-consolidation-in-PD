function [pNum, cNum, condi, day1, day2, pDataFiles, pSaveNames,pMDataFiles,bothDays,fConds, pDataFilesNoF] = DataFiles
% function [pNum, cNum, condi, day1, day2, pDataFiles, pSaveNames,pMDataFiles,bothDays,fConds, pDataFilesNoF] = DataFiles
% loads up names of text files, sets metadata for experiment 1

excludePts = 123456789;%pNum of anyone to exclude

pNum = [101,102];   %patient IDs
cNum = [205, 206]; %control IDs
for i = 1:length(pNum)%for each patient
    ppN((i-1)*4+1:i*4,1) = pNum(i);%repeat pNum 4 times - one per cond
end
ppN(end+1:end+length(cNum),1) = cNum;%put control IDs on end

excludePpN = ppN==excludePts;%remove any excluded patients
excludePNum = pNum==excludePts;%remove from this too

pNum(excludePNum) = [];
ppN(excludePpN) = [];

condi = ['A';'B';'C';'D'];   %letters of each version
conds = {'ONON';'ONOFF';'OFFON';'OFFOFF'};%names of each condition
drug = {'DAL';'DA';};%drug types for pps
lPD = {'L';'LR';};%which hemisphere PD is primarily in (opposite of side w/highest UPDRS)
drug(excludePNum) = [];%exclude any needed
lPD(excludePNum) = [];

blockNo=1:3;   %learning block
pDataFiles = cell((length(pNum)*length(condi)),3); %preallocate
pSaveNames = cell((length(pNum)*length(condi)),1);    %preallocate
pMDataFiles = cell((length(pNum)*length(condi)),4);   %preallocate
pAges = [74, 58, 86, 71, 72, 59, 60, 82, 70, 71, 74, 68, 90, 65, 73,67, 73, 68, 79];%ages of pts
cAges = [78, 78, 70, 72, 83, NaN, NaN,75, 91, 68, 63, 57, 49, 68, 68, 74,66, 79];%ages of controls - 2 missing
pAges(excludePNum) = [];%exclude any

%create matrices where each line has the meds conditions for a session -
%day 1 condition
day1 = {'ON'; 'OFF'; 'OFF'; 'ON';...
'ON'; 'OFF'; 'OFF'; 'ON';...
'CONT';'CONT';};
%day 2 cond
day2 = {'ON'; 'ON'; 'OFF'; 'OFF';...
'OFF'; 'OFF'; 'ON'; 'ON';...
'CONT';'CONT';};
day1(excludePpN) = [];%exclude any
day2(excludePpN) = [];

bothDays = strcat(day1, day2);%join to get both days in one mat
%get boolean vectors for each cond
d1On = strcmp('ON', day1);
d1Off = strcmp('OFF', day1);
d2Off = strcmp('OFF', day2);
d2On = strcmp('ON', day2);
dCont = strcmp('CONT', day1);
onOn = strcmp('ONON', bothDays);
onOff = strcmp('ONOFF', bothDays);
offOn = strcmp('OFFON', bothDays);
offOff = strcmp('OFFOFF', bothDays);

nPPs = length(bothDays);%number of sessions
nPatients = length(pNum);%number of patients
nCont = length(cNum);%number of controls
sqrtP = sqrt(nPatients);%sqrt of numbers for SEM calculations later
sqrtC = sqrt(nCont);

DataNames%get names of files

save('DataFilesData.mat')%save
end
