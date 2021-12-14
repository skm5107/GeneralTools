function self = getDetails(self)
    [old, new, rowQty] = getEmpties(self);
    [num, name, erred] = preallocate(rowQty);
    
    for idet = 1:rowQty
        try
            [num(idet), name(idet), old(idet,:), new(idet,:)] = getRow(self.log.Details{idet});
        catch
            erred{idet} = self.log.Details{idet};
        end
    end
    
    self.log.num = num;
    self.log.name = name;
    self.log.old = old;
    self.log.new = new;
    self.erred = erred;
    
    self = checkFinal(self);
end

function [old, new, rowQty] = getEmpties(self)
    rowQty = length(self.log.Details);
    [~, ~, old] = getRow(self.log.Details{1});
    old = Tbl.copyEmpty(old, rowQty);
    new = old;
end

function [num, name, erred] = preallocate(rowQty)
    num = nan(rowQty, 1);
    name = strings(rowQty, 1);
    erred = cell(rowQty, 1);
end

function [num, name, old, new] = getRow(jdet)
    jparsed = ChangeDetail(jdet).run;
    num = jparsed.num;
    name = jparsed.name;
    old = jparsed.old;
    new = jparsed.new;
end

function self = checkFinal(self)
    isSameName = self.log.name == self.log.new.name;
    isMissName = ismissing(self.log.new.name);
    isEither = xor(isSameName, isMissName);
    Warn.warnIf(~all(isEither), "ChangeLog:Details:Names:MisMatch", "Not all new names are either missing or the task name.")
    self.log.new.name = self.log.name;
end