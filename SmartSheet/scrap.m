%% SmartSheet Activity Log Parser
% Siri Maley (smaley@cmu.edu)
% Created: 12/11/2021

close all
clear classes %#ok<CLCLS>
clc
warning('off', "ChangeDetail:split:undetectable")

%% Create ChangeLog
fileName = "MoonRanger Schedule Activity Log - 20211210.csv";
Log = ChangeLog(fileName).run;

%% Find Changes to Durations
qtyErred = sum(~cellfun(@isempty, Log.erred));
fprintf("Number of errored ChangeLog rows: %d.\n", length(Log.erred));

oldDur = string.empty(0, length(Log.deets));
newDur = string.empty(0, length(Log.deets));
fails = true(0, length(Log.deets));
for idet = 1:length(Log.deets)
    try
        oldDur(idet) = Log.deets(idet).old.dur_bus;
        newDur(idet) = Log.deets(idet).new.dur_bus;
        fails(idet) = false;
    end
end

oldNum = convert(oldDur);
newNum = convert(newDur);
diffDurs = (newNum - oldNum)./oldNum*100;
diffavg_pcent = nanmean(diffDurs);
diffmed_pcent = nanmedian(diffDurs);
diff_qty = length(diffDurs(~isnan(diffDurs)));

fprintf("Duration success rate: %d sucesses, %d fails.\n", length(Log.deets) - sum(fails), sum(fails));
fprintf("Duration results: %.2f%% average increase. %.2f%% median increase. %d duration changes.\n", ...
    diffavg_pcent, diffmed_pcent, diff_qty);

%% Helpers
function durnum = convert(durstr)
    durcell = num2cell(durstr);
    durnum = cellfun(@convert1, durcell);
end

function dur = convert1(str)
    if ismissing(str) || str == "(blank)" || contains(str, "=")
        dur = days(NaN);
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


