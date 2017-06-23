% BetweenExptsGraphs
% gets means and SEM for learning and novel pairs data from all 3
% experiments, draws figures

close all
clear all

% set(0,'DefaultAxesFontSize',16)

learn = NaN(3);%preallocate for learning accuracy means
learnSEM = learn;%learning accuracy SEM
learnFilt = learn;
learnFiltSEM = learn;
ch80Av20 = NaN(3,5,2);%ch80 and av20 means
ch80Av20SEM = ch80Av20;%SEM
ch80Av20Filt = ch80Av20;
ch80Av20FiltSEM = ch80Av20;

%expt 1
load('BehGraphOutput.mat','lMeans','stlMeans','allCh80Av20','stdErrAllCh80','contCh80Av20','stdErrContCh80Av20','dCont')
learn(1,:) = lMeans(:,3);
learnSEM(1,:) = stlMeans(:,3)';
ch80Av20(1,:,1) = [allCh80Av20(1,:),contCh80Av20(1,:)];
ch80Av20SEM(1,:,1) = [stdErrAllCh80(1,:),stdErrContCh80Av20(1,:)];
ch80Av20(1,:,2) = [allCh80Av20(2,:),contCh80Av20(2,:)];
ch80Av20SEM(1,:,2) = [stdErrAllCh80(2,:),stdErrContCh80Av20(2,:)];

%filtered data
load('BehFilterOutput.mat','lFiltNPMeans','lFiltNPDayStErr','ch80Av20FiltNP','ch80Av20FiltNPStErr')
learnFilt(1,:) = lFiltNPMeans(:,3);
learnFiltSEM(1,:) = lFiltNPDayStErr(:,3);
ch80Av20Filt(1,:,1) = ch80Av20FiltNP(1,:);
ch80Av20FiltSEM(1,:,1) = ch80Av20FiltNPStErr(1,:);
ch80Av20Filt(1,:,2) = ch80Av20FiltNP(2,:);
ch80Av20FiltSEM(1,:,2) = ch80Av20FiltNPStErr(2,:);


load('F1BehGraphsOutput.mat','lMeans','stlMeans','f1Ch80Av20','f1StdErr','f1On','f1Off','f1Cont',...
    'lMeansFilt','stlMeansFilt','f1Ch80Av20Filt','f1StdErrFilt','p8020')
learn(2,:) = lMeans(3,:);
learnSEM(2,:) = stlMeans(3,:);
ch80Av20(2,[1,4,5],1) = f1Ch80Av20(1,:);
ch80Av20SEM(2,[1,4,5],1) = f1StdErr(1,:);
ch80Av20(2,[1,4,5],2) = f1Ch80Av20(2,:);
ch80Av20SEM(2,[1,4,5],2) = f1StdErr(2,:);

%filtered
learnFilt(2,:) = lMeansFilt(3,:);
learnFiltSEM(2,:) = stlMeansFilt(3,:);
ch80Av20Filt(2,[1,4,5],1) = f1Ch80Av20Filt(1,:);
ch80Av20FiltSEM(2,[1,4,5],1) = f1StdErrFilt(1,:);
ch80Av20Filt(2,[1,4,5],2) = f1Ch80Av20Filt(2,:);
ch80Av20FiltSEM(2,[1,4,5],2) = f1StdErrFilt(2,:);



load('F2BehGraphsOutput.mat','lFinalMeans','lFinalStErr','f2Ch80Av20','f2StdErr','f2On','f2Off','f2Cont',...
    'lFinalMeansFilt','lFinalStErrFilt','f2Ch80Av20Filt','f2StdErrFilt','accFiltF2')
learn(3,:) = lFinalMeans;
learnSEM(3,:) = lFinalStErr;
ch80Av20(3,[1,4,5],1) = f2Ch80Av20(1,:);
ch80Av20SEM(3,[1,4,5],1) = f2StdErr(1,:);
ch80Av20(3,[1,4,5],2) = f2Ch80Av20(2,:);
ch80Av20SEM(3,[1,4,5],2) = f2StdErr(2,:);

%filtered data
learnFilt(3,:) = lFinalMeansFilt;
learnFiltSEM(3,:) = lFinalStErrFilt;
ch80Av20Filt(3,[1,4,5],1) = f2Ch80Av20Filt(1,:);
ch80Av20FiltSEM(3,[1,4,5],1) = f2StdErrFilt(1,:);
ch80Av20Filt(3,[1,4,5],2) = f2Ch80Av20Filt(2,:);
ch80Av20FiltSEM(3,[1,4,5],2) = f2StdErrFilt(2,:);

%% plot learning acc
styles = {'bx','ro','k^'};
for i = 1:3
    errorbar(learn(:,i),learnSEM(:,i),styles{i},'MarkerSize',20,'LineWidth',2.5)
    hold on
end
box off
axis([0.5 3.5 50 90])
[~,icons] = legend('ON','OFF','HC','Location',[0.3 0.12 0.2 0.18]);
for j = 4:6
    icons(j).Children.Children(1).MarkerSize = 14;
    icons(j).Children.Children(1).LineWidth = 2.5;
end
xlabel('Experiment')
ylabel('% Accuracy')
set(gca,'XTick',1:3)
saveas(figure(1),'BetweenExptsLearning.fig')
% saveas(figure(1),'BetweenExptsLearning.jpg')
% clf

%% plot ch80 and av20
clf
yLabs = {'% choose-A','% avoid-B'};
styles = {'bx','rx','bo','ro','k^'};
for i = 1:2
    subplot(1,2,i)
    for j = [1,3,2,4,5]
        errorbar(ch80Av20(:,j,i),ch80Av20SEM(:,j,i),styles{j},'MarkerSize',20,'LineWidth',2.5)
        hold on
    end
    box off
    xlabel('Experiment')
    ylabel(yLabs{i})
    set(gca,'XTick',1:3)
    axis([0.5 3.5 40 90])
    if i ==1
        [~,icons] = legend('ONON','ONOFF','OFFON','OFFOFF','HC','Location',[0.15 0.68 0.25 0.24]);
        for j = 6:10
            icons(j).Children.Children(1).MarkerSize = 14;
            icons(j).Children.Children(1).LineWidth = 2.5;
        end
    end
end

saveas(figure(1),'BetweenExptsCh80Av20.fig')
% saveas(figure(1),'BetweenExptsCh80Av20.jpg')
% clf

%% filtered %%%%%%%%%%%%%%%
%% learning
clf
styles = {'bx','ro','k^'};
for i = 1:3
    errorbar(learnFilt(:,i),learnFiltSEM(:,i),styles{i},'MarkerSize',20,'LineWidth',2.5)
    hold on
end
box off
axis([0.5 3.5 0 90])
[~,icons] = legend('ON','OFF','HC','Location',[0.3 0.12 0.2 0.18]);
for j = 4:6
    icons(j).Children.Children(1).MarkerSize = 14;
    icons(j).Children.Children(1).LineWidth = 2.5;
end
xlabel('Experiment')
ylabel('% Accuracy')
set(gca,'XTick',1:3)
saveas(figure(1),'BetweenExptsLearningFilt.fig')
% saveas(figure(1),'BetweenExptsLearningFilt.jpg')
% clf

%%
clf
yLabs = {'% choose-A','% avoid-B'};
styles = {'bx','rx','bo','ro','k^'};
for i = 1:2
    subplot(1,2,i)
    for j = [1,3,2,4,5]
        errorbar(ch80Av20Filt(:,j,i),ch80Av20FiltSEM(:,j,i),styles{j},'MarkerSize',20,'LineWidth',2.5)
        hold on
    end
    box off
    xlabel('Experiment')
    ylabel(yLabs{i})
    set(gca,'XTick',1:3)
    axis([0.5 3.5 40 90])
    if i == 2
        [~,icons] = legend('ONON','ONOFF','OFFON','OFFOFF','HC','Location',[0.6 0.15 0.2 0.24]);
        for j = 6:10
            icons(j).Children.Children(1).MarkerSize = 14;
            icons(j).Children.Children(1).LineWidth = 2.5;
        end
    end
end

saveas(figure(1),'BetweenExptsCh80Av20Filt.fig')
% saveas(figure(1),'BetweenExptsCh80Av20Filt.jpg')
% clf


%%
save('BetweenExptsGraphsOutput.mat')
close all
