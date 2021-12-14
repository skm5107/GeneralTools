function self = getDetails(self)
    [old, new, erred, rowQty] = preallocate(self);
    for idet = 1:rowQty
        [jold, jnew, jerr] = getRow(self.log.Details{idet});
        old(idet,:) = jold;
        new(idet,:) = jnew;
        erred{idet} = jerr;
%         [old(idet,:), new(idet,:), erred{idet}] = getRow(self.log.Details{idet});
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
    %try
    jparsed = ChangeDetail(jdet).run;
    old = jparsed.old;
    new = jparsed.new;
    %catch
    erred = jdet;
    %end
end