function FormatForSPSS()
% function FormatForSPSS
% load up the analyses from expt 1
% for each measure, split by condition for patients
% extract controls separately
% replace NaNs with -9999 for SPSS missing data
% write to xlsx to be read into SPSS
% save also into .mat

    load('BehDataOutput.mat')
    [behMat,behMatCont,behNames,behContNames,behAll,behAllNames] = separateLoop(nPatients,nCont,...
        l1,l2,l3,mem1,mem2,mem3,m30M0,m24M0,m24M30,ch80,av20,chAv,novelPairs,novelPairsOld,...
        lowConflictAcc,highConflictAcc,highConflictPos,highConflictNeg);
    
    load('BehFilterOutput.mat')
    %first replace all NaNs with -9999 for SPSS missing values
    [l1FiltNP,l2FiltNP,l3FiltNP,mem1FiltNP,mem2FiltNP,mem3FiltNP,m24M30FiltNP,ch80FiltNP,av20FiltNP,chAvFiltNP,...
        ch80FiltLPNP,av20FiltLPNP,ch80FiltLP,av20FiltLP,ch80FiltLP5050,av20FiltLP5050,...
        ch80FiltLP50,av20FiltLP50,lowConflFilt,highConflFilt,highConflPosFilt,highConflNegFilt] = replaceNaNs(l1FiltNP,l2FiltNP,l3FiltNP,mem1FiltNP,mem2FiltNP,mem3FiltNP,m24M30FiltNP,ch80FiltNP,av20FiltNP,chAvFiltNP,...
        ch80FiltLPNP,av20FiltLPNP,ch80FiltLP,av20FiltLP,ch80FiltLP5050,av20FiltLP5050,...
        ch80FiltLP50,av20FiltLP50,lowConflFilt,highConflFilt,highConflPosFilt,highConflNegFilt);
    
    [behFiltMat,behFiltMatCont,behFiltNames,behFiltContNames,behFiltAll,behFiltAllNames] = separateLoop(nPatients,nCont,...
        l1FiltNP,l2FiltNP,l3FiltNP,mem1FiltNP,mem2FiltNP,mem3FiltNP,m24M30FiltNP,ch80FiltNP,av20FiltNP,chAvFiltNP,...
        ch80FiltLPNP,av20FiltLPNP,ch80FiltLP,av20FiltLP,ch80FiltLP5050,av20FiltLP5050,...
        ch80FiltLP50,av20FiltLP50,lowConflFilt,highConflFilt,highConflPosFilt,highConflNegFilt);
    
    load('AllModelsOutput.mat','SARSABetaFits','SARSAH3BetaFits','QGNBetaFits')
    SarsaLrPos = cell2mat(SARSABetaFits(:,7));
    SarsaLrNeg = cell2mat(SARSABetaFits(:,8));
    SarsaBeta = cell2mat(SARSABetaFits(:,9));
    SarsaH3LrPos = cell2mat(SARSAH3BetaFits(:,7));
    SarsaH3LrNeg = cell2mat(SARSAH3BetaFits(:,8));
    SarsaH3Beta = cell2mat(SARSAH3BetaFits(:,9));
    QGNLrG = cell2mat(QGNBetaFits(:,7));
    QGNLrN = cell2mat(QGNBetaFits(:,8));
    QGNLrBetaG = cell2mat(QGNBetaFits(:,11));
    QGNLrBetaN = cell2mat(QGNBetaFits(:,12));
    [modelMat,modelMatCont,modelNames,modelContNames,modelAll,modelAllNames] = separateLoop(nPatients,nCont,...
        SarsaLrPos,SarsaLrNeg,SarsaBeta,SarsaH3LrPos,SarsaH3LrNeg,SarsaH3Beta,QGNLrG,QGNLrN,QGNLrBetaG,QGNLrBetaN);
    
    load('AssaysOutput.mat')
    assaysPD = [drugType,lPD,num2cell(pOnUpdrs),num2cell(pOffUpdrs),num2cell(LDE),num2cell(yrsSymp),num2cell(yrsDiag)];
    assaysPDNames = {'drug';'hemi';'updrsOn';'updrsOff';'LDE';'yrsSymp';'yrsDiag'};
    assaysAll = [num2cell([[ones(length(pNum),1);zeros(length(cNum),1)],[pNum,cNum]',[pAges,cAges]',yrsEdu,mmse,dass,bis,lars,rei]),gender];
    assaysNames = {'PDCont';'pNum';'ages';'yrsEdu';'mmse';'dassD';'dassA';'dassS';'dass';'bisNP';'bisMotor';'bisCog';'bis';'lars';'larsInt';'larsEm';'larsAct';'larsSelf';'reiRE';'reiRA';'reiEE';'reiEA';'reiR';'reiE';'gender';};
    assaysLong = [num2cell(agesLong),num2cell(yrsEduLong),genderLong,num2cell(mmseLong)];
    assaysLongNames = {'agesLong';'yrsEduLong';'genderLong';'mmseLong'};
    assaysPDLong = [drugTypeLong,num2cell(LDELong),num2cell(yrsSympLong),num2cell(yrsDiagLong)];
    assaysPDLongNames = {'drugTypeLong';'LDELong';'yrsSympLong';'yrsDiagLong'};
    
    load('SleepData.mat','sleep')
    sleepQual = sleep(:,1);
    sleepNight = sleep(:,2);
    sleepDay = sleep(:,3);
    sleepTot = sleep(:,4);
    sleepLat = sleep(:,5);
    [sleepMat,sleepMatCont,sleepNames,sleepContNames,sleepAll,sleepAllNames] = separateLoop(nPatients,nCont,...
        sleepQual,sleepNight,sleepDay,sleepTot,sleepLat);
    
    conditions = sum([strcmp(bothDays,'ONON'),strcmp(bothDays,'ONOFF')*2,strcmp(bothDays,'OFFON')*3,...
        strcmp(bothDays,'OFFOFF')*4,strcmp(bothDays,'CONTCONT')*5],2);
    miscMat = [ppN,d1On,d1Off,d2On,d2Off,dCont,conditions];
    miscNames = {'ppN';'d1On';'d1Off';'d2On';'d2Off';'dCont';'conditions'};
    miscMatNoCont = miscMat(1:(nPPs-nPatients),[1,2,3,4,5,7]);
    miscNoContNames = {'ppNNoCont';'d1OnNoCont';'d1OffNoCont';'d2OnNoCont';'d2OffNoCont';'conditionsNoCont'};
    
    
    allNames = [behNames;behContNames;behAllNames;behFiltNames;behFiltContNames;...
        behFiltAllNames;modelNames;modelContNames;modelAllNames;assaysPDNames;...
        assaysNames;assaysPDLongNames;assaysLongNames;sleepNames;sleepContNames;...
        sleepAllNames;miscNames;miscNoContNames];

    %print everything into xlsx file
    allData = {behMat,behMatCont,behAll,behFiltMat,behFiltMatCont,behFiltAll,...
        modelMat,modelMatCont,modelAll,assaysPD,assaysAll,assaysPDLong,assaysLong,...
        sleepMat,sleepMatCont,sleepAll,miscMat,miscMatNoCont};
    
    PrintToExcel(allData,allNames,'.\SPSS\4CondSPSS.xlsx')

    
    fclose('all');
    fid = fopen('.\SPSS\VariableNames.txt','w');
    for i = 1:length(allNames)
        fprintf(fid,'%s\n',allNames{i});
    end
    fclose(fid);
    save('FormatForSPSS.mat','behMat','behMatCont','behNames','behContNames','behAll','behAllNames','bothDays','ppN',...
        'behFiltMat','behFiltMatCont','behFiltNames','behFiltContNames','behFiltAll','behFiltAllNames',...
        'modelMat','modelMatCont','modelNames','modelContNames','modelAll','modelAllNames',...
        'sleepMat','sleepMatCont','sleepNames','sleepContNames','sleepAll','sleepAllNames',...
        'assaysPD','assaysPDNames','assaysAll','assaysNames','allNames','miscMat','miscNames','allData')
end

function [PD,cont,PDNames,contNames,allData,allNames] = separateLoop(nPts,nCont,varargin)
% separates a vector by conditions, creates names for those new variables
    load('DataFilesData.mat','onOn','onOff','offOn','offOff','dCont')
    j = 1;
    jj = 1;
    PD = zeros(nPts,length(varargin)*4);
    cont = zeros(nCont,length(varargin));
    PDNames = cell(length(varargin)*4,1);
    contNames = cell(length(varargin),1);
    allNames = cell(length(varargin),1);
    allData = zeros(length(varargin{1}),length(varargin));
    for i = 1:length(varargin)
        PD(:,i*4-3:i*4) = condSep(varargin{i}(:,1),onOn,onOff,offOn,offOff);
        PDNames{i*4-3} = sprintf('%sOnOn',inputname(i+2));
        PDNames{i*4-2} = sprintf('%sOnOff',inputname(i+2));
        PDNames{i*4-1} = sprintf('%sOffOn',inputname(i+2));
        PDNames{i*4} = sprintf('%sOffOff',inputname(i+2));
%         j = j + 4;
        cont(:,i) = varargin{i}(dCont);
        contNames{i} = sprintf('%sCont',inputname(i+2));
        allData(:,i) = varargin{i};
        allNames{i} = sprintf('%s',inputname(i+2));
    end
end