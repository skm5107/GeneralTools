function self = clean(self)
    if isempty(self.Parent)
        self.Parent = Task.empty(1,0);
    end

    if isempty(self.Preds)
        self.Preds = Task.empty(1,0);
    end    
    
    if isempty(self.Sucs)
        self.Sucs = Task.empty(1,0);
    end
    
    if isempty(self.Childs)
        self.Childs = Task.empty(1,0);
    end
end