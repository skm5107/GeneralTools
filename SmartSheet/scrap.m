%% SmartSheet Activity Log Parser
% Siri Maley (smaley@cmu.edu)
% Created: 12/11/2021

close all
clear
clc
warning('off', "ChangeDetail:split:undetectable")

%% Create ChangeLog
fileName = "MoonRanger Schedule Activity Log - 20211210.csv";
% fileName = "Example Activity Log.csv";
Log = ChangeLog(fileName).run;

%% Changed Task Creation
viewer = table(Log.log.name, Log.log.old.name, Log.log.new.name);
viewer.Properties.VariableNames = ["name", "old", "new"];
CT = ChangedTask(Log.log(1,:), Log.log).run;

completes = Log.log(1:5,:);
CH = ChangeHistory(completes, Log.log).run;

return
%% Find Changes to Durations
qtyErred = sum(~cellfun(@isempty, Log.erred));
fprintf("Number of errored ChangeLog rows: %d.\n", qtyErred);

durs.old = getDurs(Log.log.old.dur_bus);
durs.new = getDurs(Log.log.new.dur_bus);

durs.diff.vals = (durs.new - durs.old) ./ durs.old * 100;
durrs.diff.avg_pcent = nanmean(durs.diff.vals);
durs.diff.med_pcent = nanmedian(durs.diff.vals);
durs.diff.qty = length(durs.diff.vals(~isnan(durs.diff.vals)));

fprintf("Duration results: %.2f%% average increase. %.2f%% median increase. %d duration changes.\n", ...
    durrs.diff.avg_pcent, durs.diff.med_pcent, durs.diff.qty);

%% Helpers
function durs = getDurs(log)
    log(contains(log, "=")) = missing;
    log(log=="(blank)") = missing;
    log = num2cell(log);
    durs = cellfun(@convert, log);
end

function dur = convert(str)
    if ismissing(str)
        dur = NaT-NaT;
    elseif str == "0"
        dur = days(0);
    elseif contains(str, "d")
        dur = days(Str.getNums(str));
    elseif contains(str, "w")
        dur = days(Str.getNums(str))*7;
    else
        error("Unknown duration text: %s", str);
    end
end