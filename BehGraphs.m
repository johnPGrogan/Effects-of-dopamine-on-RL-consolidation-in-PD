% BehGraphs
% draws graphs for behavioural data

clear all
close all
load('DataFilesData.mat')
load('BehDataOutput.mat')

set(0,'DefaultAxesFontSize',14)

%preallocate
nPts = length(pNum);%number of patients
set(0,'DefaultAxesFontSize',12)%axis font size
% set(0,'defaultFigureVisible','off')%put figure in background

%% learning
lMeans(1,1) = nanmean(l1(d1On));%means by day 1
lMeans(2,1) = nanmean(l1(d1Off));
lMeans(3,1) = nanmean(l1(dCont));
lMeans(1,2) = nanmean(l2(d1On));
lMeans(2,2) = nanmean(l2(d1Off));
lMeans(3,2) = nanmean(l2(dCont));
lMeans(1,3) = nanmean(l3(d1On));
lMeans(2,3) = nanmean(l3(d1Off));
lMeans(3,3) = nanmean(l3(dCont));

stlMeans(1:2,1) = SEM(nPts,condSep(l1,d1On,d1Off));%PD SEM
stlMeans(1:2,2) = SEM(nPts,condSep(l2,d1On,d1Off));
stlMeans(1:2,3) = SEM(nPts,condSep(l3,d1On,d1Off));

stlMeans(3,1) = nanstd(l1(dCont))/sqrtC;%controls SEM
stlMeans(3,2) = nanstd(l2(dCont))/sqrtC;
stlMeans(3,3) = nanstd(l3(dCont))/sqrtC;

%% memory
mMeans(1,1) = nanmean(mem1(d1On));
mMeans(2,1) = nanmean(mem1(d1Off));
mMeans(3,1) = nanmean(mem1(dCont));
mMeans(1,2) = nanmean(mem2(d1On));
mMeans(2,2) = nanmean(mem2(d1Off));
mMeans(3,2) = nanmean(mem2(dCont));
mMeans(1,3) = nanmean(mem3(d1On));
mMeans(2,3) = nanmean(mem3(d1Off));
mMeans(3,3) = nanmean(mem3(dCont));

stmMeans(1,1) = nanstd(mem1(d1On))/sqrtP;
stmMeans(2,1) = nanstd(mem1(d1Off))/sqrtP;
stmMeans(3,1) = nanstd(mem1(dCont))/sqrtC;
stmMeans(1,2) = nanstd(mem2(d1On))/sqrtP;
stmMeans(2,2) = nanstd(mem2(d1Off))/sqrtP;
stmMeans(3,2) = nanstd(mem2(dCont))/sqrtC;
stmMeans(1,3) = nanstd(mem3(d1On))/sqrtP;
stmMeans(2,3) = nanstd(mem3(d1Off))/sqrtP;
stmMeans(3,3) = nanstd(mem3(dCont))/sqrtC;

% 30min - 0min memory scores
m30M0Means(1,1) = nanmean(m30M0(d1On));
m30M0Means(1,2) = nanmean(m30M0(d1Off));
m30M0Means(1,3) = nanmean(m30M0(dCont));

stm30M0Means(1,1) = nanstd(m30M0(d1On))/sqrtP;
stm30M0Means(1,2) = nanstd(m30M0(d1Off))/sqrtP;
stm30M0Means(1,3) = nanstd(m30M0(dCont))/sqrtC;

%% m24 - m30
m24M30SepMeans = [nanmean(condSep(m24M30,onOn,offOn,onOff,offOff)),nanmean(m24M30(dCont))];%means by cond
m24M30SepStErr = [SEM(18,condSep(m24M30,onOn,offOn,onOff,offOff)),nanstd(m24M30(dCont))./sqrtC];%SEM
m24M30SepMeans = diag(m24M30SepMeans,0);%put on diagonal in matrix - for colouring bars
m24M30SepStErr = diag(m24M30SepStErr,0);%put on diagonal

%%% this part requires the 'barwitherr' function
%%% available at https://uk.mathworks.com/matlabcentral/fileexchange/30639-barwitherr-errors-varargin
%%% and the hatchfill2 function:
%%% https://uk.mathworks.com/matlabcentral/fileexchange/53593-hatchfill2


% cols = ['b','r','b','r','k'];%set colours
% for i = 1:5%loop through and plot each bar separately with colour
%     h(i) = barwitherr(m24M30SepStErr(i,:),m24M30SepMeans(i,:),cols(i));
%     hold on
% end
% hatchfill2(h(3:4),'HatchLineWidth',4,'HatchSpacing',15);%add hatching to day 1 OFF
% box off
% %title('Filtered Means for M24-M30')
% set(gca,'XTick',1:5, 'XTickLabel',{'OnOn' 'OffOn' 'OnOff', 'OffOff', 'HC'})
% xlabel('Conditon')
% ylabel('m24 score minus m30')
% saveas(figure(1), 'M24M30MeansAll.fig')
% saveas(figure(1), 'M24M30MeansAll.jpg')
% clf

%% line graphs: d1 ch80 & av20. same for d2
%day1
d1Ch80Av20(1,1) = nanmean(ch80(d1On));%means by day 1 cond
d1Ch80Av20(1,2) = nanmean(ch80(d1Off));
d1Ch80Av20(1,3) = nanmean(ch80(dCont));
d1Ch80Av20(2,1) = nanmean(av20(d1On));
d1Ch80Av20(2,2) = nanmean(av20(d1Off));
d1Ch80Av20(2,3) = nanmean(av20(dCont));

%SEM
stdErrD1Ch80(1,1:2) = SEM(nPts,condSep(ch80,d1On,d1Off));
stdErrD1Ch80(1,3) = sum(nanstd(ch80(dCont))/sqrtC);
stdErrD1Ch80(2,1:2) = SEM(nPts,condSep(av20,d1On,d1Off));
stdErrD1Ch80(2,3) = sum(nanstd(av20(dCont))/sqrtC);

%preset colors to red & blue
set(gca, 'ColorOrder', [0 0 1; 1 0 0; 0 0 0], 'NextPlot', 'replacechildren');
errorbar(d1Ch80Av20,stdErrD1Ch80, 'LineWidth', 2.5)
box off
%title('Selection on Novel Pairs (without learning pairs) task (split by Day1)')
axis([0.8 2.2 40 90])
set(gca, 'XTick', 1:2, 'XTickLabel', {'Choose-A' 'Avoid-B'},'YTick',40:10:90)
xlabel('Choice')
ylabel('% choices') 
legend('Day1 ON', 'Day1 OFF', 'HC', 'Location', 'Best')
saveas(figure(1), 'D1CH80AV20Means.fig')
saveas(figure(1), 'D1CH80AV20Means.jpg')
clf


%day2

d2Ch80Av20(1,1) = nanmean(ch80(d2On));%means by day 2 cond
d2Ch80Av20(1,2) = nanmean(ch80(d2Off));
d2Ch80Av20(1,3) = nanmean(ch80(dCont));
d2Ch80Av20(2,1) = nanmean(av20(d2On));
d2Ch80Av20(2,2) = nanmean(av20(d2Off));
d2Ch80Av20(2,3) = nanmean(av20(dCont));

%SEM
stdErrD2Ch80(1,1:2) = SEM(nPts,condSep(ch80,d2On,d2Off));
stdErrD2Ch80(1,3) = sum(nanstd(ch80(dCont))/sqrtC);
stdErrD2Ch80(2,1:2) = SEM(nPts,condSep(av20,d2On,d2Off));
stdErrD2Ch80(2,3) = sum(nanstd(av20(dCont))/sqrtC);

%preset colors to red & blue
set(gca, 'ColorOrder', [0 0 1; 1 0 0; 0 0 0], 'NextPlot', 'replacechildren');
errorbar(d2Ch80Av20,stdErrD2Ch80, '--', 'LineWidth', 2.5)
box off
%title('Selection on Novel Pairs (without learning pairs) task (split by Day2)')
axis([0.8 2.2 40 90])
set(gca, 'XTick', 1:2, 'XTickLabel', {'Choose-A' 'Avoid-B'},'YTick',40:10:90)
xlabel('Choice')
ylabel('% choices')
legend('Day2 ON', 'Day2 OFF', 'HC', 'Location', 'Best')
saveas(figure(1), 'D2CH80AV20Means.fig')
saveas(figure(1), 'D2CH80AV20Means.jpg')
clf

%% all 4 conds
allCh80Av20(1,1:4) = nanmean(condSep(ch80,onOn,offOn,onOff,offOff));
allCh80Av20(2,1:4) = nanmean(condSep(av20,onOn,offOn,onOff,offOff));

stdErrAllCh80(1,1:4) = SEM(nPts,condSep(ch80,onOn,offOn,onOff,offOff));
stdErrAllCh80(2,1:4) = SEM(nPts,condSep(av20,onOn,offOn,onOff,offOff));

contCh80Av20(1,1) = nanmean(ch80(cont));
contCh80Av20(2,1) = nanmean(av20(cont));
stdErrContCh80Av20(1,1) = sum(nanstd(ch80(cont))/sqrtC);%%ch80(cont)));
stdErrContCh80Av20(2,1) = sum(nanstd(av20(cont))/sqrtP);%av20(cont)));

%%
close all
save('BehGraphOutput.mat')