function topvars = getTops(self)
    topvars = strings(1, length(self.parsedVars));
    for icol = 1:length(topvars)
        topvars(icol) = string(self.parsedVars{icol}(1));
    end
end