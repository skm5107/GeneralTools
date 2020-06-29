function propgrp = getPropertyGroups(self)
    propList = struct();
    for jprop = string(properties(self)')
        jval = {self.(jprop)};
        propList.(jprop) = getval(jval);
    end
    propgrp = matlab.mixin.util.PropertyGroup(propList);
end

function val = getval(val)
    if class(val) == "multi"
        val = val{1};
    end
end