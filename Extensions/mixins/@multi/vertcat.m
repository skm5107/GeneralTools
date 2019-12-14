function self = vertcat(self, new)
    switch class(new)
        case "multi"
            self.values = cellfun(@vertcat, self.values, new.values, 'uni', 0);
            self.types = cellfun(@vertcat, self.types, new.types, 'uni', 0);
        otherwise
            self.values = cellfun(@vertcat, self.values, new, 'uni', 0);
    end
end