function const = setup()
    
    const.types = ["Duration", "Finish", "% Complete", "Comments", ...
        "Start", "Start Week", "State", "Assigned To", "Predecessors", ...
        "Task Name", "crit", "Slack", "Status Yellow", "Status Gray"...
        "Epic", "Parent?", "Cost Less OH", "Cost (OH)", "MATLAB", ...
        "No. Weeks", "Hrs.", "Hrs per Sprint",  "Allocation"];
    
    const.colNames = ["dur_bus", "finish", "complete_pcent", "comments", ...
        "start", "start", "state", "assigee", "preds", ...
        "name", "isCP", "slack", "", "", ...
        "", "isParent", "", "", "", ...
        "", "", "", ""];
    
    old = table('VariableNames', {
    
    
    startTypes = join(const.types, "|");
    endTypes = join(const.types, "| ");
    
    const.detExp = sprintf("^(%s): ?.* to: ?.*(?= %s)", startTypes, endTypes);
    const.parseExp = "(^.*?)(: )(.*)( to: )(.*)";
    const.typeInd = 1;
    const.oldInd = 3;
    const.newInd = 5;
    
    const.maxTries = length(const.types);
    const.detailsEmpty = string.empty(0, const.maxTries);
    
    
    const.preExp = '(^Row?)( *?)([\d]*?)(: "?)(.*?)(")';
    const.numInd = 3;
    const.nameInd = 5;
end