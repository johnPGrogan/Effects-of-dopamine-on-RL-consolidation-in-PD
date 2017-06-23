# Effects-of-dopamine-on-RL-consolidation-in-PD
The code for analysis and model fitting used in the paper "Effects of dopamine on reinforcement learning and consolidation in Parkinson's disease".

% README.txt

% This code contains the analysis used for the paper "Effects of dopamine on reinforcement learning and consolidation in Parkinson's disease".

% We do not have ethical approval to share participants' data, so we have
% also included a script to generate random data to show how the scripts run.

% You will need to copy all of the files into one folder, and run them from
% there.

% Some of the figures have been disabled as they use functions developed and 
% licensed by someone else. I have put links to those functions in the scripts
% but the analysis will run with or without those parts.

% Below is a brief description of the set up, and the list of files you
% should run in which order

%% Data
% There are three experiments in the paper, and they are sometimes referred to by different
% names.
% Experiment 1 often has no moniker, and so files without F1 or F2 in the
% title are for experiment 1.
% Experiment 2 is referred to as F1 in the files.
% Experiment 3 is referred to as F2 in the files.

% Experiment 1 has 4 sessions, one for each of 4 medication conditions,
% that all PD patients complete. Healthy Controls complete one session.
% Each session has a different version of the modified Probabilistic
% Selection Task (PST) run (versions A-D). The files are in the format:
% P101AL1.txt (1st learning block) - version A
% P101AL2.txt (2nd learning block)
% P101AL3.txt (3rd learning block)
% P101AM1.txt (1st memory test = 0 minutes delay)
% P101AM2.txt (2nd memory test = 30 minutes delay)
% P101AM3.txt (3rd memory test = 24 hours delay)
% P101AN1.txt (novel pairs test = 24 hours delay)
% P101BL1.txt (1st learning block) - version B
% and so on for versions B, C and D.
% the day1, day2 and bothDays variables set the conditions for each
% session.
% Controls complete one session, and do not have version numbers in their
% file names.

% Experiment 2 has the same 3 learning blocks, and then novel pairs test
% given immediately after learning, so there are no memory tests, and only
% 2 sessions for PD patients, one ON and OFF meds, and 1 session for
% controls.

% Experiment 3 had a variable number of learning blocks, dependent on their
% performance compared to thresholds, so are all saved in one learning
% file:
% P131AL1.txt
% and then a novel pairs test given immediately afterwards:
% P131AN1.txt
% PD patients were tested ON and OFF meds (2 sessions), and controls did 1
% session.

% The CreateFakeData.m file will generate random data that fits the format
% of the data analysed in the study.

%% files to run

% Here are the orders to run the files in:

%% create fake data

%if you don't have data in the format specified, this will create fake
%random data to test the scripts
CreateFakeData

%% Experiment 1 analysis

DataFiles;%gets file names, sets metadata
BehDataAnalysis%loads up data, processes it
BehGraphs%draw figures in paper
BehFilterAnalysis%run filtering analysis and draw those figures

%% Experiment 2 

FDataFiles%get file names for experiments 2 and 3
F1BehDataAnalysis%load up data & analyse
F1BehGraphs%draw figures

%% Experiment 3 analysis

FDataFiles%get file names and metadata for experiments 2 and 3
F2BehDataAnalysis%load up data & analyse
F2BehGraphs%draw figures

%% all 3 experiments

BetweenExptsGraphs % get analysed data from each experiment, combine, figures
BehWinStayAnalysis %run win-stay lose-shift analysis on each experiment, draw figure 

%% Model fitting
% These scripts fit Q-learning models with 1 or 2 learning rates to the
% behavioural data for patients, with the same parameters for all
% medication conditions, and with separate learning rates for ON and OFF
% conditions during learning.

QLearnNestedAuto
QLearnNestedTest
