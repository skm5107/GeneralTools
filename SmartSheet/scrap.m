%% SmartSheet Activity Log Parser
% Siri Maley (smaley@cmu.edu)
% Created: 12/11/2021

close all
clear
clc

fileName = "MoonRanger Schedule Activity Log - 20211210.csv";
Log = ChangeLog(fileName).loadRaw;
Log = Log.run();


%% Parse Details

for irow = 1:3 %height(parsed)
    parsed(irow,:) = parseRow(asgnd(irow,:));
end

%% Parse Columns
weirdNames = ["Acquired:", "DATE:", "Protoflight:", "Sheet:", ...
              "THIS:", "Unit:"];
        
hasWeird = cellfun(@(str) contains(str, weirdNames), asgnd.Details);
weird = asgnd.Details(hasWeird);

%% Find Words Before Colons
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
    


function row = getColons(details)
    %
end