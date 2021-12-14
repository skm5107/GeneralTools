function const = setup()
    const.key = loadKey();
    const.pres = loadPre();
    const.splits = loadSplit(const.key.smartsheet);
    const.parses = loadParse(const.key);
end

function key = loadKey()
    filePath = "textKey.csv";
    orig = warning('off', 'FormattedCsv:Read:ExtraVar');
    key = FormattedCsv(filePath).run;
    warning(orig);
end

function pres = loadPre()
    pres.exp = '(^Row?)( *?)([\d]*?)(: "?)(.*?)(")';
    pres.expMiss = sprintf('(^Row?)( *?)([\\d]*?)(: ?)%s( *)(.*)', ChangeDetail.missVal);
    pres.numInd = 3;
    pres.nameInd = 5;
end

function splits = loadSplit(types)
    typeStr = join(types, "|");
    endStr = join(types, ": |");
    emptyMid = '(^%s)(: )(.*?)( to: )(.*?)( )(?=%s)';
    %TODO: combine these with an optional end-of-text or next detail type.
    %TODO: combine the entire thing with arbirarily repeated detail phrases
    splits.exp.mid = sprintf(emptyMid, typeStr, endStr);
    
    emptyEnd = '(^%s?)(: )(.*?)( to: )(.*?)$';
    splits.exp.end = sprintf(emptyEnd, typeStr);
    
    splits.maxTries = length(types);
    splits.details = cell(splits.maxTries, 1);
end

function parses = loadParse(key)
    parses.exp = "(^.*?)(: )(.*)( to: )(.*)";
    parses.typeInd = 1;
    parses.oldInd = 3;
    parses.newInd = 5;
    
    tblVars = unique(key.tblVar(key.tblVar ~= "missing" & key.tblVar ~= ""));
    tblTypes = repmat("string", [1,length(tblVars)]);
    parses.old = table('VariableNames', tblVars, ...
        'VariableTypes', tblTypes, ...
        'Size', [1, length(tblVars)]);
    parses.new = parses.old;
end