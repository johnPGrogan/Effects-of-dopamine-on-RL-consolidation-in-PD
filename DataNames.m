% DataNames
% gets names of txt files (data from experiments)
% sorts into different experiments

if ~exist('excludePts')%to exclude any participants data
    excludePts = 1234;
end


x = dir ('*.txt');%get all  txt files in this folder
x = struct2cell(x);%convert to cells
x(2:5,:) = [];%delete extra stuff - just keep file names
x = x';%make a column
%exclude any people you need to:
excludeX = regexp(x,num2str(excludePts));%find ones to exclude
excludeXInds = ~cellfun(@isempty,excludeX);%get indices
x(excludeXInds) = [];%exclude them

a=regexp(x,'P1[78]|P13|P2[78]');%get F2 data - by pp nums
b=cellfun(@isempty,a);%turn to bools
F2List = x(b==0);%get all F2 files
x=x(b);%remove the F2 files from main list

a = regexp(x,'L1');%get l1 blocks
b = cellfun(@isempty,a);%get nonL1
block1 = x(b==0);%get L1 only

a = regexp(x,'L2');%2nd learning blocks
b = cellfun(@isempty,a);
block2 = x(b==0);

a = regexp(x,'L3');%3rd learning blocks
b = cellfun(@isempty,a);
block3 = x(b==0);

pDataFiles = [block1,block2,block3];%store together

a = regexp(pDataFiles(:,1), '[E F]');%get F1 files - they all have E or F
b = cellfun(@isempty,a);
pDataFilesNoF = pDataFiles(b,1);%remove F1 files from L1

a = regexp(pDataFiles(:,2), '[E F]');%remove F1 files from L2
b = cellfun(@isempty,a);
pDataFilesNoF(:,2) = pDataFiles(b,2);

a = regexp(pDataFiles(:,1), '[E F]');%remove F1 files from L3
b = cellfun(@isempty,a);
pDataFilesNoF(:,3) = pDataFiles(b,3);




a = regexp(x,'M1');%immediate memory files in expt 1
b = cellfun(@isempty,a);
m1 = x(b==0);

a = regexp(x,'M2');%30 min memory files in expt 1
b = cellfun(@isempty,a);
m2 = x(b==0);

a = regexp(x,'M3');%24hr memory files in expt 1
b = cellfun(@isempty,a);
m3 = x(b==0);

a = regexp(x,'N');%novel pairs files
b = cellfun(@isempty,a);
n1 = x(b==0);
a = regexp(n1, '[E F]');%find F1 files
b=cellfun(@isempty,a);%find ones which don't have E or F
n1(b==0) = [];%remove ones with E or F from n1

pMDataFiles = [m1,m2,m3,n1];%group memory and novel pairs files

a = regexp(x,'E');%get F1 files
b = cellfun(@isempty,a);
E = x(b==0);

a = regexp(x,'F');%get other F1 files
b = cellfun(@isempty,a);
F = x(b==0);

pF1DataFilesAll = sort([E;F]);%sort by pnum

s = ['L1.txt';'L2.txt';'L3.txt';'N1.txt'];%file endings - 3 learning blocks + novel pairs
for i = 1:4%each block into separate columns
    pF1DataFiles(:,i) = pF1DataFilesAll(~cellfun(@isempty,regexp(pF1DataFilesAll,s(i,:))));
end

%%saveNames - not used any more
pSaveNames = cell(length(pDataFiles),1);    %preallocate
for i=1:length(pDataFiles)
     a=sscanf(pDataFiles{i,1},'P%d%cL%d.txt');
     pSaveNames{i,1} = sprintf('P%d%cLpars.mat', a(1), a(2));
end

%% F2 data

a = regexp(F2List,'L');%get F2 learning files
b = cellfun(@isempty,a);
F2L = F2List(b==0);%learning files
F2N = F2List(b);%novel pairs

pF2DataFiles = [F2L,F2N];%columns

pF2SaveNames = cell(length(pF2DataFiles),1);    %preallocate
for i=1:length(pF2DataFiles)%gets names for saving pars from model fits
     a=sscanf(pF2DataFiles{i,1},'P%d%cL%d.txt');
     pF2SaveNames{i,1} = sprintf('P%d%cLpars.mat', a(1), a(2));
end
