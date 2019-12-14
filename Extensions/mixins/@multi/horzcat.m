function self = horzcat(self, new)
    switch class(new)
        case "multi"
            self.types = [self.types, Arr.cellify(new.types)];
            self.values = [self.values, Arr.cellify(new.values)];
        otherwise
            self.values = [self.values, Arr.cellify(new)];
    end
end