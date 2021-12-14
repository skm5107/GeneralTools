function self = getDetails(self)
    [old, new, erred, rowQty] = preallocate(self);
    for idet = 1:rowQty
        [old(idet,:), new(idet,:), erred{idet}] = getRow(self.log.Details{idet});
    end
    self.log.old = old;
    self.log.new = new;
    self.erred = erred;
end

function [old, new, erred, rowQty] = preallocate(self)
    rowQty = length(self.log.Details);
    old = getRow(self.log.Details{1});
    old = Tbl.copyEmpty(old, rowQty);
    new = old;
    erred = cell(rowQty, 1);
end

function [old, new, erred] = getRow(jdet)
    try
        jparsed = ChangeText(jdet).run;
        old = jparsed.old;
        new = jparsed.new;
        erred = [];
    catch
        erred = jdet;
    end
end