% BehWinStayAnalysis
% call WinStayLoseShift on beh data
% analyse results
clear
close all
%% expt1
load('BehDataOutput.mat')%load expt1 data

%run winstay loseshift analysis
[winStayPerc,loseShiftPerc,winStay,winShift,~,loseStay,loseShift] = WinStayLoseShift(allLStimuli,allLChosen,allLCorrect);

winStayMeans = [nanmean(winStayPerc(d1On)),nanmean(winStayPerc(d1Off)),nanmean(winStayPerc(dCont))];%get means
winStaySEM = [nanstd(winStayPerc(d1On))./sqrtP,nanstd(winStayPerc(d1Off))./sqrtP,nanstd(winStayPerc(dCont))./sqrtC];%SEM

winStayMeans(2,:) = [nanmean(loseShiftPerc(d1On)),nanmean(loseShiftPerc(d1Off)),nanmean(loseShiftPerc(dCont))];%for lose-shift too
winStaySEM(2,:) = [nanstd(loseShiftPerc(d1On))./sqrtP,nanstd(loseShiftPerc(d1Off))./sqrtP,nanstd(loseShiftPerc(dCont))./sqrtC];

%%%% the figure drawing requires the 'barwitherr' function
%%%% https://uk.mathworks.com/matlabcentral/fileexchange/30639-barwitherr-errors-varargin-
% subplot(2,2,1)%subplot all 3 expts
% colourOrder = [0 0 1;1 0 0;0 0 0];%set colour order
% h = barwitherr(winStaySEM,winStayMeans);%plot
% for i = 1:3%change colours
%     set(h(i),'FaceColor',colourOrder(i,:))
% end
% axis([0.5 2.5 0 100])
% set(gca,'XTick',1:2,'XTickLabel',{'Win Stay', 'Lose Shift'})
% % legend('% win stay', '% lose shift', 'Location', 'South')
% title('a)')
% ylabel('%')
% xlabel('Day 1 Condition')
% box off

%% F1/expt2
load('F1BehDataOutput.mat')
% %run winstay loseshift analysis
f1SqrtP = sqrt(sum(f1On));
f1SqrtC = sqrt(sum(f1Cont));
[f1WinStayPerc,f1LoseShiftPerc,f1WinStay,f1WinShift,~,f1LoseStay,f1LoseShift] = WinStayLoseShift(allLStimuli,allLChosen,allLCorrect);

f1WinStayMeans = [nanmean(f1WinStayPerc(f1On)),nanmean(f1WinStayPerc(f1Off)),nanmean(f1WinStayPerc(f1Cont))];
f1WinStaySEM = [nanstd(f1WinStayPerc(f1On))./f1SqrtP,nanstd(f1WinStayPerc(f1Off))./f1SqrtP,nanstd(f1WinStayPerc(f1Cont))./f1SqrtC];

f1WinStayMeans(2,:) = [nanmean(f1LoseShiftPerc(f1On)),nanmean(f1LoseShiftPerc(f1Off)),nanmean(f1LoseShiftPerc(f1Cont))];
f1WinStaySEM(2,:) = [nanstd(f1LoseShiftPerc(f1On))./f1SqrtP,nanstd(f1LoseShiftPerc(f1Off))./f1SqrtP,nanstd(f1LoseShiftPerc(f1Cont))./f1SqrtC];

% subplot(2,2,2)
% h = barwitherr(f1WinStaySEM,f1WinStayMeans);
% for i = 1:3
%     set(h(i),'FaceColor',colourOrder(i,:))
% end
% axis([0.5 2.5 0 100])
% set(gca,'XTick',1:2,'XTickLabel',{'Win Stay', 'Lose Shift'})
% % legend('% win stay', '% lose shift', 'Location', 'South')
% title('b)')
% ylabel('%')
% xlabel('Condition')
% box off

%% F2/expt3
load('F2BehDataOutput.mat')
% %run winstay loseshift analysis
f2SqrtP = sqrt(sum(f2On));
f2SqrtC = sqrt(sum(f2Cont));
[f2WinStayPerc,f2LoseShiftPerc,f2WinStay,f2WinShift,~,f2LoseStay,f2LoseShift] = WinStayLoseShift(allLStimuli,allLChosen,allLCorrect);

f2WinStayMeans = [nanmean(f2WinStayPerc(f2On)),nanmean(f2WinStayPerc(f2Off)),nanmean(f2WinStayPerc(f2Cont))];
f2WinStaySEM = [nanstd(f2WinStayPerc(f2On))./f2SqrtP,nanstd(f2WinStayPerc(f2Off))./f2SqrtP,nanstd(f2WinStayPerc(f2Cont))./f2SqrtC];

f2WinStayMeans(2,:) = [nanmean(f2LoseShiftPerc(f2On)),nanmean(f2LoseShiftPerc(f2Off)),nanmean(f2LoseShiftPerc(f2Cont))];
f2WinStaySEM(2,:) = [nanstd(f2LoseShiftPerc(f2On))./f2SqrtP,nanstd(f2LoseShiftPerc(f2Off))./f2SqrtP,nanstd(f2LoseShiftPerc(f2Cont))./f2SqrtC];

% subplot(2,2,3)
% h = barwitherr(f2WinStaySEM,f2WinStayMeans);
% for i = 1:3
%     set(h(i),'FaceColor',colourOrder(i,:))
% end
% axis([0.5 2.5 0 100])
% set(gca,'XTick',1:2,'XTickLabel',{'Win Stay', 'Lose Shift'})
% % legend('% win stay', '% lose shift', 'Location', 'South')
% title('c)')
% ylabel('%')
% xlabel('Condition')
% box off
% legend('PD ON', 'PD OFF', 'HC', 'Location', [0.57 0.129 0.335 0.2])
% saveas(figure(1),'WinStayLoseShift.fig')
% saveas(figure(1),'WinStayLoseShift.jpg')
% close(figure(1))

%% save
save('BehWinStayAnalysis.mat',...
    'winStayPerc','loseShiftPerc','winStayMeans','winStaySEM',...
    'f1WinStayPerc','f1LoseShiftPerc','f1WinStayMeans','f1WinStaySEM',...
    'f2WinStayPerc','f2LoseShiftPerc','f2WinStayMeans','f2WinStaySEM')
close all