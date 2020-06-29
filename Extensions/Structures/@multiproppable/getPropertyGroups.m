function propGrp = getPropertyGroups(self)
    if all(size(self) <= 1)
        propList = struct();
        for jprop = string(properties(self)')
            propList.(jprop) = getval({self.(jprop)});
        end
    else
        propList = properties(self);
    end
    propGrp = matlab.mixin.util.PropertyGroup(propList);
end

function val = getval(val)
    val = val{1};
    if class(val) == "multi"
        val = val.values{1};
    end
end