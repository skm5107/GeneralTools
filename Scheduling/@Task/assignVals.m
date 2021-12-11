function self = assignVals(self)
    self.id = self.raw.row;
    self.name = self.raw.name;
    self.comments = self.raw.comments;
    self.assignee = categorical(self.raw.assignee);
    
    self.When = TimePd(self.raw).run;
    self.Price = getPrices(self.raw);
    self.parentID = self.raw.parent;    
    self.predIDs = self.raw.preds;
end
    
function Price = getPrices(raw)
    Price = Cost();
    if Val.isFull(raw.cost_foroh)
        overheaded = Cost(raw.cost_foroh, "To Overhead");
        Price = [Price, overheaded];
    end
    if Val.isFull(raw.cost_nooh)
        nooverhead = Cost(raw.cost_nooh, "Not Overheaded");
        Price = [Price, nooverhead];
    end
end