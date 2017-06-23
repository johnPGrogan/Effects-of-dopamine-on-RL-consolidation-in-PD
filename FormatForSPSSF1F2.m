function FormatForSPSSF1F2()
% function FormatForSPSSF1F2()
% load up the analyses from expts 2 and 3
% for each measure, split by condition for patients
% extract controls separately
% replace NaNs with -9999 for SPSS missing data
% write to xlsx to be read into SPSS
% save also into .mat


    load('F1BehGraphsOutput.mat')
    nPtsF1 = length(pF1Num);
    nContF1 = length(cF1Num);
    allF1Nums = [pF1Num';cF1Num'];
    [f1BehMatPD,f1BehMatCont,f1BehNamesPD,f1BehNamesCont,f1BehAll,f1BehAllNames] = separateLoop('f1',f1On,f1Off,f1Cont,nPtsF1,nContF1,...
        l1,l2,l3,ch80,av20,npF1LP,f1ChAvRatio,npAccF1);
    %filtered
    [l1Filt,l2Filt,l3Filt,ch80Filt,av20Filt,npF1LPFilt,f1ChAvRatioFilt,npAccF1Filt] = replaceNaNs(accFilt,l1,l2,l3,ch80,av20,npF1LP,f1ChAvRatio,npAccF1);
    [f1BehFiltMatPD,f1BehFiltMatCont,f1BehFiltNamesPD,f1BehFiltNamesCont,f1BehFiltAll,f1BehFiltAllNames] = separateLoop('f1',f1On,f1Off,f1Cont,nPtsF1,nContF1,...
        l1Filt,l2Filt,l3Filt,ch80Filt,av20Filt,npF1LPFilt,f1ChAvRatioFilt,npAccF1Filt);
    
    load('F1AssaysAnalysisOutput.mat')
    f1AssaysPD = [drugType,pdHemi,num2cell(updrsOn),num2cell(updrsOff),num2cell(LDE),num2cell(yrsSymp),num2cell(yrsDiag)];
    f1AssaysPDNames = {'f1Drug';'f1Hemi';'f1UpdrsOn';'f1UpdrsOff';'f1LDE';'f1YrsSymp';'f1YrsDiag'};
    f1AssaysAll = [num2cell([f1PDAssays,f1PpNums,age,yrsEdu,mmse(:,3),moca,dass,bis,lars,rei]),gender,handed];
    f1AssaysNames = {'f1PDCont';'f1PNum';'f1Ages';'f1YrsEdu';'f1Mmse';'f1Moca';'f1DassD';'f1DassA';'f1DassS';'f1Dass';'f1BisNP';...
        'f1BisMotor';'f1BisCog';'f1Bis';'f1Lars';'f1LarsInt';'f1LarsEm';'f1LarsAct';'f1LarsSelf';'f1ReiRE';'f1ReiRA';'f1ReiEE';'f1ReiEA';'f1ReiR';'f1ReiE';'f1Gender';'f1Handed';};
    
    load('F2BehGraphsOutput.mat')
    nPtsF2 = length(pF2Num);
    nContF2 = length(cF2Num);
    allF2Nums = [pF2Num';cF2Num'];
    f2ChAvRatio = ch80F2100 - av20F2100;
    lFinalF2Acc = lFinalF2(:,4);
    [f2BehMatPD,f2BehMatCont,f2BehNamesPD,f2BehNamesCont,f2BehAll,f2BehAllNames] = separateLoop('f2',f2On,f2Off,f2Cont,nPtsF2,nContF2,...
        nBlocksF2,lFinalF2Acc,ch80F2100,av20F2100,npF2LP,f2ChAvRatio,npAccF2);
    %filtered
    [nBlocksFiltF2,lFinalFiltF2Acc,ch80F2Filt,av20F2Filt,npF2LPFilt,f2ChAvRatioFilt,npAccF2Filt] = replaceNaNs(accFiltF2,nBlocksF2,...
        lFinalF2Acc,ch80F2100,av20F2100,npF2LP,f2ChAvRatio,npAccF2);
    [f2BehFiltMatPD,f2BehFiltMatCont,f2BehFiltNamesPD,f2BehFiltNamesCont,f2BehFiltAll,f2BehFiltAllNames] = separateLoop('f2',f2On,f2Off,f2Cont,nPtsF2,nContF2,...
        nBlocksFiltF2,lFinalFiltF2Acc,ch80F2Filt,av20F2Filt,npF2LPFilt,f2ChAvRatioFilt,npAccF2Filt);

load('F2AssaysAnalysisOutput.mat')
    f2AssaysPD = [drugType,pdHemi,num2cell(updrsOn),num2cell(updrsOff),num2cell(LDE),num2cell(yrsSymp),num2cell(yrsDiag)];
    f2AssaysPDNames = {'f2Drug';'f2Hemi';'f2UpdrsOn';'f2UpdrsOff';'f2LDE';'f2YrsSymp';'f2YrsDiag'};
    f2AssaysAll = [num2cell([f2PDAssays,f2PpNums,age,yrsEdu,mmse(:,3),moca,dass,bis,lars,rei]),gender,handed];
    f2AssaysNames = {'f2PDCont';'f2PNum';'f2Ages';'f2YrsEdu';'f2Mmse';'f2Moca';'f2DassD';'f2DassA';'f2DassS';'f2Dass';'f2BisNP';...
        'f2BisMotor';'f2BisCog';'f2Bis';'f2Lars';'f2LarsInt';'f2LarsEm';'f2LarsAct';'f2LarsSelf';'f2ReiRE';'f2ReiRA';'f2ReiEE';'f2ReiEA';'f2ReiR';'f2ReiE';'f2Gender';'f2Handed';};
    
%     load('AllModelsOutput.mat','SARSABetaFits','SARSAH3BetaFits')
%     SarsaLrPos = cell2mat(SARSABetaFits(:,7));
%     SarsaLrNeg = cell2mat(SARSABetaFits(:,8));
%     SarsaBeta = cell2mat(SARSABetaFits(:,9));
%     SarsaH3LrPos = cell2mat(SARSAH3BetaFits(:,7));
%     SarsaH3LrNeg = cell2mat(SARSAH3BetaFits(:,8));
%     SarsaH3Beta = cell2mat(SARSAH3BetaFits(:,9));
%     [modelMat,modelMatCont,modelNames,modelContNames,modelAll,modelAllNames] = separateLoop(nPatients,nCont,...
%         SarsaLrPos,SarsaLrNeg,SarsaBeta,SarsaH3LrPos,SarsaH3LrNeg,SarsaH3Beta);
%     
%     load('AssaysOutput.mat')
%     assaysPD = [drug,lPD];
%     assaysPDNames = {'drug';'hemi';};
%     assaysAll = [[ones(length(pNum),1);zeros(length(cNum),1)],[pNum,cNum]',[pAges,cAges]',mmse,dass,bis,lars,rei];
%     assaysNames = {'PDCont';'pNum';'ages';'mmse';'dassD';'dassA';'dassS';'dass';'bisNP';'bisMotor';'bisCog';'bis';'lars';'larsInt';'larsEm';'larsAct';'larsSelf';'reiRE';'reiRA';'reiEE';'reiEA';'reiR';'reiE';};
%     
%     load('SleepData.mat','sleep')
%     sleepQual = sleep(:,1);
%     sleepNight = sleep(:,2);
%     sleepDay = sleep(:,3);
%     sleepTot = sleep(:,4);
%     sleepLat = sleep(:,5);
%     [sleepMat,sleepMatCont,sleepNames,sleepContNames,sleepAll,sleepAllNames] = separateLoop(nPatients,nCont,...
%         sleepQual,sleepNight,sleepDay,sleepTot,sleepLat);

    f1Conditions = sum([strcmp(f1Conds','ON'),strcmp(f1Conds','OFF')*2,strcmp(f1Conds','CONT')*3],2);
    f1MiscMat = [f1On,f1Off,f1Cont,f1Conditions];
    f1MiscNames = {'f1On';'f1Off';'f1Cont';'f1Conds'};
    f2Conditions = sum([strcmp(f2Conds','ON'),strcmp(f2Conds','OFF')*2,strcmp(f2Conds','CONT')*3],2);
    f2MiscMat = [f2On,f2Off,f2Cont,f2Conditions,sessVec];
    f2MiscNames = {'f2On';'f2Off';'f2Cont';'f2Conds';'sessionOrder'};
     
    allNames = [f1BehNamesPD;f1BehNamesCont;f1BehAllNames;f1BehFiltNamesPD;...
        f1BehFiltNamesCont;f1BehFiltAllNames;f1AssaysPDNames;f1AssaysNames;f1MiscNames;...
        f2BehNamesPD;f2BehNamesCont;f2BehAllNames;f2BehFiltNamesPD;f2BehFiltNamesCont;...
        f2BehFiltAllNames;f2AssaysPDNames;f2AssaysNames;f2MiscNames];%behFiltNames;behFiltContNames;...
%         behFiltAllNames;modelNames;modelContNames;modelAllNames;assaysPDNames;...
%         assaysNames;sleepNames;sleepContNames;sleepAllNames;miscNames];

    %print everything into xlsx file
    allData = {f1BehMatPD,f1BehMatCont,f1BehAll,f1BehFiltMatPD,f1BehFiltMatCont,f1BehFiltAll,f1AssaysPD,f1AssaysAll,f1MiscMat...
        f2BehMatPD,f2BehMatCont,f2BehAll,f2BehFiltMatPD,f2BehFiltMatCont,f2BehFiltAll,f2AssaysPD,f2AssaysAll,f2MiscMat};
    
    PrintToExcel(allData,allNames,'.\SPSS\F1F2SPSS.xlsx')

    fclose('all');
    fid = fopen('.\SPSS\VariableNamesF.txt','w');
    for i = 1:length(allNames)
        fprintf(fid,'%s\n',allNames{i});
    end
    fclose(fid);
    save('FormatForSPSSF1F2.mat','f1BehMatPD','f1BehMatCont','f1BehNamesPD','f1BehNamesCont','f1BehAll','f1BehAllNames',...
        'f1BehFiltMatPD','f1BehFiltMatCont','f1BehFiltNamesPD','f1BehFiltNamesCont','f1BehFiltAll','f1BehFiltAllNames',...
        'f1MiscNames','f1MiscMat',...
        'f2BehMatPD','f2BehMatCont','f2BehNamesPD','f2BehNamesCont','f2BehAll','f2BehAllNames',...
        'f2BehFiltMatPD','f2BehFiltMatCont','f2BehFiltNamesPD','f2BehFiltNamesCont','f2BehFiltAll','f2BehFiltAllNames',...
        'f2MiscNames','f2MiscMat','allNames','allData');
%         'behFiltMat','behFiltMatCont','behFiltNames','behFiltContNames','behFiltAll','behFiltAllNames',...
%         'modelMat','modelMatCont','modelNames','modelContNames','modelAll','modelAllNames',...
%         'sleepMat','sleepMatCont','sleepNames','sleepContNames','sleepAll','sleepAllNames',...
%         'assaysPD','assaysPDNames','assaysAll','assaysNames','allNames','miscMat','miscNames')
end

function [PD,contMat,PDNames,contNames,allData,allNames] = separateLoop(name,on,off,cont,nPts,nCont,varargin)
%split vectors by conditions, create variable names for new variables
    PD = zeros(nPts,length(varargin)*2);
    contMat = zeros(nCont,length(varargin));
    PDNames = cell(length(varargin)*2,1);
    contNames = cell(length(varargin),1);
    allNames = cell(length(varargin),1);
    allData = zeros(length(varargin{1}),length(varargin));
    for i = 1:length(varargin)
        PD(:,i*2-1:i*2) = condSep(varargin{i}(:,1),on,off);
        PDNames{i*2-1} = sprintf('%s%sOn',inputname(i+6),name);
        PDNames{i*2} = sprintf('%s%sOff',inputname(i+6),name);
%         j = j + 4;
        contMat(:,i) = varargin{i}(cont);
        contNames{i} = sprintf('%s%sCont',inputname(i+6),name);
        allData(:,i) = varargin{i};
        allNames{i} = sprintf('%s%s',inputname(i+6),name);
    end
end



function [varargout] = replaceNaNs(acc,varargin)
%replaces all the NaNs in a vector with -9999 for SPSS missing value
%analysis
    for i = 1:length(varargin)
        vec = varargin{i};
        vec(~acc) = -9999;
        varargout{i} = vec;
    end
end