function self = getOldNames(self)
    log = self.log;
    isFirst = false;
    
    jcur = self.row;
    itry = 1;
    irow = 1;
    while ~isFirst && itry <= self.maxTries
        jcur = getPrevRow(jcur, log);
        lastrow = height(jcur) + irow - 1;
        prevRows(irow:lastrow,:) = jcur;
        irow = lastrow + 1;
        isFirst = jcur.old.name(end) == self.firstName;
        itry = itry + 1;
    end
    self.prevRows = prevRows;
end

function prevRow = getPrevRow(curRow, log)
    if ismissing(curRow.old.name)
        oldName = curRow.name;
    else
        oldName = curRow.old.name;
    end
    ind = compareNames(oldName, log.new.name);
    prevRow = log(ind,:);
end

function ind = compareNames(searchName, newNames)
    ind = newNames == searchName;
    if ~any(ind)
        ind = getSimiliar(searchName, newNames);
    end
end

function ind = getSimiliar(searchName, newNames)
    levs = Str.lev(searchName, newNames);
    [val, ind] = min(levs);
    if val > self.maxLev
        ind = NaN;
    end
    warning("Using similar string for Task Name identification: %s", searchName);
end