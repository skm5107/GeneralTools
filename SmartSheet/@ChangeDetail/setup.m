function const = setup()
    const.pres = loadPre();
    
    types = ["Duration", "Finish", "% Complete", "Comments", ...
        "Start Week", "Start", "State", "Assigned To", "Predecessors", ...
        "Task Name", "crit", "Slack", "Status Yellow", "Status Gray"...
        "Epic", "Parent?", "Cost Less OH", "Cost (OH)", "MATLAB", ...
        "No. Weeks", "Hrs.", "Hrs per Sprint",  "Allocation"];
    const.splits = loadSplit(types);
    const.parses = loadParse(types);
end

function pres = loadPre()
    pres.exp = '(^Row?)( *?)([\d]*?)(: "?)(.*?)(")';
    pres.numInd = 3;
    pres.nameInd = 5;
end

function splits = loadSplit(types)
    startTypes = join(types, "|");
    endTypes = join(types, "| ");
    emptyMid = '(^%s)(: )(.*?)( to: )(.*?)(?= %s)';
    %TODO: combine these with an optional end-of-text or next detail type.
    %TODO: combine the entire thing with arbirarily repeated detail phrases
    splits.exp.mid = sprintf(emptyMid, startTypes, endTypes);
    
    emptyEnd = '(^%s?)(: )(.*?)( to: )(.*?)$';
    splits.exp.end = sprintf(emptyEnd, startTypes);
    
    splits.maxTries = length(types);
    splits.details = cell(splits.maxTries, 1);
end

function parses = loadParse(types)
    parses.exp = "(^.*?)(: )(.*)( to: )(.*)";
    parses.typeInd = 1;
    parses.oldInd = 3;
    parses.newInd = 5;
    
    parses.types = types;
    parses.varNames = ["dur_bus", "finish", "complete_pcent", "comments", ...
        "start", "start", "state", "assigee", "preds", ...
        "name", "isCP", "slack", "", "", ...
        "", "isParent", "", "", "", ...
        "", "", "", ""];
    parses.tblVars = unique(parses.varNames(parses.varNames ~= ""));
    parses.tblTypes = ["duration", "datetime", "double", "string", ...
        "duration", "categorical", "categorical", "cell", ...
        "string", "logical", "duration", "logical"];
    parses.old = table('VariableNames', parses.tblVars, 'VariableTypes', parses.tblTypes, 'Size', [1, length(parses.tblVars)]);
    parses.new = parses.old;
end