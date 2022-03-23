function [durs, Hists, Log, mat] = runner(requests)
    origWarns = setWarnings();
    [Log, mat] = getLog(requests);
    Hists = getCompletes(requests, Log.log);
    durs = calcDurs(Hists);
    durs.plt = plotDurs(durs);
    durs = getDurStats(durs, Log);
end

function orig = setWarnings()
    orig(1) = warning('off', "ChangeDetail:split:undetectable");
end

function [Log, mat] = getLog(requests)
    if lower(requests.file) == "example"
        name.file = "Example Activity Log.csv";
        name.mat = "FullExample.mat";
    elseif lower(requests.file) == "real"
        name.file = "Example Activity Log.csv";
        name.mat = "FullActivity.mat";
    else
        throwErr('requests.file', requests.file);
    end
    
    if requests.reload == false
        fprintf("Loading ""%s"".\n", name.mat);
        load(name.mat);
        mat = [];
    elseif requests.reload == true
        fprintf("Running filename ""%s"".\n", name.file);
        Log = ChangeLog(name.file).run;
        mat = save(request.file, 'Log');
    else
        throwErr('requests.reload', requests.reload);
    end
end

function Hists = getCompletes(requests, log)
    cpstr = log.new.complete_pcent;
    cpnum = Str.getNums(cpstr);
    cp = cellfun(@convertCP, cpnum);
    isComplete = cp < requests.complete_pcent;
    completes = log(isComplete, :);
    
    qtyCompletes = height(completes);
    fprintf("Finding Histories at %.2f%% for %d Completes.\n", requests.complete_pcent, qtyCompletes);
    Hists = ChangedTask.empty(0, qtyCompletes);
    for ic = 1 : qtyCompletes
        Hists(ic) = ChangedTask(completes(ic, :), log).run;
    end
end

function durs = calcDurs(Hists)
    qtyHists = length(Hists);
    fprintf("Calculating durations for %d histories.\n", qtyHists);
    for ihist = 1 : qtyHists
        jold = Hists(ihist).prevRows.old.dur_bus;
        jnew = Hists(ihist).prevRows.new.dur_bus;
        [jpcent, jmin, jmax] = checkDur(jold, jnew);
        durs.pcent(ihist) = jpcent;
        durs.min(ihist) = jmin;
        durs.max(ihist) = jmax;
    end
end

function durplt = plotDurs(durs)
    qtyDurs = sum(~isnan(durs.min));
    fprintf("Plotting %d actual versus expected durations.\n", qtyDurs);
    min.days = days(durs.min);
    max.days = days(durs.max);
    act = plot(min.days, max.days, '*', 'DisplayName', 'Actuals');
    axis equal
    hold on
    
    plot(xlim, xlim, 'DisplayName', '1:1 Line');
    uistack(act, 'top')
    
    xlabel("Expected Days");
    ylabel("Actual Days");
    title(["Expected vs Actual Durations" "of Completed Tasks in the last 90 Days"])
    
    xlim([0 60]);
    ylim([0 90]);
    legend('Location','southeast')
    
    Plt.sdf
    durplt = gcf;
end

function durs = getDurStats(durs, Log)
    durs.qtyErred = sum(~cellfun(@isempty, Log.erred));
    fprintf("Number of errored ChangeLog rows: %d.\n", durs.qtyErred);
    
    durs.diff.avg_pcent = nanmean(durs.pcent);
    durs.diff.med_pcent = nanmedian(durs.pcent);
    durs.diff.qty = length(durs.pcent(~isnan(durs.pcent)));
    
    fprintf("Duration results: %.2f%% average increase. %.2f%% median increase. %d duration changes.\n", ...
        durs.diff.avg_pcent, durs.diff.med_pcent, durs.diff.qty);
end

%% Helpers
function throwErr(name, var)
    error("Unknown value for %s: %s", name, var);
end

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