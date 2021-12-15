%% SmartSheet Activity Log Parser
% Siri Maley (smaley@cmu.edu)
% Created: 12/11/2021

% close all
% clear
% clc
% warning('off', "ChangeDetail:split:undetectable")
%
% %% Create ChangeLog
% fileName = "MoonRanger Schedule Activity Log - 20211210.csv";
% % fileName = "Example Activity Log.csv";
% Log = ChangeLog(fileName).run;

%% Get Completed Tasks
cpstr = Log.log.new.complete_pcent;
cpnum = Str.getNums(cpstr);
cp = cellfun(@convertCP, cpnum);
isAlmost = cp < 90;

completes = Log.log(isAlmost, :);
CH = ChangeHistory(completes, Log.log).run;

%% Check Duration Changes
for ihist = 1:length(CH.histories)
    [jpcent, jmin, jmax] = checkDur(CH.histories(ihist).prevRows.old.dur_bus, CH.histories(ihist).prevRows.new.dur_bus);
    durs.pcent(ihist) = jpcent;
    durs.min(ihist) = jmin;
    durs.max(ihist) = jmax;
end

%% Plot
close all
min.days = days(durs.min);
max.days = days(durs.max);
act = plot(min.days, max.days, '*', 'DisplayName', 'Actuals');
axis equal
hold on
lin = plot(xlim, xlim, 'DisplayName', '1:1 Line');
uistack(act, 'top')
xlabel("Expected Days");
ylabel("Actual Days");
title(["Expected vs Actual Durations" "of Completed Tasks in the last 90 Days"])
xlim([0 60]);
ylim([0 90]);
legend('Location','southeast')
Plt.sdf

%% Find Steps to Durations
qtyErred = sum(~cellfun(@isempty, Log.erred));
fprintf("Number of errored ChangeLog rows: %d.\n", qtyErred);

durs.old = getDurs(Log.log.old.dur_bus);
durs.new = getDurs(Log.log.new.dur_bus);

durs.diff.pcents = (durs.new - durs.old) ./ durs.old * 100;
durs.diff.avg_pcent = nanmean(durs.diff.pcents);
durs.diff.med_pcent = nanmedian(durs.diff.pcents);
durs.diff.qty = length(durs.diff.vals(~isnan(durs.diff.pcents)));

fprintf("Duration results: %.2f%% average increase. %.2f%% median increase. %d duration changes.\n", ...
    durs.diff.avg_pcent, durs.diff.med_pcent, durs.diff.qty);

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
        dur = NaT-NaT;
    elseif contains(str, "d")
        dur = days(Arr.uncell(Str.getNums(str)));
    elseif contains(str, "w")
        dur = days(Arr.uncell(Str.getNums(str)))*7;
    else
        error("Unknown duration text: %s", str);
    end
end

function cp = convertCP(cellcp)
    if isempty(cellcp)
        cp = NaN;
    else
        cp = cellcp;
    end
end


function [pcent, minDur, maxDur] = checkDur(olds, news)
    oldDurs = getDurs(olds);
    newDurs = getDurs(news);
    
    [minDur] = nanmin(oldDurs);
    [maxDur] = nanmax(newDurs);
    
    pcent = (maxDur - minDur) / minDur * 100;
    
    if isempty(pcent) || isinf(pcent)
        pcent = NaN;
    end
    
    if isempty(minDur)
        minDur = NaN;
    end
    if isempty(maxDur)
        maxDur = NaN;
    end
end