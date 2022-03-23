%% SmartSheet Activity Log Parser
% Siri Maley (smaley@cmu.edu)
% Created: 12/11/2021

close all
clear
clc

requests.file = "Real";
requests.reload = false;
requests.complete_pcent = 90;
[durs, Hists, Log, mat] = runner(requests);
viewer = [durs.min; durs.max]'; days(viewer(~any(isnan(viewer),2), :))