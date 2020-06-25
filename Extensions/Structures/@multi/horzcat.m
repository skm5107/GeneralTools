function self = horzcat(self, new)
    switch class(new)
        case "multi"
            self.labels = [self.labels, Arr.cellify(new.labels)];
            self.values = [self.values, Arr.cellify(new.values)];
        otherwise
            self.values = [self.values, Arr.cellify(new)];
    end
end