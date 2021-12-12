function const = setup()
    types = ["Duration", "Finish", "% Complete", "Comments", ...
        "Start", "Start Week", "State", "Assigned To", "Predecessors", ...
        "Task Name", "crit", "Slack", "Status Yellow", "Status Gray"...
        "Epic", "Parent?", "Cost Less OH", "Cost (OH)", "MATLAB", ...
        "No. Weeks", "Hrs.", "Hrs per Sprint",  "Allocation"];
    startTypes = join(types, "|");
    endTypes = join(types, "| ");
    
    const.detExp = sprintf("^(%s): ?.* to: ?.*(?= %s)", startTypes, endTypes);
    const.detRem = strlength({' to: ', ''});    
    const.parseExp = "(^.*?)(: )(.*)( to: )(.*)";
    
    const.maxTries = length(types);
    const.detailsEmpty = string.empty(0, const.maxTries);
    
    
    const.preExp = '(^Row)?( *)?([\d]+)?(: ")?(.*)?(")';
    const.numInd = 3;
    const.nameInd = 5;
end