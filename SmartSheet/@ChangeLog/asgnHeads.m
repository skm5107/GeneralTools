function self = asgnHeads(self)
    asgnd = preallocate(self.raw);
    isHead = false(height(self.raw), 1);
    jHead = self.raw(1, :);
    
    for irow = 1:height(self.raw)
        jrow = self.raw(irow,:);
        isHead(irow) = checkHead(jrow);
        if ~isHead(irow)
            asgnd(irow,:) = copyHead(jrow, jHead);
        else
            asgnd(irow,:) = Tbl.asgnMatchVars(jrow, asgnd(irow,:));
            isHead(irow) = true;
            jHead = jrow;
        end
    end
    
    asgnd(isHead, :) = [];
    self.log = asgnd;
end


function asgnd = preallocate(raw)
    asgnd = Tbl.copyEmpty(raw);
    len = height(asgnd);
    for ivar = 1:length(ChangeLog.headCols)
        jvar = ChangeLog.headCols(ivar);
        jmiss = ChangeLog.headDefs{ivar};
        asgnd.(jvar) = repmat(jmiss, len, 1);
    end
end


function isHead = checkHead(row)
    misses = cellfun(@ismissing, {row.Action, row.User, row.TimeStamp});
    isMismatch = ~xor(all(misses), ~any(misses));
    Err(isMismatch, row, "Changelog:Headings:PartialMiss", "Some but not all heading columns are missing").run;
    isHead = ~any(misses);
end


function row = copyHead(row, head)
        row.Action = head.Action;
        row.User = head.User;
        row.TimeStamp = head.TimeStamp;
end
