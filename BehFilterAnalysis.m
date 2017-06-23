% BehFilterAnalysis
% this applies a filter on data such that any sessions where a person does
% not choose A over B > 50% of the time in the novel pairs test is
% excluded.

load('BehDataOutput.mat')%load up data
alpha = 0.05;%sig threshold
% set(0,'DefaultAxesFontSize',16)
nPts = length(pNum);%number of patients
filtNP = ch8020 <= 50;%blocks failing filter - to be removed
ch80FiltNP = ch80;%copy ch80
ch80FiltNP(filtNP) = NaN;%remove blocks failing filter
av20FiltNP = av20;%copy av20
av20FiltNP(filtNP) = NaN;%remove blocks failing filter

%% graphs
% filter NP scores by ch8020>50

nPtsFilt = length(pNum)*4 - sum(filtNP(1:length(pNum)*4));
nContFilt = length(cNum) - sum(filtNP(end-length(cNum)+1:end));
nTotFilt = nPtsFilt + nContFilt;

d1Ch80Av20FiltNP = [nanmean(condSep(ch80FiltNP,d1On,d1Off)),nanmean(ch80FiltNP(dCont));nanmean(condSep(av20FiltNP,d1On,d1Off)),nanmean(av20FiltNP(dCont))];
d1Ch80Av20FiltNPStErr = [nanstd(condSep(ch80FiltNP,d1On,d1Off))./sqrt([sum(~filtNP & d1On),sum(~filtNP & d1Off)]),nanstd(ch80FiltNP(dCont))./sqrt(sum(~filtNP & dCont));nanstd(condSep(av20FiltNP,d1On,d1Off))./sqrt([sum(~filtNP & d1On),sum(~filtNP & d1Off)]),nanstd(av20FiltNP(dCont))./sum(~filtNP & dCont)];

%preset colors to red & green
set(gca, 'ColorOrder', [0 0 1; 1 0 0; 0 0 0], 'NextPlot', 'replacechildren');
errorbar(d1Ch80Av20FiltNP,d1Ch80Av20FiltNPStErr, 'LineWidth', 2.5)
box off
%title('Day 1 effects on Novel Pairs task (filtered P8020>50)')
axis([0.8 2.2 40 90])
set(gca, 'XTick', 1:2, 'XTickLabel', {'Ch80' 'Av20'}, 'YTick',40:10:90)
xlabel('Choice')
ylabel('% choices')

legend('Day1 ON', 'Day1 OFF', 'HC', 'Location', 'Best')
saveas(figure(1), 'D1CH80AV20Filt.fig')
saveas(figure(1), 'D1CH80AV20Filt.jpg')
clf


%day2
%line graphs: d1 ch80 & av20. same for d2
d2Ch80Av20FiltNP = [nanmean(condSep(ch80FiltNP,d2On,d2Off)),nanmean(ch80FiltNP(dCont));nanmean(condSep(av20FiltNP,d2On,d2Off)),nanmean(av20FiltNP(dCont))];
d2Ch80Av20FiltNPStErr = [nanstd(condSep(ch80FiltNP,d2On,d2Off))./sqrt([sum(~filtNP & d2On),sum(~filtNP & d2Off)]),nanstd(ch80FiltNP(dCont))./sqrt(sum(~filtNP & dCont));nanstd(condSep(av20FiltNP,d2On,d2Off))./sqrt([sum(~filtNP & d2On),sum(~filtNP & d2Off)]),nanstd(av20FiltNP(dCont))./sum(~filtNP & dCont)];

%preset colors to red & green
set(gca, 'ColorOrder', [0 0 1; 1 0 0; 0 0 0], 'NextPlot', 'replacechildren');
errorbar(d2Ch80Av20FiltNP,d2Ch80Av20FiltNPStErr, '--', 'LineWidth', 2.5)
box off
%title('Day 2 effects on Novel Pairs task (filtered P8020>50)')
axis([0.8 2.2 40 90])
set(gca, 'XTick', 1:2, 'XTickLabel', {'Ch80' 'Av20'}, 'YTick',40:10:90)
xlabel('Choice')
ylabel('% choices')
legend('Day2 ON', 'Day2 OFF', 'HC', 'Location', 'SouthEast')
saveas(figure(1), 'D2CH80AV20Filt.fig')
saveas(figure(1), 'D2CH80AV20Filt.jpg')
clf



ch80Av20FiltNP = [nanmean(condSep(ch80FiltNP,onOn,offOn,onOff,offOff)),nanmean(ch80FiltNP(dCont));nanmean(condSep(av20FiltNP,onOn,offOn,onOff,offOff)),nanmean(av20FiltNP(dCont))];
ch80Av20FiltNPStErr = [nanstd(condSep(ch80FiltNP,onOn,offOn,onOff,offOff))./sqrtP,nanstd(ch80FiltNP(dCont))./sqrtC;nanstd(condSep(av20FiltNP,onOn,offOn,onOff,offOff))./sqrtP,nanstd(av20FiltNP(dCont))./sqrtC];

%% learning
l1FiltNP = l1;
l1FiltNP(filtNP) = NaN;
l2FiltNP = l2;
l2FiltNP(filtNP) = NaN;
l3FiltNP = l3;
l3FiltNP(filtNP) = NaN;

lFiltNPMeans(1,1) = nanmean(l1FiltNP(d1On));
lFiltNPMeans(2,1) = nanmean(l1FiltNP(d1Off));
lFiltNPMeans(3,1) = nanmean(l1FiltNP(dCont));
lFiltNPMeans(1,2) = nanmean(l2FiltNP(d1On));
lFiltNPMeans(2,2) = nanmean(l2FiltNP(d1Off));
lFiltNPMeans(3,2) = nanmean(l2FiltNP(dCont));
lFiltNPMeans(1,3) = nanmean(l3FiltNP(d1On));
lFiltNPMeans(2,3) = nanmean(l3FiltNP(d1Off));
lFiltNPMeans(3,3) = nanmean(l3FiltNP(dCont));

lFiltNPDayStErr = [nanstd(condSep(l1FiltNP,d1On,d1Off))./sqrtP,nanstd(l1FiltNP(dCont))./sqrtC;nanstd(condSep(l2FiltNP,d2On,d2Off))./sqrtP,nanstd(l2FiltNP(dCont))./sqrtC;nanstd(condSep(l3FiltNP,d2On,d2Off))./sqrtP,nanstd(l3FiltNP(dCont))./sqrtC]';


%%
close all
save('BehFilterOutput.mat')