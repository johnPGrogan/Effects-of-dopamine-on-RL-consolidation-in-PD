% F2BehGraphs
% draws figs on F2 data

clear all
close all
load('FDataFiles.mat')%load labels etc
load('F2BehDataOutput.mat')%load data

sqrtPF2 = sqrt(nPts);%for std.errs
sqrtCF2 = sqrt(nCont);
% set(0,'DefaultAxesFontSize',16)

%number of learning blocks
nBlocksMeans(1,1) = nanmean(nBlocksF2(sessVec==1));%mean by session order
nBlocksMeans(1,2) = nanmean(nBlocksF2(sessVec==2));
nBlocksStdErr(1,:) = SEM(nPts,condSep(nBlocksF2,sessVec==1,sessVec==2));%SEM

%draw by meds cond
lBlocksMeans(1,1) = nanmean(nBlocksF2(f2On));
lBlocksMeans(1,2) = nanmean(nBlocksF2(f2Off));
lBlocksMeans(1,3) = nanmean(nBlocksF2(f2Cont));
lBlocksStdErr(1,:) = SEM(nPts,condSep(nBlocksF2,f2On,f2Off));%1) = nanstd(nBlocksF2(f2On))/sqrtPF2;
lBlocksStdErr(1,3) = nanstd(nBlocksF2(f2Cont))/sqrtCF2;


%% final block acc on vs off
lFinalMeans(1,1) = nanmean(lFinalF2(f2On,4));
lFinalMeans(1,2) = nanmean(lFinalF2(f2Off,4));
lFinalMeans(1,3) = nanmean(lFinalF2(f2Cont,4));

lFinalStErr(1,1:2) = SEM(nPts,condSep(lFinalF2(:,4),f2On,f2Off));%1) = nanstd(lFinalF2(f2On,4))/sqrtPF2;
lFinalStErr(1,3) = nanstd(lFinalF2(f2Cont,4))/sqrtCF2;

%% line graphs: ch80 & av20 - unfiltered

f2Ch80Av20(1,1) = mean(ch80F2100(f2On));%mean
f2Ch80Av20(1,2) = mean(ch80F2100(f2Off));
f2Ch80Av20(1,3) = mean(ch80F2100(f2Cont));
f2Ch80Av20(2,1) = mean(av20F2100(f2On));
f2Ch80Av20(2,2) = mean(av20F2100(f2Off));
f2Ch80Av20(2,3) = mean(av20F2100(f2Cont));

%SEM
f2StdErr(1,1:2) = SEM(nPts,condSep(ch80F2100,f2On,f2Off));
f2StdErr(1,3) = sum(std(ch80F2100(f2Cont))/sqrtCF2);
f2StdErr(2,1:2) = SEM(nPts,condSep(av20F2100,f2On,f2Off));
f2StdErr(2,3) = sum(std(av20F2100(f2Cont))/sqrtCF2);

%preset colors to red & green
set(gca,'FontSize',16)
set(gca, 'ColorOrder', [0 0 1; 1 0 0; 0 0 0], 'NextPlot', 'replacechildren');
errorbar(f2Ch80Av20,f2StdErr, 'LineWidth',2.5)
box off
% title('Selection on F2 repl Novel Pairs task (without learning pairs)')
axis([0.8 2.2 40 90])
set(gca, 'XTick', 1:2, 'XTickLabel', {'Choose-A' 'Avoid-B'})
xlabel('Choice')
ylabel('% choices')
legend('ON', 'OFF', 'HC', 'Location', 'Best')
saveas(figure(1), 'F2CH80AV20Means.fig')
saveas(figure(1), 'F2CH80AV20Means.jpg')
clf

%% filtered - only blocks where p8020 > 50% allowed
f2OnFilt = strcmp('ON',f2CondsFilt');
f2OffFilt = strcmp('OFF',f2CondsFilt');
f2ContFilt = strcmp('CONT',f2CondsFilt);
sqrtPF2Filt = sqrt(sum(f2OnFilt+f2OffFilt)/2);%for std.errs
sqrtCF2Filt = sqrt(sum(f2ContFilt));

f2Ch80Av20Filt(1,1) = mean(ch80FiltF2(f2OnFilt));
f2Ch80Av20Filt(1,2) = mean(ch80FiltF2(f2OffFilt));
f2Ch80Av20Filt(1,3) = mean(ch80FiltF2(f2ContFilt));
f2Ch80Av20Filt(2,1) = mean(av20FiltF2(f2OnFilt));
f2Ch80Av20Filt(2,2) = mean(av20FiltF2(f2OffFilt));
f2Ch80Av20Filt(2,3) = mean(av20FiltF2(f2ContFilt));
f2StdErrFilt(1,1) = sum(std(ch80FiltF2(f2OnFilt))/sqrtPF2Filt);
f2StdErrFilt(1,2) = sum(std(ch80FiltF2(f2OffFilt))/sqrtPF2Filt);
f2StdErrFilt(1,3) = sum(std(ch80FiltF2(f2ContFilt))/sqrtCF2Filt);
f2StdErrFilt(2,1) = sum(std(av20FiltF2(f2OnFilt))/sqrtPF2Filt);
f2StdErrFilt(2,2) = sum(std(av20FiltF2(f2OffFilt))/sqrtPF2Filt);
f2StdErrFilt(2,3) = sum(std(av20FiltF2(f2ContFilt))/sqrtCF2Filt);

%% filtered learning
lFinalMeansFilt(1,1) = nanmean(lFinalF2(f2On & accFiltF2,4));
lFinalMeansFilt(1,2) = nanmean(lFinalF2(f2Off & accFiltF2,4));
lFinalMeansFilt(1,3) = nanmean(lFinalF2(f2Cont & accFiltF2,4));

lFinalStErrFilt(1,1:2) = [nanstd(lFinalF2(f2On & accFiltF2,4))/sqrt(sum(f2On & accFiltF2)),nanstd(lFinalF2(f2Off & accFiltF2,4))/sqrt(sum(f2Off & accFiltF2))];
lFinalStErrFilt(1,3) = nanstd(lFinalF2(f2Cont & accFiltF2,4))/sqrt(sum(f2Cont & accFiltF2));
%%


save('F2BehGraphsOutput.mat')