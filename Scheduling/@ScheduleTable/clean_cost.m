function self = clean_cost(self)
    self.tbl.cost_foroh = cellfun(@extractNum, self.tbl.cost_foroh);
    self.tbl.cost_nooh = cellfun(@extractNum, self.tbl.cost_nooh);
end

function num = extractNum(cost)
    num = Money(cost).num;
    if isempty(num)
        num = NaN;
    end
end