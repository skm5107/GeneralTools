function self = singleClean(self, iinds)
    self.wghtd = removeSelects(self, iinds, self.wghtd);
    self.names = removeSelects(self, iinds, self.names);
end

function mat = removeSelects(self, iinds, mat)
    mat([iinds]) = [];
    mat = reshape(mat, [], self.wid);
end