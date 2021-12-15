function self = getOldNames(self)
    log = self.log;
    isFirst = false;
    
    jcur = self.row;
    restLog = log;
    itry = 1;
    irow = 1;
    while ~isFirst && itry <= self.maxTries
        [jcur, restLog] = getPrevRow(jcur(end,:), restLog);
        lastrow = height(jcur) + irow - 1;
        prevRows(irow:lastrow,:) = jcur;
        irow = lastrow + 1;
        if ~isempty(jcur)
            isFirst = jcur.old.name(end) == self.firstName;
        else
            isFirst = true;
        end
        itry = itry + 1;
    end
    self.prevRows = prevRows;
end

function [prevRow, restLog] = getPrevRow(curRow, log)
    if ismissing(curRow.old.name)
        oldName = curRow.name;
    else
        oldName = curRow.old.name;
    end
    ind = compareNames(oldName, log.new.name, curRow.num, log.num);
    prevRow = log(ind,:);
    restLog = log(ind+1:end,:);
end

function ind = compareNames(searchName, newNames, searchNum, newNums)
    indNames = newNames == searchName;
%     if ~any(indNames)
%         %indNames = getSimiliar(searchName, newNames);
%     end    
    indNums = newNums == searchNum;
    ind = and(indNames, indNums);
end

function ind = getSimiliar(searchName, newNames)
    levs = Str.lev(searchName, newNames);
    [val, ind] = min(levs);
    if val > ChangedTask.maxLev
        ind = NaN;
    end
    warning("Using similar string for Task Name identification: %s", searchName);
end