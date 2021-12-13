%% SmartSheet Activity Log Parser
% Siri Maley (smaley@cmu.edu)
% Created: 12/11/2021

%close all
clear classes
clc

fileName = "MoonRanger Schedule Activity Log - 20211210.csv";
Log = ChangeLog(fileName).loadRaw;
Log = Log.run();

%%
% clear classes
% clc
%runtests('UTestChangeDetail');
% raw = 'Row 990: "Receive" Task Name: A to: B Start Week: 3/3/33 to: 4/4/44';