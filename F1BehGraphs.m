% F1BehGraphs
% draws graphs for behavioural data from experiment F1

clear all
clf

load('FDataFiles.mat')%load labels etcs
load('F1BehDataOutput.mat')%load stats
sqrtP = sqrt(length(pF1Num));%for std.errs
sqrtC = sqrt(length(cF1Num));
nPts = length(pF1Num);%number of patients
% set(0,'DefaultAxesFontSize',16)

%% learning block acc
lMeans(1,1) = mean(l1(f1On));%means for each condition
lMeans(1,2) = mean(l1(f1Off));
lMeans(1,3) = mean(l1(f1Cont));
lMeans(2,1) = mean(l2(f1On));
lMeans(2,2) = mean(l2(f1Off));
lMeans(2,3) = mean(l2(f1Cont));
lMeans(3,1) = mean(l3(f1On));
lMeans(3,2) = mean(l3(f1Off));
lMeans(3,3) = mean(l3(f1Cont));

%standard errors
stlMeans(1,1:2) = SEM(nPts,condSep(l1,f1On,f1Off));
stlMeans(1,3) = std(l1(f1Cont))/sqrtC;
stlMeans(2,1:2) = SEM(nPts,condSep(l2,f1On,f1Off));
stlMeans(2,3) = std(l2(f1Cont))/sqrtC;
stlMeans(3,1:2) = SEM(nPts,condSep(l3,f1On,f1Off));
stlMeans(3,3) = std(l3(f1Cont))/sqrtC;

%% line graphs: ch80 & av20

f1Ch80Av20(1,1) = mean(ch80(f1On));%split by condition
f1Ch80Av20(1,2) = mean(ch80(f1Off));
f1Ch80Av20(1,3) = mean(ch80(f1Cont));
f1Ch80Av20(2,1) = mean(av20(f1On));
f1Ch80Av20(2,2) = mean(av20(f1Off));
f1Ch80Av20(2,3) = mean(av20(f1Cont));

%SEM
f1StdErr(1,1:2) = SEM(nPts,condSep(ch80,f1On,f1Off));
f1StdErr(1,3) = sum(std(ch80(f1Cont))/sqrtC);
f1StdErr(2,1:2) = SEM(nPts,condSep(av20,f1On,f1Off));
f1StdErr(2,3) = sum(std(av20(f1Cont))/sqrtC);

set(gca,'FontSize',16)
%preset colors to red & green
set(gca, 'ColorOrder', [0 0 1; 1 0 0; 0 0 0], 'NextPlot', 'replacechildren');
errorbar(f1Ch80Av20(:,1:3),f1StdErr(:,1:3), 'LineWidth',2.5)
box off
%title('Selection on F1 Novel Pairs task (without learning pairs)')
axis([0.8 2.2 40 90])
set(gca, 'XTick', 1:2, 'XTickLabel', {'Choose-A' 'Avoid-B'})
xlabel('Choice')
ylabel('% choices')
legend('ON', 'OFF', 'HC',  'Location', 'South')
saveas(figure(1), 'F1CH80AV20Means.fig')
saveas(figure(1), 'F1CH80AV20Means.jpg')
clf


%% filtered - only blocks where p8020 > 50% allowed
f1OnFilt = strcmp('ON',fCondsFilt);
f1OffFilt = strcmp('OFF',fCondsFilt);
f1ContFilt = strcmp('CONT',fCondsFilt);
sqrtPFilt = sqrt(sum(f1OnFilt+f1OffFilt)/2);%for std.errs
sqrtCFilt = sqrt(sum(f1ContFilt));

f1Ch80Av20Filt(1,1) = mean(ch80Filt(f1OnFilt));%means
f1Ch80Av20Filt(1,2) = mean(ch80Filt(f1OffFilt));
f1Ch80Av20Filt(1,3) = mean(ch80Filt(f1ContFilt));
f1Ch80Av20Filt(2,1) = mean(av20Filt(f1OnFilt));
f1Ch80Av20Filt(2,2) = mean(av20Filt(f1OffFilt));
f1Ch80Av20Filt(2,3) = mean(av20Filt(f1ContFilt));

%SEM
f1StdErrFilt(1,1:2) = [std(ch80Filt(f1OnFilt))./sqrt(sum(f1OnFilt)),std(ch80Filt(f1OffFilt))./sqrt(sum(f1OffFilt))];
f1StdErrFilt(1,3) = sum(std(ch80Filt(f1ContFilt))/sqrtCFilt);
f1StdErrFilt(2,1:2) = [std(av20Filt(f1OnFilt))./sqrt(sum(f1OnFilt)),std(av20Filt(f1OffFilt))./sqrt(sum(f1OffFilt))];
f1StdErrFilt(2,3) = sum(std(av20Filt(f1ContFilt))/sqrtCFilt);

%preset colors to red & green
set(gca,'FontSize',16)
set(gca, 'ColorOrder', [0 0 1; 1 0 0; 0 0 0], 'NextPlot', 'replacechildren');
errorbar(f1Ch80Av20Filt(:,1:3),f1StdErrFilt(:,1:3), 'LineWidth',2.5)
box off
%title('Selection on Filtered F1 Novel Pairs task (without learning pairs)')
axis([0.8 2.2 40 90])
set(gca, 'XTick', 1:2, 'XTickLabel', {'Choose-A' 'Avoid-B'})
xlabel('Choice')
ylabel('% choices')
legend('ON', 'OFF', 'HC', 'Location', 'South')
saveas(figure(1), 'F1CH80AV20MeansFilt.fig')
saveas(figure(1), 'F1CH80AV20MeansFilt.jpg')
clf


%% learning - filt

%learning block acc
lMeansFilt(1,1) = mean(l1(f1On & p8020>50));
lMeansFilt(1,2) = mean(l1(f1Off & p8020>50));
lMeansFilt(1,3) = mean(l1(f1Cont & p8020>50));
lMeansFilt(2,1) = mean(l2(f1On & p8020>50));
lMeansFilt(2,2) = mean(l2(f1Off & p8020>50));
lMeansFilt(2,3) = mean(l2(f1Cont & p8020>50));
lMeansFilt(3,1) = mean(l3(f1On & p8020>50));
lMeansFilt(3,2) = mean(l3(f1Off & p8020>50));
lMeansFilt(3,3) = mean(l3(f1Cont & p8020>50));

stlMeansFilt(1,1) = std(l1(f1On & p8020>50))./sqrt(sum(f1On&p8020>50));
stlMeansFilt(1,2) = std(l1(f1Off & p8020>50))./sqrt(sum(f1Off&p8020>50));
stlMeansFilt(1,3) = std(l1(f1Cont & p8020>50))/sqrt(sum(f1Cont & p8020>50));
stlMeansFilt(2,1) = std(l2(f1On & p8020>50))./sqrt(sum(f1On&p8020>50));
stlMeansFilt(2,2) = std(l2(f1Off & p8020>50))./sqrt(sum(f1Off&p8020>50));
stlMeansFilt(2,3) = std(l2(f1Cont & p8020>50))/sqrt(sum(f1Cont & p8020>50));
stlMeansFilt(3,1) = std(l3(f1On & p8020>50))./sqrt(sum(f1On&p8020>50));
stlMeansFilt(3,2) = std(l3(f1Off & p8020>50))./sqrt(sum(f1Off&p8020>50));
stlMeansFilt(3,3) = std(l3(f1Cont & p8020>50))/sqrt(sum(f1Cont & p8020>50));

%%
save('F1BehGraphsOutput.mat')