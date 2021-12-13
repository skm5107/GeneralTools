%% SmartSheet Activity Log Parser
% Siri Maley (smaley@cmu.edu)
% Created: 12/11/2021

close all
clear
%clc

%% Create ChangeLog
fileName = "MoonRanger Schedule Activity Log - 20211210.csv";
Log = ChangeLog(fileName).loadRaw;
Log = Log.run();

%% Find Changes to Durations
oldDur = string.empty(0, length(Log.deets));
newDur = string.empty(0, length(Log.deets));
successes = 1;
for idet = 1:length(Log.deets)
    try
        oldDur(idet) = Log.deets(idet).old.dur_bus;
        newDur(idet) = Log.deets(idet).new.dur_bus;
        successes = successes + 1;
    end
end

oldNum = convert(oldDur);
newNum = convert(newDur);
diffDurs = (newNum - oldNum)./oldNum*100;
diff_pcent = nanmean(diffDurs)
diff_qty = length(diffDurs(~isnan(diffDurs)))

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


