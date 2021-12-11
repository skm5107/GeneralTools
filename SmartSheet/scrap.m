%% SmartSheet Activity Log Parser
% Siri Maley (smaley@cmu.edu)
% Created: 12/11/2021

close all
clear
clc

%% Import CSV
fileName = "MoonRanger Schedule Activity Log - 20211210.csv";
opts = detectImportOptions(fileName);
raw = readtable(fileName, opts);
raw = removevars(raw, 'Source');

%% Assign Heading Values to Detail Rows
asgnd = raw;
lastHeadRow = 1;
for irow = 1:height(asgnd)
    if ismissing(asgnd.Action(irow)) && ismissing(asgnd.User(irow)) && ismissing(asgnd.TimeStamp(irow))
        asgnd.isHead(irow) = false;
        asgnd.Action(irow) = asgnd.Action(lastHeadRow);
        asgnd.User(irow) = asgnd.User(lastHeadRow);
        asgnd.TimeStamp(irow) = asgnd.TimeStamp(lastHeadRow);
    else
        asgnd.isHead(irow) = true;
        lastHeadRow = irow;
    end
end

%% Trim Unneeded Rows
%asgnd(asgnd.isHead,:) = [];
act = table();
[act.target, act.move] = cellfun(@getAct, asgnd.Action);
asgnd.act = act;
otherAction = ~any([asgnd.act.target == "row", asgnd.act.target == "cell"], 2);
test = asgnd;
test(otherAction,:) = [];


%% Parse Details

for irow = 1:3 %height(parsed)
    parsed(irow,:) = parseRow(asgnd(irow,:));
end

%% Parse Columns
colNames = ["State", "% Complete", "Task Name", ...
            "Duration", "Start", "Start Week", "Finish", ...
            "Assigned To", "Predecessors", "Comments", ...
            "Cost Less OH", "Cost (OH)", "MATLAB", "No. Weeks", "Hrs per Sprint", ...
            "crit", "Slack", "Status Yellow", "Epic", "Status Gray"...
            "Parent?", "Hrs.", "Allocation"];
weirdNames = ["Acquired:", "DATE:", "Protoflight:", "Sheet:", ...
              "THIS:", "Unit:"];
        
hasWeird = cellfun(@(str) contains(str, weirdNames), asgnd.Details);
weird = asgnd.Details(hasWeird);

%% unique actions
%acts = cellfun(@(act) extractBefore(act, " ("), asgnd.Action, 'UniformOutput', 0);
acts = cellfun(@getAction, asgnd.Action, 'UniformOutput', 0);
uacts = unique(acts);

%% Find Words Before Colons
colonWords = string.empty;
for irow = 1:height(asgnd)
    details = asgnd.Details(irow);
    [rowNum, rowChar] = getNum(details);
    unquoted = eraseBetween(details, '"', '"', 'Boundaries', 'inclusive');
    
    revQuotes = reverse(unquoted);
    colons = extractBetween(revQuotes, " :", " ");
    colons = cellfun(@reverse, colons, 'UniformOutput', 0);
    
    isRow = cellfun(@(val) isequal(val, rowChar), colons);
    colons = colons(~isRow);
    cellfun(@(jcolon) flagMe(jcolon, details), colons)
    colonWords = [colonWords; colons];
end
colonWords = unique(colonWords);

function action = getAction(actionStr)
    action = extractBefore(actionStr, " (");
    if isempty(action)
        action = actionStr;
    end
end


function flagMe(jcolon, details)
    if jcolon == string('"RFA-01')
        details
    end
end

%% Parse a Row
function row = parseRow(row)
    row.act = getAct(row.Action);
    
    details = row.Details;
    row.Details
    row.num = getNum(details); 
    row.name = getName(details, row.num);
    row = getColons(details);
end

function [target, move] = getAct(action)
    if contains(action, "Rows Deleted (")
        target = categorical("row");
        move = categorical("deleted");
    elseif contains(action, "Cells Changed (")
        target = categorical("cell");
        move = categorical("changed");
    elseif contains(action, "Columns Inserted (")
        target = categorical("column");
        move = categorical("inserted");
    elseif contains(action, "Sheet Exported")
        target = categorical("sheet");
        move = categorical("exported");
    elseif contains(action, "Sheet Saved as New")
        target = categorical("sheet");
        move = categorical("saved new");
    elseif contains(action, "Sheet Shared")
        target = categorical("sheet");
        move = categorical("shared");        
    else
        error("ParseRow:Action:Type", "Unrecognized Action %s", action)
    end        
end
    
function [num, numChar] = getNum(details)
    numCell = extractBetween(details, "Row ", ":");
    if ~isscalar(numCell)
        numCell = NaN;
    end
    numStr = string(numCell);
    
    if ismissing(numStr)
        numChar = '';
    else
        numChar = char(numStr);
    end
    
    num = double(numStr);
end

function name = getName(details, num)
    nameCell = extractBetween(details, "Row "+num+': "', '"');
    assert(all(size(nameCell) == [1,1]), "ParseRow:Name:Size", "Row Name is nonscalar");
    name = string(nameCell);
end

function row = getColons(details)
    %
end