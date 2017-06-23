function FDataFiles
% function FDataFiles
% gets/sets metadata (e.g. conditions, ages) for F1 and F2 experiments
% gets file names for datafiles

%set metadata
% F1 - experiment 2
pF1Num = [152, 153];%patient numbers of psp tested
f1LPD = {'L';'LR';};%whether left or right hemisphere of brain affected first
pF1Ages = [74 58];%ages of patients
cF1Num = [250, 251];%controls numbers
f1Session = ['E';'F'];%session labels for datafiles
cF1Ages = [58 55];%control ages
%conditions for each session - one cell per session, PD first (2 per 
% patient), then controls
f1Conds = {'ON', 'OFF', 'ON', 'OFF','CONT','CONT'};%CONDITIONS OF BOTH BLOCK
f1On = strcmp(f1Conds, 'ON')';%get boolean vectors for each cond
f1Off = strcmp(f1Conds, 'OFF')';
f1Cont = strcmp(f1Conds, 'CONT')';


%F2 - experiment 3
pF2Num = [131, 132];%patient numbers
cF2Num = [270, 271];%control numbers
%conditions - PD (2 per person) then controls
f2Conds = {'ON','OFF','OFF','ON','CONT','CONT'};
pF2Ages = [69,76];%patient ages
f2LPD = {'LR';'LR'};%which hemisphere of brain affected most - based on UPDRS
cF2Ages = [60, 66];%control ages
f2On = strcmp(f2Conds, 'ON')';%boolean vectors for codnitions
f2Off = strcmp(f2Conds, 'OFF')';
f2Cont = strcmp(f2Conds, 'CONT')';

DataNames%get names of data files
save('FDataFiles.mat')%save
end
